import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefreshScreen extends StatelessWidget {
  const RefreshScreen(
      {super.key,
      required this.child,
      required this.onRefresh,
      required this.onLoading,
      required this.refreshController});

  final Widget child;
  final Future<void> Function() onRefresh;
  final void Function()? onLoading;
  final RefreshController refreshController;

  @override
  Widget build(BuildContext context) {
    // final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
    //     GlobalKey<RefreshIndicatorState>();
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      onRefresh: onRefresh,
      onLoading: onLoading,
      header: const WaterDropHeader(),
      controller: refreshController,
      child: child,
    );
  }
}
