import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/db.dart';

class UpdateView extends StatelessWidget {
  UpdateView({super.key});
  final db = DbHelper();
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
  final TextEditingController station = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100),
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
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: FutureBuilder(
                    future: db.getStations(),
                    builder: (context, snapshoot) {
                      if (snapshoot.hasData) {
                        final dataRes = snapshoot.data
                            as QuerySnapshot<Map<String, dynamic>>;
                        debugPrint(
                            dataRes.docs.map((e) => e.data()).toString());
                        return DataTable(
                          columns: [
                            DataColumn(
                              label: Text(
                                'ID',
                                style: headingStyle,
                              ),
                            ),
                            DataColumn(
                                label: Text('Station', style: headingStyle)),
                            DataColumn(
                                label: Text('Date of creation',
                                    style: headingStyle)),
                            // DataColumn(label: Text('Units', style: headingStyle)),
                          ],
                          rows: dataRes.docs
                              .map(
                                (item) => DataRow(
                                  cells: [
                                    DataCell(Text(
                                      item.id,
                                      style: body,
                                    )),
                                    DataCell(
                                      Text(
                                        item.data()['station'],
                                        style: body,
                                      ),
                                    ),
                                    DataCell(Text(
                                      '${(item.data()['d_o_c'] as Timestamp).toDate()}',
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
                        );
                      } else if (snapshoot.connectionState ==
                          ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else {
                        return Text('No data');
                      }
                    }),
              ),
              Align(
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
                                    onTap: () {
                                      final db = DbHelper();
                                      if (station.text.isNotEmpty) {
                                        db.createStation(station.text).then(
                                            (value) =>
                                                Navigator.of(context).pop());
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
              ),
              Divider(),
              Text(
                'Collected blood',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff160304).withOpacity(0.6),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
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
                    )),
                    DataColumn(
                      label: Text(
                        'Date in',
                        style: headingStyle,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Exp date',
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
                  rows: data
                      .map(
                        (item) => DataRow(
                          cells: [
                            DataCell(Text(
                              item['id'].toString(),
                              style: body,
                            )),
                            DataCell(
                              Text(
                                item['station'],
                                style: body,
                              ),
                            ),
                            DataCell(Text(
                              item['Date in'] ?? '',
                              style: body,
                            )),
                            DataCell(Text(
                              item['Exp date'] ?? '',
                              style: body,
                            )),
                            DataCell(Text(
                              item['Type'] ?? '',
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
                              width: 800,
                              height: 600,
                              child: Column(
                                children: [
                                  // TypeAheadField(
                                  //   textFieldConfiguration:
                                  //       TextFieldConfiguration(
                                  //           autofocus: true,
                                  //           style: DefaultTextStyle.of(context)
                                  //               .style
                                  //               .copyWith(
                                  //                   fontStyle:
                                  //                       FontStyle.italic),
                                  //           decoration: const InputDecoration(
                                  //               border: OutlineInputBorder())),
                                  //   suggestionsCallback: (pattern) async {
                                  //     return await db.getStations();
                                  //   },
                                  //   itemBuilder: (context, suggestion) {
                                  //     return const ListTile(
                                  //       leading: Icon(Icons.shopping_cart),
                                  //       title: Text(""),
                                  //       // subtitle: Text('\$${suggestion['price']}'),
                                  //     );
                                  //   },
                                  //   onSuggestionSelected: (suggestion) {
                                  //     // Navigator.of(context).push(
                                  //     //     MaterialPageRoute(
                                  //     //         builder: (context) => ProductPage(
                                  //     //             product: suggestion)));
                                  //   },
                                  // ),
                                  TextFormField(
                                    controller: station,
                                    decoration: const InputDecoration(
                                      label: Text('Donar Id'),
                                    ),
                                  ),
                                  DropdownButtonFormField(
                                    items: List.generate(db.station.length,
                                        (index) {
                                      final item = db.station[index];
                                      return DropdownMenuItem(
                                        value: index,
                                        child: Text(item['station']),
                                      );
                                    }),
                                    decoration:
                                        InputDecoration(label: Text('Station')),
                                    // .map(
                                    //   (data) => DropdownMenuItem(
                                    //     value: data.,
                                    //     child: Text(data['station']),
                                    //   ),
                                    // )
                                    // .toList(),
                                    onChanged: (v) {},
                                  ),
                                  DropdownButtonFormField(
                                    items: const [
                                      DropdownMenuItem(
                                        value: "0",
                                        child: Text('A'),
                                      ),
                                      DropdownMenuItem(
                                        value: "1",
                                        child: Text('B'),
                                      ),
                                      DropdownMenuItem(
                                        value: "2",
                                        child: Text('AB'),
                                      ),
                                      DropdownMenuItem(
                                        value: "3",
                                        child: Text('O'),
                                      ),
                                    ],
                                    decoration: const InputDecoration(
                                      label: Text('Blood type'),
                                    ),
                                    // .map(
                                    //   (data) => DropdownMenuItem(
                                    //     value: data.,
                                    //     child: Text(data['station']),
                                    //   ),
                                    // )
                                    // .toList(),
                                    onChanged: (v) {},
                                  ),

                                  TextFormField(
                                    controller: station,
                                    decoration: const InputDecoration(
                                      label: Text('Date of collection'),
                                    ),
                                  ),
                                  // TextFormField(),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      final db = DbHelper();
                                      if (station.text.isNotEmpty) {
                                        db.createStation(station.text).then(
                                            (value) =>
                                                Navigator.of(context).pop());
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
                        'Blood Stock In',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
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
          ),
        ),
      ),
    );
  }
}
