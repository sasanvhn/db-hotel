import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({Key? key, required this.titlee})
      : super(key: key, title: Text(titlee), centerTitle: true);

  final String titlee;
}
