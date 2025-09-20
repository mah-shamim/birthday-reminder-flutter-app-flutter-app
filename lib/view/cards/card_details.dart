import 'package:birthday_reminder/helper/common_import.dart';

class CardDetailsPage extends GetView<CardDetailsPageController> {
  const CardDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40.h),
              Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios_new,
                    size: 20.sp,
                  ).onTap(() {
                    Get.back();
                  }),
                ],
              ),
              SizedBox(height: 50.h),
              Column(
                children: [
                  Container(
                    height: isTab(context) ? 600.w : 470.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: controller.card.value.isEmpty
                          ? null
                          : DecorationImage(
                              image: AssetImage(
                                controller.card.value,
                              ),
                              fit: BoxFit.fill,
                            ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: isTab(context) ? 50.h : 95.h),
              Container(
                height: 65.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(15),
                  color: blue,
                ),
                child: Text(
                  'Edit Card',
                  style: customTextStyle(
                    18.sp,
                    FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ).onTap(() {
                Get.toNamed(Routes.editCardPage);
              }),
            ],
          ).pSymmetric(h: 15, v: 15),
        ),
      );
    });
  }
}
