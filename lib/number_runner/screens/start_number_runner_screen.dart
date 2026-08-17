import 'package:flutter/material.dart';

import 'number_runner_screen.dart';

class StartNumberRunnerScreen extends StatelessWidget {
  const StartNumberRunnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),

        title: const Text('Number Bike Runner'),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF64B5F6), Color(0xFF81C784)],
          ),
        ),

        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              const Text('🚴', style: TextStyle(fontSize: 100)),

              const SizedBox(height: 20),

              const Text(
                'NUMBER BIKE RUNNER',

                textAlign: TextAlign.center,

                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Ride • Collect • Learn',

                style: TextStyle(color: Colors.white, fontSize: 18),
              ),

              const SizedBox(height: 50),

              SizedBox(
                width: 220,
                height: 60,

                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,

                      MaterialPageRoute(
                        builder: (_) => const NumberRunnerScreen(),
                      ),
                    );
                  },

                  icon: const Icon(Icons.play_arrow_rounded, size: 30),

                  label: const Text(
                    'START GAME',

                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,

                    foregroundColor: const Color(0xFF3949AB),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: 220,
                height: 55,

                child: OutlinedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,

                      builder: (_) {
                        return AlertDialog(
                          title: const Text('How to Play'),

                          content: const Text(
                            '🚴 Ride the bike\n\n'
                            '⬅️ Move Left\n'
                            '➡️ Move Right\n\n'
                            '🎯 Collect the required number\n\n'
                            '🚧 Avoid barricades\n\n'
                            '💥 Wrong number or obstacle = Game Over',
                          ),

                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },

                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  },

                  icon: const Icon(Icons.help_outline),

                  label: const Text('HOW TO PLAY'),

                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,

                    side: const BorderSide(color: Colors.white, width: 2),
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
