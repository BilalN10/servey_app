import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:survey_markus/View/Screen/home/home_controller.dart';
import 'package:survey_markus/View/widgets/custom_dropdown.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';

class SortAndFilterData extends StatelessWidget {
  const SortAndFilterData({
    super.key,
    required this.homeController,
    required this.projectId,
  });

  final HomeController homeController;
  final String projectId;

  // Get sortable fields from configurations
  List<Map<String, String>> _getSortableFields() {
    final sortableFields = [
      {'fieldName': 'location', 'displayName': 'Location'},
      {'fieldName': 'priority', 'displayName': 'Priority'},
      {'fieldName': 'status', 'displayName': 'Status'},
      {'fieldName': 'recorder', 'displayName': 'Creator (Recorder)'},
      {
        'fieldName': 'responsible_employer',
        'displayName': 'Responsible Employee'
      },
      {'fieldName': 'recorded', 'displayName': 'Recording Date'},
      {'fieldName': 'dead_line', 'displayName': 'Deadline'},
    ];

    // Filter: 'location' is only shown if it exists in configurations and is not hidden.
    // All other fields are always shown.
    return sortableFields.where((field) {
      if (field['fieldName'] == 'location') {
        return homeController.projectConfigurationsList.any(
          (config) =>
              config.fieldName == 'location' &&
              config.isActive &&
              !config.isHidden,
        );
      }
      return true;
    }).toList();
  }

  // Get field label from configurations
  String _getFieldLabel(String fieldName) {
    try {
      final config = homeController.projectConfigurationsList.firstWhere(
        (config) => config.fieldName == fieldName,
        orElse: () => throw StateError('Config not found'),
      );
      return config.fieldLabel;
    } catch (e) {
      return fieldName;
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey sortKey = GlobalKey();
    return GetBuilder<HomeController>(
      builder: (controller) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                key: sortKey,
                onTap: () async {
                  final RenderBox renderBox =
                      sortKey.currentContext!.findRenderObject() as RenderBox;
                  final Offset offset = renderBox.localToGlobal(Offset.zero);
                  final Size size = renderBox.size;

                  // Build sort menu items dynamically from configurations
                  final sortableFields = _getSortableFields();
                  final menuItems = <PopupMenuEntry<String>>[];

                  // Add sortable fields
                  for (var field in sortableFields) {
                    final fieldName = field['fieldName']!;
                    final displayName = field['displayName']!;
                    final fieldLabel = _getFieldLabel(fieldName);

                    // Map field names to controller method names
                    String controllerFieldName = displayName;
                    if (fieldName == 'recorded')
                      controllerFieldName = 'Recording';
                    if (fieldName == 'dead_line')
                      controllerFieldName = 'Deadline';

                    menuItems.add(
                      PopupMenuItem(
                        value: '${controllerFieldName}_Asc',
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(fieldLabel),
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    if (homeController.currentSortField ==
                                            controllerFieldName &&
                                        homeController.isAscending == true) {
                                      homeController.resetSort();
                                      Navigator.pop(context);
                                    } else {
                                      Navigator.pop(context,
                                          '${controllerFieldName}_Asc');
                                    }
                                  },
                                  child: Text('↑'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (homeController.currentSortField ==
                                            controllerFieldName &&
                                        homeController.isAscending == false) {
                                      homeController.resetSort();
                                      Navigator.pop(context);
                                    } else {
                                      Navigator.pop(context,
                                          '${controllerFieldName}_Desc');
                                    }
                                  },
                                  child: Text('↓'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  final selected = await showMenu<String>(
                    context: context,
                    position: RelativeRect.fromLTRB(
                      offset.dx,
                      offset.dy + size.height,
                      offset.dx + size.width,
                      offset.dy,
                    ),
                    items: menuItems,
                  );

                  if (selected == null) return;

                  // Handle field-specific sorting
                  if (selected.endsWith('_Asc')) {
                    final fieldName = selected.replaceAll('_Asc', '');
                    homeController.sortByField(fieldName, ascending: true);
                  } else if (selected.endsWith('_Desc')) {
                    final fieldName = selected.replaceAll('_Desc', '');
                    homeController.sortByField(fieldName, ascending: false);
                  }
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/icons/sort.svg'),
                      const SizedBox(width: 10),
                      const CustomText(
                        text: 'Sort',
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => FilterDialogWidget(
                      projectId: projectId,
                    ),
                  );
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/icons/filter.svg'),
                      SizedBox(width: 10),
                      CustomText(
                        text: 'Filter',
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FilterDialogWidget extends StatefulWidget {
  const FilterDialogWidget({super.key, required this.projectId});

  final String projectId;

  @override
  State<FilterDialogWidget> createState() => _FilterDialogWidgetState();
}

class _FilterDialogWidgetState extends State<FilterDialogWidget> {
  final HomeController controller = Get.find<HomeController>();

  // Text controllers
  final TextEditingController recorderController = TextEditingController();
  final TextEditingController responsibleEmployerController =
      TextEditingController();

  // Date controllers
  DateTime? deadlineFrom;
  DateTime? deadlineTo;

  // Dropdown selections
  String? selectedSystem;
  String? selectedSubsystem;
  String? selectedCategory;
  String? selectedLocation;
  String? selectedPriority;
  String? selectedStatus;

  @override
  void dispose() {
    recorderController.dispose();
    responsibleEmployerController.dispose();
    super.dispose();
  }

  // Get dropdown options from configurations
  List<String> _getDropdownOptions(String fieldName) {
    try {
      final config = controller.projectConfigurationsList.firstWhere(
        (config) =>
            config.fieldName == fieldName &&
            config.isActive &&
            !config.isHidden &&
            config.dropdownOptions != null,
        orElse: () => throw StateError('Config not found'),
      );
      return config.dropdownOptions ?? [];
    } catch (e) {
      return [];
    }
  }

  // Check if field exists in configurations
  bool _fieldExists(String fieldName) {
    return controller.projectConfigurationsList.any(
      (config) =>
          config.fieldName == fieldName && config.isActive && !config.isHidden,
    );
  }

  // Get field label from configurations
  String _getFieldLabel(String fieldName) {
    try {
      final config = controller.projectConfigurationsList.firstWhere(
        (config) => config.fieldName == fieldName,
        orElse: () => throw StateError('Config not found'),
      );
      return config.fieldLabel;
    } catch (e) {
      return fieldName;
    }
  }

  void clearFilters() async {
    // Clear all text controllers
    recorderController.clear();
    responsibleEmployerController.clear();

    // Clear all date selections
    setState(() {
      deadlineFrom = null;
      deadlineTo = null;
    });

    // Clear all dropdown selections
    setState(() {
      selectedSystem = null;
      selectedSubsystem = null;
      selectedCategory = null;
      selectedLocation = null;
      selectedPriority = null;
      selectedStatus = null;
    });

    // Reload all issues without filters
    await controller.getProjectIssuesByProject(projectId: widget.projectId);

    Navigator.pop(context);
  }

  void applyFilters() async {
    // Build query parameters map
    Map<String, String> filters = {};

    if (selectedSystem != null && selectedSystem!.isNotEmpty) {
      filters['system'] = selectedSystem!;
    }
    if (selectedSubsystem != null && selectedSubsystem!.isNotEmpty) {
      filters['subsystem'] = selectedSubsystem!;
    }
    if (selectedCategory != null && selectedCategory!.isNotEmpty) {
      filters['category'] = selectedCategory!;
    }
    if (selectedLocation != null && selectedLocation!.isNotEmpty) {
      filters['location'] = selectedLocation!;
    }
    if (recorderController.text.isNotEmpty) {
      filters['recorder'] = recorderController.text;
    }
    if (responsibleEmployerController.text.isNotEmpty) {
      filters['responsible_employer'] = responsibleEmployerController.text;
    }
    if (deadlineFrom != null && deadlineTo != null) {
      String from = DateFormat('yyyy-MM-dd').format(deadlineFrom!);
      String to = DateFormat('yyyy-MM-dd').format(deadlineTo!);
      filters['dead_line_date_range'] = '$from,$to';
    } else if (deadlineFrom != null) {
      filters['dead_line_from'] =
          DateFormat('yyyy-MM-dd').format(deadlineFrom!);
    } else if (deadlineTo != null) {
      filters['dead_line_to'] = DateFormat('yyyy-MM-dd').format(deadlineTo!);
    }
    if (selectedPriority != null && selectedPriority!.isNotEmpty) {
      filters['priority'] = selectedPriority!;
    }
    if (selectedStatus != null && selectedStatus!.isNotEmpty) {
      filters['status'] = selectedStatus!;
    }

    // Call filter API
    await controller.getFilteredProjectIssues(
      projectId: widget.projectId,
      filters: filters,
    );

    Navigator.pop(context);
  }

  // Build filter widgets based on configurations
  List<Widget> _buildFilterWidgets() {
    final double w = MediaQuery.of(context).size.width;
    List<Widget> widgets = [];

    // Filterable fields from API (in order of appearance)
    // Filterable fields from API (in order of appearance)
    final filterFields = [
      'system',
      'subsystem',
      'category',
      'location',
      'priority',
      'status',
      'dead_line',
      'responsible_employer',
      'recorder',
    ];

    for (var fieldName in filterFields) {
      if (['system', 'subsystem', 'category', 'location'].contains(fieldName)) {
        if (!_fieldExists(fieldName)) continue;
      }

      final fieldLabel = _getFieldLabel(fieldName);
      final options = _getDropdownOptions(fieldName);

      // Build widget based on field type
      if (fieldName == 'system') {
        widgets.add(CustomDropdown(
          width: w * 0.9,
          hintText: fieldLabel,
          items: options.isNotEmpty ? options : [],
          value: selectedSystem,
          onChanged: (value) => setState(() => selectedSystem = value),
        ));
        widgets.add(SizedBox(height: 16));
      } else if (fieldName == 'subsystem') {
        widgets.add(CustomDropdown(
          width: w * 0.9,
          hintText: fieldLabel,
          items: options.isNotEmpty ? options : [],
          value: selectedSubsystem,
          onChanged: (value) => setState(() => selectedSubsystem = value),
        ));
        widgets.add(SizedBox(height: 16));
      } else if (fieldName == 'category') {
        widgets.add(CustomDropdown(
          width: w * 0.9,
          hintText: fieldLabel,
          items: options.isNotEmpty ? options : [],
          value: selectedCategory,
          onChanged: (value) => setState(() => selectedCategory = value),
        ));
        widgets.add(SizedBox(height: 16));
      } else if (fieldName == 'location') {
        widgets.add(CustomDropdown(
          width: w * 0.9,
          hintText: fieldLabel,
          items: options.isNotEmpty ? options : [],
          value: selectedLocation,
          onChanged: (value) => setState(() => selectedLocation = value),
        ));
        widgets.add(SizedBox(height: 16));
      } else if (fieldName == 'priority') {
        // Hardcoded priority options
        widgets.add(CustomDropdown(
          width: w * 0.9,
          hintText: fieldLabel,
          items: ['3', '2', '1'],
          value: selectedPriority,
          onChanged: (value) => setState(() => selectedPriority = value),
        ));
        widgets.add(SizedBox(height: 16));
      } else if (fieldName == 'status') {
        // Hardcoded status options
        widgets.add(CustomDropdown(
          width: w * 0.9,
          hintText: fieldLabel,
          items: [
            'Nicht begonnen',
            'In Arbeit',
            'Im Test',
            'Retest',
            'Erledigt',
            'Zurückgestellt',
          ],
          value: selectedStatus,
          onChanged: (value) => setState(() => selectedStatus = value),
        ));
        widgets.add(SizedBox(height: 16));
      } else if (fieldName == 'dead_line') {
        widgets.add(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5, bottom: 5),
              child: CustomText(
                text: fieldLabel,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomText(
                            text: deadlineFrom != null
                                ? DateFormat('dd/MM/yyyy').format(deadlineFrom!)
                                : 'From',
                            color: deadlineFrom != null
                                ? Colors.black
                                : Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: deadlineFrom ?? DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (picked != null) {
                              setState(() => deadlineFrom = picked);
                            }
                          },
                          child: Icon(Icons.calendar_today,
                              color: Color(0xffebb105), size: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text('-'),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomText(
                            text: deadlineTo != null
                                ? DateFormat('dd/MM/yyyy').format(deadlineTo!)
                                : 'To',
                            color:
                                deadlineTo != null ? Colors.black : Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: deadlineTo ?? DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (picked != null) {
                              setState(() => deadlineTo = picked);
                            }
                          },
                          child: Icon(Icons.calendar_today,
                              color: Color(0xffebb105), size: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
        widgets.add(SizedBox(height: 16));
      } else if (fieldName == 'recorder') {
        widgets.add(TextFormField(
          controller: recorderController,
          decoration: InputDecoration(
            labelText: fieldLabel,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ));
        widgets.add(SizedBox(height: 16));
      } else if (fieldName == 'responsible_employer') {
        widgets.add(TextFormField(
          controller: responsibleEmployerController,
          decoration: InputDecoration(
            labelText: fieldLabel,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ));
        widgets.add(SizedBox(height: 16));
      }
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: SingleChildScrollView(
              child: GetBuilder<HomeController>(
                builder: (controller) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ..._buildFilterWidgets(),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: clearFilters,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[300],
                              foregroundColor: Colors.black,
                              minimumSize: Size(0, 48),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: CustomText(
                              text: 'Clear Filters',
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: applyFilters,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffebb105),
                              foregroundColor: Colors.white,
                              minimumSize: Size(0, 48),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: CustomText(
                              text: 'Apply Filters',
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
