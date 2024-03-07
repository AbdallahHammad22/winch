import 'package:flutter/material.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/models/package.dart';
import 'package:winch/models/subtitle.dart';
import 'package:winch/widgets/loaders/no_item_found.dart';
import 'package:winch/widgets/packages/package_item.dart';

class PackagesList extends StatelessWidget {

  final List<Package> packages;
  final Package selectedPackage;
  final Function(Package) onItemPressed;

  const PackagesList({Key key, this.packages, this.selectedPackage,this.onItemPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Subtitle _subtitle = WinchLocalization.of(context).subtitle;
    if(packages.length == 0)
      return NoItemFound(
        message: _subtitle.noPackagesFound,
      );

    return ListView.builder(
      itemCount: packages.length,
      itemBuilder: (listContext,itemIndex){
        return PackageItem(
          selectedPackage: selectedPackage,
          package: packages[itemIndex],
          onPressed: (package){
            onItemPressed(package);
          },
        );
      },
    );
  }
}
