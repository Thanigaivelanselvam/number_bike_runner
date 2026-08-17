import 'dart:async';

import 'package:flutter/material.dart';

enum BikeAnimation {
  idle,
  run,
  hit,
}

class BikeSprite extends StatefulWidget {
  final BikeAnimation animation;
  final double size;

  const BikeSprite({
    required this.animation,
    this.size = 110,
    super.key,
  });

  @override
  State<BikeSprite> createState() => _BikeSpriteState();
}

class _BikeSpriteState extends State<BikeSprite> {
  Timer? timer;

  int frame = 0;

  final Map<BikeAnimation, List<String>> frames = {
    BikeAnimation.idle: [
      'assets/game/bike/bike1.png',
    ],

    BikeAnimation.run: [
      'assets/game/bike/bike1.png',
      'assets/game/bike/bike1.png',
      'assets/game/bike/bike1.png',
      'assets/game/bike/bike1.png',
    ],

    BikeAnimation.hit: [
      'assets/game/bike/bike1.png',
    ],
  };

  @override
  void initState() {
    super.initState();

    _startAnimation();
  }

  @override
  void didUpdateWidget(
      covariant BikeSprite oldWidget,
      ) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.animation != widget.animation) {
      frame = 0;

      _startAnimation();
    }
  }

  void _startAnimation() {
    timer?.cancel();

    timer = Timer.periodic(
      const Duration(milliseconds: 110),
          (_) {
        if (!mounted) return;

        setState(() {
          final currentFrames =
          frames[widget.animation]!;

          frame =
              (frame + 1) % currentFrames.length;
        });
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentFrames =
    frames[widget.animation]!;

    return Image.asset(
      currentFrames[
      frame % currentFrames.length],
      width: widget.size,
      height: widget.size,
      fit: BoxFit.contain,
    );
  }
}