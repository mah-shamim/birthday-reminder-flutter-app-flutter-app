import 'package:birthday_reminder/helper/common_import.dart';

class MyCardsPageController extends GetxController {
  @override
  void onInit() {
    fetchMyCards();
    super.onInit();
  }

  RxList<MyCardModel> myCardsList = <MyCardModel>[].obs;

  Future<void> fetchMyCards() async {
    myCardsList.clear();
    List<MyCardModel> data = await DatabaseHelper().getMyCard();
    myCardsList.addAll(data);
    for (var element in myCardsList) {
      debugPrint("Greetings ====> ${element.greetings}");
      debugPrint("Greetings ====> ${element.fontString}");
      debugPrint("Index ====> ${element.uid}");
    }
    debugPrint('------------------------ length :- ${myCardsList.length} ---------------------');
  }
}
