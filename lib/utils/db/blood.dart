import 'package:hive/hive.dart';
part 'blood.g.dart';

@HiveType(typeId: 0)
class BloodInDb {
  @HiveField(0)
  late final String name;
  @HiveField(1)
  late final String batchNo;
  @HiveField(2)
  late final String station;
  @HiveField(3)
  late final String bloodType;
  @HiveField(4)
  late final String dOfCollection;
  // late final String name;
}

@HiveType(typeId: 1)
class BloodOutDb {
  @HiveField(0)
  late final String batchNo;
  @HiveField(1)
  late final String hospital;
  @HiveField(2)
  late final String dOfDisbatch;
  @HiveField(3)
  late final String bloodType;
}

@HiveType(typeId: 2)
class Stations {
  @HiveField(0)
  late final String name;
  @HiveField(1)
  late final DateTime dOfDisbatch;
}
