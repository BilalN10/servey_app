import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:survey_markus/View/Screen/home/home_model.dart';
import 'package:survey_markus/View/Screen/home/model/project_issue_model.dart';
import 'package:survey_markus/View/Screen/home/model/project_configuration_model.dart';
import 'package:survey_markus/service/api_client.dart';
import 'package:survey_markus/service/api_url.dart';
import 'package:survey_markus/service/api_check.dart';
import 'package:survey_markus/utils/AppConst/app_const.dart';
import 'package:survey_markus/utils/ToastMsg/toast_message.dart';
import 'dart:convert';

class HomeController extends GetxController {
  // Observable for project issues
  final projectIssuesLoading = Status.loading.obs;
  void projectIssuesLoadingMethod(Status value) =>
      projectIssuesLoading.value = value;

  RxList<ProjectIssueModel> projectIssuesList = <ProjectIssueModel>[].obs;

  // Store original list for search functionality
  RxList<ProjectIssueModel> originalProjectIssuesList =
      <ProjectIssueModel>[].obs;

  // Search controller
  final searchController = TextEditingController();

  // Local filter states for Frontend Workaround
  final deadLineFrom = Rxn<DateTime>();
  final deadLineTo = Rxn<DateTime>();

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  // Unified method to apply both local filters (deadline) and search query
  void _applyFiltersAndSearch() {
    print('Applying filters and search locally...');
    final searchQuery = searchController.text.trim().toLowerCase();

    final filtered = originalProjectIssuesList.where((issue) {
      // 1. Search filter
      bool matchesSearch = true;
      if (searchQuery.isNotEmpty) {
        matchesSearch = issue.description.toLowerCase().contains(searchQuery);
      }

      // 2. Deadline range filter (Frontend Workaround)
      bool matchesDeadline = true;
      if (deadLineFrom.value != null || deadLineTo.value != null) {
        final issueDeadline = _parseDate(issue.deadLine);
        if (issueDeadline == null) {
          matchesDeadline = false;
        } else {
          // Normalize dates to remove time parts for comparison
          final d = DateTime(
              issueDeadline.year, issueDeadline.month, issueDeadline.day);

          if (deadLineFrom.value != null) {
            final from = DateTime(deadLineFrom.value!.year,
                deadLineFrom.value!.month, deadLineFrom.value!.day);
            if (d.isBefore(from)) matchesDeadline = false;
          }

          if (deadLineTo.value != null) {
            final to = DateTime(deadLineTo.value!.year, deadLineTo.value!.month,
                deadLineTo.value!.day);
            if (d.isAfter(to)) matchesDeadline = false;
          }
        }
      }

      return matchesSearch && matchesDeadline;
    }).toList();

    projectIssuesList.value = filtered;
    print('Final filtered list count: ${projectIssuesList.length}');
    update();
  }

  // Search project issues by description
  void searchProjectIssues(String query) {
    _applyFiltersAndSearch();
  }

  // Observable for project configurations
  final projectConfigurationsLoading = Status.loading.obs;
  void projectConfigurationsLoadingMethod(Status value) =>
      projectConfigurationsLoading.value = value;

  RxList<FieldConfiguration> projectConfigurationsList =
      <FieldConfiguration>[].obs;

  List<HomeModel> allTasks = [
    HomeModel(
      description:
          "Customer reference as a property of the inventory (according to migration data): In the case of HOE, the 'special stock' is a sales order stock (with the sales order...",
      isFav: false,
      priority: 'High',
      deadline: DateTime.now().add(Duration(days: 2)),
      recordingDate: DateTime.now().subtract(Duration(days: 1)),
    ),
    HomeModel(
      description:
          "Customer reference as a property of the inventory (according to migration data): In the case of HOE, the 'special stock' is a sales order stock (with the sales order...",
      isFav: true,
      priority: 'Low',
      deadline: DateTime.now().add(Duration(days: 1)),
      recordingDate: DateTime.now().subtract(Duration(days: 2)),
    ),
    // Add more HomeModel items as needed
  ];

  List<HomeModel> tasks = [];
  String? currentSortField;
  bool? isAscending;

  @override
  void onInit() {
    super.onInit();
    tasks = List.from(allTasks);
  }

  void resetSort() {
    currentSortField = null;
    isAscending = null;
    // Reload original data - this will be handled by calling getProjectIssuesByProject
    update();
  }

  // Priority: Convert API values (1,2,3) to numeric for sorting
  int _priorityValue(String? p) {
    if (p == null) return 0;
    try {
      return int.parse(p);
    } catch (e) {
      // Handle text values
      switch (p.toLowerCase()) {
        case 'high':
          return 3;
        case 'medium':
          return 2;
        case 'low':
          return 1;
        default:
          return 0;
      }
    }
  }

  // Parse date string to DateTime for comparison
  DateTime? _parseDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return null;
    try {
      return DateTime.parse(dateStr);
    } catch (e) {
      return null;
    }
  }

  // Generic sort method
  void _sortProjectIssues(String field, bool? ascending) {
    final list = List<ProjectIssueModel>.from(projectIssuesList);

    list.sort((a, b) {
      int comparison = 0;

      switch (field) {
        case 'Priority':
          comparison =
              _priorityValue(a.priority).compareTo(_priorityValue(b.priority));
          break;
        case 'Deadline':
          final dateA = _parseDate(a.deadLine);
          final dateB = _parseDate(b.deadLine);
          if (dateA == null && dateB == null)
            comparison = 0;
          else if (dateA == null)
            comparison = 1;
          else if (dateB == null)
            comparison = -1;
          else
            comparison = dateA.compareTo(dateB);
          break;
        case 'Recording':
          final dateA = _parseDate(a.recorded);
          final dateB = _parseDate(b.recorded);
          if (dateA == null && dateB == null)
            comparison = 0;
          else if (dateA == null)
            comparison = 1;
          else if (dateB == null)
            comparison = -1;
          else
            comparison = dateA.compareTo(dateB);
          break;
        case 'System':
          comparison = (a.system ?? '').compareTo(b.system ?? '');
          break;
        case 'Subsystem':
          comparison = (a.subsystem ?? '').compareTo(b.subsystem ?? '');
          break;
        case 'Category':
          comparison = (a.category ?? '').compareTo(b.category ?? '');
          break;
        case 'Location':
          comparison = (a.location ?? '').compareTo(b.location ?? '');
          break;
        case 'Status':
          comparison = (a.status ?? '').compareTo(b.status ?? '');
          break;
        case 'Reference':
          comparison = (a.reference ?? '').compareTo(b.reference ?? '');
          break;
        case 'Recorder':
          comparison = (a.recorder ?? '').compareTo(b.recorder ?? '');
          break;
        case 'Responsible Company':
          comparison = (a.responsibleCompany ?? '')
              .compareTo(b.responsibleCompany ?? '');
          break;
        case 'Responsible Employer':
          comparison = (a.responsibleEmployer ?? '')
              .compareTo(b.responsibleEmployer ?? '');
          break;
        case 'Completed On':
          final dateA = _parseDate(a.completedOn);
          final dateB = _parseDate(b.completedOn);
          if (dateA == null && dateB == null)
            comparison = 0;
          else if (dateA == null)
            comparison = 1;
          else if (dateB == null)
            comparison = -1;
          else
            comparison = dateA.compareTo(dateB);
          break;
        case 'Completed By':
          comparison = (a.completedBy ?? '').compareTo(b.completedBy ?? '');
          break;
        default:
          comparison = 0;
      }

      return ascending == true ? comparison : -comparison;
    });

    projectIssuesList.value = list;
  }

  void sortByPriority({bool? ascending}) {
    if (currentSortField == 'Priority' && isAscending == ascending) {
      resetSort();
    } else {
      currentSortField = 'Priority';
      isAscending = ascending;
      _sortProjectIssues('Priority', ascending);
    }
    update();
  }

  void sortByDeadline({bool? ascending}) {
    if (currentSortField == 'Deadline' && isAscending == ascending) {
      resetSort();
    } else {
      currentSortField = 'Deadline';
      isAscending = ascending;
      _sortProjectIssues('Deadline', ascending);
    }
    update();
  }

  void sortByRecordingDate({bool? ascending}) {
    if (currentSortField == 'Recording' && isAscending == ascending) {
      resetSort();
    } else {
      currentSortField = 'Recording';
      isAscending = ascending;
      _sortProjectIssues('Recording', ascending);
    }
    update();
  }

  void sortBySystem({bool? ascending}) {
    if (currentSortField == 'System' && isAscending == ascending) {
      resetSort();
    } else {
      currentSortField = 'System';
      isAscending = ascending;
      _sortProjectIssues('System', ascending);
    }
    update();
  }

  void sortBySubsystem({bool? ascending}) {
    if (currentSortField == 'Subsystem' && isAscending == ascending) {
      resetSort();
    } else {
      currentSortField = 'Subsystem';
      isAscending = ascending;
      _sortProjectIssues('Subsystem', ascending);
    }
    update();
  }

  void sortByCategory({bool? ascending}) {
    if (currentSortField == 'Category' && isAscending == ascending) {
      resetSort();
    } else {
      currentSortField = 'Category';
      isAscending = ascending;
      _sortProjectIssues('Category', ascending);
    }
    update();
  }

  void sortByLocation({bool? ascending}) {
    if (currentSortField == 'Location' && isAscending == ascending) {
      resetSort();
    } else {
      currentSortField = 'Location';
      isAscending = ascending;
      _sortProjectIssues('Location', ascending);
    }
    update();
  }

  void sortByStatus({bool? ascending}) {
    if (currentSortField == 'Status' && isAscending == ascending) {
      resetSort();
    } else {
      currentSortField = 'Status';
      isAscending = ascending;
      _sortProjectIssues('Status', ascending);
    }
    update();
  }

  void sortByField(String field, {bool? ascending}) {
    if (currentSortField == field && isAscending == ascending) {
      resetSort();
    } else {
      currentSortField = field;
      isAscending = ascending;
      _sortProjectIssues(field, ascending);
    }
    update();
  }

  void showStarred() {
    tasks = allTasks.where((task) => task.isFav).toList();
    update();
  }

  void showAll() {
    tasks = List.from(allTasks);
    update();
  }

  void changeFav(int index) {
    tasks[index].isFav = !tasks[index].isFav;
    // Also update in allTasks if needed
    int allIndex = allTasks.indexWhere(
      (t) => t.description == tasks[index].description,
    );
    if (allIndex != -1) {
      allTasks[allIndex].isFav = tasks[index].isFav;
    }
    update();
  }

  /// Update project issue
  Future<Map<String, dynamic>> updateProjectIssue({
    required String issueId,
    required String projectId,
    required String system,
    required String subsystem,
    required String category,
    required String location,
    required String description,
    required String descriptionOriginalLanguage,
    required String responsibleCompany,
    required String responsibleEmployer,
    required String status,
    required String priority,
    required String deadLine,
  }) async {
    try {
      final body = jsonEncode({
        "project_id": projectId,
        'system': system,
        'subsystem': subsystem,
        'category': category,
        'location': location,
        'description': description,
        'description_original_language': descriptionOriginalLanguage,
        'responsible_company': responsibleCompany,
        'responsible_employer': responsibleEmployer,
        'status': status,
        'priority': priority,
        'dead_line': deadLine,
      });

      print('Update Issue Body: $body');

      final apiClient = ApiClient();

      final response = await apiClient.putData(
        ApiUrl.updateProjectIssue(issueId: issueId),
        body,
      );

      print('Update response status: ${response.statusCode}');
      print('Update response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'data': response.body,
          'message': 'Project issue updated successfully',
        };
      } else {
        return {
          'success': false,
          'message':
              response.body?['message'] ?? 'Failed to update project issue',
          'statusCode': response.statusCode,
        };
      }
    } catch (e) {
      print('Exception in updateProjectIssue: $e');
      return {
        'success': false,
        'message': 'Error updating project issue: ${e.toString()}',
      };
    }
  }

  /// Get project issues by project ID
  getProjectIssuesByProject({required String projectId}) async {
    // Reset local frontend filters
    deadLineFrom.value = null;
    deadLineTo.value = null;

    projectIssuesList.clear();
    originalProjectIssuesList.clear();
    projectIssuesLoadingMethod(Status.loading);

    var response = await ApiClient.getData(
      ApiUrl.getProjectIssuesByProject(projectId: projectId),
    );

    print("Project Issues Response: ${response.body}");

    if (response.statusCode == 200) {
      if (response.body["data"] != null) {
        final issues = List<ProjectIssueModel>.from(
          response.body["data"].map((x) => ProjectIssueModel.fromJson(x)),
        ).reversed.toList();
        // Update both lists
        originalProjectIssuesList.value = issues;
        // Apply local filtering (deadline) and search query
        _applyFiltersAndSearch();
        print("Loaded ${issues.length} project issues");
        print("Original list count: ${originalProjectIssuesList.length}");
        print("Display list count: ${projectIssuesList.length}");
      }

      update();

      projectIssuesLoadingMethod(Status.completed);
      refresh();
    } else if (response.statusCode == 404) {
      projectIssuesLoadingMethod(Status.completed);
      toastMessage(
          message: response.body["message"] ?? "No project issues found");
    } else {
      if (response.statusText == ApiClient.noInternetMessage) {
        projectIssuesLoadingMethod(Status.internetError);
      } else {
        projectIssuesLoadingMethod(Status.error);
      }
      ApiChecker.checkApi(response);
    }
  }

  /// Create a new project issue
  Future<Map<String, dynamic>> createProjectIssue({
    required int projectId,
    required String system,
    required String subsystem,
    required String category,
    required String description,
    required String descriptionOriginalLanguage,
    required String reference,
    required String location,
    required String recorder,
    required String recorded,
    required String responsibleCompany,
    required String responsibleEmployer,
    required String deadLine,
    required String priority,
    required String status,
  }) async {
    try {
      // Create the project issue model
      final projectIssue = ProjectIssueModel(
        projectId: projectId,
        system: system,
        subsystem: subsystem,
        category: category,
        description: description,
        descriptionOriginalLanguage: descriptionOriginalLanguage,
        reference: reference,
        location: location,
        recorder: recorder,
        recorded: recorded,
        responsibleCompany: responsibleCompany,
        responsibleEmployer: responsibleEmployer,
        deadLine: deadLine,
        priority: priority,
        status: status,
      );

      // Convert to JSON
      final jsonData = projectIssue.toJson();
      print('JSON data before encoding: $jsonData');
      final body = jsonEncode(jsonData);
      print('body is $body');

      // Make API call
      final response = await ApiClient.postData(
        ApiUrl.createProjectIssue,
        body,
      );
      print('response status code: ${response.statusCode}');
      print('response body: ${response.body}');
      print('response status text: ${response.statusText}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Success
        return {
          'success': true,
          'data': response.body,
          'message': 'Project issue created successfully',
        };
      } else {
        // Error
        return {
          'success': false,
          'message':
              response.body?['message'] ?? 'Failed to create project issue',
          'statusCode': response.statusCode,
        };
      }
    } catch (e) {
      print('Exception in createProjectIssue: $e');
      print('Exception stack trace: ${e.toString()}');
      return {
        'success': false,
        'message': 'Error creating project issue: ${e.toString()}',
      };
    }
  }

  /// Example usage function with sample data
  Future<void> createSampleProjectIssue() async {
    final result = await createProjectIssue(
      projectId: 1,
      system: "System A",
      subsystem: "Subsystem 1",
      category: "Bug",
      description: "Issue description",
      descriptionOriginalLanguage: "Original description",
      reference: "REF-001",
      location: "Location details",
      recorder: "John Doe",
      recorded: "2025-06-24",
      responsibleCompany: "Company Name",
      responsibleEmployer: "Employer Name",
      deadLine: "2025-07-24",
      priority: "High",
      status: "Open",
    );

    if (result['success']) {
      print('Project issue created successfully: ${result['data']}');
    } else {
      print('Failed to create project issue: ${result['message']}');
    }
  }

  /// Get project issues with configurations by project ID
  getProjectIssuesWithConfigurations({required String projectId}) async {
    print("Project ID: $projectId");
    projectConfigurationsList.clear();
    projectConfigurationsLoadingMethod(Status.loading);

    var response = await ApiClient.getData(
      ApiUrl.getProjectIssuesWithConfigurations(projectId: projectId),
    );

    print("Project Issues with Configurations Response: ${response.body}");

    if (response.statusCode == 200) {
      if (response.body["data"] != null) {
        try {
          final projectConfigurationModel =
              ProjectConfigurationModel.fromJson(response.body);
          projectConfigurationsList.value =
              projectConfigurationModel.fieldConfigurations;
        } catch (e) {
          print('Error parsing project configurations: $e');
          projectConfigurationsLoadingMethod(Status.error);
          toastMessage(message: "Error parsing project configurations");
          return;
        }
      }

      projectConfigurationsLoadingMethod(Status.completed);
      refresh();
    } else if (response.statusCode == 404) {
      projectConfigurationsLoadingMethod(Status.completed);
      toastMessage(
          message:
              response.body["message"] ?? "No project configurations found");
    } else {
      if (response.statusText == ApiClient.noInternetMessage) {
        projectConfigurationsLoadingMethod(Status.internetError);
      } else {
        projectConfigurationsLoadingMethod(Status.error);
      }
      ApiChecker.checkApi(response);
    }
  }

  /// Get filtered project issues with configurations
  Future<void> getFilteredProjectIssues({
    required String projectId,
    Map<String, String>? filters,
  }) async {
    // 1. Handle local frontend filters (Workaround)
    deadLineFrom.value = null;
    deadLineTo.value = null;

    if (filters != null) {
      if (filters.containsKey('dead_line_from')) {
        deadLineFrom.value = _parseDate(filters['dead_line_from']);
        filters.remove('dead_line_from');
      }
      if (filters.containsKey('dead_line_to')) {
        deadLineTo.value = _parseDate(filters['dead_line_to']);
        filters.remove('dead_line_to');
      }
      if (filters.containsKey('dead_line_date_range')) {
        final range = filters['dead_line_date_range'];
        if (range != null && range.contains(',')) {
          final parts = range.split(',');
          if (parts.length == 2) {
            deadLineFrom.value = _parseDate(parts[0]);
            deadLineTo.value = _parseDate(parts[1]);
          }
        }
        filters.remove('dead_line_date_range');
      }
    }

    projectIssuesList.clear();
    projectIssuesLoadingMethod(Status.loading);

    var response = await ApiClient.getData(
      ApiUrl.getProjectIssuesWithConfigurationsAndFilters(
        projectId: projectId,
        queryParams: filters,
      ),
    );

    print("Filtered Project Issues Response: ${response.body}");

    if (response.statusCode == 200) {
      if (response.body["data"] != null) {
        List<ProjectIssueModel> issues = [];
        // Check if response has issues array (from filter API)
        if (response.body["data"]["issues"] != null) {
          issues = List<ProjectIssueModel>.from(
            response.body["data"]["issues"]
                .map((x) => ProjectIssueModel.fromJson(x)),
          );
        }
        // Check if response has project_issues array
        else if (response.body["data"]["project_issues"] != null) {
          issues = List<ProjectIssueModel>.from(
            response.body["data"]["project_issues"]
                .map((x) => ProjectIssueModel.fromJson(x)),
          );
        }
        // If data is directly a list
        else if (response.body["data"] is List) {
          issues = List<ProjectIssueModel>.from(
            response.body["data"].map((x) => ProjectIssueModel.fromJson(x)),
          );
        }

        // Reverse list to show newest first
        issues = issues.reversed.toList();

        // Update both lists
        originalProjectIssuesList.value = issues;
        print("Filtered: Loaded ${issues.length} project issues");
        print(
            "Filtered: Original list count: ${originalProjectIssuesList.length}");

        // 2. Apply local filtering (deadline) and search query
        _applyFiltersAndSearch();
        print("Filtered: Display list count: ${projectIssuesList.length}");
      }

      update();
      projectIssuesLoadingMethod(Status.completed);
      refresh();
    } else if (response.statusCode == 404) {
      projectIssuesLoadingMethod(Status.completed);
      projectIssuesList.clear();
      toastMessage(
          message: response.body["message"] ?? "No project issues found");
    } else {
      if (response.statusText == ApiClient.noInternetMessage) {
        projectIssuesLoadingMethod(Status.internetError);
      } else {
        projectIssuesLoadingMethod(Status.error);
      }
      ApiChecker.checkApi(response);
    }
  }
}
