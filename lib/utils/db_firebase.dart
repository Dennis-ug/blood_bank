import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DbHelper {
  // DbHelper(){}
  List<QueryDocumentSnapshot<Map<String, dynamic>>> station = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> bloodUnits = [];
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

  Future<void> addBlood({
    required String dName,
    required String bNo,
    required String station,
    required String bType,
    required String dCollection,
  }) async {
    try {
      FirebaseFirestore database = FirebaseFirestore.instance;
      await database.collection('boodIn').doc().set({
        'name': dName,
        'batch_no': bNo,
        'station': station,
        'blood_type': bType,
        'd_o_f': dCollection,
        // 'd_o_c': DateTime.now(),
      });
      debugPrint(station);
    } catch (e) {
      debugPrint('Tried to add bllod but =====>${e.toString()}');
    }
  }

  Future getBloodRecords() async {
    try {
      FirebaseFirestore database = FirebaseFirestore.instance;

      await database.enablePersistence(
        const PersistenceSettings(synchronizeTabs: true),
      );
      database.settings = const Settings(
        persistenceEnabled: true,
        cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
      );
      final res = await database.collection('boodIn').get();
      bloodUnits = res.docs;
      return res.docs;

      // debugPrint(station);
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
      station = res.docs;
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
