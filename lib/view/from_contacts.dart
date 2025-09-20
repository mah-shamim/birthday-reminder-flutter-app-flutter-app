import 'package:birthday_reminder/ads/admob_ads.dart';
import 'package:birthday_reminder/helper/common_import.dart';

class FromContactsPage extends GetView<FromContactsPageController> {
  const FromContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: Column(
          children: [
            SizedBox(height: 40.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
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
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      'Contacts',
                      style: customTextStyle(
                        18.sp,
                        FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Done',
                      style: customTextStyle(
                        16.sp,
                        FontWeight.normal,
                        color: blue,
                      ),
                    ).onTap(() {
                      controller.validation(context, controller.selectedContactName.value);
                    }),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.h),
            showBannerAds(),
            Visibility(
              visible: controller.contactsList.isNotEmpty,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select all',
                    style: customTextStyle(15.sp, FontWeight.w600),
                  ),
                  Checkbox(
                    value: controller.isAllSelect.value,
                    checkColor: Colors.white,
                    activeColor: blue,
                    onChanged: (bool? value) {
                      controller.isAllSelect.value = value!;
                      if (controller.isAllSelect.value) {
                        controller.selectedContactList.addAll(controller.contactsList);
                      } else {
                        controller.selectedContactList.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: controller.contactsList.isEmpty
                  ? controller.isLoading.value
                      ? Container()
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'No Contact Found',
                              style: customTextStyle(
                                20.sp,
                                FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              'You don’t have any contacts in your\n Contact book',
                              textAlign: TextAlign.center,
                              style: customTextStyle(
                                14.sp,
                                FontWeight.w500,
                                color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.490),
                              ),
                            ),
                          ],
                        )
                  : ListView.builder(
                      itemCount: controller.contactsList.length,
                      padding: EdgeInsets.zero,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Obx(() {
                          return Container(
                            color: Colors.transparent,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      height: 45.w,
                                      width: 45.w,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: blue,
                                      ),
                                      child: controller.contactsList[index].photoOrThumbnail == null
                                          ? Text(
                                              controller.getInitials(controller.contactsList[index].displayName),
                                              style: customTextStyle(
                                                17.sp,
                                                FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            )
                                          : ClipOval(
                                              child: Image.memory(
                                                controller.contactsList[index].photoOrThumbnail!,
                                                fit: BoxFit.cover,
                                                width: 45.w,
                                                height: 45.w,
                                              ),
                                            ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Text(
                                      controller.contactsList[index].displayName,
                                      style: customTextStyle(
                                        17.sp,
                                        FontWeight.w500,
                                      ),
                                    ),
                                    const Spacer(),
                                    Visibility(
                                      visible: controller.selectedContactList.contains(controller.contactsList[index]),
                                      child: Icon(
                                        Icons.check,
                                        size: 20.sp,
                                        color: blue,
                                      ).pOnly(right: 10),
                                    ),
                                  ],
                                ),
                                Divider(
                                  thickness: 1,
                                  color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.08),
                                ),
                              ],
                            ),
                          );
                        }).onTap(() {
                          if (controller.selectedContactList.contains(controller.contactsList[index])) {
                            controller.selectedContactList.remove(controller.contactsList[index]);
                          } else {
                            controller.selectedContactList.add(controller.contactsList[index]);
                          }
                          debugPrint('${controller.selectedContactList.length}');
                          controller.selectedContactName.value = controller.contactsList[index].displayName;
                          if (controller.contactsList.length == controller.selectedContactList.length) {
                            controller.isAllSelect.value = true;
                          } else {
                            controller.isAllSelect.value = false;
                          }
                        }).pOnly(top: 10, left: 5);
                      },
                    ),
            ),
          ],
        ).pSymmetric(v: 15, h: 15),
      );
    });
  }
}
