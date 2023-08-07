import 'package:get/get.dart';
import 'package:onboarding_concept/main.dart';
import 'package:onboarding_concept/ui/utils/colors/color.dart';
import 'package:quickalert/quickalert.dart';

void showQuickDialog(String title, QuickAlertType dialogType, String content, {Function()? customFunction}) {
  QuickAlert.show(
    context: navigatorKey.currentContext!,
    type: dialogType,
    title: title,
    text: content,
    confirmBtnText: 'OK',
    onConfirmBtnTap: () {
      if (customFunction != null) {
        customFunction();
      } else {
        Get.back();
      }
    },
  );
}

void showYesNoQuickDialog(String title, QuickAlertType dialogType, String content, {Function()? customFunction}) {
  QuickAlert.show(
    context: navigatorKey.currentContext!,
    type: dialogType,
    title: title,
    text: content,
    confirmBtnText: 'Yes',
    cancelBtnText: 'No',
    confirmBtnColor: themeColor,
    onConfirmBtnTap: () {
      if (customFunction != null) {
        customFunction();
      } else {
        Get.back();
      }
    },
    onCancelBtnTap: () {
      Get.back();
    },
  );
}
