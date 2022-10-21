import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(duration: const Duration(seconds: 5), vsync: this)
          ..repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final DecorationTween _decorationTween = DecorationTween(
      // beginning values (color, shape, boxShadow, border)
      begin: BoxDecoration(
          color: Colors.yellow,
          shape: BoxShape.circle,
          border: Border.all(width: 10, color: Colors.orange)),
      end: BoxDecoration(
          color: Colors.purple,
          shape: BoxShape.circle,
          border: Border.all(width: 50, color: Colors.red)));

  @override
  Widget build(BuildContext context) {
    return DecoratedBoxTransition(
      decoration: _decorationTween.animate(_controller),
      child: const SizedBox(width: 100, height: 100),
    );
  }
}
