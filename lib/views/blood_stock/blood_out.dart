import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../../utils/db/blood.dart';
import '../../utils/db_firebase.dart';
import '../exchange/blood_out.dart';

class BloodOutflow extends StatelessWidget {
  BloodOutflow({super.key});

  final db = DbHelper();
  // final List<Map<String, dynamic>> data = [
  //   {'id': 1, 'station': 'Station A', 'date': '2023-07-19', 'units': 10},
  //   {'id': 2, 'station': 'Station B', 'date': '2023-07-20', 'units': 8},
  //   {'id': 3, 'station': 'Station C', 'date': '2023-07-21', 'units': 12},
  //   {'id': 4, 'station': 'Station D', 'date': '2023-07-22', 'units': 6},
  // ];

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
    return FutureBuilder(
      future: Hive.openBox<BloodOutDb>('bout'),
      builder: (
        context,
        snapshoot,
      ) {
        if (snapshoot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Blood given out',
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
                      'Hospital',
                      style: headingStyle,
                    )),
                    DataColumn(
                      label: Text(
                        'Date out',
                        style: headingStyle,
                      ),
                    ),
                    // DataColumn(
                    //   label: Text(
                    //     'Exp date',
                    //     style: headingStyle,
                    //   ),
                    // ),
                    DataColumn(
                      label: Text(
                        'Type',
                        style: headingStyle,
                      ),
                    ),
                    // DataColumn(label: Text('Units', style: headingStyle)),
                  ],
                  rows: snapshoot.data!.values
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
                                item.hospital,
                                style: body,
                              ),
                            ),
                            DataCell(Text(
                              "${DateFormat.yMd().format(DateTime.parse(item.dOfDisbatch))}",
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
                          builder: (BuildContext context) => const BloodOut(),
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
                          'Blood Stock Out',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )),
              ),
            ],
            // Divider()
          );
        } else if (snapshoot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 40,
            width: 40,
            child: CircularProgressIndicator(),
          );
        } else {
          return Text('Error');
        }
      },
    );
  }
}
