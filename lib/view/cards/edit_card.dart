import 'package:birthday_reminder/ads/admob_ads.dart';
import 'package:birthday_reminder/helper/common_import.dart';

class EditCardPage extends GetView<EditCardPageController> {
  const EditCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
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
                  Text(
                    'Done',
                    style: customTextStyle(
                      17.sp,
                      FontWeight.normal,
                    ),
                  ).onTap(() {
                    if (controller.greetingsController.value.text.isNotEmpty) {
                      Get.toNamed(
                        Routes.previewCardPage,
                        arguments: controller.greetingsController.value.text,
                      );
                    } else {
                      showAlertDialog(context, 'Alert', 'Please add greetings');
                    }
                  }),
                ],
              ).pSymmetric(v: 15, h: 15),
              SizedBox(height: 10.h),
              showBannerAds(),
              SizedBox(
                height: 50.h,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${controller.currentLength.value}/${controller.maxLength}',
                    style: controller.changeFontsFamilyOfTextField(controller.currentIndex.value).copyWith(
                          color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.15),
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ).pOnly(right: 50),
              ),
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
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        height: isTab(context) ? 600.w : 470.w,
                        width: isTab(context) ? 530.w : 320.w,
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
                        child: TextField(
                          controller: controller.greetingsController.value,
                          cursorColor: blue,
                          textAlign: textAlignment(controller.currentImageIndex.value),
                          style: controller.changeFontsFamilyOfTextField(controller.currentIndex.value).copyWith(
                                color: black,
                              ),
                          maxLines: null,
                          maxLength: controller.maxLength,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: 'Tap here to write',
                            hintStyle: customTextStyle(
                              16.sp,
                              FontWeight.w600,
                              color: black.withOpacity(0.15),
                            ),
                            counterText: '',
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      Image.asset(
                        I.addCircleIcon,
                        height: 30.w,
                      ).onTap(() {
                        Get.toNamed(Routes.greetingPage, arguments: 0);
                      }).pOnly(right: 10, bottom: 15)
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Container(
                padding: const EdgeInsets.only(left: 20),
                height: 70.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: black,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.2),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 30.w,
                      child: SvgPicture.asset(
                        controller.alignmentSvg[controller.currentImageIndex.value],
                        height: 30.w,
                        width: 30.w,
                        fit: BoxFit.contain,
                      ),
                    ).onTap(() {
                      controller.showNextSvg();
                    }),
                    SizedBox(width: 20.w),
                    Container(
                      height: 40.w,
                      width: 1.5.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: white.withOpacity(0.30),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.googleFonts.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            alignment: Alignment.center,
                            height: 40.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadiusDirectional.circular(30),
                              color: controller.currentIndex.value == index ? lightGreen : black,
                              border: Border.all(color: lightGreen),
                            ),
                            child: Text(
                              controller.googleFonts[index].title,
                              style: controller
                                  .changeFontsFamily(index, context)
                                  .copyWith(color: controller.currentIndex.value == index ? Colors.black : lightGreen),
                            ),
                          ).onTap(() {
                            controller.currentIndex.value = index;
                            Settings.textStyleIndex = controller.currentIndex.value;
                          }).pOnly(top: 15, bottom: 15, left: 8, right: 8);
                        },
                      ),
                    ),
                  ],
                ),
              ).pSymmetric(h: 15, v: 15),
            ],
          ),
        ),
      );
    });
  }
}
