import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String yourName;
  final String valentineName;
  final String quote;
  final int gifNo;

  UserModel({
    required this.yourName,
    required this.valentineName,
    required this.quote,
    required this.gifNo,
  });

  Map<String, dynamic> toMap() {
    return {
      'yourName': yourName,
      'valentineName': valentineName,
      'quote': quote,
      'gifNo': gifNo,
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data()!;
    return UserModel(
      yourName: data['yourName'],
      valentineName: data['valentineName'],
      quote: data['quote'],
      gifNo: data['gifNo'],
    );
  }
}
