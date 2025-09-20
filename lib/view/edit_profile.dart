import 'package:birthday_reminder/helper/common_import.dart';

class EditProfilePage extends GetView<EditProfilePageController> {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        controller.image.value;
        return Scaffold(
          resizeToAvoidBottomInset: false,
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
                          size: 20.sp,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        Text(
                          'Back',
                          style: customTextStyle(
                            16.sp,
                            FontWeight.normal,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ).onTap(() {
                      Get.back(result: false);
                    }),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        'Edit Profile',
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
                      ).onTap(() {
                        controller.validation(context);
                      }),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50.h),
              controller.imageBytes == null || controller.imageBytes!.isEmpty
                  ? Container(
                      height: 120.w,
                      width: 120.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            I.profileImage,
                          ),
                        ),
                      ),
                      child: Text(
                        controller.getInitials(),
                        style: customTextStyle(
                          35.sp,
                          FontWeight.w800,
                          color: Colors.white,
                        ),
                      )).onTap(() async {
                      await bottomSheet(context);
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
                            child: Image.memory(
                              controller.imageBytes!,
                              height: 120.w,
                              width: 120.w,
                              fit: BoxFit.cover,
                            ).onTap(() async {}),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 5,
                            child: Image.asset(
                              I.cameraCir,
                              height: 34.h,
                            ).onTap(() async {
                              bottomSheet(context);
                            }),
                          )
                        ],
                      ),
                    ),
              SizedBox(height: 70.h),
              Container(
                height: 65.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context).colorScheme.primaryContainer,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.20),
                  ),
                ),
                child: Stack(
                  children: [
                    Text(
                      'Name',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.20),
                      ),
                    ).pOnly(left: 15, top: 9, bottom: 5),
                    TextField(
                      controller: controller.nameController.value,
                      cursorColor: blue,
                      style: customTextStyle(
                        20.sp,
                        FontWeight.w700,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ).pOnly(top: 8, left: 5),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Container(
                    height: 65.w,
                    width: 80.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context).colorScheme.primaryContainer,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.20),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Text(
                          'DD',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.20),
                          ),
                        ).pOnly(left: 15, top: 9, bottom: 5),
                        Positioned(
                          bottom: 10,
                          left: 15,
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
                  ),
                  SizedBox(width: 15.w),
                  Container(
                    height: 65.w,
                    width: 80.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context).colorScheme.primaryContainer,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.20),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Text(
                          'MM',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.20),
                          ),
                        ).pOnly(
                          left: 15,
                          top: 9,
                          bottom: 5,
                        ),
                        Positioned(
                          bottom: 10,
                          left: 15,
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
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: Container(
                      height: 65.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Theme.of(context).colorScheme.primaryContainer,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.20),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Text(
                            'YYYY',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.20),
                            ),
                          ).pOnly(left: 15, top: 9, bottom: 5),
                          Positioned(
                            bottom: 10,
                            left: 15,
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
                  ),
                ],
              ).onTap(() {
                controller.pickDate(context);
              }),
              SizedBox(height: 20.h),
              Container(
                height: 60.w,
                padding: const EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context).colorScheme.primaryContainer,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.20),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Gender',
                      style: customTextStyle(
                        20.sp,
                        FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      controller.gender.value,
                      style: customTextStyle(
                        20.sp,
                        FontWeight.w500,
                        color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.30),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 20.sp,
                      color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.30),
                    ),
                  ],
                ),
              ).onTap(() {
                if (controller.gender.value == 'Male') {
                  controller.gender.value = 'Female';
                } else {
                  controller.gender.value = 'Male';
                }
              }),
              const Spacer(),
              Container(
                height: 60.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  'Delete Account',
                  style: customTextStyle(
                    16.sp,
                    FontWeight.w600,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ).onTap(() {
                deleteDialog(context);
              }),
            ],
          ).pSymmetric(v: 15, h: 15),
        );
      },
    );
  }

  Future bottomSheet(BuildContext context) {
    return showModalBottomSheet(
      enableDrag: false,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      constraints: BoxConstraints(
        maxHeight: 210.w,
        maxWidth: width(context),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      context: context,
      builder: (context) {
        return Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 105.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    color: Theme.of(context).colorScheme.primary,
                    child: Text(
                      'Take Photo',
                      style: customTextStyle(
                        20.sp,
                        FontWeight.normal,
                        color: blue,
                      ),
                    ),
                  ).onTap(() async {
                    controller.requestPermission.value = await controller.requestPermissions();
                    Get.back();
                    await controller.getImageFromGallery(1);
                  }),
                  Divider(
                    color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.20),
                  ),
                  Container(
                    color: Theme.of(context).colorScheme.primary,
                    child: Text(
                      'Photo Library',
                      style: customTextStyle(
                        20.sp,
                        FontWeight.normal,
                        color: blue,
                      ),
                    ),
                  ).onTap(() async {
                    Get.back();
                    await controller.getImageFromGallery(0);
                  }),
                ],
              ),
            ),
            const Spacer(),
            Container(
              height: 60.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Text(
                'Cancel',
                style: customTextStyle(
                  20.sp,
                  FontWeight.w500,
                  color: blue,
                ),
              ),
            ).onTap(() {
              Get.back();
            })
          ],
        ).pSymmetric(h: 10, v: 15);
      },
    );
  }
}
