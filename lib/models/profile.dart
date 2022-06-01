import 'package:json_annotation/json_annotation.dart';
import "user.dart";
part 'profile.g.dart';

@JsonSerializable()
class Profile {
  Profile();

  late num theme;
  late String locale;
  User? user;
  late String lastLogin;
  
  factory Profile.fromJson(Map<String,dynamic> json) => _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
