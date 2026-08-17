import 'package:flutter/material.dart';

class GameOverScreen extends StatelessWidget {
  final int score;
  final bool completed;

  const GameOverScreen({
    required this.score,
    this.completed = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF42A5F5),
              Color(0xFF81C784),
            ],
          ),
        ),

        child: SafeArea(
          child: Column(
            mainAxisAlignment:
            MainAxisAlignment.center,

            children: [
              Text(
                completed ? '🏆' : '💥',
                style: const TextStyle(
                  fontSize: 90,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                completed
                    ? 'CONGRATULATIONS!'
                    : 'GAME OVER',

                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                'Score: $score',

                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: 220,
                height: 55,

                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },

                  icon: const Icon(
                    Icons.refresh,
                  ),

                  label: const Text(
                    'PLAY AGAIN',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  style:
                  ElevatedButton.styleFrom(
                    backgroundColor:
                    Colors.white,
                    foregroundColor:
                    const Color(0xFF3949AB),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              TextButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                  );

                  Navigator.pop(
                    context,
                  );
                },

                child: const Text(
                  'EXIT',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}