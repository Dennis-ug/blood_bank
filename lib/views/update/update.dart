import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateView extends StatelessWidget {
  UpdateView({super.key});
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
                child: DataTable(
                  columns: [
                    DataColumn(
                      label: Text(
                        'ID',
                        style: headingStyle,
                      ),
                    ),
                    DataColumn(label: Text('Station', style: headingStyle)),
                    DataColumn(
                        label: Text('Date of creation', style: headingStyle)),
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
                              item['date'],
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
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => UpdateView())),
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
                'Collection sites',
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
                    DataColumn(label: Text('Station', style: headingStyle)),
                    DataColumn(
                        label: Text('Date of creation', style: headingStyle)),
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
                              item['date'],
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
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => UpdateView())),
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
              Divider(),
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => UpdateView())),
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
            ],
            // Divider()
          ),
        ),
      ),
    );
  }
}
