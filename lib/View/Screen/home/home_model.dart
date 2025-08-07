class HomeModel {
  final String description;

  bool isFav;
  final String priority;
  final DateTime deadline;
  final DateTime recordingDate;

  HomeModel({
    required this.description,
    required this.isFav,
    required this.priority,
    required this.deadline,
    required this.recordingDate,
  });
}
