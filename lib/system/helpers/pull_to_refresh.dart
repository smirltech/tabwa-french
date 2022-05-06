import 'dart:developer';

import 'package:flutter/material.dart';

class PullToRefreshController extends ChangeNotifier {
  bool isRefreshing = false;
  bool isPulling = false;
  bool endPulling = false;
  bool isLoaded = false;

  bool onRefreshing() {
    isRefreshing = true;
    // isLoaded = false;
    notifyListeners();
    return true;
  }

  void onPulling() {
    isPulling = true;
    notifyListeners();
  }

  void onEndPulling() {
    endPulling = true;
    notifyListeners();
  }

  void setLoaded() {
    isLoaded = true;
    notifyListeners();
  }

  void isCompleted() {
    isRefreshing = false;
    isPulling = false;
    endPulling = false;
    isLoaded = false;
    notifyListeners();
  }
}

class PullToRefresh extends StatefulWidget {
  const PullToRefresh({
    Key? key,
    this.header,
    this.child,
    this.maxHeight = 150.0,
    this.controller,
  }) : super(key: key);
  final Widget? header;
  final Widget? child;

  final double maxHeight;

  final PullToRefreshController? controller;

  @override
  _PullToRefreshState createState() => _PullToRefreshState();
}

class _PullToRefreshState extends State<PullToRefresh> {
  double _y0 = 0.0;
  double _y1 = 0.0;
  double _yt = 0.0;
  double _ym = 0.0;

  final Duration _duration = const Duration(microseconds: 500);

  @override
  initState() {
    super.initState();
    if (widget.controller != null) {
      widget.controller!.addListener(() {
        if (widget.controller!.isPulling) {
          _yt = _y1 < _y0 ? 0 : _y1 - _y0;
          if (_yt > widget.maxHeight) _yt = widget.maxHeight;
          _ym = _yt * 0.1;
          setState(() {});
        }
        if (widget.controller!.isLoaded) {
          slapBack();
        }
      });
    }
  }

  dispose() {
    if (widget.controller != null) {
      widget.controller!.dispose();
    }
    super.dispose();
  }

  slapBack() async {
    while (_yt > 1) {
      _yt -= 1;
      if (_yt < 1) {
        _y0 = 0.0;
        _y1 = 0.0;
        _ym = 0.0;
        break;
      }
      setState(() {});

      await Future.delayed(_duration);
    }
    widget.controller!.isCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: SizedBox.expand(
            child: NotificationListener(
                child: widget.child!,
                onNotification: (notification) {
                  if (notification is ScrollStartNotification) {
                    if (_y0 < 1) {
                      _y0 = notification.dragDetails?.globalPosition.dy ?? 0.0;
                    }
                    widget.controller!.onRefreshing();
                  }
                  if (notification is OverscrollNotification) {
                    try {
                      _y1 = notification.dragDetails?.globalPosition.dy ?? 0.0;
                      widget.controller!.onPulling();
                    } on Exception catch (e) {
                      // TODO
                      log(e.toString());
                    }
                  }
                  if (notification is ScrollEndNotification) {
                    if (_y0 < _y1) {
                      widget.controller!.onEndPulling();
                    }
                  }
                  return false;
                }),
          ),
        ),
        if (_y1 > _y0 && _yt > _ym)
          Positioned(
            child: Column(
              children: [
                AnimatedContainer(
                  duration: _duration,
                  curve: Curves.bounceInOut,
                  height: _yt,
                  child: widget.header ??
                      const Center(
                          child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.all(4.0),
                          child: CircularProgressIndicator.adaptive(
                              //  backgroundColor: Colors.white,
                              ),
                        ),
                      )),
                ),
                const Spacer(),
              ],
            ),
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
          ),
      ],
    );
  }
}
