import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class UiUtils {
  static ui.Paragraph getParagraph(String text, double textSize,
      {Color color = Colors.black, double itemWidth = 100}) {
    var pb = ui.ParagraphBuilder(ui.ParagraphStyle(
      textAlign: TextAlign.center,
      fontSize: textSize,
    )
    );
    pb.addText(text);
    pb.pushStyle(ui.TextStyle(color: color));
    var paragraph = pb.build()
      ..layout(ui.ParagraphConstraints(width: itemWidth));
    return paragraph;
  }
}
