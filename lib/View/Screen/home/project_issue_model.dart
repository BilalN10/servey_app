class ProjectIssueModel {
  final int projectId;
  final String system;
  final String subsystem;
  final String category;
  final String description;
  final String descriptionOriginalLanguage;
  final String reference;
  final String location;
  final String recorder;
  final String recorded;
  final String responsibleCompany;
  final String responsibleEmployer;
  final String deadLine;
  final String priority;
  final String status;

  ProjectIssueModel({
    required this.projectId,
    required this.system,
    required this.subsystem,
    required this.category,
    required this.description,
    required this.descriptionOriginalLanguage,
    required this.reference,
    required this.location,
    required this.recorder,
    required this.recorded,
    required this.responsibleCompany,
    required this.responsibleEmployer,
    required this.deadLine,
    required this.priority,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'project_id': projectId,
      'system': system,
      'subsystem': subsystem,
      'category': category,
      'description': description,
      'description_original_language': descriptionOriginalLanguage,
      'reference': reference,
      'location': location,
      'recorder': recorder,
      'recorded': recorded,
      'responsible_company': responsibleCompany,
      'responsible_employer': responsibleEmployer,
      'dead_line': deadLine,
      'priority': priority,
      'status': status,
    };
  }
}
