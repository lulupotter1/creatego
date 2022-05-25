import 'package:flutter/material.dart';

TextInputType? getKeyboardType(String? kTypeStr) {
  switch (kTypeStr) {
    case "number":
      return TextInputType.number;
    case "text":
      return TextInputType.text;
    case "email":
      return TextInputType.emailAddress;
  }
}

AlignmentGeometry? getAlignment(String? kAlignmentStr) {
  switch (kAlignmentStr) {
    case "center":
      return Alignment.center;
    case "centerRight":
      return Alignment.centerRight;
    case "centerLeft":
      return Alignment.centerLeft;
    case "bottomCenter":
      return Alignment.bottomCenter;
    case "bottomRight":
      return Alignment.bottomRight;
    case "bottomLeft":
      return Alignment.bottomLeft;
    case "topCenter":
      return Alignment.topCenter;
    case "topRight":
      return Alignment.topRight;
    case "topLeft":
      return Alignment.topLeft;
  }
}

TextAlign? getTextAlign(String? kAlignmentStr) {
  switch (kAlignmentStr) {
    case "center":
      return TextAlign.center;
    case "left":
      return TextAlign.left;
    case "right":
      return TextAlign.right;
  }
}
