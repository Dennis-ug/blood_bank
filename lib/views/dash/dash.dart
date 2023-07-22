import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/size_gen.dart';
import '../update/update.dart';

class DashView extends StatelessWidget {
  const DashView({super.key});

  @override
  Widget build(BuildContext context) {
    Sizing size = Sizing(context);
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: size.wyt(230),
            height: double.infinity,
            color: const Color(0xffE0222B),
          ),
          Expanded(
            child: PageView(
              children: [
                SingleChildScrollView(
                  child: Container(
                    // width: double.infinity,
                    // height: double.infinity,
                    padding: const EdgeInsets.all(20),
                    child: Column(children: [
                      Profile(),
                      SizedBox(
                        height: 32,
                      ),
                      StatColoum(),
                      SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RecentCollections(),
                          BloodRates(),
                        ],
                      )
                    ]),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class BloodRates extends StatelessWidget {
  const BloodRates({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
            Divider(),
            Row(
              children: [
                const CircleAvatar(
                  child: Text('A'),
                ),
                Expanded(
                  child: ListTile(
                    title: Text(
                      '6,000 Units',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff160304).withOpacity(0.6),
                      ),
                    ),
                    subtitle: Text(
                      'Rate 20%',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff160304).withOpacity(0.6),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent blood collection',
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
                DataColumn(label: Text('Date', style: headingStyle)),
                DataColumn(label: Text('Units', style: headingStyle)),
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
                        DataCell(Text(
                          item['units'].toString(),
                          style: body,
                        )),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
          Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => UpdateView())),
              child: Container(
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                  color: const Color(0xffE0222B),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'Update',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
} // ],
//         ));
//   }
// }

class StatColoum extends StatelessWidget {
  const StatColoum({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        StatCard(
          title: 'Blood in',
          units: '23,544',
        ),
        StatCard(
          title: 'Blood out',
          units: '3,544',
        ),
        StatCard(
          title: 'Exp blood',
          units: '544',
        ),
        StatCard(
          title: 'Available units',
          units: '19,456',
        )
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
