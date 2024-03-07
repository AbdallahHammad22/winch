import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winch/controllers/providers/api/categories_provider.dart';
import 'package:winch/controllers/providers/api/packages_provider.dart';
import 'package:winch/controllers/providers/api/user_provider.dart';
import 'package:winch/models/category.dart';
import 'package:winch/models/package.dart';
import 'package:winch/pages/categories/categories_list.dart';
import 'package:winch/pages/packages/packages_list.dart';
import 'package:winch/widgets/app_text_field/app_text_form_field_3.dart';
import 'package:winch/widgets/buttons/app_button.dart';
import 'package:winch/widgets/loaders/loading_manager.dart';

class PackagePicker extends StatefulWidget {
  static final String id = "/package-picker";

  @override
  _PackagePickerState createState() => _PackagePickerState();
}

class _PackagePickerState extends State<PackagePicker>
  with TickerProviderStateMixin{
  List<Package> _searchableList = [];
  UserProvider _userProvider;
  Package _selectedPackage = Package();
  bool _firstTime = true;
  PackagesProvider _packagesProvider;

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    _packagesProvider = Provider.of<PackagesProvider>(context);
    if(_firstTime && _packagesProvider.packages != null){
      _searchableList.clear();
      _searchableList.addAll(_packagesProvider.packages);
      _firstTime = false;
    }
    return Scaffold(
      body: LoadingManager(
        isLoading: _packagesProvider.isLoading,
        isFailedLoading: _packagesProvider.packages == null,
        stateCode: _packagesProvider.stateCode,
        onRefresh: () async {
          _packagesProvider.reset();
          await _packagesProvider.getPackages(
              token: _userProvider.userDate.token
          );
          _searchableList.clear();
          _searchableList.addAll(_packagesProvider.packages);
          setState(() {});
        },
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
                child: ATextFormField3(
                  hintText: "Search",
                  style: Theme.of(context).textTheme.subtitle1,
                  suffixIcon: Icons.search_rounded,
                  onChange: (value){
                    _searchableList.clear();
                    _searchableList.addAll(_packagesProvider.packages.where(
                            (element) => element.name.toLowerCase().contains(
                            value.toLowerCase()
                        )
                    ).toList());
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: PackagesList(
                  packages: _searchableList,
                  selectedPackage: _selectedPackage,
                  onItemPressed: (package){
                   _selectedPackage = package;
                   setState(() {});
                  },
                ),
              ),
              AnimatedSize(
                duration: Duration(milliseconds: 400),
                vsync: this,
                curve: Curves.easeInOut,
                child: Visibility(
                  visible: _selectedPackage.id != null,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width /1.3,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: AButton(
                        text: "Pick ${_selectedPackage?.name}",
                        onPressed: (){
                          Navigator.of(context).pop(_selectedPackage);
                        },
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
