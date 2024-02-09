import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

height(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

width(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

var appPinkColor = HexColor("ff7878");

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

InputDecoration inputDecoration(BuildContext context,
    {Widget? prefixIcon,
    String? labelText,
    double? borderRadius,
    String? hint}) {
  return InputDecoration(
    counterText: "",
    hintText: hint ?? "",
    hintStyle: GoogleFonts.itim(fontSize: 17, color: Colors.grey),
    contentPadding: EdgeInsets.only(left: 12, bottom: 10, top: 10, right: 10),
    labelText: labelText,
    labelStyle: secondaryTextStyle(),
    alignLabelWithHint: true,
    prefixIcon: prefixIcon,
    enabledBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: Colors.transparent, width: 0.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: Colors.red, width: 0.0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: Colors.red, width: 1.0),
    ),
    errorMaxLines: 2,
    errorStyle: primaryTextStyle(color: Colors.red, size: 12),
    focusedBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: appPinkColor, width: 0.0),
    ),
    filled: true,
    fillColor: context.cardColor,
  );
}

List<String> romanticQuotes = [
  "Every moment with you feels like a love story in the making.",
  "Your smile is the highlight of my day, especially on Valentine's.",
  "With you, every day feels like Valentine's Day.",
  "You're the reason my heart beats a little faster.",
  "In a world full of chaos, you're my calm.",
  "With you by my side, every day is filled with love and laughter.",
  "You're not just my Valentine; you're my forever.",
  "I never knew I could feel this much until I met you.",
  "My love for you grows stronger with each passing day.",
  "With you, I've found my happily ever after.",
  "You're the missing piece I never knew I needed.",
  "Your love is the greatest gift I've ever received.",
  "In your arms is where I belong, especially on Valentine's.",
  "I'm grateful every day for the love we share.",
  "You're the light that guides me through the darkest nights.",
  "With you, I've discovered what true love means.",
  "Your love is like a treasure I cherish every day.",
  "You're the melody that plays in my heart.",
  "With you, I've found my soulmate, my partner, my love.",
  "You're the love story I've always dreamed of writing."
];
