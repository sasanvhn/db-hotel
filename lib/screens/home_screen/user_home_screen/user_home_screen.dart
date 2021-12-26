import 'package:db_hotel/db/database.dart';
import 'package:db_hotel/widgets/styles/my_styles.dart';
import 'package:flutter/material.dart';

import '../../../configs.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({Key? key, required this.database}) : super(key: key);

  final AppDatabase database;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Guest Home Screen"),
        centerTitle: true,
        actions: [
          Row(
            children: [
              Text(Configs.guest!.name),
              const SizedBox(
                width: 10,
              ),
              const Icon(Icons.account_circle)
            ],
          )
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Center(
          child: Wrap(
            spacing: 30,
            runSpacing: 30,
            children: [
              InkWell(
                // onTap: () => Navigator.push(
                //     context, MaterialPageRoute(builder: (context) => null)),
                child: Container(
                  width: 300,
                  height: 100,
                  decoration: MyStyles.roundedBox,
                  child: Center(
                    child: Text(
                      "Available Rooms",
                      style: MyStyles.normalText20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
