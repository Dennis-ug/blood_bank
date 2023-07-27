import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../../utils/db/blood.dart';
import '../../utils/db_firebase.dart';
import '../exchange/blood_add.dart';

class BloodInflow extends StatelessWidget {
  BloodInflow({super.key});

  final db = DbHelper();

  TextStyle headingStyle = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: const Color(0xff160304).withOpacity(0.6),
  );
  TextStyle body = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: const Color(0xff160304).withOpacity(0.4),
  );

  //Controllers

  @override
  Widget build(BuildContext context) {
    // var stations = await ;
    return FutureBuilder<Box<BloodInDb>>(
        future: Hive.openBox<BloodInDb>('bIn'),
        builder: (context, snapShoot) {
          if (snapShoot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Collected blood',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff160304).withOpacity(0.6),
                  ),
                ),
                Divider(),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                      // DataColumn(
                      //   label: Text(
                      //     'ID',
                      //     style: headingStyle,
                      //   ),
                      // ),
                      DataColumn(
                          label: Text(
                        'Station',
                        style: headingStyle,
                      )),
                      DataColumn(
                        label: Text(
                          'Date in',
                          style: headingStyle,
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Exp in',
                          style: headingStyle,
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Type',
                          style: headingStyle,
                        ),
                      ),
                      // DataColumn(label: Text('Units', style: headingStyle)),
                    ],
                    rows: snapShoot.data!.values
                        .toList()
                        .map(
                          (item) => DataRow(
                            cells: [
                              // DataCell(Text(
                              //   item.id,
                              //   style: body,
                              // )),
                              DataCell(
                                Text(
                                  item.station,
                                  style: body,
                                ),
                              ),
                              DataCell(Text(
                                item.dOfCollection.toString(),
                                style: body,
                              )),
                              DataCell(Text(
                                '${DateFormat.yMd().parse(item.dOfCollection).add(const Duration(days: 42)).difference(DateTime.now()).inDays} days',
                                style: body,
                              )),
                              DataCell(Text(
                                item.bloodType.toUpperCase(),
                                style: body,
                              )),
                              // DataCell(Text(
                              //   item['units'].toString(),
                              //   style: body,
                              // )),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => const AddBlood(),
                          ),
                        );
                      },
                      child: Container(
                        height: 40,
                        width: 300,
                        decoration: BoxDecoration(
                          color: const Color(0xffE0222B),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'Blood Stock In',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )),
                ),
                // Divider(),
                // GestureDetector(
                //   onTap: () => Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (BuildContext context) => UpdateView())),
                //   child: Container(
                //     height: 40,
                //     width: 300,
                //     decoration: BoxDecoration(
                //       color: Color(0xffE0222B),
                //       borderRadius: BorderRadius.circular(12),
                //     ),
                //     child: Center(
                //       child: Text(
                //         'Blood Stock out',
                //         style: GoogleFonts.poppins(
                //           fontSize: 16,
                //           fontWeight: FontWeight.w400,
                //           color: Colors.white,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
              // Divider()
            );
          } else if (snapShoot.connectionState == ConnectionState.waiting) {
            return const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator.adaptive(),
            );
          } else {
            return Text('error');
          }
        });
  }
}
