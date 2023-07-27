import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../../utils/db/blood.dart';

class BloodOut extends StatefulWidget {
  const BloodOut({super.key});

  @override
  State<BloodOut> createState() => _BloodOutState();
}

class _BloodOutState extends State<BloodOut> {
  @override
  Widget build(BuildContext context) {
    // final db = DbHelper();
    final TextEditingController hosp = TextEditingController();
    final TextEditingController bNo = TextEditingController();
    final TextEditingController dateOut = TextEditingController();
    final TextEditingController expDate = TextEditingController();
    final TextEditingController type = TextEditingController();
    final bloodInForm = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Blood out'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: SizedBox(
          width: 800,
          height: 600,
          child: Form(
            key: bloodInForm,
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
                  controller: hosp,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'This required';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text('Hospital'),
                  ),
                ),
                TextFormField(
                  controller: bNo,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'This required';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text('Batch No'),
                  ),
                ),
                // TextFormField(
                //   controller: bNo,
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return 'This required';
                //     }
                //     return null;
                //   },
                //   decoration: const InputDecoration(
                //     label: Text('Batch No'),
                //   ),
                // ),

                DropdownButtonFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'This required';
                    }
                    return null;
                  },
                  items: const [
                    DropdownMenuItem(
                      value: "a",
                      child: Text('A'),
                    ),
                    DropdownMenuItem(
                      value: "b",
                      child: Text('B'),
                    ),
                    DropdownMenuItem(
                      value: "ab",
                      child: Text('AB'),
                    ),
                    DropdownMenuItem(
                      value: "o",
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
                  onChanged: (v) {
                    type.text = v as String;
                  },
                ),
                TextFormField(
                  readOnly: true,
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      initialDatePickerMode: DatePickerMode.day,
                      firstDate:
                          DateTime.now().subtract(const Duration(days: 15)),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      dateOut.text = DateFormat.yMd().format(picked);
                      // setState(() {
                      //   // selectedDate = picked;

                      // });
                    }
                  },
                  controller: dateOut,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'This required';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text('Date out'),
                  ),
                ),
                // TextFormField(
                //   controller: dateOut,
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return 'This required';
                //     }
                //     return null;
                //   },
                //   decoration: const InputDecoration(
                //     label: Text('Date out'),
                //   ),
                // ),
                // TextFormField(),
                const SizedBox(
                  height: 24,
                ),
                GestureDetector(
                  onTap: () async {
                    var bloodIn = await Hive.openBox<BloodInDb>('bIn');
                    final ifBlood = bloodIn.values
                        .where(
                          (element) =>
                              element.bloodType.toLowerCase() ==
                              bNo.text.toLowerCase(),
                        )
                        .toList();
                    print(ifBlood);
                    final box = await Hive.openBox<BloodOutDb>('bout');
                    if (ifBlood.isNotEmpty) {
                      final objBloodIn = BloodOutDb()
                        ..hospital = hosp.text
                        ..batchNo = bNo.text
                        ..bloodType = type.text
                        ..dOfDisbatch = DateTime.now().toString();
                      box
                          .add(objBloodIn)
                          .then((value) => Navigator.pop(context));
                    } else {
                      final snac = SnackBar(
                        content: Text("No blood available"),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snac);
                    }

                    // final db = DbHelper();
                    // await db.addBlood(
                    //   dName: dName.text,
                    //   bNo: bNo.text,
                    //   station: stationIn.text,
                    //   bType: bType.text,
                    //   dCollection: dCollection.text,
                    // );
                    // if (bloodInForm.currentState!
                    //     .validate()) {
                    //   // Navigator.pop(context);

                    // }
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
                        'Serve out',
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
        ),
      ),
    );
  }
}
