import 'dart:developer';

import 'package:db_hotel/db/cleaning_service/cleaning_service_model.dart';
import 'package:db_hotel/db/database.dart';
import 'package:db_hotel/db/food_order_relation/food_order_relation_model.dart';
import 'package:db_hotel/db/order/order_model.dart';
import 'package:db_hotel/db/reservation_details/reservation_details_model.dart';
import 'package:db_hotel/db/staff/staff_model.dart';
import 'package:db_hotel/widgets/styles/my_styles.dart';
import 'package:flutter/material.dart';

class AssignStaffToCleaningService extends StatelessWidget {
  const AssignStaffToCleaningService(
      {Key? key, required this.database, required this.cleaningServiceID})
      : super(key: key);

  final AppDatabase database;
  final int cleaningServiceID;

  // final TextEditingController placeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("the cleaning service ID is $cleaningServiceID"),
              const Divider(),
              FutureBuilder(
                future: _getStaff(),
                builder: (context, AsyncSnapshot<List<Staff>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                          snapshot.data!.length,
                          (index) => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(snapshot.data![index].id.toString()),
                                  Text(snapshot.data![index].name.toString()),
                                  Text(snapshot.data![index].nationalId
                                      .toString()),
                                  TextButton(
                                      onPressed: () async {
                                        await _assign(context,
                                            snapshot.data![index].id!);
                                        log("Assigned ${snapshot.data![index].name} to $cleaningServiceID",
                                            name: "CLEANING ASSIGN");
                                      },
                                      child: const Text("Assign"))
                                ],
                              )),
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _assign(context, int sid) async {
    CleaningServiceModel? cs =
        await database.cleaningServiceDao.getCSByID(cleaningServiceID);

    cs!.staff = sid;
    await database.cleaningServiceDao.updateCleaningService(cs);

    Navigator.pop(context);
  }

  Future<List<Staff>> _getStaff() async {
    return await database.staffDao.getCleaningStaff();
  }
}
