import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DbHelper {
  // DbHelper(){}

  void createStation(String station) {
    try {
      FirebaseFirestore database = FirebaseFirestore.instance;
      database.collection('stations').doc().set({
        'station': station,
        'd_o_c': DateTime.now(),
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
