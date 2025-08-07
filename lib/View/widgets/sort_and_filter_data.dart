import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:survey_markus/View/Screen/home/home_controller.dart';
import 'package:survey_markus/View/Screen/home/home_model.dart';

class SortAndFilterData extends StatelessWidget {
  const SortAndFilterData({super.key, required this.homeController});

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    final GlobalKey sortKey = GlobalKey();
    return Padding(
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

                final selected = await showMenu<String>(
                  context: context,
                  position: RelativeRect.fromLTRB(
                    offset.dx,
                    offset.dy + size.height,
                    offset.dx + size.width,
                    offset.dy,
                  ),
                  items: [
                    PopupMenuItem(
                      value: 'Priority',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Priority'),
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  if (homeController.currentSortField ==
                                          'Priority' &&
                                      homeController.isAscending == true) {
                                    homeController.resetSort();
                                    Navigator.pop(context);
                                  } else {
                                    Navigator.pop(context, 'Priority_Asc');
                                  }
                                },
                                child: Text('↑'),
                              ),
                              TextButton(
                                onPressed: () {
                                  if (homeController.currentSortField ==
                                          'Priority' &&
                                      homeController.isAscending == false) {
                                    homeController.resetSort();
                                    Navigator.pop(context);
                                  } else {
                                    Navigator.pop(context, 'Priority_Desc');
                                  }
                                },
                                child: Text('↓'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'Deadline',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Deadline'),
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  if (homeController.currentSortField ==
                                          'Deadline' &&
                                      homeController.isAscending == true) {
                                    homeController.resetSort();
                                    Navigator.pop(context);
                                  } else {
                                    Navigator.pop(context, 'Deadline_Asc');
                                  }
                                },
                                child: Text('↑'),
                              ),
                              TextButton(
                                onPressed: () {
                                  if (homeController.currentSortField ==
                                          'Deadline' &&
                                      homeController.isAscending == false) {
                                    homeController.resetSort();
                                    Navigator.pop(context);
                                  } else {
                                    Navigator.pop(context, 'Deadline_Desc');
                                  }
                                },
                                child: Text('↓'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'Recording Date',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Recording Date'),
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  if (homeController.currentSortField ==
                                          'Recording' &&
                                      homeController.isAscending == true) {
                                    homeController.resetSort();
                                    Navigator.pop(context);
                                  } else {
                                    Navigator.pop(context, 'Recording_Asc');
                                  }
                                },
                                child: Text('↑'),
                              ),
                              TextButton(
                                onPressed: () {
                                  if (homeController.currentSortField ==
                                          'Recording' &&
                                      homeController.isAscending == false) {
                                    homeController.resetSort();
                                    Navigator.pop(context);
                                  } else {
                                    Navigator.pop(context, 'Recording_Desc');
                                  }
                                },
                                child: Text('↓'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(value: 'Ascending', child: Text('Ascending')),
                    PopupMenuItem(
                      value: 'Descending',
                      child: Text('Descending'),
                    ),
                  ],
                );

                if (selected == null) return;

                if (selected == 'Priority_Asc') {
                  homeController.sortByPriority(ascending: true);
                } else if (selected == 'Priority_Desc') {
                  homeController.sortByPriority(ascending: false);
                } else if (selected == 'Deadline_Asc') {
                  homeController.sortByDeadline(ascending: true);
                } else if (selected == 'Deadline_Desc') {
                  homeController.sortByDeadline(ascending: false);
                } else if (selected == 'Recording_Asc') {
                  homeController.sortByRecordingDate(ascending: true);
                } else if (selected == 'Recording_Desc') {
                  homeController.sortByRecordingDate(ascending: false);
                } else if (selected == 'Ascending') {
                  if (homeController.currentSortField == null) {
                    // If no field is selected, default to Priority
                    homeController.sortByPriority(ascending: true);
                  } else if (homeController.isAscending == true) {
                    // If already ascending, reset
                    homeController.resetSort();
                  } else {
                    // Apply ascending to current field
                    switch (homeController.currentSortField) {
                      case 'Priority':
                        homeController.sortByPriority(ascending: true);
                        break;
                      case 'Deadline':
                        homeController.sortByDeadline(ascending: true);
                        break;
                      case 'Recording':
                        homeController.sortByRecordingDate(ascending: true);
                        break;
                    }
                  }
                } else if (selected == 'Descending') {
                  if (homeController.currentSortField == null) {
                    // If no field is selected, default to Priority
                    homeController.sortByPriority(ascending: false);
                  } else if (homeController.isAscending == false) {
                    // If already descending, reset
                    homeController.resetSort();
                  } else {
                    // Apply descending to current field
                    switch (homeController.currentSortField) {
                      case 'Priority':
                        homeController.sortByPriority(ascending: false);
                        break;
                      case 'Deadline':
                        homeController.sortByDeadline(ascending: false);
                        break;
                      case 'Recording':
                        homeController.sortByRecordingDate(ascending: false);
                        break;
                    }
                  }
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
                    SizedBox(width: 10),
                    Text(
                      'Sort',
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => FilterDialogWidget(),
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
                    Text(
                      'Filter',
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FilterDialogWidget extends StatefulWidget {
  const FilterDialogWidget({super.key});

  @override
  State<FilterDialogWidget> createState() => _FilterDialogWidgetState();
}

class _FilterDialogWidgetState extends State<FilterDialogWidget> {
  final TextEditingController recordingDateController = TextEditingController();
  final TextEditingController deadlineController = TextEditingController();
  String? selectedSystem;
  String? selectedSubsystem;
  String? selectedCategory;
  String? selectedLocation;
  String? selectedResponsibility;
  String? selectedPriority;
  String? selectedStatus;
  String? selectedStarred;

  @override
  void dispose() {
    recordingDateController.dispose();
    deadlineController.dispose();
    super.dispose();
  }

  void applyFilters() {
    final HomeController controller = Get.find<HomeController>();
    List<HomeModel> filteredTasks = List.from(controller.allTasks);

    // Apply starred filter
    if (selectedStarred == 'Yes') {
      filteredTasks =
          filteredTasks.where((task) => task.isFav == true).toList();
    }

    // Apply other filters if needed
    if (selectedSystem != null) {
      // Add system filter logic
    }
    if (selectedSubsystem != null) {
      // Add subsystem filter logic
    }
    if (selectedCategory != null) {
      // Add category filter logic
    }
    if (selectedLocation != null) {
      // Add location filter logic
    }
    if (selectedResponsibility != null) {
      // Add responsibility filter logic
    }
    if (selectedPriority != null) {
      filteredTasks = filteredTasks
          .where((task) => task.priority == selectedPriority)
          .toList();
    }
    if (selectedStatus != null) {
      // Add status filter logic
    }
    if (recordingDateController.text.isNotEmpty) {
      // Add recording date filter logic
    }
    if (deadlineController.text.isNotEmpty) {
      // Add deadline filter logic
    }

    controller.tasks = filteredTasks;
    controller.update();
    Navigator.pop(context);
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'System'),
                    value: selectedSystem,
                    items: ['A', 'B', 'C']
                        .map(
                          (e) => DropdownMenuItem(value: e, child: Text(e)),
                        )
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedSystem = val;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Subsystem'),
                    value: selectedSubsystem,
                    items: ['X', 'Y', 'Z']
                        .map(
                          (e) => DropdownMenuItem(value: e, child: Text(e)),
                        )
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedSubsystem = val;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Category'),
                    value: selectedCategory,
                    items: ['Cat1', 'Cat2', 'Cat3']
                        .map(
                          (e) => DropdownMenuItem(value: e, child: Text(e)),
                        )
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedCategory = val;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Location'),
                    value: selectedLocation,
                    items: ['Loc1', 'Loc2', 'Loc3']
                        .map(
                          (e) => DropdownMenuItem(value: e, child: Text(e)),
                        )
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedLocation = val;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: recordingDateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Recording Date',
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        setState(() {
                          recordingDateController.text =
                              "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
                        });
                      }
                    },
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Responsibility'),
                    value: selectedResponsibility,
                    items: ['Person1', 'Person2', 'Person3']
                        .map(
                          (e) => DropdownMenuItem(value: e, child: Text(e)),
                        )
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedResponsibility = val;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: deadlineController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Deadline',
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        setState(() {
                          deadlineController.text =
                              "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
                        });
                      }
                    },
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Priority'),
                    value: selectedPriority,
                    items: ['High', 'Medium', 'Low']
                        .map(
                          (e) => DropdownMenuItem(value: e, child: Text(e)),
                        )
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedPriority = val;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Status'),
                    value: selectedStatus,
                    items: ['Open', 'Closed', 'In Progress']
                        .map(
                          (e) => DropdownMenuItem(value: e, child: Text(e)),
                        )
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedStatus = val;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Starred'),
                    value: selectedStarred,
                    items: ['Yes', 'No']
                        .map(
                          (e) => DropdownMenuItem(value: e, child: Text(e)),
                        )
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedStarred = val;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: applyFilters,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xfff3c23a),
                      foregroundColor: Colors.white,
                      minimumSize: Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('Apply'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
