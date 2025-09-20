import 'dart:io';
import 'package:birthday_reminder/helper/common_import.dart';

BannerAd? bannerAd;
InterstitialAd? interstitialAd;
bool isLoaded = false;
int maxFailedLoadAttempts = 3;
int numInterstitialAdLoadAttempt = 0;

String bannerAndroid = 'ca-app-pub-3940256099942544/6300978111';
String bannerIOS = 'ca-app-pub-3940256099942544/2934735716';
String interstitialAndroid = 'ca-app-pub-3940256099942544/1033173712';
String interstitialIOS = 'ca-app-pub-3940256099942544/4411468910';

Widget showBannerAds() {
  final appID = Platform.isAndroid ? bannerAndroid : bannerIOS;
  final googleBannerAd = BannerAd(
    adUnitId: appID,
    size: AdSize.banner,
    listener: BannerAdListener(
      onAdFailedToLoad: (ad, err) {
        debugPrint('Hello onAdFailedToLoad ::::: $err');
        ad.dispose();
      },
    ),
    request: AdRequest(),
  )..load();
  return Container(
    alignment: Alignment.center,
    width: googleBannerAd.size.width.toDouble(),
    height: googleBannerAd.size.height.toDouble(),
    child: AdWidget(ad: googleBannerAd),
  );
}

const AdRequest request = AdRequest(
  keywords: ['foo', 'bar'],
  contentUrl: 'http://foo.com/bar.html',
  nonPersonalizedAds: true,
);

InterstitialAd? createInterstitialAd() {
  final appId = Platform.isAndroid ? interstitialAndroid : interstitialIOS;
  try {
    InterstitialAd.load(
        adUnitId: appId,
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            interstitialAd = ad;
            maxFailedLoadAttempts = 0;
            interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            numInterstitialAdLoadAttempt += 1;
            if (numInterstitialAdLoadAttempt < maxFailedLoadAttempts) {
              createInterstitialAd();
            }
          },
        ));
  } catch (e) {}
  return null;
}

Future<void> showInterstitialAd() async {
  if (interstitialAd == null) {
    debugPrint('------ Hello interstitialAd Null ------');
    return;
  }
  interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) {},
      onAdDismissedFullScreenContent: (InterstitialAd ad) async {
        ad.dispose();
        createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) async {
        ad.dispose();
        createInterstitialAd();
      },
      onAdWillDismissFullScreenContent: (InterstitialAd ad) async {
        ad.dispose();
        createInterstitialAd();
      });
  interstitialAd!.show();
  interstitialAd = null;
}
