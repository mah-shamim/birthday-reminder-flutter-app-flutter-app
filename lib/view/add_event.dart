import 'dart:io';
import 'package:birthday_reminder/helper/common_import.dart';

class AddEventPage extends GetView<AddEventPageController> {
  const AddEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
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
                          size: 20.sp,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        Text(
                          'Cancel',
                          style: customTextStyle(
                            16.sp,
                            FontWeight.normal,
                            color: Theme.of(context).colorScheme.secondary,
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
                        'Add Event',
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
                        'Save',
                        style: customTextStyle(
                          16.sp,
                          FontWeight.normal,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ).onTap(() {
                      controller.validation(context);
                    }),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              ValueListenableBuilder<File?>(
                valueListenable: controller.imageNotifier,
                builder: (context, imageFile, child) {
                  return controller.isImagePicked.value == false
                      ? Image.asset(
                          controller.selectedIndex.value == 0
                              ? I.birthdayEvent
                              : controller.selectedIndex.value == 1
                                  ? I.anniversaryEvent
                                  : I.otherEvent,
                          height: 120.h,
                          fit: BoxFit.cover,
                        ).onTap(() async {
                          await controller.getImageFromGallery(context);
                        })
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
                                child: Image.file(
                                  controller.imageNotifier.value!,
                                  height: 120.h,
                                  width: 120.w,
                                  fit: BoxFit.cover,
                                ).onTap(() async {
                                  await controller.getImageFromGallery(context);
                                }),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 5,
                                child: Image.asset(
                                  I.cameraCir,
                                  height: 34.h,
                                ).onTap(() async {
                                  await controller.getImageFromGallery(context);
                                }),
                              )
                            ],
                          ),
                        ); // Default text if no image is selected
                },
              ),
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: isTab(context) ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 45.h,
                    width: 95.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: controller.selectedIndex.value == 0 ? blue : Colors.transparent,
                      border: Border.all(
                        color: controller.selectedIndex.value == 0 ? Colors.transparent : blue,
                      ),
                    ),
                    child: Text(
                      'Birthday',
                      style: customTextStyle(
                        16.sp,
                        FontWeight.w600,
                        color: controller.selectedIndex.value == 0 ? Colors.white : Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  ).onTap(() {
                    controller.selectedIndex.value = 0;
                  }),
                  SizedBox(width: isTab(context) ? 30.w : 15.w),
                  Container(
                    alignment: Alignment.center,
                    height: 45.h,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    // width: 120.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: controller.selectedIndex.value == 1 ? blue : Colors.transparent,
                      border: Border.all(
                        color: controller.selectedIndex.value == 1 ? Colors.transparent : blue,
                      ),
                    ),
                    child: Text(
                      'Anniversary',
                      style: customTextStyle(
                        16.sp,
                        FontWeight.w600,
                        color: controller.selectedIndex.value == 1 ? Colors.white : Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  ).onTap(() {
                    controller.selectedIndex.value = 1;
                  }),
                  SizedBox(width: isTab(context) ? 30.w : 15.w),
                  Container(
                    alignment: Alignment.center,
                    height: 45.h,
                    width: 77.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: controller.selectedIndex.value == 2 ? blue : Colors.transparent,
                      border: Border.all(
                        color: controller.selectedIndex.value == 2 ? Colors.transparent : blue,
                      ),
                    ),
                    child: Text(
                      'Other',
                      style: customTextStyle(
                        16.sp,
                        FontWeight.w600,
                        color: controller.selectedIndex.value == 2 ? Colors.white : Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  ).onTap(() {
                    controller.selectedIndex.value = 2;
                  }),
                ],
              ),
              SizedBox(height: 20.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Name',
                  style: customTextStyle(
                    16.sp,
                    FontWeight.normal,
                    color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.45),
                  ),
                ),
              ).pOnly(left: 5),
              SizedBox(height: 5.h),
              Container(
                height: 60.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.20),
                    )),
                child: TextField(
                  controller: controller.nameController.value,
                  cursorColor: blue,
                  style: customTextStyle(
                    16.sp,
                    FontWeight.w700,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.primaryContainer,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'DD',
                        style: customTextStyle(
                          16.sp,
                          FontWeight.normal,
                          color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.45),
                        ),
                      ).pOnly(left: 5),
                      SizedBox(height: 5.h),
                      Container(
                        height: 60.w,
                        width: 80.w,
                        padding: const EdgeInsets.only(left: 15),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Theme.of(context).colorScheme.primaryContainer,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.20),
                          ),
                        ),
                        child: Text(
                          controller.day.value,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 15.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'MM',
                        style: customTextStyle(
                          16.sp,
                          FontWeight.normal,
                          color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.45),
                        ),
                      ).pOnly(left: 5),
                      SizedBox(height: 5.h),
                      Container(
                        height: 60.w,
                        width: 80.w,
                        padding: const EdgeInsets.only(left: 15),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Theme.of(context).colorScheme.primaryContainer,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.20),
                          ),
                        ),
                        child: Text(
                          controller.month.value,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'YYYY',
                          style: customTextStyle(
                            16.sp,
                            FontWeight.normal,
                            color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.45),
                          ),
                        ).pOnly(left: 5),
                        SizedBox(height: 5.h),
                        Container(
                          padding: const EdgeInsets.only(left: 15),
                          alignment: Alignment.centerLeft,
                          height: 60.w,
                          width: 200.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Theme.of(context).colorScheme.primaryContainer,
                            border: Border.all(
                              color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.20),
                            ),
                          ),
                          child: Text(
                            controller.year.value,
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ).onTap(() {
                controller.pickDate(context);
              }),
              SizedBox(height: 20.h),
              Visibility(
                visible: controller.selectedIndex.value == 0,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Greeting (Optional)',
                    style: customTextStyle(
                      16.sp,
                      FontWeight.normal,
                      color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.45),
                    ),
                  ).pOnly(left: 5),
                ),
              ),
              SizedBox(height: 5.h),
              Visibility(
                visible: controller.selectedIndex.value == 0,
                child: Container(
                  height: 130.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.20),
                      )),
                  child: TextField(
                    cursorColor: blue,
                    controller: controller.greetingsController.value,
                    maxLines: 5,
                    style: customTextStyle(
                      16.sp,
                      FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.primaryContainer,
                      hintText: 'Type here...',
                      hintStyle: customTextStyle(
                        16.sp,
                        FontWeight.normal,
                        color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.29),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Visibility(
                visible: controller.selectedIndex.value == 0,
                child: Container(
                  alignment: Alignment.center,
                  height: 45.w,
                  width: 120.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: blue,
                  ),
                  child: Text(
                    'Add Greeting',
                    style: customTextStyle(
                      14.sp,
                      FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ).onTap(() {
                  Get.toNamed(Routes.greetingPage, arguments: 2);
                }),
              ),
              /* SizedBox(height: 10.h),
              showBannerAds()*/
            ],
          ).pSymmetric(v: 15, h: 15),
        ),
      );
    });
  }
}
