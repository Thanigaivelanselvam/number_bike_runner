import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../models/number_game_model.dart';

class NumberObject extends StatelessWidget {
  final NumberObjectModel object;
  final VoidCallback onTap;
  final Animation<double> animation;

  const NumberObject({
    required this.object,
    required this.onTap,
    required this.animation,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final float =
        math.sin(
          animation.value * math.pi * 2,
        ) *
            7;

    final scale =
        0.65 + object.depth * 0.4;

    return GestureDetector(
      onTap: onTap,

      child: Transform.translate(
        offset: Offset(0, float),

        child: Transform.scale(
          scale: scale,

          child: Container(
            width: 90,
            height: 90,

            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,

              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 15,
                  offset: Offset(0, 8),
                ),
              ],
            ),

            alignment: Alignment.center,

            child: Text(
              '${object.number}',

              style: const TextStyle(
                color: Color(0xFF3949AB),
                fontSize: 32,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ),
    );
  }
}