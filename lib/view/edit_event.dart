import 'package:birthday_reminder/helper/common_import.dart';

class EditEventPage extends GetView<EditEventPageController> {
  const EditEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      controller.image.value;
      return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: isTab(context) ? height(context) * 0.50 : height(context) * 0.45,
                width: width(context),
                decoration: BoxDecoration(
                  color: controller.model.anniversary == 'Birthday'
                      ? birthaEventColor
                      : controller.model.anniversary == 'Anniversary'
                          ? anniversaryEventColor
                          : otherEventColor,
                  image: controller.imageBytes != null
                      ? DecorationImage(
                          image: MemoryImage(
                            controller.imageBytes!,
                          ),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 40.h),
                    Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 20.sp,
                            color: Colors.white,
                          ).onTap(() {
                            Get.back();
                          }),
                          const Spacer(),
                          Text(
                            'Done',
                            style: customTextStyle(
                              17.sp,
                              FontWeight.normal,
                              color: Colors.white,
                            ),
                          ).onTap(() {
                            controller.validation(context);
                          })
                        ],
                      ).pSymmetric(v: 15, h: 15),
                    ),
                    const Spacer(),
                    Container(
                      height: 100.w,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        colors: [
                          const Color(0xff000000).withOpacity(0),
                          const Color(0xff000000).withOpacity(0.40),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(
                            I.cameraIcon,
                            height: 35.w,
                          )
                        ],
                      ).pOnly(right: 15, top: 30).onTap(() {
                        controller.getImageFromGallery(context);
                      }),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 40.w,
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
                    /*controller.selectedIndex.value = 0;*/
                  }),
                  SizedBox(width: isTab(context) ? 30.w : 15.w),
                  Container(
                    alignment: Alignment.center,
                    height: 40.w,
                    padding: const EdgeInsets.only(left: 10, right: 10),
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
                    /*controller.selectedIndex.value = 1;*/
                  }),
                  SizedBox(width: isTab(context) ? 30.w : 15.w),
                  Container(
                    alignment: Alignment.center,
                    height: 40.w,
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
                    /*controller.selectedIndex.value = 2;*/
                  }),
                ],
              ),
              SizedBox(height: 5.h),
              Column(
                children: [
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
                    alignment: Alignment.center,
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
                        controller: controller.greetingsController.value,
                        cursorColor: blue,
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
                      Get.toNamed(Routes.greetingPage, arguments: 3);
                    }),
                  ),
                ],
              ).pSymmetric(v: 15, h: 15),
            ],
          ),
        ),
      );
    });
  }
}
