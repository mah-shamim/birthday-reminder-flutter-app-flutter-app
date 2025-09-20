import 'package:birthday_reminder/ads/admob_ads.dart';
import 'package:birthday_reminder/helper/common_import.dart';

class MyCardsPage extends GetView<MyCardsPageController> {
  const MyCardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: Column(
          children: [
            SizedBox(height: 40.h),
            Row(
              children: [
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
                SizedBox(width: 80.w),
                Text(
                  'My Cards',
                  style: customTextStyle(
                    18.sp,
                    FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.h),
            showBannerAds(),
            SizedBox(height: 15.h),
            Expanded(
              child: RefreshIndicator(
                color: blue,
                onRefresh: () {
                  return Future.delayed(const Duration(milliseconds: 800), () async {
                    await controller.fetchMyCards();
                  });
                },
                child: Column(
                  children: [
                    Expanded(
                      child: controller.myCardsList.isEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'No Any Card Found',
                                  style: customTextStyle(
                                    20.sp,
                                    FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  'Create a personalized greeting card to\n make someone’s day special',
                                  textAlign: TextAlign.center,
                                  style: customTextStyle(
                                    14.sp,
                                    FontWeight.w500,
                                    color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.490),
                                  ),
                                ),
                              ],
                            )
                          : GridView.builder(
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                              ),
                              itemCount: controller.myCardsList.length,
                              physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                mainAxisExtent: isTab(context) ? height(context) * 0.400 : height(context) * 0.250,
                              ),
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      image: AssetImage(controller.myCardsList[index].image.toString()),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ).onTap(() {
                                  Get.toNamed(Routes.myCardDetailPage, arguments: {
                                    'greetings': controller.myCardsList[index].greetings,
                                    'image': controller.myCardsList[index].image,
                                    'index': controller.myCardsList[index].uid,
                                    'fontString': controller.myCardsList[index].fontString,
                                  });
                                });
                              },
                            ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ).pSymmetric(v: 15, h: 15),
      );
    });
  }
}
