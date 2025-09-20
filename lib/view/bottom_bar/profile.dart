import 'package:birthday_reminder/ads/admob_ads.dart';
import 'package:birthday_reminder/helper/common_import.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfilePageController());
    return Obx(() {
      controller.image.value;
      return Scaffold(
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      Get.toNamed(Routes.editProfilePage)?.then((value) {
                        print(value);
                        if (value) {
                          print('object');
                          controller.name.value = Settings.name;
                          if (Settings.data.isNotEmpty) {
                            controller.sImage = Settings.data;
                            controller.image.value = controller.sImage.toString();
                            debugPrint('Image saved ->>>>>>>>>');
                          }
                        }
                      });
                    },
                    child: Text(
                      'Edit',
                      style: customTextStyle(
                        17.sp,
                        FontWeight.normal,
                        color: blue,
                      ),
                    )),
              ),
              SizedBox(height: 10.h),
              controller.sImage == null || controller.sImage!.isEmpty
                  ? Container(
                      height: 120.w,
                      width: 120.w,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white, // Background color
                        border: Border.all(
                          color: blue,
                          width: 1.5,
                        ),
                      ),
                      child: Container(
                        height: 120.w,
                        width: 120.w,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: blue, // Background color
                        ),
                        child: Text(
                          controller.getInitials(),
                          style: customTextStyle(
                            35.sp,
                            FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      height: 120.w,
                      width: 120.w,
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: blue,
                        ),
                      ),
                      child: Stack(
                        children: [
                          ClipOval(
                            child: Image.memory(
                              controller.sImage!,
                              height: 140.w,
                              width: 140.w,
                              fit: BoxFit.cover,
                            ).onTap(() async {}),
                          ),
                        ],
                      ),
                    ),
              SizedBox(height: 20.h),
              Text(
                controller.name.value,
                textAlign: TextAlign.center,
                style: customTextStyle(
                  24.sp,
                  FontWeight.w900,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                controller.formatedDate(),
                textAlign: TextAlign.center,
                style: customTextStyle(
                  18.sp,
                  FontWeight.w500,
                  color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.33),
                ),
              ),
              SizedBox(height: 15.h),
              showBannerAds(),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.profileList.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              controller.profileList[index].images,
                              height: 40.w,
                              width: 40.w,
                            ),
                            SizedBox(width: 15.w),
                            Text(
                              controller.profileList[index].title,
                              style: customTextStyle(
                                16.sp,
                                FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 20.sp,
                            )
                          ],
                        ),
                        Divider(
                          thickness: 1,
                          color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.08),
                        ),
                      ],
                    ).pOnly(top: 10),
                  ).onTap(() {
                    controller.navigation(index, context);
                  });
                },
              )
            ],
          ).pSymmetric(v: 15, h: 15),
        ),
      );
    });
  }
}
