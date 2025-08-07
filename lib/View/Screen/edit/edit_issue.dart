import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:survey_markus/View/Screen/create/create_issue.dart';
import 'package:survey_markus/View/Screen/edit/components/lang_header.dart';
import 'package:survey_markus/View/Screen/edit/controller/edit_issue_controller.dart';
import 'package:survey_markus/View/widgets/custom_date_picker.dart';
import 'package:survey_markus/View/widgets/custom_dropdown.dart';

class EditIssuePage extends StatefulWidget {
  const EditIssuePage({super.key});

  @override
  State<EditIssuePage> createState() => _EditIssuePageState();
}

class _EditIssuePageState extends State<EditIssuePage> {
  final List<String> _system = ['WMS System', 'B', 'C', 'D'];
  String? _selectedSystem;
  final List<String> _subSystem = ['Goods receipt', 'B', 'C', 'D'];
  String? _selectedSubSystem;
  final List<String> _category = ['Error', 'Warning', 'From Scratch'];
  String? _selectedCategory;
  final List<String> _location = ['Setting up conveyor technology', 'A', 'B'];
  String? _selectedLocation;
  final List<String> _status = ['Open', 'Closed', 'In Progress'];
  String? _selectedStatus;
  final List<String> _priority = ['Low', 'Medium', 'High'];
  String? _selectedPriority;
  final List<String> _responsible = ['Paul Müller', 'John Dow'];
  String? _selectedResponsible;
  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.sizeOf(context).height;
    final double w = MediaQuery.sizeOf(context).width;
    final EditIssueController controller = Get.put(EditIssueController());

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
                            Text(
                              'recording'.toUpperCase(),
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: Color(0xffEBB105),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: h * 0.01),
                            Text(
                              'Issue No. 176',
                              style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
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
                                      color: Color(
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
                        GestureDetector(
                          onTap: () => Get.to(() => CreateIssuePage()),
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Color(0xffebb105).withOpacity(.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/icons/add.svg',
                                color: Color(0xffebb105),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: h * 0.02),
                  Obx(
                    () => CustomDropdown(
                      width: w,
                      hintText: 'Trade / System',
                      items: _system,
                      value: _selectedSystem,
                      onChanged: controller.isEditMode.value
                          ? (value) => setState(() {
                                _selectedSystem = value;
                              })
                          : null,
                    ),
                  ),
                  SizedBox(height: h * 0.02),
                  Obx(
                    () => CustomDropdown(
                      width: w,
                      hintText: 'Sub-system',
                      items: _subSystem,
                      value: _selectedSubSystem,
                      onChanged: controller.isEditMode.value
                          ? (value) => setState(() {
                                _selectedSubSystem = value;
                              })
                          : null,
                    ),
                  ),
                  SizedBox(height: h * 0.02),
                  Obx(
                    () => CustomDropdown(
                      width: w,
                      hintText: 'Category',
                      items: _category,
                      value: _selectedCategory,
                      onChanged: controller.isEditMode.value
                          ? (value) => setState(() {
                                _selectedCategory = value;
                              })
                          : null,
                    ),
                  ),
                  SizedBox(height: h * 0.02),
                  Obx(
                    () => CustomDropdown(
                      width: w,
                      hintText: 'Location',
                      items: _location,
                      value: _selectedLocation,
                      onChanged: controller.isEditMode.value
                          ? (value) => setState(() {
                                _selectedLocation = value;
                              })
                          : null,
                    ),
                  ),
                  SizedBox(height: h * 0.02),
                  Obx(
                    () => CustomDatePicker(
                      width: w,
                      hintText: 'Recording date',
                      value: controller.recordingDate.value,
                      onChanged: controller.isEditMode.value
                          ? (date) => controller.setRecordingDate(date)
                          : null,
                    ),
                  ),
                  SizedBox(height: h * 0.02),
                  Obx(
                    () => CustomDropdown(
                      width: w,
                      hintText: 'Responsible',
                      items: _responsible,
                      value: _selectedResponsible,
                      onChanged: controller.isEditMode.value
                          ? (value) => setState(() {
                                _selectedResponsible = value;
                              })
                          : null,
                    ),
                  ),
                  SizedBox(height: h * 0.02),
                  Obx(
                    () => CustomDatePicker(
                      width: w,
                      hintText: 'Deadline',
                      value: controller.deadlineDate.value,
                      onChanged: controller.isEditMode.value
                          ? (date) => controller.setDeadlineDate(date)
                          : null,
                    ),
                  ),
                  SizedBox(height: h * 0.02),
                  Obx(
                    () => CustomDropdown(
                      width: w,
                      hintText: 'Priority',
                      items: _priority,
                      value: _selectedPriority,
                      onChanged: controller.isEditMode.value
                          ? (value) => setState(() {
                                _selectedPriority = value;
                              })
                          : null,
                    ),
                  ),
                  SizedBox(height: h * 0.02),
                  Obx(
                    () => CustomDropdown(
                      width: w,
                      hintText: 'Status',
                      items: _status,
                      value: _selectedStatus,
                      onChanged: controller.isEditMode.value
                          ? (value) => setState(() {
                                _selectedStatus = value;
                              })
                          : null,
                    ),
                  ),
                  SizedBox(height: h * 0.02),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Obx(
                      () => Container(
                        width: w,
                        height: h * .2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: controller.isEditMode.value
                                ? Color(0xffebb105)
                                : Color(0xff747474).withOpacity(.54),
                          ),
                        ),
                        child: TextFormField(
                          controller: controller.descriptionController,
                          enabled: controller.isEditMode.value,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: 'Description',
                            hintStyle: GoogleFonts.inter(
                              color: controller.isEditMode.value
                                  ? Colors.black
                                  : Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.04),
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
                                onPressed: () =>
                                    controller.showImagePickerOptions(),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xffebb105),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: Color(0xffebb105),
                                    ),
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
                                    Text(
                                      'Add photo',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
                                onPressed: () {
                                  controller.toggleEditMode();
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
                                child: Text(
                                  'Save Changes',
                                  style: GoogleFonts.poppins(
                                    color: Color(0xffebb105),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),
                  ),
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
