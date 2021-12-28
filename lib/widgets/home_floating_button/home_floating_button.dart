import 'package:db_hotel/screens/home_screen/user_home_screen/user_home_screen.dart';
import 'package:flutter/material.dart';

class HomeFloatingButton extends FloatingActionButton {
  HomeFloatingButton({Key? key, context, database})
      : super(
            key: key,
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserHomeScreen(database: database)),
                  (route) => false);
            },
            child: const Icon(Icons.home_filled));
}
