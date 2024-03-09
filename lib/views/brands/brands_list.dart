import 'package:flutter/material.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/models/brand.dart';
import 'package:winch/models/subtitle.dart';
import 'package:winch/widgets/brands/brand_item.dart';
import 'package:winch/widgets/loaders/no_item_found.dart';

class BrandsList extends StatelessWidget {

  final List<Brand> brands;
  final Function(int) onItemPressed;

  const BrandsList({Key key, this.brands,this.onItemPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Subtitle _subtitle = WinchLocalization.of(context).subtitle;
    if(brands.length == 0)
      return NoItemFound(
        message: _subtitle.noBrandsFound,
      );

    return ListView.builder(
      itemCount: brands.length,
      itemBuilder: (listContext,itemIndex){
        return BrandItem(
          brand: brands[itemIndex],
          onPressed: (){
            onItemPressed(itemIndex);
          },
        );
      },
    );
  }
}
