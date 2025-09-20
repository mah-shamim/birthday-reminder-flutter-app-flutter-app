import 'package:birthday_reminder/helper/common_import.dart';

class SplashPage extends GetView<SplashPageController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(I.crackersGif),
                  ),
                ),
                child: Image.asset(
                  I.splashGif,
                  height: 260.w,
                )),
            Text(
              'Birthday Anniversary',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'Reminder',
              style: TextStyle(
                fontSize: 17.sp,
                letterSpacing: 6,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
