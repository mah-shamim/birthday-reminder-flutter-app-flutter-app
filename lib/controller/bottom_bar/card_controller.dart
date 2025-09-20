import 'package:birthday_reminder/helper/common_import.dart';

class CardPageController extends GetxController {
  PageController pageController = PageController(initialPage: 0);
  RxList cardList = [
    I.card1,
    I.card2,
    I.card3,
    I.card4,
    I.card5,
    I.card6,
    I.card7,
    I.card8,
    I.card9,
    I.card10,
    I.card11,
    I.card12,
    I.card13,
    I.card14,
    I.card15,
    I.card16,
  ].obs;
  RxInt index = 0.obs;
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
  ].obs;

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
  RxList othersGreeting = [
    'Good evening, esteemed guests. It is an honor to welcome you all to this special occasion.',
    'Hey everyone, thanks for coming! Let\'s have a great time.',
    'Welcome, dear friends and family. We\'re so happy you could join us to celebrate our love.',
    'Hey everyone, great to see you all! Let\'s have a fun time and make some memories.',
    'Let\'s make some unforgettable memories together!',
    'A warm welcome to all our distinguished guests.',
    'Thank you for taking the time to be here with us.',
    'We hope you enjoy this evening and feel at home.',
    'Thank you for your presence and support.',
    'Thank you all for joining us this evening. We\'re honored by your presence.',
    'Great to see you all. Let\'s have a fantastic time together.',
  ].obs;

  @override
  void onClose() {
    index.value = 0;
    super.onClose();
  }
}
