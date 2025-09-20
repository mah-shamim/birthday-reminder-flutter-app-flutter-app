import 'package:birthday_reminder/ads/admob_ads.dart';
import 'package:birthday_reminder/helper/common_import.dart';
import 'package:pdf/pdf.dart';

class SendGreetingCardPage extends GetView<SendGreetingCardPageController> {
  const SendGreetingCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    var con = Get.put(PreviewCardPageController());
    return Obx(() {
      return Scaffold(
        body: Column(
          children: [
            SizedBox(height: 40.h),
            Row(
              children: [
                Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 20.sp,
                  color: Theme.of(context).colorScheme.secondary,
                ).onTap(() {
                  Get.back();
                }),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      'Greeting',
                      style: customTextStyle(
                        18.sp,
                        FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            showBannerAds(),
            SizedBox(height: 20.h),
            Container(
              height: isTab(context) ? 200.w : 180.w,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(15),
              width: width(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(20),
                color: Color(controller.colorList[controller.currentIndex.value]),
              ),
              child: Text(
                controller.greeting.value,
                textAlign: TextAlign.center,
                style: con.changeFontsFamilyOfTextField().copyWith(color: black),
              ),
            ),
            const Spacer(),
            Row(
              children: List.generate(
                controller.colorList.length,
                (index) {
                  return Container(
                    height: 60.w,
                    width: 60.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(15),
                      color: Color(controller.colorList[index]),
                    ),
                  ).onTap(() {
                    controller.currentIndex.value = index;
                  }).pOnly(left: 10);
                },
              ),
            ).scrollHorizontal(),
            SizedBox(height: 20.h),
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
              await generatePdfWithGreeting(
                Settings.name,
                controller.greeting.value,
                PdfColor.fromInt(controller.colorList[controller.currentIndex.value]),
                'assets/font/Roboto-Bold.ttf',
                context,
              ).then((value) {
                Get.back();
              });
            }),
          ],
        ).pSymmetric(v: 15, h: 15),
      );
    });
  }
}
