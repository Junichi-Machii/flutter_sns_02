import 'package:flutter/material.dart';

class RefreshScreen extends StatelessWidget {
  const RefreshScreen(
      {super.key, required this.child, required this.onRefresh});

  final Widget child;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
        GlobalKey<RefreshIndicatorState>();
    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            key: refreshIndicatorKey,
            color: Colors.white,
            backgroundColor: Colors.blue,
            // controller: homeModel.refreshController,
            // enablePullDown: true,
            // enablePullUp: true,
            onRefresh: onRefresh,
            // onLoading: homeModel.onLoading,
            // header: WaterDropHeader(),
            child: child,
          ),
        ),
      ],
    );
  }
}
