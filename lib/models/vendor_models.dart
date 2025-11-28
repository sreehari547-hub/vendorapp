import 'package:hive/hive.dart';

part 'vendor_models.g.dart';

@HiveType(typeId: 0)
class VendorModel extends HiveObject {
  @HiveField(0)
  String firstName;

  @HiveField(1)
  String lastName;

  @HiveField(2)
  String email;

  @HiveField(3)
  String mobile;

  @HiveField(4)
  String password;

  VendorModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobile,
    required this.password,
  });
}
