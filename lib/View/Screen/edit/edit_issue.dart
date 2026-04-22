import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:survey_markus/View/Screen/edit/components/lang_header.dart';
import 'package:survey_markus/View/Screen/edit/controller/edit_issue_controller.dart';
import 'package:survey_markus/View/Screen/home/model/project_issue_model.dart';
import 'package:survey_markus/View/widgets/custom_date_picker.dart';
import 'package:survey_markus/View/widgets/custom_dropdown.dart';
import 'package:survey_markus/View/widgets/custom_text_field/custom_text_field.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';

class EditIssuePage extends StatefulWidget {
  // const EditIssuePage({super.key, required this.projectIssue});
  final ProjectIssueModel projectIssue;
  final String companyName;
  final String companyImage;
  final String projectName;
  const EditIssuePage(
      {super.key,
      required this.projectIssue,
      required this.companyName,
      required this.companyImage,
      required this.projectName});
  @override
  State<EditIssuePage> createState() => _EditIssuePageState();
}

class _EditIssuePageState extends State<EditIssuePage> {
  String? _selectedSystem;
  String? _selectedSubSystem;
  String? _selectedCategory;
  String? _selectedLocation;
  String? _selectedStatus;
  String? _selectedPriority;
  final EditIssueController controller = Get.put(EditIssueController());

  final List<String> _statusOptions = [
    'nicht begonnen',
    'in Arbeit',
    'im Test',
    'retest',
    'erledigt',
    'zurückgestellt',
  ];

  // Hardcoded priority options (numeric values)
  final List<String> _priorityOptions = [
    '1',
    '2',
    '3',
  ];

  // Convert priority display value to API value
  String _getPriorityApiValue(String displayValue) {
    // Since we're using numeric values directly, return as-is
    return displayValue;
  }

  // Convert priority API value to display value
  String _getPriorityDisplayValue(String apiValue) {
    // Since we're using numeric values directly, return as-is
    return apiValue;
  }

  @override
  void initState() {
    super.initState();
    // Set initial values from the issue
    _selectedSystem = widget.projectIssue.system;
    _selectedSubSystem = widget.projectIssue.subsystem;
    _selectedCategory = widget.projectIssue.category;
    _selectedLocation = widget.projectIssue.location;
    // Convert priority API value (1, 2, 3) to display value (Low, Medium, High)
    _selectedPriority = widget.projectIssue.priority != null
        ? _getPriorityDisplayValue(widget.projectIssue.priority!)
        : null;
    _selectedStatus = widget.projectIssue.status?.toLowerCase();

    // Set controller values
    controller.selectedSystem.value = _selectedSystem;
    controller.selectedSubsystem.value = _selectedSubSystem;
    controller.selectedCategory.value = _selectedCategory;
    controller.selectedLocation.value = _selectedLocation;
    controller.selectedPriority.value = _selectedPriority;
    controller.selectedStatus.value = _selectedStatus;

    // Parse dates
    try {
      if (widget.projectIssue.deadLine != null &&
          widget.projectIssue.deadLine!.isNotEmpty) {
        controller.deadlineDate.value =
            DateTime.parse(widget.projectIssue.deadLine!);
      }
    } catch (e) {
      print('Error parsing deadline date: ${widget.projectIssue.deadLine}');
    }

    try {
      if (widget.projectIssue.recorded != null &&
          widget.projectIssue.recorded!.isNotEmpty) {
        controller.recordingDate.value =
            DateTime.parse(widget.projectIssue.recorded!);
      }
    } catch (e) {
      print('Error parsing recorded date: ${widget.projectIssue.recorded}');
    }
    controller.descriptionController.text = widget.projectIssue.description;
    controller.responsibleController.text =
        widget.projectIssue.responsibleEmployer ?? '';
    controller.responsibleCompanyController.text =
        widget.projectIssue.responsibleCompany ?? '';

    // Fetch project configurations and add missing values
    _fetchConfigurationsAndAddMissingValues();

    // Fetch images for this issue
    controller.fetchIssueImages(widget.projectIssue.id.toString());
  }

  Future<void> _fetchConfigurationsAndAddMissingValues() async {
    // Fetch configurations from API
    await controller
        .fetchProjectConfigurations(widget.projectIssue.projectId.toString());

    // Add missing values from the issue to the dropdown options
    controller.addMissingValuesToOptions(
      system: widget.projectIssue.system,
      subsystem: widget.projectIssue.subsystem,
      category: widget.projectIssue.category,
      location: widget.projectIssue.location,
      priority: widget.projectIssue.priority,
      responsible: widget.projectIssue.responsibleEmployer,
    );

    // Add status from issue to status options if it doesn't exist
    if (_selectedStatus != null && !_statusOptions.contains(_selectedStatus)) {
      setState(() {
        _statusOptions.add(_selectedStatus!);
      });
    }

    // Add priority from issue to priority options if it doesn't exist
    // (in case API returns a value that's not 1, 2, or 3)
    if (_selectedPriority != null &&
        !_priorityOptions.contains(_selectedPriority)) {
      setState(() {
        _priorityOptions.add(_selectedPriority!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.sizeOf(context).height;
    final double w = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: ScrollbarTheme(
        data: ScrollbarThemeData(
          thumbColor: MaterialStateProperty.all(Color(0xffEBB105)),
          trackColor: MaterialStateProperty.all(
            Color(0xffEBB105).withOpacity(0.1),
          ),
          thickness: WidgetStateProperty.all(2),
        ),
        child: Scrollbar(
          thumbVisibility: true,
          thickness: 4,
          radius: Radius.circular(10),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LangHeader(
                    w: w,
                    h: h,
                    companyName: widget.companyName,
                    companyImage: widget.companyImage,
                    projectName: widget.projectName,
                    children: [
                      Expanded(
                        child: Obx(
                          () => tabBar(
                            'DE',
                            'assets/icons/de.svg',
                            0,
                            controller,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Obx(
                          () => tabBar(
                            'EN',
                            'assets/icons/eng.svg',
                            1,
                            controller,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: h * 0.01),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'recording'.toUpperCase(),
                              fontSize: 14,
                              color: Color(0xffEBB105),
                              fontWeight: FontWeight.w600,
                              shouldTranslate: true,
                            ),
                            SizedBox(height: h * 0.01),
                            CustomText(
                              text: 'Issue No. ${widget.projectIssue.id}',
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              shouldTranslate: true,
                            ),
                          ],
                        ),
                        const Spacer(),
                        Obx(
                          () => controller.isEditMode.value
                              ? SizedBox()
                              : GestureDetector(
                                  onTap: () => controller.toggleEditMode(),
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: const Color(
                                        0xffebb105,
                                      ).withOpacity(.2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        'assets/icons/edit.svg',
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                        SizedBox(width: w * 0.02),
                        // GestureDetector(
                        //   onTap: () => Get.to(() => CreateIssuePage(
                        //         projectId:
                        //             widget.projectIssue.projectId.toString(),
                        //       )),
                        //   child: Container(
                        //     height: 40,
                        //     width: 40,
                        //     decoration: BoxDecoration(
                        //       color: Color(0xffebb105).withOpacity(.2),
                        //       borderRadius: BorderRadius.circular(8),
                        //     ),
                        //     child: Center(
                        //       child: SvgPicture.asset(
                        //         'assets/icons/add.svg',
                        //         color: Color(0xffebb105),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(height: h * 0.02),
                  Obx(() => controller.configurationsLoading.value
                      ? Container(
                          width: w,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: Color(0xff747474).withOpacity(.54)),
                          ),
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xffEBB105)),
                            ),
                          ),
                        )
                      : (controller.isFieldHidden('system') ||
                              controller.systemOptions.isEmpty
                          ? SizedBox()
                          : CustomDropdown(
                              width: w,
                              hintText: 'trade / system',
                              items: controller.systemOptions,
                              shouldTranslate: true,
                              value: _selectedSystem,
                              onChanged: controller.isEditMode.value
                                  ? (value) {
                                      setState(() {
                                        _selectedSystem = value;
                                      });
                                      controller.selectedSystem.value = value;
                                    }
                                  : null,
                            ))),
                  Obx(() => controller.isFieldHidden('system') ||
                          controller.systemOptions.isEmpty
                      ? SizedBox()
                      : SizedBox(height: h * 0.02)),
                  Obx(() => controller.configurationsLoading.value
                      ? Container(
                          width: w,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: Color(0xff747474).withOpacity(.54)),
                          ),
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xffEBB105)),
                            ),
                          ),
                        )
                      : (controller.isFieldHidden('subsystem') ||
                              controller.subsystemOptions.isEmpty
                          ? SizedBox()
                          : CustomDropdown(
                              width: w,
                              hintText: 'sub-system',
                              items: controller.subsystemOptions,
                              shouldTranslate: true,
                              value: _selectedSubSystem,
                              onChanged: controller.isEditMode.value
                                  ? (value) {
                                      setState(() {
                                        _selectedSubSystem = value;
                                      });
                                      controller.selectedSubsystem.value =
                                          value;
                                    }
                                  : null,
                            ))),
                  Obx(() => controller.isFieldHidden('subsystem') ||
                          controller.subsystemOptions.isEmpty
                      ? SizedBox()
                      : SizedBox(height: h * 0.02)),
                  // Category dropdown - only show if not hidden
                  Obx(() => controller.isFieldHidden('category') ||
                          controller.categoryOptions.isEmpty
                      ? SizedBox()
                      : (controller.configurationsLoading.value
                          ? Container(
                              width: w,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: Color(0xff747474).withOpacity(.54)),
                              ),
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Color(0xffEBB105)),
                                ),
                              ),
                            )
                          : CustomDropdown(
                              width: w,
                              hintText: 'category',
                              items: controller.categoryOptions,
                              shouldTranslate: true,
                              value: _selectedCategory,
                              onChanged: controller.isEditMode.value
                                  ? (value) {
                                      setState(() {
                                        _selectedCategory = value;
                                      });
                                      controller.selectedCategory.value = value;
                                    }
                                  : null,
                            ))),
                  Obx(() => controller.isFieldHidden('category') ||
                          controller.categoryOptions.isEmpty
                      ? SizedBox()
                      : SizedBox(height: h * 0.02)),
                  Obx(() => controller.configurationsLoading.value
                      ? Container(
                          width: w,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: Color(0xff747474).withOpacity(.54)),
                          ),
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xffEBB105)),
                            ),
                          ),
                        )
                      : (controller.isFieldHidden('location') ||
                              controller.locationOptions.isEmpty
                          ? SizedBox()
                          : CustomDropdown(
                              width: w,
                              hintText: 'location',
                              items: controller.locationOptions,
                              shouldTranslate: true,
                              value: _selectedLocation,
                              onChanged: controller.isEditMode.value
                                  ? (value) {
                                      setState(() {
                                        _selectedLocation = value;
                                      });
                                      controller.selectedLocation.value = value;
                                    }
                                  : null,
                            ))),
                  Obx(() => controller.isFieldHidden('location') ||
                          controller.locationOptions.isEmpty
                      ? SizedBox()
                      : SizedBox(height: h * 0.02)),
                  CustomDatePicker(
                    width: w,
                    hintText: 'recording date',
                    value: controller.recordingDate.value,
                    shouldTranslate: true,
                    onChanged: null, // Always read-only
                  ),
                  SizedBox(height: h * 0.02),
                  Center(
                    child: Obx(() => Container(
                          padding: EdgeInsets.only(left: 10, right: 5),
                          width: w * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: controller.isEditMode.value
                                  ? Color(0xffebb105)
                                  : Color(0xff747474).withOpacity(.54),
                            ),
                          ),
                          child: CustomTextField(
                            hintText: 'Responsible Company',
                            textEditingController:
                                controller.responsibleCompanyController,
                            readOnly: !controller.isEditMode.value,
                          ),
                        )),
                  ),
                  SizedBox(height: h * 0.02),
                  Center(
                    child: Obx(() => Container(
                          padding: EdgeInsets.only(left: 10, right: 5),
                          width: w * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: controller.isEditMode.value
                                  ? Color(0xffebb105)
                                  : Color(0xff747474).withOpacity(.54),
                            ),
                          ),
                          child: CustomTextField(
                            hintText: 'Responsible Employer',
                            textEditingController:
                                controller.responsibleController,
                            readOnly: !controller.isEditMode.value,
                          ),
                        )),
                  ),
                  SizedBox(height: h * 0.02),
                  Obx(() => CustomDatePicker(
                        width: w,
                        hintText: 'deadline',
                        value: controller.deadlineDate.value,
                        shouldTranslate: true,
                        onChanged: controller.isEditMode.value
                            ? (date) => controller.setDeadlineDate(date)
                            : null,
                      )),
                  SizedBox(height: h * 0.02),
                  Obx(() => CustomDropdown(
                        width: w,
                        hintText: 'priority',
                        items: _priorityOptions,
                        shouldTranslate: true,
                        value: _selectedPriority,
                        onChanged: controller.isEditMode.value
                            ? (value) {
                                setState(() {
                                  _selectedPriority = value;
                                });
                                controller.selectedPriority.value = value;
                              }
                            : null,
                      )),
                  SizedBox(height: h * 0.02),
                  Obx(() => CustomDropdown(
                        width: w,
                        hintText: 'status',
                        items: _statusOptions,
                        shouldTranslate: true,
                        value: _selectedStatus,
                        onChanged: controller.isEditMode.value
                            ? (value) {
                                setState(() {
                                  _selectedStatus = value;
                                });
                                controller.selectedStatus.value = value;
                              }
                            : null,
                      )),
                  SizedBox(height: h * 0.02),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width: w,
                      height: h * .2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Color(0xff747474).withOpacity(.54),
                        ),
                      ),
                      child: Obx(
                        () => TextFormField(
                          controller: controller.descriptionController,
                          enabled: controller.isEditMode.value,
                          readOnly: true,
                          maxLines: null,
                          expands: true,
                          keyboardType: TextInputType.multiline,
                          textAlignVertical: TextAlignVertical.top,
                          style: GoogleFonts.inter(
                            color: Colors.grey,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: 'description',
                            hintStyle: GoogleFonts.inter(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: h * 0.04),
                  // Display uploaded images
                  Obx(
                    () => controller.imagesLoading.value
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              height: 100,
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Color(0xffEBB105)),
                                ),
                              ),
                            ),
                          )
                        : controller.issueImages.isNotEmpty
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: 'Uploaded Images',
                                      fontSize: 14,
                                      color: Color(0xffEBB105),
                                      fontWeight: FontWeight.w600,
                                      shouldTranslate: true,
                                    ),
                                    SizedBox(height: h * 0.01),
                                    Center(
                                      child: Container(
                                        height: 200,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              controller.issueImages.length,
                                          itemBuilder: (context, index) {
                                            final imageUrl =
                                                controller.issueImages[index];
                                            return Container(
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              width: 200,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                  color: Color(0xffebb105),
                                                  width: 1,
                                                ),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Image.network(
                                                  imageUrl,
                                                  width: 200,
                                                  height: 200,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return Container(
                                                      color: Colors.grey[300],
                                                      child: Icon(
                                                        Icons.broken_image,
                                                        color: Colors.grey,
                                                      ),
                                                    );
                                                  },
                                                  loadingBuilder: (context,
                                                      child, loadingProgress) {
                                                    if (loadingProgress == null)
                                                      return child;
                                                    return Container(
                                                      color: Colors.grey[200],
                                                      child: Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          value: loadingProgress
                                                                      .expectedTotalBytes !=
                                                                  null
                                                              ? loadingProgress
                                                                      .cumulativeBytesLoaded /
                                                                  loadingProgress
                                                                      .expectedTotalBytes!
                                                              : null,
                                                          strokeWidth: 2,
                                                          valueColor:
                                                              AlwaysStoppedAnimation<
                                                                      Color>(
                                                                  Color(
                                                                      0xffEBB105)),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox(),
                  ),
                  SizedBox(height: h * 0.02),
                  Obx(
                    () => controller.isEditMode.value
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: SizedBox(
                              height: 50,
                              width: w,
                              child: ElevatedButton(
                                onPressed: () async {
                                  // Validate fields - skip hidden fields and empty options
                                  final isCategoryHidden =
                                      controller.isFieldHidden('category');
                                  final isSystemHidden =
                                      controller.isFieldHidden('system');
                                  final isSubsystemHidden =
                                      controller.isFieldHidden('subsystem');

                                  bool isSystemValid =
                                      controller.systemOptions.isEmpty ||
                                          isSystemHidden ||
                                          _selectedSystem != null;
                                  bool isSubsystemValid =
                                      controller.subsystemOptions.isEmpty ||
                                          isSubsystemHidden ||
                                          _selectedSubSystem != null;
                                  bool isCategoryValid =
                                      controller.categoryOptions.isEmpty ||
                                          isCategoryHidden ||
                                          _selectedCategory != null;

                                  if (isSystemValid &&
                                      isSubsystemValid &&
                                      isCategoryValid &&
                                      _selectedStatus != null &&
                                      _selectedPriority != null) {
                                    await controller.updateProjectIssue(
                                      projectId: widget.projectIssue.projectId
                                          .toString(),
                                      issueId:
                                          widget.projectIssue.id.toString(),
                                      system: _selectedSystem ?? '',
                                      subsystem: _selectedSubSystem ?? '',
                                      category: _selectedCategory ??
                                          '', // Use empty string if null (hidden field)
                                      location: _selectedLocation ?? '',
                                      description:
                                          controller.descriptionController.text,
                                      descriptionOriginalLanguage:
                                          controller.descriptionController.text,
                                      responsibleCompany: controller
                                          .responsibleCompanyController.text,
                                      responsibleEmployer:
                                          controller.responsibleController.text,
                                      status: _selectedStatus ?? "",
                                      priority: _getPriorityApiValue(
                                          _selectedPriority ?? "3"),
                                      deadLine:
                                          controller.deadlineDate.value != null
                                              ? controller.deadlineDate.value!
                                                  .toIso8601String()
                                                  .split('T')[0]
                                              : "",
                                    );
                                  } else {
                                    String errorMsg =
                                        'Please fill all required fields';
                                    if (!isSystemValid)
                                      errorMsg = 'Please select a Trade/System';
                                    else if (!isSubsystemValid)
                                      errorMsg = 'Please select a Sub-system';

                                    Get.snackbar(
                                      'Validation Error',
                                      errorMsg,
                                      backgroundColor: Colors.orange,
                                      colorText: Colors.white,
                                      snackPosition: SnackPosition.TOP,
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: Color(0xffebb105),
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: CustomText(
                                  text: 'Save Changes',
                                  color: Color(0xffebb105),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),
                  ),
                  SizedBox(height: h * 0.07),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget tabBar(
    String lang,
    String icon,
    int selectedIndex,
    EditIssueController controller,
  ) {
    return GestureDetector(
      onTap: () {
        controller.changeLanguage(selectedIndex);
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: selectedIndex == controller.selectedIndex.value
              ? Colors.white
              : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(icon),
            SizedBox(width: 5),
            Text(
              lang,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: selectedIndex == controller.selectedIndex.value
                    ? Color(0xffEBB105)
                    : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
