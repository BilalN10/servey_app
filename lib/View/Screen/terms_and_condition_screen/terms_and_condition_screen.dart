import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:survey_markus/View/Screen/terms_and_condition_screen/controller/terms_controller.dart';
import 'package:survey_markus/View/widgets/custom_loader/custom_loader.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/global/screen/GenerelError/general_error.dart';
import 'package:survey_markus/global/screen/no%20internet/no_internet.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';
import 'package:survey_markus/utils/AppConst/app_const.dart';
import 'package:survey_markus/utils/StaticString/static_string.dart';

class TermsAndConditionScreen extends StatelessWidget {
  TermsAndConditionScreen({super.key});
  final TermsController controller = Get.find<TermsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,

        ///====================Terms and condition Appbar=============
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          title: CustomText(
            text: AppStaticStrings.termsAndCondition,
            fontSize: 24.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.grayDarker,
          ),
          centerTitle: true,
        ),
        body: Obx(() {
          switch (controller.rxRequestStatus.value) {
            case Status.loading:
              return const CustomLoader();
            case Status.internetError:
              return NoInternetScreen(
                onTap: () {
                  controller.getTermsAndCondition();
                },
              );
            case Status.error:
              return GeneralErrorScreen(
                onTap: () {
                  controller.getTermsAndCondition();
                },
              );

            case Status.completed:
              return SingleChildScrollView(
                  padding: EdgeInsets.all(20.r),
                  child: HtmlWidget(controller.policy.value));
          }
        }));
  }
}
