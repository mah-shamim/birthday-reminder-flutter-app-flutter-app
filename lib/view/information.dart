import 'package:birthday_reminder/helper/common_import.dart';

class InformationPage extends GetView<InformationPageController> {
  const InformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: blue,
        resizeToAvoidBottomInset: false,
        body: Container(
          width: width(context),
          height: height(context),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                I.bgImage,
              ),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height(context) * 0.36),
              Expanded(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: controller.pageController,
                  children: <Widget>[
                    EnterYourName(controller: controller),
                    AddYourBirthday(controller: controller),
                    ChooseYourGender(controller: controller),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 60.w,
                    width: width(context) * 0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: white,
                    ),
                    child: Text(
                      controller.j.value == 3 ? 'Done' : 'Next',
                      style: TextStyle(
                        fontSize: 17.sp,
                        color: const Color(0xff5285E8),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ).onTap(() {
                    controller.validation(context);
                  }),
                ],
              ),
            ],
          ).pSymmetric(h: 15, v: 20),
        ),
      );
    });
  }
}

class EnterYourName extends StatelessWidget {
  final InformationPageController controller;

  const EnterYourName({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          return Text(
            'Step ${controller.j.value} of 3',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
              color: white,
            ),
          );
        }),
        Text(
          'Enter your name',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: white,
          ),
        ),
        SizedBox(height: 15.h),
        Container(
          height: 65.w,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: white),
          child: Stack(
            children: [
              Text(
                'Name',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: black.withOpacity(0.20),
                ),
              ).pOnly(left: 15, top: 9, bottom: 5),
              TextField(
                cursorColor: blue,
                controller: controller.nameController.value,
                style: customTextStyle(
                  16.sp,
                  FontWeight.w700,
                  color: black,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ).pOnly(top: 10, left: 5),
            ],
          ),
        ),
      ],
    );
  }
}

class AddYourBirthday extends StatelessWidget {
  final InformationPageController controller;

  const AddYourBirthday({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Step ${controller.j.value} of 3',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
              color: white,
            ),
          ),
          Text(
            'Add Your Birthday',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: white,
            ),
          ),
          SizedBox(height: 15.h),
          Row(
            children: [
              Container(
                height: 65.w,
                width: 80.w,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: white),
                child: Stack(
                  children: [
                    Text(
                      'DD',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: black.withOpacity(0.20),
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
                          color: black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.w),
              Container(
                height: 65.w,
                width: 80.w,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: white),
                child: Stack(
                  children: [
                    Text(
                      'MM',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: black.withOpacity(0.20),
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
                          color: black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Container(
                  height: 65.w,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: white),
                  child: Stack(
                    children: [
                      Text(
                        'YYYY',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: black.withOpacity(0.20),
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
                            color: black,
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
        ],
      );
    });
  }
}

class ChooseYourGender extends StatelessWidget {
  final InformationPageController controller;

  const ChooseYourGender({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Step ${controller.j.value} of 3',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
              color: white,
            ),
          ),
          Text(
            'Choose Your Gender',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: white,
            ),
          ),
          SizedBox(height: 15.h),
          Container(
            height: 60.w,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Male',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: black,
                  ),
                ),
                Visibility(
                  visible: controller.gender.value == 1,
                  child: Image.asset(
                    I.doneCircleIcon,
                    height: 35.w,
                  ),
                )
              ],
            ).pOnly(left: 15, right: 15),
          ).onTap(() {
            controller.gender.value = 1;
          }),
          SizedBox(height: 30.h),
          Container(
            height: 60.w,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Female',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: black,
                  ),
                ),
                Visibility(
                  visible: controller.gender.value == 2,
                  child: Image.asset(
                    I.doneCircleIcon,
                    height: 35.w,
                  ),
                )
              ],
            ).pOnly(left: 15, right: 15),
          ).onTap(() {
            controller.gender.value = 2;
          }),
        ],
      );
    });
  }
}
