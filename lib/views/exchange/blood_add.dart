import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../../utils/db/blood.dart';
import '../../utils/db_firebase.dart';

class AddBlood extends StatefulWidget {
  const AddBlood({super.key});

  @override
  State<AddBlood> createState() => _AddBloodState();
}

class _AddBloodState extends State<AddBlood> {
  @override
  Widget build(BuildContext context) {
    final db = DbHelper();
    final TextEditingController dName = TextEditingController();
    final TextEditingController bNo = TextEditingController();
    final TextEditingController stationIn = TextEditingController();
    final TextEditingController bType = TextEditingController();
    final TextEditingController dCollection = TextEditingController();
    final bloodInForm = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Add blood'),
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
                TextFormField(
                  controller: dName,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'This required';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text('Donar name'),
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
                TextFormField(
                  controller: stationIn,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'This required';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text('Station'),
                  ),
                ),

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
                    bType.text = v as String;
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
                      dCollection.text = DateFormat.yMd().format(picked);
                      // setState(() {
                      //   // selectedDate = picked;

                      // });
                    }
                  },
                  controller: dCollection,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'This required';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text('Date of collection'),
                  ),
                ),
                // TextFormField(),
                const SizedBox(
                  height: 24,
                ),
                GestureDetector(
                  onTap: () async {
                    var bloodIn = await Hive.openBox<BloodInDb>('bIn');
                    final objBlodin = BloodInDb()
                      ..name = dName.text
                      ..batchNo = bNo.text
                      ..station = stationIn.text
                      ..bloodType = bType.text
                      ..dOfCollection = dCollection.text;
                    bloodIn
                        .add(objBlodin)
                        .then((value) => Navigator.pop(context));
                    ;
                    // if (bloodInForm.currentState!.validate()) {

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
        ),
      ),
    );
  }
}
