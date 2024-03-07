import 'package:flutter/material.dart';
import 'package:winch/controllers/app_style/colors.dart';
import 'package:winch/controllers/app_style/sizing.dart';
import 'package:winch/models/category.dart';
import 'package:winch/widgets/loaders/image_loader.dart';
class CategoryItem extends StatelessWidget {
  final Category category;
  final VoidCallback onPressed;

  const CategoryItem({Key key, this.category, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(
            AStyling.getBorderRadius(context),

          ),
          boxShadow: [
            BoxShadow(
                color: AColors.grey,
                blurRadius: 10,
                offset: Offset(0,5)
            )
          ]
      ),
      margin: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
      child: ListTile(
        leading: SizedBox(
          width: 42,
          child: ImageLoader(url: category.image,)
        ),
        title: Text(
          category.name ?? "--- no name found ---",
          style: Theme.of(context).textTheme.subtitle1,
        ),
        onTap: onPressed,
      ),
    );
  }
}
