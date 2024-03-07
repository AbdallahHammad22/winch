import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:winch/controllers/app_style/colors.dart';
import 'package:winch/controllers/app_style/sizing.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/models/subtitle.dart';
import 'package:winch/widgets/loaders/image_loader.dart';

import 'buttons/app_button.dart';
class AImagePicker extends StatefulWidget {
  final Function(File) onPick;
  final File image;
  final String networkImage;
  final String label;
  final bool error;
  const AImagePicker({Key key, this.label, this.error,this.image,this.networkImage, this.onPick}) : super(key: key);

  @override
  _AImagePickerState createState() => _AImagePickerState();
}

class _AImagePickerState extends State<AImagePicker> {
  File _image;
  Subtitle _subtitle;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _image = widget.image;
  }
  @override
  Widget build(BuildContext context) {
    _subtitle = WinchLocalization.of(context).subtitle;
    return Column(
      children: [
        Visibility(
          visible: _image == null && widget.error == true,
          child: Column(
            children: [
              SizedBox(height: 4,),
              Text(
                _subtitle.imageAlert,
                style: Theme.of(context).textTheme.subtitle2.copyWith(
                  color: Colors.red
                ),
              ),
              SizedBox(height: 8,),
            ],
          ),
        ),
        Container(
          height: 54 * AStyling.getScaleFactor(context),
          child: MaterialButton(
            padding: _image == null ? null : EdgeInsets.zero,
            child: _image == null ?
            widget.networkImage != null ?
            ImageLoader(url: widget.networkImage,boxFit: BoxFit.contain,):
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AColors.deepGrey
                  ),
                  child: Icon(Icons.add,color: AColors.white,size: 32,),
                ),
              ],
            ):
            Image(
              image: FileImage(_image),
            ),
            onPressed: () async {
              ImageSource source = await showDialog(
                  context: context,
                  builder: (_) => CupertinoAlertDialog(
                    actions: <Widget>[
                      FlatButton(
                        child: Text(_subtitle.pickFromCamera),
                        onPressed: () {
                          Navigator.of(context).pop(ImageSource.camera);
                        },
                      ),
                      FlatButton(
                        child: Text(_subtitle.pickFromGallery),
                        onPressed: () {
                          Navigator.of(context).pop(ImageSource.gallery);
                        },
                      ),
                    ],
                  )
              );
              if(source == null)
                return;

              PickedFile pickedFile = await ImagePicker().getImage(
                source: source,
                imageQuality: 70,
                maxWidth: 800,
                maxHeight: 800
              );

              if (pickedFile != null) {
                _image = File(pickedFile.path);
                widget.onPick(_image);
              } else {
                print('No image selected.');
              }
              setState(() {});
              print(await _image.length());
            },
          ),
        ),
      ],
    );
  }
}
