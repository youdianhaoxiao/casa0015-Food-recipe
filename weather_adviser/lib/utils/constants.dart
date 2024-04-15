import 'package:flutter/material.dart';

const primaryColor = Color(0xff2c2c2c);
const blackColor = Colors.black;
const whiteColor = Colors.white;
const greyColor = Color(0xffc4c4c4);
const bgGreyColor = Color(0xfffdfcfc);
const darkGreyColor = Color(0xff9a9a9a);

// custom Text Widget
Widget appText(
    {FontWeight isBold = FontWeight.normal,
    Color color = blackColor,
    required double size,
    required String text,
    int maxLines = 0,
    bool overflow = false,
    bool alignCenter = false}) {
  return Text(
    text,
    textAlign: alignCenter == true ? TextAlign.center : null,
    maxLines: maxLines == 0 ? null : maxLines,
    overflow: overflow == true ? TextOverflow.ellipsis : null,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: isBold,
    ),
  );
}

// for displaying snackbars
showSnackBar(BuildContext context, String text, {Color color = primaryColor}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      elevation: 3,
      content: Text(text, textAlign: TextAlign.center),
    ),
  );
}

// Custom ListTile for MainScreen
Widget customListTile({
  required String first,
  required String second,
  required IconData icon,
  required Color iconColor,
  String text = '',
}) {
  return ListTile(
    trailing: appText(size: 16, text: text, color: darkGreyColor),
    leading: Icon(icon, color: iconColor),
    title: RichText(
      maxLines: 1,
      text: TextSpan(
        children: [
          TextSpan(
            text: first,
            style: const TextStyle(
              color: darkGreyColor,
              fontSize: 16,
            ),
          ),
          TextSpan(
            text: second,
            style: const TextStyle(
              color: primaryColor,
              fontSize: 16,
            ),
          ),
        ],
      ),
    ),
  );
}

void showToast(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(child: Text(message)),
      duration: const Duration(milliseconds: 2000),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.only(bottom: 30, left: 30, right: 30),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.black54,
      shape: const StadiumBorder(
        side: BorderSide(width: 5, color: Colors.transparent),
      ),
    ),
  );
}

class MyWidget extends StatelessWidget {
  const MyWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.blue),
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 24.0,
            color: Colors.white,
            decoration: TextDecoration.none),
      ),
    );
  }
}

class MyText extends Text {
  const MyText(String data, {Key? key})
      : super(
          data,
          key: key,
          style: const TextStyle(
              fontSize: 24.0,
              color: Colors.white,
              decoration: TextDecoration.none),
        );
}

class MyTextSmall extends Text {
  const MyTextSmall(String data, {Key? key})
      : super(
          data,
          key: key,
          style: const TextStyle(
              fontSize: 14.0,
              color: Colors.white,
              decoration: TextDecoration.none),
        );
}

class MyButton extends TextButton {
  MyButton({
    Key? key,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    ValueChanged<bool>? onFocusChange,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool autofocus = false,
    Clip clipBehavior = Clip.none,
    required Widget child,
  }) : super(
          key: key,
          onPressed: onPressed,
          onLongPress: onLongPress,
          onHover: onHover,
          onFocusChange: onFocusChange,
          style: style ??
              TextButton.styleFrom(
                padding: const EdgeInsets.all(5.0),
                // primary: Colors.white,
                backgroundColor: Colors.blue,
                textStyle: const TextStyle(fontSize: 16),
              ),
          focusNode: focusNode,
          autofocus: autofocus,
          clipBehavior: clipBehavior,
          child: child,
        );
}

// API
// http://api.weatherapi.com/v1/forecast.json?key=66eb35a4c0134ef3a23153944222403&q=Vladivostok&days=1&aqi=no&alerts=no
// 8ff95441e89a44f4b4e184906232004
class Constants {
  static const String WEATHER_APP_ID = 'eb837ffa480948fd8dc171158241004';
  static const String WEATHER_BASE_SCHEME = 'https://';
  static const String WEATHER_BASE_URL_DOMAIN = 'api.weatherapi.com/v1';
  static const String WEATHER_FORECAST_PATH = '/forecast.json';
}
