import 'package:db_hotel/screens/first_screen/first_screen.dart';
import 'package:db_hotel/widgets/styles/my_styles.dart';
import 'package:flutter/material.dart';

import '../../configs.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({Key? key, required this.titlee})
      : super(
          key: key,
          title: Text(titlee),
          centerTitle: true,
          actions: [
            Row(
              children: [
                Text(
                  Configs.guest!.name,
                  style: MyStyles.normalText20,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  Icons.account_circle,
                  size: 40,
                ),
                const SizedBox(
                  width: 40,
                ),
                // InkWell(
                //   child: Text(
                //     "Log Out",
                //     style: MyStyles.normalText20,
                //   ),
                //   onTap: () {
                //     Configs.guest = null;
                //     Navigator.pushAndRemoveUntil(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) =>
                //                 FirstScreen(database: database)),
                //         (route) => false);
                //   },
                // )
              ],
            )
          ],
        );

  final String titlee;
}
