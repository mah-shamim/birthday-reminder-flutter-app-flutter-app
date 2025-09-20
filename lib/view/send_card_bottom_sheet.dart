import 'dart:math';

import 'package:birthday_reminder/ads/admob_ads.dart';
import 'package:birthday_reminder/helper/common_import.dart';
import 'package:pdf/pdf.dart';

class SendCardBottomSheetPage extends GetView<SendCardBottomSheetPageController> {
  const SendCardBottomSheetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        // resizeToAvoidBottomInset: true,
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
              ).pOnly(
                top: 15,
                right: 15,
                left: 15,
              ),
              SizedBox(height: 10.h),
              showBannerAds(),
              SizedBox(height: 20.h),
              Stack(
                children: [
                  Row(
                    children: [
                      Visibility(
                        visible: controller.isOpen.value,
                        child: Container(
                          height: isTab(context) ? 600.w : 470.w,
                          width: 25.w,
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
                            child: Stack(
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
                                    textAlign: TextAlign.center,
                                    style: customTextStyle(
                                      17.sp,
                                      FontWeight.w600,
                                      color: black,
                                    ),
                                    maxLines: null,
                                    keyboardType: TextInputType.multiline,
                                    cursorColor: blue,
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
                                  Get.toNamed(Routes.greetingPage, arguments: 4);
                                }).pOnly(right: 10, bottom: 15)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  AnimatedBuilder(
                    animation: controller.animationController,
                    builder: (context, child) {
                      return Transform(
                        transform: Matrix4.identity()..rotateY(controller.animationController.value * pi / 2),
                        child: Container(
                          height: isTab(context) ? 600.w : 470.w,
                          width: isTab(context) ? 530.w : 320.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: AssetImage(
                                controller.image.value,
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ).onTap(() {
                controller.toggleAnimation(context);
              }).pOnly(left: controller.isOpen.value == true ? 0 : 25.w, right: 25),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    I.tapIcon,
                    height: 30.w,
                    color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.2),
                  ),
                  Text(
                    controller.isOpen.value ? 'Tap to Close' : 'Tap to Open',
                    style: customTextStyle(
                      17.sp,
                      FontWeight.normal,
                      color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.2),
                    ),
                  )
                ],
              ),
              // SizedBox(height: 10.h),
              Container(
                height: 65.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(15),
                  color: blue,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      I.sendIcon,
                      height: 20.w,
                      color: Colors.white,
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      'Send Card',
                      style: customTextStyle(
                        18.sp,
                        FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ).onTap(() async {
                if (controller.image.value.isNotEmpty && controller.greetingsController.value.text.isNotEmpty) {
                  await generatePdfWithImageAndGreeting(
                    controller.image.value,
                    controller.greetingsController.value.text,
                    const PdfColor.fromInt(0xffFFFFFF),
                    'assets/font/Roboto-Bold.ttf',
                    context,
                  ).then((value) {
                    Get.back();
                  });
                }
              }).pOnly(top: 15, right: 15, left: 15, bottom: 15),
            ],
          ),
        ),
      );
    });
  }
}
