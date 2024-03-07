import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:winch/controllers/app_style/colors.dart';
import 'package:winch/controllers/http_status_manger/http_status_manger.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/controllers/providers/api/brand_vehicles_provider.dart';
import 'package:winch/controllers/providers/api/user_provider.dart';
import 'package:winch/controllers/providers/api/user_vehicles_provider.dart';
import 'package:winch/controllers/validator/validator.dart';
import 'package:winch/models/user_vehicle.dart';
import 'package:winch/models/brand.dart';
import 'package:winch/models/category.dart';
import 'package:winch/models/subtitle.dart';
import 'package:winch/widgets/app_text_field/app_text_form_field_3.dart';

import 'package:winch/widgets/brands/brand_picker.dart';
import 'package:winch/widgets/buttons/app_button.dart';
import 'package:winch/widgets/buttons/app_button_2.dart';
import 'package:winch/widgets/categories/category_picker.dart';
import 'package:winch/widgets/from_top_cover.dart';
import 'package:winch/widgets/image_picker.dart';
import 'package:winch/widgets/loaders/loading_manager.dart';
import 'package:winch/widgets/titles/app_sub_title.dart';

class EditVehicle extends StatefulWidget {
  static final String id = "/driver/new-vehicle";
  final UserVehicle userVehicle;

  const EditVehicle({Key key, this.userVehicle}) : super(key: key);
  @override
  _EditVehicleState createState() => _EditVehicleState();
}

class _EditVehicleState extends State<EditVehicle> {

  UserVehicle _userVehicle = UserVehicle();
  UserProvider _userProvider;
  bool _isLoading = false;
  UserVehiclesProvider _userVehiclesProvider;
  BrandVehiclesProvider _brandVehiclesProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Size _size;
  File _frontCarLicence;
  File _backCarLicence;
  String _language;
  Subtitle _subtitle;

  Future<bool> editVehicle() async {

    if(!_formKey.currentState.validate())
      return false;
    _formKey.currentState.save();

    if(_userVehicle.category == null){
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(_subtitle.categoryAlert),
          )
      );
      return false;
    }
    if(_frontCarLicence == null)
      _userVehicle.frontCarLicence = null;
    if(_backCarLicence == null)
      _userVehicle.backCarLicence = null;
    // add user id if all data is valid
    _userVehicle.userId = _userProvider.userDate.id;
    _isLoading = true;
    setState(() {});
    int statue = await _userVehiclesProvider.updateUserVehicle(
        token: _userProvider.userDate.token,
        userVehicle: widget.userVehicle,
        newUserVehicle: _userVehicle,
    );
    _isLoading = false;
    setState(() {});
    if(statue >= 200 && statue < 300){
      Fluttertoast.showToast(
          msg: _subtitle.carUpdatedSuccessfully,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          backgroundColor: Colors.black,
          fontSize: 16.0
      );
      return true;
    }else{
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(
                HttpStatusManger.getStatusMessage(
                    status: statue, subtitle: _subtitle
                )
            ),
          )
      );
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    _userVehicle.fromUserVehicle(widget.userVehicle);
  }
  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    _userVehiclesProvider = Provider.of<UserVehiclesProvider>(context);
    _brandVehiclesProvider = Provider.of<BrandVehiclesProvider>(context);
    _size = MediaQuery.of(context).size;
    _language = WinchLocalization.of(context).locale.languageCode;
    _subtitle = WinchLocalization.of(context).subtitle;
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: LoadingManager(
          isLoading: _isLoading,
          stateCode: 200,
          isFailedLoading: false,
          onRefresh: (){},
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              FormTopCover(_subtitle.editCarInfo),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0,),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8,),
                      ASubTitle(_subtitle.category),
                      SizedBox(
                        width: _size.width,
                        child: AButton2(
                          color: AColors.lightGrey,
                          borderColor: AColors.lightGrey,
                          text:  _userVehicle.category?.name,
                          onPressed: () async {
                            Category _category = await Navigator.of(context)
                                .pushNamed(CategoryPicker.id) as Category;
                            if(_category != null){
                              _userVehicle.category = _category;
                              setState(() {});
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 8,),
                      ASubTitle(_subtitle.chassisNumber),
                      ATextFormField3(
                        initialValue: _userVehicle.chassisNumber,
                        validator: (value) =>
                        Validator.hasValue(value)
                            ? null : _subtitle.chassisAlert,
                        textInputType: TextInputType.text,
                        onSaved: (value){
                          _userVehicle.chassisNumber = value;
                        },
                      ),
                      SizedBox(height: 8,),
                      ASubTitle(_subtitle.year),
                      ATextFormField3(
                        initialValue: _userVehicle.year,
                        validator: (value) =>
                        Validator.isYear(value)
                            ? null : _subtitle.yearAlert,
                        textInputType: TextInputType.text,
                        onSaved: (value){
                          _userVehicle.year = value;
                        },
                      ),
                      SizedBox(height: 8,),
                      ASubTitle(_subtitle.frontCarLicence),
                      SizedBox(height: 4,),
                      AImagePicker(
                        networkImage: _userVehicle.frontCarLicence,
                        image: _frontCarLicence,
                        onPick:(file){
                          _frontCarLicence = file;
                          _userVehicle.frontCarLicence = _frontCarLicence.path;
                          setState(() {});
                        },
                      ),
                      SizedBox(height: 8,),
                      ASubTitle(_subtitle.backCarLicence),
                      SizedBox(height: 4,),
                      AImagePicker(
                        networkImage: _userVehicle.backCarLicence,
                        image: _backCarLicence,
                        onPick:(file){
                          _backCarLicence = file;
                          _userVehicle.backCarLicence = _backCarLicence.path;
                          setState(() {});
                        },
                      ),
                      SizedBox(height:  100,),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: _size.width /1.5,
                    child: AButton(
                      text: _subtitle.update,
                      onPressed: () async {
                        bool result = await editVehicle();
                        if(result)
                          Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height:  _size.height/10,),
            ],
          ),
        ),
      ),
    );
  }
}
