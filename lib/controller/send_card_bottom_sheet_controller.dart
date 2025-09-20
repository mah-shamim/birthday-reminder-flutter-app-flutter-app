import 'package:birthday_reminder/helper/common_import.dart';

class SendCardBottomSheetPageController extends GetxController with GetSingleTickerProviderStateMixin {
  RxString image = ''.obs;
  RxString greetings = ''.obs;
  var greetingsController = TextEditingController().obs;
  late AnimationController animationController;
  RxBool isOpen = false.obs;

  @override
  void onInit() {
    initMethod();
    super.onInit();
  }

  void initMethod() {
    image.value = Get.arguments['image'];
    greetings.value = Get.arguments['greetings'];
    animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    greetingsController.value = TextEditingController(text: greetings.value);
    greetingsController.value.addListener(_updateText);
  }

  void toggleAnimation(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (animationController.isCompleted) {
      animationController.reverse();
      isOpen.value = false;
    } else {
      animationController.forward().then((value) {
        isOpen.value = true;
      });
    }
  }

  @override
  void dispose() {
    greetingsController.value.removeListener(_updateText);
    greetingsController.value.dispose();
    super.dispose();
  }

  void _updateText() {
    final text = greetingsController.value.text;
    if (text.isNotEmpty && (!text.startsWith('" ') || !text.endsWith('"'))) {
      final newText = '" ${text.replaceAll('"', '')}"';
      greetingsController.value.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length - 1),
      );
    }
  }

  @override
  void onClose() {
    greetingsController.value.removeListener(_updateText);
    greetingsController.value.dispose();
    animationController.dispose();
    super.onClose();
  }
}
