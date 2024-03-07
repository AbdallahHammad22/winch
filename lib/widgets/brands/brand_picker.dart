import 'package:flutter/material.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/models/brand.dart';
import 'package:winch/models/category.dart';
import 'package:winch/models/subtitle.dart';
import 'package:winch/pages/brands/brands_list.dart';
import 'package:winch/widgets/app_text_field/app_text_form_field_3.dart';

class BrandPicker extends StatefulWidget {
  static final String id = "/brand-picker";

  @override
  _BrandPickerState createState() => _BrandPickerState();
}

class _BrandPickerState extends State<BrandPicker> {
  Category _category;
  bool _firstTime = true;
  List<Brand> _searchableList = [];
  Subtitle _subtitle;
  @override
  Widget build(BuildContext context) {
    _category = ModalRoute.of(context).settings.arguments;
    _subtitle = WinchLocalization.of(context).subtitle;
    if(_firstTime ){
      _searchableList.clear();
      _searchableList.addAll(_category.brands);
      _firstTime = false;
    }
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
              child: ATextFormField3(
                hintText: _subtitle.search,
                style: Theme.of(context).textTheme.subtitle1,
                suffixIcon: Icons.search_rounded,
                onChange: (value){
                  _searchableList.clear();
                  _searchableList.addAll(_category.brands.where(
                          (element) => element.name.toLowerCase().contains(
                          value.toLowerCase()
                      )
                  ).toList());
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: BrandsList(
                brands: _searchableList,
                onItemPressed: (index){
                  Navigator.of(context).pop(_searchableList[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
