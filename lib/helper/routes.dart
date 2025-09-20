import 'common_import.dart';

class Routes {
  static const String splash = '/splash';
  static const String onBoarding = '/onBoarding';
  static const String information = '/information';
  static const String receiveBirthDayNotificationPage = '/receiveBirthDayNotificationPage';
  static const String addExistingContacts = '/addExistingContacts';
  static const String bottomPage = '/bottomPage';
  static const String greetingPage = '/greetingPage';
  static const String addEventPage = '/addEventPage';
  static const String fromContactPage = '/fromContactPage';
  static const String myCardsPage = '/myCardsPage';
  static const String notificationPage = '/notificationPage';
  static const String reminderPage = '/reminderPage';
  static const String darkLightModePage = '/darkLightModePage';
  static const String editProfilePage = '/editProfilePage';
  static const String birthDayPage = '/birthDayPage';
  static const String editEventPage = '/editEventPage';
  static const String cardDetailsPage = '/cardDetailsPage';
  static const String editCardPage = '/editCardPage';
  static const String previewCardPage = '/previewCardPage';
  static const String saveMyCardPage = '/saveMyCardPage';
  static const String sendGreetingCardPage = '/sendGreetingCardPage';
  static const String myCardDetailPage = '/myCardDetailPage';
  static const String sendCardBottomSheetPage = '/sendCardBottomSheetPage';

  static List<GetPage> pages = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashPage(),
      binding: BindingsBuilder.put(
        () => SplashPageController(),
      ),
    ),
    GetPage(
      name: Routes.onBoarding,
      page: () => const OnBoardingPage(),
      binding: BindingsBuilder.put(
        () => OnBoardingPageController(),
      ),
    ),
    GetPage(
      name: Routes.information,
      page: () => const InformationPage(),
      binding: BindingsBuilder.put(
        () => InformationPageController(),
      ),
    ),
    GetPage(
      name: Routes.receiveBirthDayNotificationPage,
      page: () => const ReceiveBirthDayNotificationPage(),
      binding: BindingsBuilder.put(
        () => ReceiveBirthDayNotificationPageController(),
      ),
    ),
    GetPage(
      name: Routes.addExistingContacts,
      page: () => const AddExistingContactsPage(),
      binding: BindingsBuilder.put(
        () => AddExistingContactsPageController(),
      ),
    ),
    GetPage(
      name: Routes.bottomPage,
      page: () => const BottomPage(),
      binding: BindingsBuilder.put(
        () => BottomPageController(),
      ),
    ),
    GetPage(
      name: Routes.greetingPage,
      page: () => const GreetingPage(),
      binding: BindingsBuilder.put(
        () => GreetingsPageController(),
      ),
    ),
    GetPage(
      name: Routes.addEventPage,
      page: () => const AddEventPage(),
      binding: BindingsBuilder.put(
        () => AddEventPageController(),
      ),
    ),
    GetPage(
      name: Routes.fromContactPage,
      page: () => const FromContactsPage(),
      binding: BindingsBuilder.put(
        () => FromContactsPageController(),
      ),
    ),
    GetPage(
      name: Routes.myCardsPage,
      page: () => const MyCardsPage(),
      binding: BindingsBuilder.put(
        () => MyCardsPageController(),
      ),
    ),
    GetPage(
      name: Routes.notificationPage,
      page: () => const NotificationPage(),
      binding: BindingsBuilder.put(
        () => NotificationPageController(),
      ),
    ),
    GetPage(
      name: Routes.reminderPage,
      page: () => const ReminderPage(),
      binding: BindingsBuilder.put(
        () => ReminderPageController(),
      ),
    ),
    GetPage(
      name: Routes.darkLightModePage,
      page: () => const DarkLightModePage(),
      binding: BindingsBuilder.put(
        () => DarkLightModePageController(),
      ),
    ),
    GetPage(
      name: Routes.editProfilePage,
      page: () => const EditProfilePage(),
      binding: BindingsBuilder.put(
        () => EditProfilePageController(),
      ),
    ),
    GetPage(
      name: Routes.birthDayPage,
      page: () => const BirthdayPage(),
      binding: BindingsBuilder.put(
        () => BirthdayPageController(),
      ),
    ),
    GetPage(
      name: Routes.editEventPage,
      page: () => const EditEventPage(),
      binding: BindingsBuilder.put(
        () => EditEventPageController(),
      ),
    ),
    GetPage(
      name: Routes.cardDetailsPage,
      page: () => const CardDetailsPage(),
      binding: BindingsBuilder.put(
        () => CardDetailsPageController(),
      ),
    ),
    GetPage(
      name: Routes.editCardPage,
      page: () => const EditCardPage(),
      binding: BindingsBuilder.put(
        () => EditCardPageController(),
      ),
    ),
    GetPage(
      name: Routes.previewCardPage,
      page: () => const PreviewCardPage(),
      binding: BindingsBuilder.put(
        () => PreviewCardPageController(),
      ),
    ),
    GetPage(
      name: Routes.saveMyCardPage,
      page: () => const SaveMyCardPage(),
      binding: BindingsBuilder.put(
        () => SaveMyCardPageController(),
      ),
    ),
    GetPage(
      name: Routes.sendGreetingCardPage,
      page: () => const SendGreetingCardPage(),
      binding: BindingsBuilder.put(
        () => SendGreetingCardPageController(),
      ),
    ),
    GetPage(
      name: Routes.myCardDetailPage,
      page: () => const MyCardDetailPage(),
      binding: BindingsBuilder.put(
        () => MyCardDetailPageController(),
      ),
    ),
    GetPage(
      name: Routes.sendCardBottomSheetPage,
      page: () => const SendCardBottomSheetPage(),
      binding: BindingsBuilder.put(
        () => SendCardBottomSheetPageController(),
      ),
    ),
  ];
}
