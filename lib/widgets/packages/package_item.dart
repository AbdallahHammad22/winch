import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:winch/controllers/app_style/colors.dart';
import 'package:winch/controllers/app_style/sizing.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/models/package.dart';
import 'package:winch/models/subtitle.dart';
import 'package:winch/widgets/titles/app_sub_title.dart';
class PackageItem extends StatelessWidget {
  final Package package;
  final EdgeInsets margin;
  final Package selectedPackage;
  final Function(Package) onPressed;

  const PackageItem({Key key, this.package, this.margin, this.selectedPackage, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Subtitle _subtitle = WinchLocalization.of(context).subtitle;
    return Padding(
      padding: margin ?? const EdgeInsets.symmetric(horizontal: 48,vertical: 16),
      child: RaisedButton(
        splashColor: Theme.of(context).accentColor,
        elevation: 8,
        padding: EdgeInsets.symmetric(vertical: 4),
        color: AColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              AStyling.getBorderRadius(context)
          ),
          side: BorderSide(
              color: AColors.yellow,
              width: 2,
              style: BorderStyle.solid
          ),
        ),
        child: package == null ?
          SizedBox(height: 100 * AStyling.getScaleFactor(context), child: Center(child: ASubTitle("Pick Package")))
        :Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
              child: Row(
                children: [
                  Visibility(
                    visible: selectedPackage != null,
                    child: SizedBox(
                      width: 36,
                      height: 20,
                      child: Radio(
                        value: package,
                        groupValue: selectedPackage,
                        onChanged: (value){},
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      package.name ?? _subtitle.noNameFound,
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                        fontSize: 14
                      ),
                      textScaleFactor: AStyling.getScaleFactor(context),
                    ),
                  ),
                  Text(
                    (package.price.toString() ?? _subtitle.noCostFount) + " ${_subtitle.egp}",
                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 12
                    ),
                    textScaleFactor: AStyling.getScaleFactor(context),
                  ),
                ],
              ),
            ),
            Divider(thickness: 2,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8,),
                  Text(
                    package.description ?? _subtitle.noDescriptionFound,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontSize: 11,
                      color: Colors.grey[700]
                    ),
                    textScaleFactor: AStyling.getScaleFactor(context),
                  ),
                  SizedBox(height: 16,),

                  Text(
                    package.duration ?? _subtitle.noDurationFound,
                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 12
                    ),
                    textScaleFactor: AStyling.getScaleFactor(context),
                  ),
                  SizedBox(height: 8,),
                ],
              ),
            ),
            package.expiryDate != null ?
            Column(
              children: [
                Divider(thickness: 2,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${_subtitle.subscribeDate}: ",
                              style: Theme.of(context).textTheme.subtitle2.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12
                              ),
                              textScaleFactor: AStyling.getScaleFactor(context),
                            ),
                          ),
                          Text(
                            DateFormat.yMd().add_jm().format(package.startDate),
                            style: Theme.of(context).textTheme.subtitle2.copyWith(
                              fontSize: 12
                            ),
                            textScaleFactor: AStyling.getScaleFactor(context),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${_subtitle.expiryDate}: ",
                              style: Theme.of(context).textTheme.subtitle2.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12
                              ),
                              textScaleFactor: AStyling.getScaleFactor(context),
                            ),
                          ),
                          Text(
                            DateFormat.yMd().add_jm().format(package.expiryDate),
                            style: Theme.of(context).textTheme.subtitle2.copyWith(
                              fontSize: 12
                            ),
                            textScaleFactor: AStyling.getScaleFactor(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8,),
              ],
            ):SizedBox.shrink(),
          ],
        ),
        onPressed: (){
          onPressed(package);
        }
      ),
    );
  }
}
