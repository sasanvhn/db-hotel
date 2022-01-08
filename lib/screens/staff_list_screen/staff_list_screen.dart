import 'dart:developer';
import 'package:db_hotel/db/database.dart';
import 'package:db_hotel/db/room/room_model.dart';
import 'package:db_hotel/db/room_status/room_status_model.dart';
import 'package:db_hotel/db/room_type/room_type_model.dart';
import 'package:db_hotel/db/staff/staff_model.dart';
import 'package:db_hotel/screens/reserve_screen/reserve_screen.dart';
import 'package:db_hotel/widgets/custom_appbar/custom_appbar.dart';
import 'package:db_hotel/widgets/home_floating_button/home_floating_button.dart';
import 'package:flutter/material.dart';

import 'add_staff_screen.dart';

class StaffListScreen extends StatefulWidget {
  const StaffListScreen({Key? key, required this.database}) : super(key: key);

  final AppDatabase database;

  @override
  _StaffListScreenState createState() => _StaffListScreenState();
}

class _StaffListScreenState extends State<StaffListScreen> {
  String dropDownVal = "All";

  void callback() {
    setState(() {
      log("Screen Refreshed", name: "STAFF_LIST_SCREEN");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titlee: 'Staff List',
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Row(
                  children: const [
                    Text("Staff List"),
                    // SizedBox(
                    //   width: 10,
                    // ),
                    // SizedBox(
                    //   width: 30,
                    //   child: TextField(),
                    // ),
                    // SizedBox(
                    //   width: 10,
                    // ),
                    // Text("To"),
                    // SizedBox(
                    //   width: 10,
                    // ),
                    // SizedBox(
                    //   width: 30,
                    //   child: TextField(),
                    // ),
                  ],
                ),
              ),
              TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              content: AddStaffScreen(
                                  database: widget.database,
                                  callback: callback),
                              backgroundColor: Colors.transparent,
                              contentPadding: const EdgeInsets.all(0),
                            ));
                  },
                  child: const Icon(
                    Icons.add,
                    color: Colors.green,
                  )),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Row(
                  children: [
                    const Text("Filter"),
                    const SizedBox(
                      width: 10,
                    ),
                    DropdownButton<String>(
                      value: dropDownVal,
                      items: <String>["All", "Receptionist", "Maid"]
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (val) {
                        log("val is $val", name: "DROPDOWN");
                        setState(() {
                          val == null ? dropDownVal = "" : dropDownVal = val;
                        });
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
          FutureBuilder(
              future: _getStaff(),
              builder: (context, AsyncSnapshot<List<Staff>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return Expanded(
                    child: SingleChildScrollView(
                      child: DataTable(
                          columns: const [
                            DataColumn(
                                label: Center(child: Text("National ID"))),
                            DataColumn(label: Center(child: Text("Name"))),
                            DataColumn(
                                label: Center(child: Text("Start Date"))),
                            DataColumn(label: Center(child: Text("Salary"))),
                            DataColumn(label: Center(child: Text("Role"))),
                            DataColumn(label: Center(child: Text("Email"))),
                            DataColumn(label: Center(child: Text(" "))),
                          ],
                          rows: List.generate(
                              snapshot.data!.length,
                              (index) => DataRow(cells: [
                                    DataCell(Center(
                                      child: Text(snapshot
                                          .data![index].nationalId
                                          .toString()),
                                    )),
                                    DataCell(Center(
                                      child: Text(snapshot.data![index].name
                                          .toString()),
                                    )),
                                    DataCell(Center(
                                      child: Text(snapshot
                                          .data![index].startDate
                                          .toString()),
                                    )),
                                    DataCell(Center(
                                      child: Text(snapshot.data![index].salary
                                          .toString()),
                                    )),
                                    DataCell(Center(
                                      child: Text(snapshot.data![index].role
                                          .toString()),
                                    )),
                                    DataCell(Center(
                                      child: Text(snapshot.data![index].email
                                          .toString()),
                                    )),
                                    DataCell(Center(
                                      child: TextButton(
                                        onPressed: () {
                                          _removeStaff(
                                              snapshot.data![index].id!);
                                        },
                                        child: const Icon(
                                          Icons.delete_forever,
                                          color: Colors.red,
                                        ),
                                      ),
                                    )),
                                  ]))),
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return const Text("error");
                }
                return Container();
              })
        ],
      ),
      floatingActionButton:
          HomeFloatingButton(context: context, database: widget.database),
    );
  }

  Future<List<Staff>> _getStaff() async {
    log("in get staff", name: "GET STAFF");

    if (dropDownVal == "All") {
      return await widget.database.staffDao.getAll();
    } else {
      if (dropDownVal == "Maid") {
        return await widget.database.staffDao.getCleaningStaff();
      } else {
        return await widget.database.staffDao.getReceptions();
      }
    }
  }

  void _removeStaff(int id) async {
    final Staff? s = await widget.database.staffDao.getStaffByID(id);
    log(s!.name);

    final int a = await widget.database.staffDao.deleteStaff([s]);
    log(a.toString());
    setState(() {
      log(
        a.toString(),
      );
    });
  }
}
