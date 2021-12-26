import 'dart:ui';
import 'package:flutter/material.dart';

const kBackgroundImage = BoxDecoration(
  image: DecorationImage(
    image: AssetImage("assets/images/background.jpg"),
    fit: BoxFit.fill,
  ),
);
ImageFilter kBlurFilter = ImageFilter.blur(sigmaY: 5, sigmaX: 5);
Color primaryColor = Color(0xffBD4567);
