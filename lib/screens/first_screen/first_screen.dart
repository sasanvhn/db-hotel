import 'package:db_hotel/db/database.dart';
import 'package:db_hotel/screens/auth_screens/staff_auth_screen/staff_auth_screen.dart';
import 'package:db_hotel/screens/auth_screens/user_auth_screen/user_auth_screen.dart';
import 'package:db_hotel/widgets/styles/my_styles.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key, required this.database}) : super(key: key);
  final AppDatabase database;

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: const Text("Hotel DB Project"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Choose an actor",
              style: MyStyles.bigBoldText36,
            ),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserAuthScreen(
                                database: widget.database,
                              ))),
                  child: Container(
                    width: 300,
                    height: 100,
                    decoration: MyStyles.roundedBox,
                    child: Center(
                      child: Text(
                        "User",
                        style: MyStyles.normalText20,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StaffAuthScreen(
                                database: widget.database,
                              ))),
                  child: Container(
                    width: 300,
                    height: 100,
                    decoration: MyStyles.roundedBox,
                    child: Center(
                      child: Text(
                        "Staff",
                        style: MyStyles.normalText20,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 300,
                  height: 100,
                  decoration: MyStyles.roundedBox,
                  child: Center(
                    child: Text(
                      "Admin",
                      style: MyStyles.normalText20,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
