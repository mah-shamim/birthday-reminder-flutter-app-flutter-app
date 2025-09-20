import 'package:birthday_reminder/helper/common_import.dart';

class DarkLightModePage extends GetView<DarkLightModePageController> {
  const DarkLightModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 40.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.arrow_back_ios_new_rounded,
                color: blue,
                size: 20.sp,
              ),
              Text(
                'Back',
                style: customTextStyle(
                  16.sp,
                  FontWeight.normal,
                  color: blue,
                ),
              ),
            ],
          ).onTap(() {
            Get.back();
          }),
          SizedBox(height: 20.h),
          buildRadioOption('System Default', 0),
          buildDivider(context),
          buildRadioOption('Dark', 1),
          buildRadioOption('Light', 2),
        ],
      ).pSymmetric(v: 15, h: 15),
    );
  }

  Widget buildRadioOption(String text, int index) {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Radio(
              value: controller.modeList[index],
              groupValue: controller.selectedMode.value,
              onChanged: (value) {
                controller.changeTheme(value.toString());
                Settings.mode = value ?? '';
                debugPrint("Selected Theme Mode: ${controller.selectedMode.value}");
              },
            ),
          ],
        ).paddingSymmetric(horizontal: 10));
  }

  Divider buildDivider(BuildContext context) {
    return Divider(
      thickness: 1,
      color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.07),
    );
  }
}
