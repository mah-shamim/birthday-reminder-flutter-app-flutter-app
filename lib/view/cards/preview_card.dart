import 'package:birthday_reminder/ads/admob_ads.dart';
import 'package:birthday_reminder/helper/common_import.dart';

class PreviewCardPage extends GetView<PreviewCardPageController> {
  const PreviewCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.arrow_back_ios_new,
                  size: 20.sp,
                ).onTap(() {
                  Get.back();
                }),
              ],
            ).pSymmetric(v: 15, h: 15),
            SizedBox(height: 10.h),
            showBannerAds(),
            SizedBox(height: 10.h),
            Row(
              children: [
                Container(
                  height: isTab(context) ? 600.w : 470.w,
                  width: 30.w,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.04),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.10),
                    ),
                  ),
                ),
                Container(
                  height: isTab(context) ? 600.w : 470.w,
                  width: isTab(context) ? 530.w : 320.w,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.10),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: Text(
                    controller.text.value,
                    textAlign: textAlignment(Settings.textAlignment),
                    style: controller.changeFontsFamilyOfTextField().copyWith(
                          color: black,
                        ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.w),
            Container(
              alignment: Alignment.center,
              height: 65.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: blue,
              ),
              child: Text(
                'Preview Card',
                style: customTextStyle(
                  18.sp,
                  FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ).onTap(() {
              Get.toNamed(
                Routes.saveMyCardPage,
                arguments: controller.text.value,
              );
            }).pSymmetric(h: 15, v: 15),
          ],
        ),
      ),
    );
  }
}
