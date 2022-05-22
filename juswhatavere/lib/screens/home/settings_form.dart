import 'package:flutter/material.dart';
import 'package:juswhatavere/models/user_costume.dart';
import 'package:juswhatavere/screens/services/database.dart';
import 'package:juswhatavere/shared/constants.dart';
import 'package:juswhatavere/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0','1','2','3','4'];

   String? _currentName ;
   String? _currentSugars ;
   int? _currentStrength ;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserCostume?>(context);
    return StreamBuilder<UserData>(
      stream: DataBaseService(uid: user!.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData userdata = snapshot.data!;
           // _currentName = userdata.name;
           // _currentSugars = userdata.sugars;
           // _currentStrength = userdata.strength;
          return Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Update your brew settings',
                  style: TextStyle(fontSize: 18, color: Colors.brown[800]),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  initialValue: userdata.name,
                  decoration: textInputDecoration,
                  validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) => setState(() {
                    _currentName = val;
                  }),
                ),
                SizedBox(height: 20,),
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value: _currentSugars ?? userdata.sugars,
                  items: sugars.map((sugar){
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar sugars'),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() {
                    _currentSugars= val.toString();
                  }),
                ),
                Slider(
                  min: 100,
                  max: 900,
                  divisions: 8,
                  value: (_currentStrength ?? userdata.strength).toDouble(),
                  onChanged: (val) => setState(() {
                    _currentStrength= val.toInt();
                  }),
                  activeColor: Colors.brown[_currentStrength ?? userdata.strength],
                  inactiveColor: Colors.brown[_currentStrength ?? userdata.strength] ,
                ),
                ElevatedButton(
                  onPressed: ()async{
                    // print(_currentName);
                    // print(_currentSugars);
                    // print(_currentStrength);
                    if(_formKey.currentState!.validate()){
                      await DataBaseService(uid: user.uid).updateUserData(
                          _currentSugars ?? userdata.sugars,
                          _currentName ?? userdata.name,
                          _currentStrength ?? userdata.strength);
                      Navigator.pop(context);
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.pink.shade400),
                  ),
                  child: Text(
                    'Update ',
                    style: TextStyle(color: Colors.white),
                  ),
                ),

              ],
            ),
          );
        }
        else{
          return Loading();
        }

      }
    );
  }
}

