class NumberObjectModel {
  final String id;
  final int number;
  final bool correct;
  final double x;
  final double depth;

  const NumberObjectModel({
    required this.id,
    required this.number,
    required this.correct,
    required this.x,
    required this.depth,
  });
}

class NumberMissionModel {
  final int id;
  final int targetNumber;
  final String title;
  final String instruction;
  final List<NumberObjectModel> objects;

  const NumberMissionModel({
    required this.id,
    required this.targetNumber,
    required this.title,
    required this.instruction,
    required this.objects,
  });
}