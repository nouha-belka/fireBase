import 'package:cloud_firestore/cloud_firestore.dart';

class Brew{
  final String name;
  final String sugars;
  final int strength;

  Brew({required this.strength,required this.sugars,required this.name});

}