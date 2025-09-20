import 'ads/admob_ads.dart';
import 'firebase_options.dart';
import 'helper/common_import.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  MobileAds.instance.initialize();
  showBannerAds();
  createInterstitialAd();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));

  await initializeNotifications();
  await Settings.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: isTab(context) ? const Size(585, 812) : const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData.light(
            useMaterial3: false,
          ).copyWith(
            scaffoldBackgroundColor: white,
            colorScheme: ColorScheme.light(
              primary: white,
              onPrimary: black,
              secondary: black,
              onSecondary: black,
              primaryContainer: Colors.white,
              onPrimaryContainer: Colors.white,
              errorContainer: Colors.white,
              error: const Color(0xffFF3B30),
              secondaryContainer: const Color(0xff3C3C43).withOpacity(0.25),
            ),
            textTheme: ThemeData.light().textTheme.apply(
                  fontFamily: 'SF',
                ),
            dialogTheme: const DialogTheme(backgroundColor: white),
          ),
          darkTheme: ThemeData.dark(
            useMaterial3: false,
          ).copyWith(
            scaffoldBackgroundColor: black,
            dialogTheme: const DialogTheme(backgroundColor: Color(0xff1E1E1E)),
            colorScheme: ColorScheme.dark(
              primary: black,
              onPrimary: white,
              secondary: blue,
              onSecondary: white,
              primaryContainer: black,
              onPrimaryContainer: white,
              errorContainer: const Color(0xffFF3B30),
              error: Colors.white,
              secondaryContainer: const Color(0xff545458).withOpacity(0.65),
            ),
            textTheme: ThemeData.dark().textTheme.apply(
                  fontFamily: 'SF',
                ),
          ),
          themeMode: Settings.mode == 'Light'
              ? ThemeMode.light
              : Settings.mode == 'Dark'
                  ? ThemeMode.dark
                  : ThemeMode.system,

          // translations: Languages(),
          // locale: Settings.selectedLanguageCode.isNotEmpty && Settings.selectedLanguageCountryCode.isNotEmpty
          //     ? Locale(Settings.selectedLanguageCode, Settings.selectedLanguageCountryCode)
          //     : const Locale('en', 'US'),
          // fallbackLocale: Settings.selectedLanguageCode.isNotEmpty && Settings.selectedLanguageCountryCode.isNotEmpty
          //     ? Locale(Settings.selectedLanguageCode, Settings.selectedLanguageCountryCode)
          //     : const Locale('en', 'US'),
          initialRoute: Routes.splash,
          getPages: Routes.pages,
        );
      },
    );
  }
}
