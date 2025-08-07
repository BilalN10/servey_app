import 'package:get/get.dart';
import 'package:survey_markus/View/Screen/home/home_model.dart';
import 'package:survey_markus/View/Screen/home/project_issue_model.dart';
import 'package:survey_markus/service/api_client.dart';
import 'package:survey_markus/service/api_url.dart';
import 'dart:convert';

class HomeController extends GetxController {
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
    tasks = List.from(allTasks);
    update();
  }

  // Priority: Assuming 'High' > 'Medium' > 'Low'
  int _priorityValue(String p) {
    switch (p) {
      case 'High':
        return 3;
      case 'Medium':
        return 2;
      case 'Low':
        return 1;
      default:
        return 0;
    }
  }

  void sortByPriority({bool? ascending}) {
    if (currentSortField == 'Priority' && isAscending == ascending) {
      // Reset sort if clicking the same option
      resetSort();
    } else {
      currentSortField = 'Priority';
      isAscending = ascending;
      tasks.sort((a, b) {
        int comparison = _priorityValue(
          a.priority,
        ).compareTo(_priorityValue(b.priority));
        return ascending == true ? comparison : -comparison;
      });
    }
    update();
  }

  void sortByDeadline({bool? ascending}) {
    if (currentSortField == 'Deadline' && isAscending == ascending) {
      // Reset sort if clicking the same option
      resetSort();
    } else {
      currentSortField = 'Deadline';
      isAscending = ascending;
      tasks.sort((a, b) {
        int comparison = a.deadline.compareTo(b.deadline);
        return ascending == true ? comparison : -comparison;
      });
    }
    update();
  }

  void sortByRecordingDate({bool? ascending}) {
    if (currentSortField == 'Recording' && isAscending == ascending) {
      // Reset sort if clicking the same option
      resetSort();
    } else {
      currentSortField = 'Recording';
      isAscending = ascending;
      tasks.sort((a, b) {
        int comparison = a.recordingDate.compareTo(b.recordingDate);
        return ascending == true ? comparison : -comparison;
      });
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
      final body = jsonEncode(projectIssue.toJson());

      // Make API call
      final response = await ApiClient.postData(
        ApiUrl.createProjectIssue,
        body,
      );

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
}
