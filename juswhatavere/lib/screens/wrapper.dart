import 'package:flutter/material.dart';
import 'package:juswhatavere/models/user_costume.dart';
import 'package:juswhatavere/screens/authenticate/authenticate.dart';
import 'package:juswhatavere/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserCostume?>(context);
    if(user == null ){
      return Authenticate();
    }
    else{
      return Home() ;
    }
  }
}
