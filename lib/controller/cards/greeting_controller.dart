import 'package:birthday_reminder/helper/common_import.dart';

class GreetingsPageController extends GetxController {
  RxInt id = 100.obs;
  @override
  void onInit() {
    id.value = Get.arguments;
    super.onInit();
  }

  RxInt greetingCardIndex = 0.obs;

  RxList birthDayGreeting = [
    'Hope all your birthday wishes come true.',
    'You bring light and love into my life. Happy birthday!',
    'Forget the past; look forward to the future, for the best things are yet to come.',
    'Life is a journey. Enjoy every mile.',
    'Happy birthday! I hope this is the beginning of your greatest, most wonderful year ever!',
    'You have to get older, but you don’t have to grow up.',
    'Happy moments. Happy thoughts. Happy dreams. Happy feelings. Happy birthday.',
    'May life’s brightest joys illuminate your path, and may each day’s journey bring you closer to your dreams!',
    'I love celebrating with you. Thanks for having a birthday and giving us a reason.',
    'I’m truly touched by all of your kind words and simply saying thanks for birthday wishes doesn’t even begin to show my appreciation. You made my special day 100 times better!',
    'Happy Birthday! You get to celebrate not just one but two amazing occasions this season enjoy every moment of it!',
    'A wish for you on your birthday, whatever you ask may you receive, whatever you seek may you find, whatever you wish may it be fulfilled on your birthday and always. Happy birthday!',
    'Be happy! Today is the day you were brought into this world to be a blessing and inspiration to the people around you! You are a wonderful person! May you be given more birthdays to fulfill all of your dreams!',
    'If you’re waiting for your birthday gift, close your eyes and make a wish. Surprise, it’s me! Happy birthday!',
  ].obs;

  void setData(int index, int i) {
    if (i == 0) {
      var controllers = Get.put(EditCardPageController());
      controllers.greetingsController.value.text = '';
      controllers.greetingsController.value.text = greetingCardIndex.value == 0
          ? birthDayGreeting[index]
          : greetingCardIndex.value == 1
              ? anniversaryGreeting[index]
              : othersGreeting[index];
    } else if (i == 3) {
      var controllers = Get.put(EditEventPageController());
      controllers.greetingsController.value.text = '';
      controllers.greetingsController.value.text = greetingCardIndex.value == 0
          ? birthDayGreeting[index]
          : greetingCardIndex.value == 1
              ? anniversaryGreeting[index]
              : othersGreeting[index];
    } else if (i == 4) {
      var controllers = Get.put(SendCardBottomSheetPageController());
      controllers.greetingsController.value.text = '';
      controllers.greetingsController.value.text = greetingCardIndex.value == 0
          ? birthDayGreeting[index]
          : greetingCardIndex.value == 1
              ? anniversaryGreeting[index]
              : othersGreeting[index];
    } else {
      var controllers = Get.put(AddEventPageController());
      controllers.greetingsController.value.text = '';
      controllers.greetingsController.value.text = greetingCardIndex.value == 0
          ? birthDayGreeting[index]
          : greetingCardIndex.value == 1
              ? anniversaryGreeting[index]
              : othersGreeting[index];
    }
    Get.back();
  }

  RxList anniversaryGreeting = [
    'Happy Anniversary! It\'s such a blessing to have you in my life!',
    'The sound of the sea and the echo of your love share a few characteristics in common: they are both constant and eternal. Happy Anniversary!',
    'Happy Anniversary! May God continue to bless you and keep you happy.',
    'Everything was like a dark sky until you, my brightest star, came through. We\'ve had our ups and downs, but my heart always knew we\'d make it this far. Happy Anniversary!',
    'Happy Anniversary! You two are an inspiration.',
    'Happy Anniversary! Your love is always a breath of fresh air.',
    'High-five to your five-year milestone.',
    'One decade down; forever to go.',
    'For your 25th year in marriage, may you receive more silver gifts than you have silver in your hair.',
    'Fifty years later and all that glitters is still gold.',
  ].obs;
  RxList othersGreeting = [].obs;

  void addGreetings(int index) {
    var controller = Get.put(BirthdayPageController());
    if (greetingCardIndex.value == 0) {
      controller.addedGreetingsList.add(birthDayGreeting[index]);
    } else {
      controller.addedGreetingsList.add(anniversaryGreeting[index]);
    }
    Get.back();
  }
}
