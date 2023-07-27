import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../../utils/db/blood.dart';
import '../../utils/size_gen.dart';
import '../update/update.dart';

class DashView extends StatelessWidget {
  const DashView({super.key});

  @override
  Widget build(BuildContext context) {
    Sizing size = Sizing(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          // width: double.infinity,
          // height: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            const Profile(),
            const SizedBox(
              height: 32,
            ),
            const StatColoum(),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RecentCollections(),
                const BloodRates(),
              ],
            )
          ]),
        ),
      ),
    );
  }
}

class BloodRates extends StatelessWidget {
  const BloodRates({
    super.key,
  });

  // get typ => null;

  @override
  Widget build(BuildContext context) {
    List<String> _tpy = ['A', 'B', 'AB', 'O'];
    return Container(
      width: 245,
      height: 508,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xff2D070A).withOpacity(0.4),
            blurRadius: 19,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Blood Consumption',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff160304).withOpacity(0.6),
                ),
              ),
            ),
            const Divider(),
            ...List.generate(
              _tpy.length,
              (index) => BloodConsumption(
                type: _tpy[index],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BloodConsumption extends StatelessWidget {
  final String type;
  const BloodConsumption({
    super.key,
    required this.type,
  });
  Future<Map<String, String>> staticGenarator(String bloodType) async {
    final out = await Hive.openBox<BloodOutDb>('bout');
    final int unitsServed = out.values
        .where(
            (blood) => blood.bloodType.toLowerCase() == bloodType.toLowerCase())
        .toList()
        .length;

    final int totalUnits = out.values.length;
    final percentage = unitsServed > 0 ? unitsServed / totalUnits * 100 : 0;

    return {
      "percentage": percentage.toString(),
      "units": unitsServed.toString()
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: staticGenarator(type),
        builder: (context, snap) {
          if (snap.hasData) {
            final data = snap.data;
            return Row(
              children: [
                CircleAvatar(
                  child: Text(type),
                ),
                Expanded(
                  child: ListTile(
                    title: Text(
                      '${data!['units']} Units',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff160304).withOpacity(0.6),
                      ),
                    ),
                    subtitle: Text(
                      'Rate ${data['percentage']}%',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff160304).withOpacity(0.6),
                      ),
                    ),
                  ),
                )
              ],
            );
          } else if (snap.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            return const Text("Error");
          }
        });
  }
}

class RecentCollections extends StatelessWidget {
  RecentCollections({
    super.key,
  });
  final List<Map<String, dynamic>> data = [
    {'id': 1, 'station': 'Station A', 'date': '2023-07-19', 'units': 10},
    {'id': 2, 'station': 'Station B', 'date': '2023-07-20', 'units': 8},
    {'id': 3, 'station': 'Station C', 'date': '2023-07-21', 'units': 12},
    {'id': 4, 'station': 'Station D', 'date': '2023-07-22', 'units': 6},
  ];
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

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 841,
        height: 508,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0xff2D070A).withOpacity(0.4),
              blurRadius: 19,
            ),
          ],
        ),
        child: FutureBuilder<Box<BloodInDb>>(
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
                    // Align(
                    //   alignment: Alignment.bottomRight,
                    //   child: GestureDetector(
                    //       onTap: () {
                    //         Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //             builder: (BuildContext context) => const AddBlood(),
                    //           ),
                    //         );
                    //       },
                    //       child: Container(
                    //         height: 40,
                    //         width: 300,
                    //         decoration: BoxDecoration(
                    //           color: const Color(0xffE0222B),
                    //           borderRadius: BorderRadius.circular(12),
                    //         ),
                    //         child: Center(
                    //           child: Text(
                    //             'Blood Stock In',
                    //             style: GoogleFonts.poppins(
                    //               fontSize: 16,
                    //               fontWeight: FontWeight.w400,
                    //               color: Colors.white,
                    //             ),
                    //           ),
                    //         ),
                    //       )),
                    // ),
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
            }));
  }
}
// ],
//         ));
//   }
// }

class StatColoum extends StatelessWidget {
  const StatColoum({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //TODO:
    Future<int> getDiff() async {
      final inB = await Hive.openBox<BloodInDb>('bIn');
      final outB = await Hive.openBox<BloodOutDb>('bout');
      final int deff = inB.values.length - outB.values.length;
      return deff < 0 ? 0 : deff;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FutureBuilder(
            future: Hive.openBox<BloodInDb>('bIn'),
            builder: (context, snapT) {
              if (snapT.hasData) {
                return StatCard(
                  title: 'Blood in',
                  units: '${snapT.data!.values.length}',
                );
              } else {
                return const Text('0');
              }
            }),
        FutureBuilder(
            future: Hive.openBox<BloodOutDb>('bout'),
            builder: (context, snapT) {
              if (snapT.hasData) {
                return StatCard(
                  title: 'Blood out',
                  units: '${snapT.data!.values.length}',
                );
              } else {
                return const Text('0');
              }
            }),
        const StatCard(
          title: 'Exp blood',
          units: '0',
        ),
        FutureBuilder(
            future: getDiff(),
            builder: (context, snapT) {
              if (snapT.hasData) {
                return StatCard(
                  title: 'Available units',
                  units: snapT.data.toString(),
                );
              } else {
                return const Text('0');
              }
            }),
        // StatCard(
        //   title: 'Available units',
        //   units: '19,456',
        // )
      ],
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String units;
  const StatCard({
    super.key,
    required this.title,
    required this.units,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 245,
      width: 245,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: const Color(0xff2D070A).withOpacity(0.4),
                blurRadius: 19),
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              units,
              style: GoogleFonts.poppins(
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Units',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w300,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset('assets/user dp.png'),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Clever Kim",
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Branch Administrator",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: const Color(0xff160304).withOpacity(0.4),
              ),
            )
          ],
        ),
      ],
    );
  }
}
