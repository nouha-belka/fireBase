// ignore_for_file: dead_code

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:juswhatavere/models/brew.dart';
import 'package:juswhatavere/models/user_costume.dart';

class DataBaseService{

  final String? uid;
  DataBaseService({this.uid});
  //collection reference
  //Firestore ==> FirebaseFirestore
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('Brew');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars' : sugars,
      'name' : name,
      'strength' : strength,
    });
  }

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      dynamic data = doc.data()!;
      return Brew(
          strength: data['strength'] ,
          sugars: data['sugars'] ,
          name: data['name'] );
    }).toList();
  }

  //userdata from snapshot
  UserData _userDataFromSnapshot (DocumentSnapshot snapshot) {
    dynamic data = snapshot.data()!;
    return UserData(
        strength: data['strength'],
        sugars: data['sugars'],
        name: data['name'],
        uid: uid);
  }

  //get brew stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}