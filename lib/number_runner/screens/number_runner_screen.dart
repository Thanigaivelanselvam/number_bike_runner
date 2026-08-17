import 'dart:async';
import 'package:flutter/material.dart';
import '../controller/number_runner_controller.dart';
import '../data/number_game_data.dart';
import '../models/number_game_model.dart';
import '../painters/perspective_road_painter.dart';
import '../widgets/bike_sprite.dart';
import '../widgets/number_object.dart';
import 'game_over_screen.dart';

class NumberRunnerScreen
    extends StatefulWidget {
  const NumberRunnerScreen({
    super.key,
  });

  @override
  State<NumberRunnerScreen> createState() =>
      _NumberRunnerScreenState();
}

class _NumberRunnerScreenState
    extends State<NumberRunnerScreen>
    with TickerProviderStateMixin {

  late NumberRunnerController controller;

  late AnimationController worldAnimation;

  late AnimationController numberAnimation;

  late AnimationController obstacleAnimation;

  Timer? numberCollisionTimer;

  Timer? obstacleCollisionTimer;

  double playerX = 0.5;

  double cameraX = 0;

  double obstacleX = 0.5;

  bool running = false;

  bool numbersVisible = false;

  bool obstacleVisible = false;

  bool gameOverShown = false;

  @override
  void initState() {
    super.initState();

    controller =
        NumberRunnerController();

    controller.setMissions(
      numberMissions,
    );

    worldAnimation =
        AnimationController(
          vsync: this,

          duration:
          const Duration(seconds: 2),
        );

    numberAnimation =
        AnimationController(
          vsync: this,

          duration:
          const Duration(seconds: 5),
        );

    obstacleAnimation =
        AnimationController(
          vsync: this,

          duration:
          const Duration(seconds: 6),
        );

    _startGame();
  }

  void _startGame() {
    Future.delayed(
      const Duration(
        milliseconds: 800,
      ),
          () {
        if (!mounted) return;

        setState(() {
          running = true;
        });

        worldAnimation.repeat();

        controller.notifyListeners();
      },
    );

    Future.delayed(
      const Duration(
        milliseconds: 1500,
      ),
          () {
        if (!mounted) return;

        setState(() {
          numbersVisible = true;
        });

        numberAnimation.repeat();

        startNumberCollision();
      },
    );

    Future.delayed(
      const Duration(
        milliseconds: 3000,
      ),
          () {
        if (!mounted) return;

        setState(() {
          obstacleVisible = true;
        });

        obstacleAnimation.repeat();

        startObstacleCollision();
      },
    );
  }

  // ------------------------------------------------
  // PLAYER MOVEMENT
  // ------------------------------------------------

  void movePlayer(
      double amount,
      ) {
    if (controller.gameOver ||
        controller.gameCompleted) {
      return;
    }

    setState(() {
      playerX += amount;

      if (playerX < 0.12) {
        playerX = 0.12;
      }

      if (playerX > 0.88) {
        playerX = 0.88;
      }

      cameraX =
          (playerX - 0.5) * 0.15;
    });
  }

  void handleSwipe(
      DragUpdateDetails details,
      ) {
    final dx = details.delta.dx;

    if (dx.abs() < 1) {
      return;
    }

    movePlayer(
      dx / 350,
    );
  }

  // ------------------------------------------------
  // NUMBER COLLISION
  // ------------------------------------------------

  void startNumberCollision() {
    numberCollisionTimer?.cancel();

    numberCollisionTimer =
        Timer.periodic(
          const Duration(
            milliseconds: 50,
          ),
              (timer) {
            if (!mounted) {
              timer.cancel();
              return;
            }

            if (controller.gameOver ||
                controller.gameCompleted) {
              timer.cancel();
              return;
            }

            final mission =
                controller.currentMission;

            if (mission == null) {
              return;
            }

            final progress =
                numberAnimation.value;

            final objectY =
                260 + (progress * 430);

            final screenWidth =
                MediaQuery.of(context)
                    .size
                    .width;

            final playerScreenX =
                screenWidth * playerX;

            final playerY =
                MediaQuery.of(context)
                    .size
                    .height -
                    145;

            for (final object
            in mission.objects) {

              if (controller
                  .collectedObjects
                  .contains(object.id)) {
                continue;
              }

              final objectX =
                  screenWidth * object.x;

              final distanceX =
              (objectX -
                  playerScreenX)
                  .abs();

              final distanceY =
              (objectY - playerY)
                  .abs();

              // Collision
              if (distanceX < 90 &&
                  distanceY < 100) {

                _collectNumber(object);

                return;
              }

              // Required number missed
              if (progress > 0.96 &&
                  object.correct &&
                  !controller
                      .collectedObjects
                      .contains(object.id)) {

                controller.missedNumber();

                _showGameOver();

                return;
              }
            }
          },
        );
  }

  void _collectNumber(
      NumberObjectModel object,
      ) {
    final correct =
    controller.collectNumber(
      object,
    );

    if (!mounted) {
      return;
    }

    setState(() {});

    if (!correct) {
      _showGameOver();

      return;
    }

    // Correct number
    numberAnimation.forward(
      from: 0,
    );

    if (controller.gameCompleted) {
      _showGameOver(
        completed: true,
      );
    }
  }

  // ------------------------------------------------
  // OBSTACLE COLLISION
  // ------------------------------------------------

  void startObstacleCollision() {
    obstacleCollisionTimer?.cancel();

    obstacleCollisionTimer =
        Timer.periodic(
          const Duration(
            milliseconds: 50,
          ),
              (timer) {
            if (!mounted) {
              timer.cancel();
              return;
            }

            if (!obstacleVisible) {
              return;
            }

            if (controller.gameOver ||
                controller.gameCompleted) {
              timer.cancel();
              return;
            }

            final progress =
                obstacleAnimation.value;

            final obstacleY =
                250 + (progress * 430);

            final screenWidth =
                MediaQuery.of(context)
                    .size
                    .width;

            final obstacleScreenX =
                screenWidth * obstacleX;

            final playerScreenX =
                screenWidth * playerX;

            final playerY =
                MediaQuery.of(context)
                    .size
                    .height -
                    145;

            final distanceX =
            (obstacleScreenX -
                playerScreenX)
                .abs();

            final distanceY =
            (obstacleY - playerY)
                .abs();

            if (distanceX < 90 &&
                distanceY < 100) {

              controller.hitObstacle();

              _showGameOver();

              return;
            }

            // Reset obstacle
            if (progress > 0.98) {
              _changeObstaclePosition();
            }
          },
        );
  }

  void _changeObstaclePosition() {
    setState(() {
      if (obstacleX == 0.25) {
        obstacleX = 0.75;
      } else if (obstacleX == 0.75) {
        obstacleX = 0.50;
      } else {
        obstacleX = 0.25;
      }
    });

    obstacleAnimation.forward(
      from: 0,
    );
  }

  // ------------------------------------------------
  // GAME OVER
  // ------------------------------------------------

  void _showGameOver({
    bool completed = false,
  }) {
    if (gameOverShown) {
      return;
    }

    gameOverShown = true;

    numberCollisionTimer?.cancel();

    obstacleCollisionTimer?.cancel();

    worldAnimation.stop();

    numberAnimation.stop();

    obstacleAnimation.stop();

    Future.delayed(
      const Duration(
        milliseconds: 300,
      ),
          () {
        if (!mounted) return;

        Navigator.pushReplacement(
          context,

          MaterialPageRoute(
            builder: (_) =>
                GameOverScreen(
                  score: controller.score,
                  completed: completed,
                ),
          ),
        );
      },
    );
  }

  // ------------------------------------------------
  // BUILD
  // ------------------------------------------------

  @override
  Widget build(
      BuildContext context,
      ) {
    final mission =
        controller.currentMission;

    if (mission == null) {
      return const Scaffold(
        body: Center(
          child:
          CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: GestureDetector(
        onHorizontalDragUpdate:
        handleSwipe,

        child: Stack(
          children: [
            _buildWorld(),

            _buildNumbers(
              mission,
            ),

            _buildObstacle(),

            _buildBike(),

            _buildHUD(
              mission,
            ),

            _buildControls(),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------
  // WORLD
  // ------------------------------------------------

  Widget _buildWorld() {
    return Positioned.fill(
      child: Container(
        decoration:
        const BoxDecoration(
          gradient:
          LinearGradient(
            begin:
            Alignment.topCenter,
            end:
            Alignment.bottomCenter,
            colors: [
              Color(0xFF42A5F5),
              Color(0xFF90CAF9),
              Color(0xFF81C784),
            ],
          ),
        ),

        child: Stack(
          children: [
            const Positioned(
              top: 80,
              left: 25,

              child: Text(
                '☀️',

                style: TextStyle(
                  fontSize: 60,
                ),
              ),
            ),

            const Positioned(
              top: 170,
              left: 20,

              child: Text(
                '🌳',

                style: TextStyle(
                  fontSize: 100,
                ),
              ),
            ),

            const Positioned(
              top: 240,
              right: 15,

              child: Text(
                '🌳',

                style: TextStyle(
                  fontSize: 120,
                ),
              ),
            ),

            _buildPerspectiveRoad(),
          ],
        ),
      ),
    );
  }

  Widget _buildPerspectiveRoad() {
    return Positioned.fill(
      child: AnimatedBuilder(
        animation: worldAnimation,

        builder: (
            context,
            child,
            ) {
          return CustomPaint(
            painter:
            PerspectiveRoadPainter(
              animation:
              worldAnimation.value,

              cameraX: cameraX,
            ),
          );
        },
      ),
    );
  }

  // ------------------------------------------------
  // NUMBERS
  // ------------------------------------------------

  Widget _buildNumbers(
      NumberMissionModel mission,
      ) {
    if (!numbersVisible) {
      return const SizedBox();
    }

    return Stack(
      children:
      mission.objects.map(
            (object) {
          if (controller
              .collectedObjects
              .contains(object.id)) {
            return const SizedBox();
          }

          return AnimatedBuilder(
            animation:
            numberAnimation,

            builder:
                (context, child) {
              final screenWidth =
                  MediaQuery.of(
                    context,
                  ).size.width;

              final progress =
                  numberAnimation.value;

              final y =
                  260 +
                      (progress * 430);

              final scale =
                  0.65 +
                      (progress * 0.55);

              final x =
                  screenWidth *
                      object.x -
                      (45 * scale);

              return Positioned(
                left: x,
                top: y,

                child:
                Transform.scale(
                  scale: scale,

                  child: NumberObject(
                    object: object,

                    animation:
                    numberAnimation,

                    onTap: () {
                      _collectNumber(
                        object,
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ).toList(),
    );
  }

  // ------------------------------------------------
  // OBSTACLE
  // ------------------------------------------------

  Widget _buildObstacle() {
    if (!obstacleVisible) {
      return const SizedBox();
    }

    return AnimatedBuilder(
      animation:
      obstacleAnimation,

      builder:
          (context, child) {
        final screenWidth =
            MediaQuery.of(context)
                .size
                .width;

        final progress =
            obstacleAnimation.value;

        final y =
            250 +
                (progress * 430);

        final scale =
            0.55 +
                (progress * 0.55);

        final x =
            screenWidth *
                obstacleX -
                (45 * scale);

        return Positioned(
          left: x,
          top: y,

          child:
          Transform.scale(
            scale: scale,

            child: Image.asset(
              'assets/game/objects/barricade.png',

              width: 90,
              height: 90,

              errorBuilder:
                  (
                  context,
                  error,
                  stackTrace,
                  ) {
                return const Text(
                  '🚧',

                  style: TextStyle(
                    fontSize: 70,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  // ------------------------------------------------
  // BIKE
  // ------------------------------------------------

  Widget _buildBike() {
    final width =
        MediaQuery.of(context)
            .size
            .width;

    final left =
        width * playerX - 55;

    return AnimatedPositioned(
      duration:
      const Duration(
        milliseconds: 180,
      ),

      curve:
      Curves.easeOut,

      left: left,

      bottom: 145,

      child: BikeSprite(
        animation: running
            ? BikeAnimation.run
            : BikeAnimation.idle,

        size: 110,
      ),
    );
  }

  // ------------------------------------------------
  // HUD
  // ------------------------------------------------

  Widget _buildHUD(
      NumberMissionModel mission,
      ) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding:
            const EdgeInsets.all(
              15,
            ),

            child: Row(
              children: [
                _hud(
                  '🏆',
                  '${controller.score}',
                ),

                const Spacer(),

                _hud(
                  '🎯',
                  'Find ${mission.targetNumber}',
                ),
              ],
            ),
          ),

          Container(
            margin:
            const EdgeInsets.symmetric(
              horizontal: 20,
            ),

            padding:
            const EdgeInsets.all(
              16,
            ),

            decoration:
            BoxDecoration(
              color:
              Colors.white
                  .withOpacity(
                0.95,
              ),

              borderRadius:
              BorderRadius.circular(
                24,
              ),
            ),

            child: Row(
              children: [
                Container(
                  width: 55,
                  height: 55,

                  decoration:
                  const BoxDecoration(
                    color:
                    Color(0xFF3949AB),
                    shape:
                    BoxShape.circle,
                  ),

                  alignment:
                  Alignment.center,

                  child: Text(
                    '${mission.targetNumber}',

                    style:
                    const TextStyle(
                      color:
                      Colors.white,

                      fontSize: 25,

                      fontWeight:
                      FontWeight.w900,
                    ),
                  ),
                ),

                const SizedBox(
                  width: 12,
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                    children: [
                      const Text(
                        'MISSION',

                        style:
                        TextStyle(
                          color:
                          Colors.grey,

                          fontSize: 11,

                          fontWeight:
                          FontWeight
                              .w800,
                        ),
                      ),

                      Text(
                        mission.title,

                        style:
                        const TextStyle(
                          fontSize: 20,

                          fontWeight:
                          FontWeight
                              .w900,
                        ),
                      ),

                      Text(
                        mission
                            .instruction,

                        style:
                        const TextStyle(
                          color:
                          Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _hud(
      String icon,
      String value,
      ) {
    return Container(
      padding:
      const EdgeInsets.symmetric(
        horizontal: 13,
        vertical: 9,
      ),

      decoration:
      BoxDecoration(
        color:
        Colors.black.withOpacity(
          0.35,
        ),

        borderRadius:
        BorderRadius.circular(
          18,
        ),
      ),

      child: Text(
        '$icon $value',

        style:
        const TextStyle(
          color: Colors.white,

          fontWeight:
          FontWeight.w900,
        ),
      ),
    );
  }

  // ------------------------------------------------
  // CONTROLS
  // ------------------------------------------------

  Widget _buildControls() {
    return Positioned(
      left: 20,
      right: 20,
      bottom: 30,

      child: Row(
        mainAxisAlignment:
        MainAxisAlignment
            .spaceBetween,

        children: [
          _control(
            Icons
                .keyboard_arrow_left_rounded,
                () {
              movePlayer(-0.08);
            },
          ),

          Container(
            padding:
            const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 10,
            ),

            decoration:
            BoxDecoration(
              color:
              Colors.black.withOpacity(
                0.35,
              ),

              borderRadius:
              BorderRadius.circular(
                20,
              ),
            ),

            child: const Text(
              'SWIPE TO RUN',

              style:
              TextStyle(
                color: Colors.white,

                fontWeight:
                FontWeight.w900,
              ),
            ),
          ),

          _control(
            Icons
                .keyboard_arrow_right_rounded,
                () {
              movePlayer(0.08);
            },
          ),
        ],
      ),
    );
  }

  Widget _control(
      IconData icon,
      VoidCallback callback,
      ) {
    return GestureDetector(
      onTap: callback,

      child: Container(
        width: 65,
        height: 65,

        decoration:
        const BoxDecoration(
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

        child: Icon(
          icon,
          size: 40,
          color:
          Color(0xFF3949AB),
        ),
      ),
    );
  }

  @override
  void dispose() {
    numberCollisionTimer?.cancel();

    obstacleCollisionTimer?.cancel();

    worldAnimation.dispose();

    numberAnimation.dispose();

    obstacleAnimation.dispose();

    controller.dispose();

    super.dispose();
  }
}