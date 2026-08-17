import '../models/number_game_model.dart';

final List<NumberMissionModel> numberMissions = [
  NumberMissionModel(
    id: 1,
    targetNumber: 5,
    title: 'Find 5',
    instruction: 'Collect the number 5',
    objects: [
      NumberObjectModel(
        id: 'number_5',
        number: 5,
        correct: true,
        x: 0.30,
        depth: 0.85,
      ),
      NumberObjectModel(
        id: 'number_2',
        number: 2,
        correct: false,
        x: 0.70,
        depth: 0.65,
      ),
      NumberObjectModel(
        id: 'number_8',
        number: 8,
        correct: false,
        x: 0.50,
        depth: 0.75,
      ),
    ],
  ),

  NumberMissionModel(
    id: 2,
    targetNumber: 8,
    title: 'Find 8',
    instruction: 'Collect the number 8',
    objects: [
      NumberObjectModel(
        id: 'number_8',
        number: 8,
        correct: true,
        x: 0.70,
        depth: 0.85,
      ),
      NumberObjectModel(
        id: 'number_3',
        number: 3,
        correct: false,
        x: 0.30,
        depth: 0.65,
      ),
      NumberObjectModel(
        id: 'number_6',
        number: 6,
        correct: false,
        x: 0.50,
        depth: 0.75,
      ),
    ],
  ),

  NumberMissionModel(
    id: 3,
    targetNumber: 12,
    title: 'Find 12',
    instruction: 'Collect the number 12',
    objects: [
      NumberObjectModel(
        id: 'number_12',
        number: 12,
        correct: true,
        x: 0.50,
        depth: 0.85,
      ),
      NumberObjectModel(
        id: 'number_7',
        number: 7,
        correct: false,
        x: 0.25,
        depth: 0.65,
      ),
      NumberObjectModel(
        id: 'number_10',
        number: 10,
        correct: false,
        x: 0.75,
        depth: 0.75,
      ),
    ],
  ),

  NumberMissionModel(
    id: 4,
    targetNumber: 20,
    title: 'Find 20',
    instruction: 'Collect the number 20',
    objects: [
      NumberObjectModel(
        id: 'number_20',
        number: 20,
        correct: true,
        x: 0.25,
        depth: 0.85,
      ),
      NumberObjectModel(
        id: 'number_15',
        number: 15,
        correct: false,
        x: 0.55,
        depth: 0.70,
      ),
      NumberObjectModel(
        id: 'number_25',
        number: 25,
        correct: false,
        x: 0.75,
        depth: 0.75,
      ),
    ],
  ),
];