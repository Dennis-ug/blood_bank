import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DbHelper {
  // DbHelper(){}
  List<Map<String, dynamic>> station = [];
  Future<void> createStation(String station) async {
    try {
      FirebaseFirestore database = FirebaseFirestore.instance;
      await database.collection('stations').doc().set({
        'station': station,
        'd_o_c': DateTime.now(),
      });
      debugPrint(station);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future getStations() async {
    try {
      FirebaseFirestore database = FirebaseFirestore.instance;

      await database
          .enablePersistence(const PersistenceSettings(synchronizeTabs: true));
      database.settings = const Settings(
        persistenceEnabled: true,
        cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
      );
      final res = await database.collection('stations').get();
      station = res.docs.map((e) => e.data()).toList();
      return res;

      // debugPrint(station);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // Future<QuerySnapshot<Map<String, dynamic>>> getStationsSuggetions() async {

  //   try {
  //     FirebaseFirestore database = FirebaseFirestore.instance;

  //     await database
  //         .enablePersistence(const PersistenceSettings(synchronizeTabs: true));
  //     database.settings = const Settings(
  //       persistenceEnabled: true,
  //       cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  //     );
  //     return await database.collection('stations').get();

  //     // debugPrint(station);
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  //   return null;
  // }
}
