import 'dart:developer';
import 'package:db_hotel/db/guest/guest_model.dart';
import 'package:db_hotel/screens/first_screen/first_screen.dart';
import 'package:db_hotel/screens/home_screen/user_home_screen/user_home_screen.dart';
import 'package:db_hotel/widgets/custom_appbar/custom_appbar.dart';
import 'package:db_hotel/widgets/styles/my_styles.dart';
import 'package:flutter/material.dart';

import '../../../configs.dart';

class UserAuthScreen extends StatelessWidget {
  UserAuthScreen({Key? key, required this.database}) : super(key: key);

  final database;

  final TextEditingController loginNameController = TextEditingController();
  final TextEditingController loginPassController = TextEditingController();
  final TextEditingController signupNameController = TextEditingController();
  final TextEditingController signupPassController = TextEditingController();
  final TextEditingController signupIDController = TextEditingController();
  final TextEditingController signupGenderController = TextEditingController();
  final TextEditingController signupAddressController = TextEditingController();
  final TextEditingController signupBirthDateController =
      TextEditingController();
  final TextEditingController signupPhoneController = TextEditingController();

  void _login(context) async {
    log("name: ${loginNameController.text} and pass: ${loginPassController.text}",
        name: "LOGIN");
    final guestDao = database.guestDao;
    final Guest? guest = await guestDao.getGuest(
        loginNameController.text, loginPassController.text);
    log("guest is found: ${guest != null}", name: "LOGIN");
    if (guest != null) {
      Configs.guest = guest;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UserHomeScreen(database: database)));
    }
  }

  void _signup(context) async {
    log(
        "name: ${signupNameController.text} and pass: ${signupPassController.text} and "
        "nationalID: ${signupIDController.text} and address ${signupAddressController.text}"
        " and gender: ${signupGenderController.text} and phone: ${signupPhoneController.text}"
        " and birth: ${signupBirthDateController.text}",
        name: "SIGNUP");
    final guestDao = database.guestDao;
    final Guest? guest =
        await guestDao.getGuestByNationalID(loginNameController.text);
    log("guest is found: ${guest != null}", name: "SIGNUP");
    if (guest == null) {
      final tempGuest = Guest(
          name: signupNameController.text,
          nationalId: signupIDController.text,
          password: signupPassController.text,
          phoneNumber: signupPhoneController.text,
          address: signupAddressController.text,
          gender: signupGenderController.text,
          birthDate: signupBirthDateController.text);
      await guestDao.insertGuest(tempGuest);
      final Guest? guest2 = await guestDao.getGuest(
          signupIDController.text, signupPassController.text);
      log("guest is created: ${guest2 != null}", name: "SIGNUP");

      if (guest != null) {
        Configs.guest = guest2;

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UserHomeScreen(database: database)));
      }
    }
    if (guest != null) {
      log("Guest Already Exists", name: "SIGNUP");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titlee: "User Auth Screen",
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
            Card(
              elevation: 20,
              child: SizedBox(
                height: 600,
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
                            "Sign Up",
                            style: MyStyles.normalText20,
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          physics: AlwaysScrollableScrollPhysics(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "National Code",
                                    style: MyStyles.normalText20,
                                  ),
                                  TextField(controller: signupIDController),
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
                                  TextField(controller: signupPassController),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name",
                                    style: MyStyles.normalText20,
                                  ),
                                  TextField(controller: signupNameController),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Address",
                                    style: MyStyles.normalText20,
                                  ),
                                  TextField(
                                      controller: signupAddressController),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Birth Date",
                                    style: MyStyles.normalText20,
                                  ),
                                  TextField(
                                      controller: signupBirthDateController),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Gender",
                                    style: MyStyles.normalText20,
                                  ),
                                  TextField(controller: signupGenderController),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Phone",
                                    style: MyStyles.normalText20,
                                  ),
                                  TextField(controller: signupPhoneController),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: () {
                            if (signupNameController.text != "" &&
                                signupIDController.text != "" &&
                                signupPassController.text != "" &&
                                signupPhoneController.text != "") {
                              _signup(context);
                            } else {
                              log("pass or name or phone or id is empty",
                                  name: "SIGNUP");
                            }
                          },
                          child: Container(
                            height: 60,
                            width: 80,
                            decoration: MyStyles.roundedBox,
                            child: const Center(
                              child: Text("Sign Up"),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
