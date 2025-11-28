import 'package:hive/hive.dart';

part 'session_model.g.dart';

@HiveType(typeId: 1)
class SessionModel extends HiveObject {
  @HiveField(0)
  bool isLoggedIn;

  @HiveField(1)
  String? loggedInEmail;

  @HiveField(2)
  String? userId;

  SessionModel({
    this.isLoggedIn = false,
    this.loggedInEmail,
    this.userId,
  });
}







