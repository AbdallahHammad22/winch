import 'package:flutter/material.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/models/category.dart';
import 'package:winch/models/subtitle.dart';
import 'package:winch/widgets/categories/category_item.dart';
import 'package:winch/widgets/loaders/no_item_found.dart';

class CategoriesList extends StatelessWidget {

  final List<Category> categories;
  final Function(int) onItemPressed;
  const CategoriesList({Key key, this.categories,this.onItemPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Subtitle _subtitle = WinchLocalization.of(context).subtitle;
    if(categories.length == 0)
      return NoItemFound(
        message: _subtitle.noCategoriesFound,
      );

    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (listContext,itemIndex){
        return CategoryItem(
          category: categories[itemIndex],
          onPressed: (){
            onItemPressed(itemIndex);
          },
        );
      },
    );
  }
}
