import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import '../../utils/db/blood.dart';
import '../../utils/db_firebase.dart';

class StationsView extends StatefulWidget {
  const StationsView({super.key});

  @override
  State<StationsView> createState() => _StationsViewState();
}

class _StationsViewState extends State<StationsView> {
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
  //db
  final db = DbHelper();

  final TextEditingController station = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Future<Iterable<Stations>> getStations() async {
      var stations = await Hive.openBox<Stations>('userBox');
      return stations.values;
    }

    return FutureBuilder(
        future: getStations(),
        builder: (context, AsyncSnapshot<Iterable<Stations>> snapshoot) {
          if (snapshoot.hasData) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Collection sites',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff160304).withOpacity(0.6),
                    ),
                  ),
                  // CollectionSitesTable(
                  //   db: db,
                  //   headingStyle: headingStyle,
                  //   body: body,
                  // ),

                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          sortColumnIndex: 2,
                          columns: [
                            DataColumn(
                              label: Text(
                                'ID',
                                style: headingStyle,
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Station',
                                style: headingStyle,
                              ),
                            ),
                            DataColumn(
                                label: Text('Date of creation',
                                    style: headingStyle)),
                            // DataColumn(label: Text('Units', style: headingStyle)),
                          ],
                          rows: snapshoot.data!
                              .toList()
                              .map(
                                (item) => DataRow(
                                  cells: [
                                    DataCell(Text(
                                      '',
                                      style: body,
                                    )),
                                    DataCell(
                                      Text(
                                        item.name,
                                        style: body,
                                      ),
                                    ),
                                    DataCell(Text(
                                      '${item.dOfDisbatch.day}/${item.dOfDisbatch.month}/${item.dOfDisbatch.year}',
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
                    ),
                  ),

                  AddSiteBtn(station: station),
                ],
              ),
            );
          } else if (snapshoot.connectionState == ConnectionState.waiting) {
            return const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(),
            );
          } else {
            return const Text('Someting went wrong');
          }
        });
  }
}

//btn
class AddSiteBtn extends StatelessWidget {
  const AddSiteBtn({
    super.key,
    required this.station,
  });

  final TextEditingController station;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.white,
                  title: Text(
                    "Add collection site",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      // color: Colors.white,
                    ),
                  ),
                  content: SizedBox(
                    width: 400,
                    height: 200,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: station,
                        ),
                        // TextFormField(),
                        const SizedBox(
                          height: 24,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (station.text.isNotEmpty) {
                              var objStain = Stations()
                                ..name = station.text
                                ..dOfDisbatch = DateTime.now();

                              var stations =
                                  await Hive.openBox<Stations>('userBox');
                              stations.add(objStain);
                            }
                          },
                          child: Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                              color: const Color(0xffE0222B),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                'Add',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
        child: Container(
          height: 40,
          width: 300,
          decoration: BoxDecoration(
            color: Color(0xffE0222B),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              'Add collection site',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class CollectionSitesTable extends StatelessWidget {
//   const CollectionSitesTable({
//     super.key,
//     required this.db,
//     required this.headingStyle,
//     required this.body,
//   });

//   final DbHelper db;
//   final TextStyle headingStyle;
//   final TextStyle body;

//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }
