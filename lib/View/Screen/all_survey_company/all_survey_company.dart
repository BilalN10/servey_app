import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:survey_markus/View/Screen/all_survey_company/controller/companylist_controller.dart';
import 'package:survey_markus/View/widgets/CustomSurveyCard/custom_survey_card.dart';
import 'package:survey_markus/View/widgets/custom_loader/custom_loader.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/View/widgets/custom_text_field/custom_text_field.dart';
import 'package:survey_markus/View/widgets/navBar/nav_bar.dart';
import 'package:survey_markus/global/screen/GenerelError/general_error.dart';
import 'package:survey_markus/global/screen/no%20internet/no_internet.dart';
import 'package:survey_markus/service/api_url.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';
import 'package:survey_markus/utils/AppConst/app_const.dart';
import 'package:survey_markus/utils/StaticString/static_string.dart';

class AllSurveyCompany extends StatelessWidget {
  AllSurveyCompany({super.key});

  final CompanyListController companyListController =
      Get.find<CompanyListController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const NavBar(currentIndex: 1),
        backgroundColor: AppColors.backgroundColor,
        body: RefreshIndicator(
          edgeOffset: double.maxFinite,
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          color: AppColors.yellowNormalHover,
          onRefresh: () {
            return companyListController.getCompanyList(search: "");
          },
          child: Obx(() {
            switch (companyListController.rxRequestStatus.value) {
              case Status.loading:
                return const CustomLoader();
              case Status.internetError:
                return NoInternetScreen(
                  onTap: () {
                    companyListController.getCompanyList(search: "");
                  },
                );
              case Status.error:
                return GeneralErrorScreen(
                  onTap: () {
                    companyListController.getCompanyList(search: "");
                  },
                );

              case Status.completed:
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                  child: Column(
                    children: [
                      CustomText(
                        top: 44.h,
                        bottom: 20.h,
                        text: AppStaticStrings.allSurveyCompany,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: AppColors.grayDarker,
                      ),

                      ///<========================== This is the search field ======================>

                      CustomTextField(
                        onSubmit: (value) {
                          companyListController.getCompanyList(search: value);
                          companyListController.showClear.value = true;
                        },
                        hintText: AppStaticStrings.searchhere,
                        isPrefixIcon: true,
                        hintStyle:
                            const TextStyle(color: AppColors.yellowNormal),
                        prefixIconColor: AppColors.yellowNormal,
                        focusBorderColor: AppColors.yellowNormalHover,
                        textInputAction: TextInputAction.search,
                      ),

                      if (companyListController.showClear.value)
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {
                                companyListController.getCompanyList(
                                    search: "");
                                companyListController.showClear.value = false;
                              },
                              child: CustomText(
                                text: AppStaticStrings.clear,
                                fontSize: 14.sp,
                              )),
                        ),

                      ///<============================ This is the survey company list =======================>

                      Expanded(
                        child: ListView.builder(
                          itemCount: companyListController.companyList.length,
                          itemBuilder: (context, index) {
                            var data = companyListController.companyList[index];
                            return CustomSurveyCard(
                              image: "${ApiUrl.baseUrl}/${data.image ?? ""}",
                              buttonText: data.status == "accepted"
                                  ? "Joined"
                                  : data.status == "pending"
                                      ? AppStaticStrings.joinReqSended
                                      : AppStaticStrings.joinCompany,
                              companyName: data.name ?? "no",
                              onTap: () {
                                if (data.status == "default") {
                                  companyListController.sendJoinReq(
                                      companyID: data.id.toString(),
                                      index: index);
                                }
                              },
                            );
                          },
                        ),
                      )
                    ],
                  ),
                );
            }
          }),
        ));
  }
}
