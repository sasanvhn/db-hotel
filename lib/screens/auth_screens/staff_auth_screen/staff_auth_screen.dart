import 'dart:developer';
import 'package:db_hotel/db/database.dart';
import 'package:db_hotel/db/staff/staff_model.dart';
import 'package:db_hotel/screens/home_screen/staff_home_screen/staff_home_screen.dart';
import 'package:db_hotel/widgets/styles/my_styles.dart';
import 'package:flutter/material.dart';

import '../../../configs.dart';

class StaffAuthScreen extends StatelessWidget {
  StaffAuthScreen({Key? key, required this.database}) : super(key: key);

  final AppDatabase database;

  final TextEditingController loginNameController = TextEditingController();
  final TextEditingController loginPassController = TextEditingController();

  void _login(context) async {
    log("name: ${loginNameController.text} and pass: ${loginPassController.text}",
        name: "LOGIN");
    final staffDao = database.staffDao;
    final Staff? staff = await staffDao.getStaff(
        loginNameController.text, loginPassController.text);
    log("staff is found: ${staff != null}", name: "LOGIN");
    if (staff != null) {
      Configs.staff = staff;
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => StaffHomeScreen(database: database)),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Staff Auth Screen"),
        centerTitle: true,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              elevation: 20,
              child: SizedBox(
                height: 500,
                width: 400,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // width: 400,
                        height: 60,
                        color: Colors.blueAccent,
                        child: Center(
                          child: Text(
                            "Login",
                            style: MyStyles.normalText20,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "National Code",
                            style: MyStyles.normalText20,
                          ),
                          TextField(controller: loginNameController),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Password",
                            style: MyStyles.normalText20,
                          ),
                          TextField(controller: loginPassController),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: () {
                            if (loginNameController.text != "" &&
                                loginPassController.text != "") {
                              _login(context);
                            } else {
                              log("pass or name is empty", name: "LOGIN");
                            }
                          },
                          child: Container(
                            height: 60,
                            width: 80,
                            decoration: MyStyles.roundedBox,
                            child: const Center(
                              child: Text("Log In"),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
