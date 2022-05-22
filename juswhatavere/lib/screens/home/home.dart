import 'package:flutter/material.dart';
import 'package:juswhatavere/models/brew.dart';
import 'package:juswhatavere/screens/home/brew_list.dart';
import 'package:juswhatavere/screens/home/settings_form.dart';
import 'package:juswhatavere/screens/services/auth.dart';
import 'package:juswhatavere/screens/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
   Home({Key? key}) : super(key: key);

  final AuthService _auth  = AuthService();
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          color: Colors.brown[50],
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 60),
          child: SettingsForm(),
        );
      });
    }
    return StreamProvider<List<Brew>>.value(
      value: DataBaseService().brews,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          title: Text('Brew Crew'),
          actions: [
            TextButton.icon(
                onPressed: () async{
                  await _auth.signOutApp();
                },
                icon: Icon(
                    Icons.person,
                  color: Colors.brown[200],
                ),
                label: Text(
                    'Log out',
                  style: TextStyle(color: Colors.brown[200]),
                ),
            ),
            TextButton.icon(
                onPressed: () => _showSettingsPanel(),
                icon:Icon(Icons.settings,color: Colors.brown[200],), 
                label: Text(
                  'Settings',
                  style: TextStyle(color: Colors.brown[200]),
                ),
            )
          ],
        ),
        body: Container(
            child: BrewList(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            )
          ),
        ),
      ),
    );
  }
}
