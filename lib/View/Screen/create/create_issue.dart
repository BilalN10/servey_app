import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:survey_markus/View/Screen/edit/components/lang_header.dart';
import 'package:survey_markus/View/Screen/create/controller/create_issue_controller.dart';
import 'package:survey_markus/View/widgets/custom_date_picker.dart';
import 'package:survey_markus/View/widgets/custom_dropdown.dart';
import 'package:survey_markus/View/widgets/custom_text_field/custom_text_field.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';

class CreateIssuePage extends StatefulWidget {
  //const CreateIssuePage({super.key, required this.projectId});
  final String projectId;
  final String companyName;
  final String companyImage;
  final String projectName;
  const CreateIssuePage(
      {super.key,
      required this.projectId,
      required this.companyName,
      required this.companyImage,
      required this.projectName});
  @override
  State<CreateIssuePage> createState() => _CreateIssuePageState();
}

class _CreateIssuePageState extends State<CreateIssuePage> {
  String? _selectedSystem;
  String? _selectedSubSystem;
  String? _selectedCategory;
  String? _selectedLocation;
  String? _selectedStatus;
  String? _selectedPriority;
  final CreateIssueController controller = Get.put(CreateIssueController());

  // Hardcoded status options (German)
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

  @override
  void initState() {
    super.initState();
    // Priorities and status are optional, so they remain null initially as requested.
    // Pre-fill dates
    controller.setRecordingDate(DateTime.now());
    // Deadline is initially empty (null) as requested
    // controller.setDeadlineDate(DateTime.now());
    // Fetch project configurations when page loads
    controller.fetchProjectConfigurations(widget.projectId);
  }

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.sizeOf(context).height;
    final double w = MediaQuery.sizeOf(context).width;

    // Update controller with selected values
    controller.updateSelectedValues(
      system: _selectedSystem,
      subsystem: _selectedSubSystem,
      category: _selectedCategory,
      location: _selectedLocation,
      priority: _selectedPriority,
      status: _selectedStatus,
    );

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
                padding: EdgeInsets.only(bottom: 70),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LangHeader(
                        projectName: widget.projectName,
                        w: w,
                        h: h,
                        companyName: widget.companyName,
                        companyImage: widget.companyImage,
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
                                // Text(
                                //   'Issue No. 176',
                                //   style: GoogleFonts.inter(
                                //     color: Colors.black,
                                //     fontSize: 14,
                                //     fontWeight: FontWeight.w400,
                                //   ),
                                // ),
                              ],
                            ),
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
                          : (controller.systemOptions.isEmpty
                              ? const SizedBox()
                              : CustomDropdown(
                                  width: w,
                                  hintText: 'trade / system',
                                  items: controller.systemOptions,
                                  shouldTranslate: true,
                                  value: _selectedSystem,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedSystem = value;
                                    });
                                    controller.selectedSystem.value = value;
                                  },
                                ))),
                      Obx(() => controller.systemOptions.isEmpty
                          ? const SizedBox()
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
                          : (controller.subsystemOptions.isEmpty
                              ? const SizedBox()
                              : CustomDropdown(
                                  width: w,
                                  hintText: 'sub-system',
                                  items: controller.subsystemOptions,
                                  shouldTranslate: true,
                                  value: _selectedSubSystem,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedSubSystem = value;
                                    });
                                    controller.selectedSubsystem.value = value;
                                  },
                                ))),
                      Obx(() => controller.subsystemOptions.isEmpty
                          ? const SizedBox()
                          : SizedBox(height: h * 0.02)),
                      // Category dropdown - only show if not hidden and not empty
                      Obx(() => controller.isFieldHidden('category') ||
                              controller.categoryOptions.isEmpty
                          ? const SizedBox()
                          : (controller.configurationsLoading.value
                              ? Container(
                                  width: w,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color:
                                            Color(0xff747474).withOpacity(.54)),
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
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedCategory = value;
                                    });
                                    controller.selectedCategory.value = value;
                                  },
                                ))),
                      Obx(() => controller.isFieldHidden('category') ||
                              controller.categoryOptions.isEmpty
                          ? const SizedBox()
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
                          : (controller.locationOptions.isEmpty
                              ? const SizedBox()
                              : CustomDropdown(
                                  width: w,
                                  hintText: 'location',
                                  items: controller.locationOptions,
                                  shouldTranslate: true,
                                  value: _selectedLocation,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedLocation = value;
                                    });
                                    controller.selectedLocation.value = value;
                                  },
                                ))),
                      Obx(() => controller.locationOptions.isEmpty
                          ? const SizedBox()
                          : SizedBox(height: h * 0.02)),
                      Obx(
                        () => CustomDatePicker(
                          width: w,
                          hintText: 'recording date',
                          value: controller.recordingDate.value,
                          shouldTranslate: true,
                          onChanged: (date) =>
                              controller.setRecordingDate(date),
                        ),
                      ),
                      SizedBox(height: h * 0.02),
                      // Erfasser (Creator/Recorder) field - mandatory
                      Center(
                        child: Container(
                          padding: EdgeInsets.only(left: 10, right: 5),
                          width: w * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Color(0xffebb105)),
                          ),
                          child: CustomTextField(
                            hintText: 'creator',
                            textEditingController:
                                controller.erfasserController,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter Erfasser (Creator)';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: h * 0.02),
                      // Responsible Company field - optional
                      Center(
                        child: Container(
                          padding: EdgeInsets.only(left: 10, right: 5),
                          width: w * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: Color(0xff747474).withOpacity(.54)),
                          ),
                          child: CustomTextField(
                            hintText: 'Responsible Company',
                            textEditingController:
                                controller.responsibleCompanyController,
                          ),
                        ),
                      ),
                      SizedBox(height: h * 0.02),
                      // Responsible Employer field - optional
                      Center(
                        child: Container(
                          padding: EdgeInsets.only(left: 10, right: 5),
                          width: w * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: Color(0xff747474).withOpacity(.54)),
                          ),
                          child: CustomTextField(
                            hintText: 'Responsible Employer',
                            textEditingController:
                                controller.responsibleEmployerController,
                          ),
                        ),
                      ),
                      SizedBox(height: h * 0.02),
                      Center(
                        child: Obx(
                          () => CustomDatePicker(
                            width: w,
                            hintText: 'deadline',
                            value: controller.deadlineDate.value,
                            shouldTranslate: true,
                            onChanged: (date) =>
                                controller.setDeadlineDate(date),
                          ),
                        ),
                      ),
                      SizedBox(height: h * 0.02),
                      CustomDropdown(
                        width: w,
                        hintText: 'priority',
                        items: _priorityOptions,
                        shouldTranslate: true,
                        value: _selectedPriority,
                        onChanged: (value) {
                          setState(() {
                            _selectedPriority = value;
                          });
                          controller.selectedPriority.value = value;
                        },
                      ),
                      SizedBox(height: h * 0.02),
                      CustomDropdown(
                        width: w,
                        hintText: 'status',
                        items: _statusOptions,
                        shouldTranslate: true,
                        value: _selectedStatus,
                        onChanged: (value) {
                          setState(() {
                            _selectedStatus = value;
                          });
                          controller.selectedStatus.value = value;
                        },
                      ),
                      SizedBox(height: h * 0.02),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          width: w,
                          height: h * .2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Color(0xffebb105)),
                          ),
                          child: TextFormField(
                            controller: controller.descriptionController,
                            maxLines: null,
                            expands: true,
                            keyboardType: TextInputType.multiline,
                            textAlignVertical: TextAlignVertical.top,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Description is required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              hintText: 'description',
                              hintStyle: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: h * 0.04),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          height: 50,
                          width: w,
                          child: ElevatedButton(
                            onPressed: () =>
                                controller.showImagePickerOptions(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffebb105),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Color(0xffebb105)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 25,
                                ),
                                SizedBox(width: 10),
                                CustomText(
                                  text: 'Add photo',
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  shouldTranslate: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: h * 0.02),
                      // Multiple images preview
                      Obx(
                        () => controller.selectedImages.isNotEmpty
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Container(
                                  height: 200,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: controller.selectedImages.length,
                                    itemBuilder: (context, index) {
                                      final image =
                                          controller.selectedImages[index];
                                      return Container(
                                        margin: EdgeInsets.only(right: 10),
                                        width: 200,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                            color: Color(0xffebb105),
                                            width: 1,
                                          ),
                                        ),
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image.file(
                                                File(image.path),
                                                width: 200,
                                                height: 200,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Positioned(
                                              top: 8,
                                              right: 8,
                                              child: GestureDetector(
                                                onTap: () {
                                                  controller.selectedImages
                                                      .removeAt(index);
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Icon(
                                                    Icons.close,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            : SizedBox(),
                      ),
                      SizedBox(height: h * 0.02),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          height: 50,
                          width: w,
                          child: ElevatedButton(
                            onPressed: controller.isLoading.value
                                ? null
                                : () async {
                                    // Validate only mandatory fields if they are not empty/hidden
                                    bool isSystemValid =
                                        controller.systemOptions.isEmpty ||
                                            _selectedSystem != null;
                                    bool isLocationValid =
                                        controller.locationOptions.isEmpty ||
                                            _selectedLocation != null;

                                    if (isSystemValid &&
                                        isLocationValid &&
                                        controller.recordingDate.value !=
                                            null &&
                                        controller.erfasserController.text
                                            .trim()
                                            .isNotEmpty &&
                                        controller.descriptionController.text
                                            .trim()
                                            .isNotEmpty) {
                                      await controller.submitForm(
                                        system: _selectedSystem ?? '',
                                        subsystem: _selectedSubSystem ?? '',
                                        category: _selectedCategory ??
                                            '', // Use empty string if null (hidden field)
                                        location: _selectedLocation ?? '',
                                        priority: _selectedPriority != null
                                            ? _getPriorityApiValue(
                                                _selectedPriority!)
                                            : '', // Default to empty if optional
                                        status: _selectedStatus ??
                                            '', // Default to empty if optional
                                        projectId: widget.projectId,
                                      );
                                    } else {
                                      String errorMsg =
                                          'Please fill all required fields';
                                      if (!isSystemValid)
                                        errorMsg =
                                            'Please select a Trade/System';
                                      else if (!isLocationValid)
                                        errorMsg = 'Please select a Location';
                                      else if (controller.recordingDate.value ==
                                          null)
                                        errorMsg =
                                            'Please select a Recording Date';
                                      else if (controller
                                          .erfasserController.text
                                          .trim()
                                          .isEmpty)
                                        errorMsg =
                                            'Please enter Erfasser (Creator)';
                                      else if (controller
                                          .descriptionController.text
                                          .trim()
                                          .isEmpty)
                                        errorMsg = 'Please enter a Description';

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
                                side: BorderSide(color: Color(0xffebb105)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Obx(() => controller.isLoading.value
                                ? SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Color(0xffebb105),
                                      ),
                                    ),
                                  )
                                : CustomText(
                                    text: 'Save Issue',
                                    color: Color(0xffebb105),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    shouldTranslate: true,
                                  )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Widget tabBar(
    String lang,
    String icon,
    int selectedIndex,
    CreateIssueController controller,
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
