import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/controllers/providers/api/categories_provider.dart';
import 'package:winch/controllers/providers/api/user_provider.dart';
import 'package:winch/models/category.dart';
import 'package:winch/models/subtitle.dart';
import 'package:winch/pages/categories/categories_list.dart';
import 'package:winch/widgets/app_text_field/app_text_form_field_3.dart';
import 'package:winch/widgets/loaders/loading_manager.dart';

class CategoryPicker extends StatefulWidget {
  static final String id = "/category-picker";

  @override
  _CategoryPickerState createState() => _CategoryPickerState();
}

class _CategoryPickerState extends State<CategoryPicker> {
  List<Category> _searchableList = [];
  UserProvider _userProvider;
  bool _firstTime = true;
  CategoriesProvider _categoriesProvider;
  String _language;
  Subtitle _subtitle;
  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    _categoriesProvider = Provider.of<CategoriesProvider>(context);
    _language = WinchLocalization.of(context).locale.languageCode;
    _subtitle = WinchLocalization.of(context).subtitle;
    if(_firstTime && _categoriesProvider.categories != null){
      _searchableList.clear();
      _searchableList.addAll(_categoriesProvider.categories);
      _firstTime = false;
    }
    return Scaffold(
      body: LoadingManager(
        isLoading: _categoriesProvider.isLoading,
        isFailedLoading: _categoriesProvider.categories == null,
        stateCode: _categoriesProvider.stateCode,
        onRefresh: () async {
          _categoriesProvider.reset();
          await _categoriesProvider.getCategories(
              language: _language,
              token: _userProvider.userDate.token
          );
          _searchableList.clear();
          _searchableList.addAll(_categoriesProvider.categories);
          setState(() {});
        },
        child: SafeArea(
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
                    _searchableList.addAll(_categoriesProvider.categories.where(
                            (element) => element.name.toLowerCase().contains(
                            value.toLowerCase()
                        )
                    ).toList());
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: CategoriesList(
                  categories: _searchableList,
                  onItemPressed: (index){
                    Navigator.of(context).pop(_searchableList[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
