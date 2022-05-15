import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class RefreshWidget extends StatefulWidget {
  final Widget child;
  final Future Function() onRefresh;
  final GlobalKey<RefreshIndicatorState> keyRefresh;
  const RefreshWidget(
      {Key? key,
        required this.onRefresh,
        required this.child,
        required this.keyRefresh})
      : super(key: key);
  @override
  _RefreshWidgetState createState() => _RefreshWidgetState();
}

class _RefreshWidgetState extends State<RefreshWidget> {
  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid ? buidAndroidList() : buidIOSList();
  }
  Widget buidAndroidList() {
    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      child: widget.child,
    );
  }
  Widget buidIOSList() {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        CupertinoSliverRefreshControl(
          onRefresh: widget.onRefresh,
        ),
        SliverToBoxAdapter(
          child: widget.child,
        )
      ],
    );
  }
}
