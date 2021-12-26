import 'package:db_hotel/widgets/styles/my_styles.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key, required this.database}) : super(key: key);

  final database;

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
                Container(
                  width: 300,
                  height: 100,
                  decoration: MyStyles.roundedBox,
                  child: const Center(
                    child: Text("User"),
                  ),
                ),
                Container(
                  width: 300,
                  height: 100,
                  decoration: MyStyles.roundedBox,
                  child: const Center(
                    child: Text("Staff"),
                  ),
                ),
                Container(
                  width: 300,
                  height: 100,
                  decoration: MyStyles.roundedBox,
                  child: const Center(
                    child: Text("Admin"),
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
