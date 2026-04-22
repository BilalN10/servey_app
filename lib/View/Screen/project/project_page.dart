import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:survey_markus/View/Screen/home/home.dart';
import 'package:survey_markus/View/Screen/project/project_controller.dart';
import 'package:survey_markus/View/Screen/HomeScreen/model/company_project_model.dart';
import 'package:survey_markus/View/widgets/custom_loader/custom_loader.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/global/screen/GenerelError/general_error.dart';
import 'package:survey_markus/global/screen/no%20internet/no_internet.dart';
import 'package:survey_markus/helper/network_img/network_img.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';
import 'package:survey_markus/utils/AppConst/app_const.dart';

class ProjectPage extends StatefulWidget {
  final String companyId;
  final String? companyName;
  final String? image;

  const ProjectPage({
    super.key,
    required this.companyId,
    this.companyName,
    this.image,
  });

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  ProjectController projectController = Get.put(ProjectController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      print("Company ID: ${widget.companyId}");
      projectController.getCompanyProjects(companyId: widget.companyId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          children: [
            ///<======================= This is company logo ===============================>

            CustomNetworkImage(
              imageUrl: widget.image ?? "",
              height: 40.h,
              width: 58.w,
              boxShape: BoxShape.circle,
            ),

            SizedBox(
              width: 10.w,
            ),

            ///<======================== This is the company name ===============================>

            CustomText(
              text: widget.companyName ?? "",
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: AppColors.yellowNormal,
            ),
          ],
        ),
      ),
      body: Obx(() {
        if (projectController.rxLoading.value == Status.loading) {
          return const Center(
            child: CustomLoader(),
          );
        } else if (projectController.rxLoading.value == Status.error) {
          return GeneralErrorScreen(
              onTap: () => projectController.getCompanyProjects(
                  companyId: widget.companyId));
        } else if (projectController.rxLoading.value == Status.internetError) {
          return NoInternetScreen(
              onTap: () => projectController.getCompanyProjects(
                  companyId: widget.companyId));
        } else if (projectController.rxLoading.value == Status.completed) {
          if (projectController.companyProjectsList.isEmpty) {
            return _buildEmptyState();
          } else {
            return _buildProjectList();
          }
        }
        return const SizedBox.shrink();
      }),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.folder_open,
            size: 80.sp,
            color: AppColors.grayNormal,
          ),
          SizedBox(height: 16.h),
          CustomText(
            text: 'No Projects Found',
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.grayNormal,
          ),
          SizedBox(height: 8.h),
          CustomText(
            text: 'There are no projects available at the moment.',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.grayNormal,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          ElevatedButton.icon(
            onPressed: () => projectController.getCompanyProjects(
                companyId: widget.companyId),
            icon: Icon(Icons.refresh, size: 18.sp),
            label: CustomText(
              text: 'Refresh',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.yellowNormal,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectList() {
    return RefreshIndicator(
      onRefresh: () async {
        await projectController.getCompanyProjects(companyId: widget.companyId);
      },
      child: ListView.builder(
        padding: EdgeInsets.all(16.w),
        itemCount: projectController.companyProjectsList.length,
        itemBuilder: (context, index) {
          final project = projectController.companyProjectsList[index];
          return _buildProjectCard(project, index);
        },
      ),
    );
  }

  Widget _buildProjectCard(Project project, int index) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12.r),
            onTap: () {
              Get.to(() => HomePage(
                  companyName: widget.companyName ?? "",
                  companyImage: widget.image ?? "",
                  projectId: project.id.toString(),
                  projectName: project.projectName));
              // Navigate to project details or surveys
              // Get.toNamed(AppRoute.projectDetails, arguments: [project]);
            },
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48.w,
                        height: 48.w,
                        decoration: BoxDecoration(
                          color: AppColors.yellowNormal.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Icon(
                          Icons.folder,
                          color: AppColors.yellowNormal,
                          size: 24.sp,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: project.projectName,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.blackNew,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4.h),
                            CustomText(
                              text: 'Project ID: ${project.id}',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.grayNormal,
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16.sp,
                        color: AppColors.grayNormal,
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 14.sp,
                        color: AppColors.grayNormal,
                      ),
                      SizedBox(width: 4.w),
                      CustomText(
                        text: 'Created: ${project.createdAt.substring(0, 10)}',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.grayNormal,
                      ),
                      // const Spacer(),
                      // Icon(
                      //   Icons.update,
                      //   size: 14.sp,
                      //   color: AppColors.grayNormal,
                      // ),
                      // SizedBox(width: 4.w),
                      // CustomText(
                      //   text: 'Updated: ${project.updatedAt.substring(0, 10)}',
                      //   fontSize: 12,
                      //   fontWeight: FontWeight.w400,
                      //   color: AppColors.grayNormal,
                      // ),
                    ],
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
