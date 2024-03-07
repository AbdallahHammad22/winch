import 'package:flutter/material.dart';
import 'package:winch/controllers/http_status_manger/http_status_manger.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/models/subtitle.dart';
import 'package:winch/widgets/dialogs/dialog.dart';
import 'app_loading.dart';

import 'failed_loading.dart';
class LoadingManager extends StatelessWidget {
  final bool isLoading;
  final bool isFailedLoading;
  final bool isNotPage;
  final int stateCode;
  final bool askOnBack;
  final int progress;
  final Future<void> Function() onRefresh;
  final Widget child;

  LoadingManager({
    Key key,
    @required this.isLoading,
    @required this.isFailedLoading,
    @required this.stateCode,
    @required this.onRefresh,
    @required this.child,
    this.isNotPage = false,
    this.askOnBack = false,
    this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Subtitle _subtitle = WinchLocalization.of(context).subtitle;
    Widget _placeHolder;
    // to load data if load not start
    if(isLoading == null || stateCode == null)
      onRefresh();

    // if loading of still not start in loading (true or null)
    // return loading widget
    if(isLoading != false || stateCode == null){
      _placeHolder = ALoading(progress: progress,);
    }else if(isFailedLoading && !isNotPage){
      // if failed return failed widget
      _placeHolder = FailedLoading(
        message: HttpStatusManger.getStatusMessage(
            status: stateCode, subtitle: _subtitle),
        onReload: onRefresh,
      );
    }

    // if load end successfully return loaded widget
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 400),
      child: RefreshIndicator(
        key: ValueKey(isLoading == true ? 1 : 2),
        onRefresh: onRefresh,
        child: _placeHolder ?? child
      ),
    );
  }
}
