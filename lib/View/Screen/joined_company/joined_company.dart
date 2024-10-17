import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey_markus/View/Screen/HomeScreen/controller/home_controller.dart';
import 'package:survey_markus/View/widgets/custom_company_card/custom_company_card.dart';
import 'package:survey_markus/View/widgets/custom_loader/custom_loader.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/core/app_routes/app_routes.dart';
import 'package:survey_markus/global/screen/GenerelError/general_error.dart';
import 'package:survey_markus/global/screen/no%20internet/no_internet.dart';
import 'package:survey_markus/service/api_url.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';
import 'package:survey_markus/utils/AppConst/app_const.dart';
import 'package:survey_markus/utils/StaticString/static_string.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JoinedCompany extends StatelessWidget {
  JoinedCompany({super.key});
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppStaticStrings.joinedUpSurveyCompany,
          fontSize: 14.w,
        ),
      ),
      body: RefreshIndicator(
        edgeOffset: double.maxFinite,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        color: AppColors.yellowNormalHover,
        onRefresh: () {
          return homeController.joinedCompanyList();
        },
        child: Obx(() {
          switch (homeController.joinedCompanyLoading.value) {
            case Status.loading:
              return const CustomLoader();
            case Status.internetError:
              return NoInternetScreen(
                onTap: () {
                  // controller.getFaq();
                },
              );
            case Status.error:
              return GeneralErrorScreen(
                onTap: () {
                  // controller.getFaq();
                },
              );

            case Status.completed:
              return homeController.jointedCompanyList.isEmpty
                  ? Center(
                      child: IconButton(
                        onPressed: () {
                          homeController.joinedCompanyList();
                        },
                        icon: const CustomText(text: "Refresh for update"),
                      ),
                    )
                  : ListView.builder(
                      itemCount: homeController.jointedCompanyList.length,
                      itemBuilder: (context, index) {
                        var data = homeController.jointedCompanyList[index];
                        return CustomCompanyCard(
                          size: 20,
                          onTap: () {
                            Get.toNamed(AppRoute.allProjectScreen, arguments: [
                              "${ApiUrl.baseUrl}/${data.user?.image ?? ""}",
                              data.user?.name ?? "",
                              data.companyId.toString()
                            ]);
                          },
                          companyName: data.user?.name ?? "",
                          image: "${ApiUrl.baseUrl}/${data.user?.image ?? ""}",
                        );
                      },
                    );
          }
        }),
      ),
    );
  }
}
