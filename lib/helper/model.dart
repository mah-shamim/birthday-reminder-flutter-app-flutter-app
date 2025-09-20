import 'package:flutter/services.dart';

class BirthDayListModel {
  int? id;
  String? name, birthDate, year, greetings, gender, anniversary;
  Uint8List? image;

  BirthDayListModel({this.id, this.name, this.year, this.birthDate, this.image, this.greetings, this.gender, this.anniversary});
  factory BirthDayListModel.fromMap(Map<String, dynamic> json) => BirthDayListModel(
        id: json['id'],
        name: json['name'],
        year: json['year'],
        birthDate: json['birthDate'],
        image: json['image'],
        greetings: json['greetings'],
        gender: json['gender'],
        anniversary: json['anniversary'],
      );
  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'year': year,
        'birthDate': birthDate,
        'image': image,
        'greetings': greetings,
        'gender': gender,
        'anniversary': anniversary,
      };
}

class MyCardModel {
  int? id, uid;
  String? greetings, image, fontString;

  MyCardModel({
    this.id,
    this.image,
    this.greetings,
    this.uid,
    this.fontString,
  });
  factory MyCardModel.fromMap(Map<String, dynamic> json) => MyCardModel(
        id: json['id'],
        image: json['image'],
        greetings: json['greetings'],
        uid: json['uid'],
        fontString: json['fontString'],
      );
  Map<String, dynamic> toMap() => {
        'id': id,
        'image': image,
        'greetings': greetings,
        'uid': uid,
        'fontString': fontString,
      };
}

class ReminderModel {
  int? id, uid, isActive;
  String? reminder, reminderTime;

  ReminderModel({
    this.id,
    this.reminder,
    this.uid,
    this.isActive,
    this.reminderTime,
  });
  factory ReminderModel.fromMap(Map<String, dynamic> json) => ReminderModel(
        id: json['id'],
        uid: json['uid'],
        reminder: json['reminder'],
        isActive: json['isActive'],
        reminderTime: json['reminderTime'],
      );
  Map<String, dynamic> toMap() => {
        'id': id,
        'uid': uid,
        'reminder': reminder,
        'isActive': isActive,
        'reminderTime': reminderTime,
      };
}

class ProfileModel {
  String? title, images;
  ProfileModel({
    this.images,
    this.title,
  });
}

class ReminderTime {
  String? title;
  bool? isTrue;
  ReminderTime({
    this.isTrue,
    this.title,
  });
}

class BirthDayData {
  int? id;
  String? image;
  String? name, birthdate, year;

  BirthDayData({
    required this.name,
    this.year,
    required this.birthdate,
    this.id,
    this.image,
  });

  factory BirthDayData.fromJson(Map<String, dynamic> json) => BirthDayData(
        id: json['id'],
        image: json['image'],
        name: json['name'],
        year: json['year'],
        birthdate: json['birthdate'],
      );
  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'year': year,
        'birthdate': birthdate,
        'image': image,
      };
}

class PreferencesModel {
  int? id, notificationID;
  PreferencesModel({
    this.id,
    this.notificationID,
  });
  factory PreferencesModel.fromJson(Map<String, dynamic> json) => PreferencesModel(
        id: json['id'],
        notificationID: json['notificationID'],
      );
  Map<String, dynamic> toMap() => {
        'id': id,
        'notificationID': notificationID,
      };
}
