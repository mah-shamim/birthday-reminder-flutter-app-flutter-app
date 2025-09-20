import 'dart:math';
import 'package:birthday_reminder/helper/common_import.dart';
import 'package:pdf/pdf.dart';

class SaveMyCardPage extends GetView<SaveMyCardPageController> {
  const SaveMyCardPage({super.key});

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
                    controller.isSaved.value ? Get.offAllNamed(Routes.bottomPage) : Get.back();
                  }),
                  Text(
                    'Save my Card',
                    style: customTextStyle(
                      17.sp,
                      FontWeight.normal,
                    ),
                  ).onTap(() {
                    if (!controller.isSaved.value) {
                      controller.saveCard();
                    }
                  })
                ],
              ).pOnly(
                top: 15,
                right: 15,
                left: 15,
              ),
              SizedBox(height: 38.h),
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
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(20),
                        height: isTab(context) ? 600.w : 470.w,
                        width: isTab(context) ? 530.w : 320.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: TextField(
                          controller: controller.greetingsController.value,
                          textAlign: textAlignment(Settings.textAlignment),
                          style: Get.put(PreviewCardPageController()).changeFontsFamilyOfTextField().copyWith(
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
                            borderRadius: BorderRadius.circular(20),
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
              }).pOnly(left: controller.isOpen.value == true ? 0 : 25.w, right: 25.w),
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
              SizedBox(height: isTab(context) ? 60.w : 36.w),
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
                await generatePdfWithImageAndGreeting(
                    controller.image.value, controller.greetings.value, const PdfColor.fromInt(0xffFFFFFF), controller.setFontFamily(), context);
              }).pOnly(top: 15, right: 15, left: 15, bottom: 15),
            ],
          ),
        ),
      );
    });
  }
}
