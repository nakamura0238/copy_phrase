import 'package:flutter/material.dart';
import 'dart:async';

final _overlayEntry = OverlayEntry(builder: (_) => const _Toast());

void showToast(BuildContext context) {
  if (_overlayEntry != null && _overlayEntry.mounted) {
    _overlayEntry.remove();
  } 

  if (!_overlayEntry.mounted) {
    Navigator.of(context).overlay?.insert(_overlayEntry);
  }

  Timer(const Duration(seconds: 1), () {
    if (_overlayEntry != null && _overlayEntry.mounted) _overlayEntry.remove();
  });
}

class _Toast extends StatefulWidget {
  const _Toast({Key? key}) : super(key: key);

  @override
  State<_Toast> createState() => _ToastState();
}

class _ToastState extends State<_Toast> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );

    final _tween = TweenSequence<double>([
    TweenSequenceItem(
      tween: Tween(begin: 0.0, end: 1.0),
      weight: 2,
    ),
    TweenSequenceItem(
      tween: ConstantTween(1.0),
      weight: 6,
    ),
    TweenSequenceItem(
      tween: Tween(begin: 1.0, end: 0.0,),
      weight: 2,
    ),
  ]);

  @override
  void initState() {
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller, 
      builder: (BuildContext context, _) {
        return Center(
          child: FadeTransition(
            opacity: _controller.drive(_tween),
            child: Container(
              width: 200,
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('コピーしました',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}