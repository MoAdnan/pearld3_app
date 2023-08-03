import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension StringUtils<T> on String {
  String toTitleCase() {
    String title = this;

    title = title.replaceFirst(title[0], title[0].toUpperCase());
    return title;
  }
}

extension DoubleEntension<T> on double {
  double roundToFixedDigits(int digit) {
    String inString = toStringAsFixed(digit); // '2.35'
    double inDouble = double.parse(inString);
    return inDouble;
  }
}

extension BuildContextEntension<T> on BuildContext {
  String get logo => 'assets/images/app_logo_splash.png';
  String getLogo() {
    return 'assets/images/app_logo_splash.png';
  }

  SwitchThemeData get switchThemeData {
    return SwitchThemeData(
      thumbColor: MaterialStateProperty.all(colorGrey),
      trackColor: MaterialStateProperty.all(Colors.white),
      trackOutlineColor: MaterialStateProperty.all(Colors.grey),
    );
  }

  CheckboxThemeData get checkboxThemeData {
    return CheckboxThemeData(
      checkColor: MaterialStateProperty.all(Colors.white),
      fillColor: MaterialStateProperty.all(primaryColor),
    );
  }

  TextSelectionThemeData get textSelectionThemeData {
    return TextSelectionThemeData(
        cursorColor: primaryColor,
        selectionColor: Colors.grey,
        selectionHandleColor: primaryColor);
  }

  TextButtonThemeData get textButtonThemeData {
    return TextButtonThemeData(
        style: ButtonStyle(
      textStyle: MaterialStateProperty.all(const TextStyle(color: Colors.blue)),
    ));
  }

  bool get isMobile => MediaQuery.of(this).size.width <= 500.0;

  bool get isTablet =>
      MediaQuery.of(this).size.width < 1024.0 &&
      MediaQuery.of(this).size.width >= 650.0;

  bool get isSmallTablet =>
      MediaQuery.of(this).size.width < 650.0 &&
      MediaQuery.of(this).size.width > 500.0;

  bool get isDesktop => MediaQuery.of(this).size.width >= 1024.0;

  bool get isSmall =>
      MediaQuery.of(this).size.width < 850.0 &&
      MediaQuery.of(this).size.width >= 560.0;

  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

  Size get size => MediaQuery.of(this).size;

  // text styles
  TextStyle get buttonTextStyle => const TextStyle(color: Colors.blue);

  TextStyle? get displayMedium => Theme.of(this).textTheme.displayMedium;

  TextStyle? get displaySmall => Theme.of(this).textTheme.displaySmall;
  TextStyle? get displaySmall2 => Theme.of(this)
      .textTheme
      .displaySmall!
      .copyWith(fontSize: 20, fontWeight: FontWeight.w600);
  TextStyle? get displaySmall3 => Theme.of(this)
      .textTheme
      .displaySmall!
      .copyWith(fontSize: 17, fontWeight: FontWeight.w600);

  TextStyle? get headlineLarge => Theme.of(this).textTheme.headlineLarge;

  TextStyle? get headlineMedium => Theme.of(this).textTheme.headlineMedium;

  TextStyle? get titleLarge => Theme.of(this).textTheme.titleLarge;

  TextStyle? get titleMedium => Theme.of(this).textTheme.titleMedium;
  TextStyle? get titleSmallRed =>
      Theme.of(this).textTheme.titleSmall!.copyWith(color: Colors.red);

  TextStyle? get titleSmall => Theme.of(this).textTheme.titleSmall;
  TextStyle? get hintSmall =>
      const TextStyle(color: Colors.black54, fontSize: 13);
  TextStyle? get highlightSmall =>
      const TextStyle(color: Colors.blue, fontSize: 13);

  TextStyle? get labelLarge => Theme.of(this).textTheme.labelLarge;

  TextStyle? get bodySmall => Theme.of(this).textTheme.bodySmall;

  TextStyle? get titleTextStyle => Theme.of(this).appBarTheme.titleTextStyle;

  TextStyle? get bodyExtraSmall =>
      bodySmall?.copyWith(fontSize: 10, height: 1.6, letterSpacing: .5);

  TextStyle? get bodyLarge => Theme.of(this).textTheme.bodyLarge;

  TextStyle? get dividerTextSmall => bodySmall?.copyWith(
      letterSpacing: 0.5, fontWeight: FontWeight.w700, fontSize: 12.0);

  TextStyle? get dividerTextLarge => bodySmall?.copyWith(
      letterSpacing: 1.5,
      fontWeight: FontWeight.w700,
      fontSize: 13.0,
      height: 1.23);
//images

  // colors
  Color get primaryColor => const Color(0xff071d40);
  Color get colorGrey => Colors.grey;
  Color get colorOrange => Colors.orange;
  Color get colorGreen => Color(0xFF1C4244);
  Color get colorWhite => Colors.white;
  Color get colorBlack => Colors.black;
  Color get colorRed => Colors.red;

  MaterialColor get inactiveSwitchColor => Colors.grey;
  MaterialColor get materialWhite => const MaterialColor(
        0xFFFFFFFF,
        <int, Color>{
          50: Color(0xFFFFFFFF),
          100: Color(0xFFFFFFFF),
          200: Color(0xFFFFFFFF),
          300: Color(0xFFFFFFFF),
          400: Color(0xFFFFFFFF),
          500: Color(0xFFFFFFFF),
          600: Color(0xFFFFFFFF),
          700: Color(0xFFFFFFFF),
          800: Color(0xFFFFFFFF),
          900: Color(0xFFFFFFFF),
        },
      );

  Color get primaryColorDark => Theme.of(this).primaryColorDark;

  Color get primaryColorLight => Theme.of(this).primaryColorLight;

  Color get primary => Theme.of(this).colorScheme.primary;

  Color get onPrimary => Theme.of(this).colorScheme.onPrimary;

  Color get secondary => Theme.of(this).colorScheme.secondary;

  Color get onSecondary => Theme.of(this).colorScheme.onSecondary;

  Color get cardColor => Theme.of(this).cardColor;

  Color get errorColor => Theme.of(this).colorScheme.error;

  Color get background => Theme.of(this).colorScheme.background;

  //
  Future<T?> showBottomSheet(
    Widget child, {
    bool isScrollControlled = true,
    Color? backgroundColor,
    Color? barrierColor,
  }) {
    return showModalBottomSheet(
      useSafeArea: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      context: this,
      barrierColor: barrierColor,
      isScrollControlled: isScrollControlled,
      backgroundColor: backgroundColor,
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          child: child,
        ),
      ),
    );
  }

  void showAlert(
      {required String title,
      required String confirmText,
      required String cancelText,
      required VoidCallback? onConfirm,
      required VoidCallback? onCancel,
      required  TextStyle? titleStyle,
      required  TextStyle? buttonTextStyle,
      Widget? content}) {
    showDialog(
      barrierDismissible: false,
      context: this,
      builder: (context) {
        return AlertDialog(

          titlePadding: const EdgeInsets.all(15),
          contentPadding: const EdgeInsets.all(10),
          backgroundColor: Colors.white,
          title: Text(
            title,
          style: titleStyle
          ),
          content: content,
          actions: [
            SizedBox(
              height: 31,
              child: OutlinedButton(
                onPressed: onCancel,
                child: Text(
                  cancelText,
              style: buttonTextStyle,
                ),
              ),
            ),
            SizedBox(
              height: 31,
              child: OutlinedButton(
                onPressed: onConfirm,
                child: Text(confirmText,
               style: buttonTextStyle
       ),
              ),
            )
          ],
        );
      },
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showErrorSnackBar(
      String message) {
    return ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
          duration: const Duration(milliseconds: 1000),
        backgroundColor: const Color(0xffff5158),
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              CupertinoIcons.clear_circled,
              color: Colors.white,
              size: 30,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              message,
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showWarningSnackBar(
      String message) {
    return ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 1000),
        backgroundColor: Colors.red,
        //Color(0xffeb8600),
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              CupertinoIcons.info,
              color: Colors.white,
              size: 30,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              message,
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSuccessSnackBar(
      String message) {
    return ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
          duration: const Duration(milliseconds: 1000),
        backgroundColor: const Color(0xff40b368),
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              CupertinoIcons.check_mark_circled,
              color: Colors.white,
              size: 30,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              message,
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void exitApp() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  void dismissKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}
