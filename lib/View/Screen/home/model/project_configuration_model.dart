class ProjectConfigurationModel {
  final List<FieldConfiguration> fieldConfigurations;

  ProjectConfigurationModel({
    required this.fieldConfigurations,
  });

  factory ProjectConfigurationModel.fromJson(Map<String, dynamic> json) {
    return ProjectConfigurationModel(
      fieldConfigurations:
          (json['data']['field_configurations'] as List<dynamic>?)
                  ?.map((x) => FieldConfiguration.fromJson(x))
                  .toList() ??
              [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'field_configurations':
          fieldConfigurations.map((x) => x.toJson()).toList(),
    };
  }
}

class FieldConfiguration {
  final int id;
  final int projectId;
  final String fieldName;
  final String fieldLabel;
  final String fieldType;
  final List<String>? dropdownOptions;
  final bool isRequired;
  final bool isHidden;
  final bool isActive;
  final int sortOrder;
  final String createdAt;
  final String updatedAt;

  FieldConfiguration({
    required this.id,
    required this.projectId,
    required this.fieldName,
    required this.fieldLabel,
    required this.fieldType,
    this.dropdownOptions,
    required this.isRequired,
    required this.isHidden,
    required this.isActive,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FieldConfiguration.fromJson(Map<String, dynamic> json) {
    return FieldConfiguration(
      id: json['id'] ?? 0,
      projectId: json['project_id'] ?? 0,
      fieldName: json['field_name'] ?? '',
      fieldLabel: json['field_label'] ?? '',
      fieldType: json['field_type'] ?? '',
      dropdownOptions: json['dropdown_options'] != null
          ? List<String>.from(json['dropdown_options'])
          : null,
      isRequired: json['is_required'] ?? false,
      isHidden: json['is_hidden'] ?? false,
      isActive: json['is_active'] ?? true,
      sortOrder: json['sort_order'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'project_id': projectId,
      'field_name': fieldName,
      'field_label': fieldLabel,
      'field_type': fieldType,
      'dropdown_options': dropdownOptions,
      'is_required': isRequired,
      'is_hidden': isHidden,
      'is_active': isActive,
      'sort_order': sortOrder,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
