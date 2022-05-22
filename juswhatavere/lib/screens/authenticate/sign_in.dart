import 'package:flutter/material.dart';
import 'package:juswhatavere/screens/services/auth.dart';
import 'package:juswhatavere/shared/constants.dart';
import 'package:juswhatavere/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth  = AuthService();
  final _formKey = GlobalKey<FormState>();
  String buttonText = 'sign in ';
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() :Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0,
        title: const Text(
          'sign in to Brew Crew',
        ),
        actions: [
          TextButton.icon(
              onPressed: (){
                widget.toggleView();
              },
              label: Text(
                  'Register',
                style: TextStyle(color: Colors.brown[200]),
              ),
              icon: Icon(
                  Icons.person,
                color: Colors.brown[200],
              ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height:20 ,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val!.isEmpty ? 'Enter Email' : null,
                onChanged: (val){
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(height:20 ,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator: (val) => val!.length < 6 ? 'Enter Password with more than 6 characters' : null,
                onChanged: (val){
                  setState(() {
                    password = val;
                  });
                },
                obscureText: true,
              ),
              SizedBox(height:20 ,),
              Padding(
                padding: const EdgeInsets.fromLTRB(160, 0, 0, 0),
                child: ElevatedButton(
                  onPressed: ()async{
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                      if(result == null){
                        setState(() {
                          loading = false;
                          error = 'Invalid email or password';
                        });
                      }
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.pink.shade400),
                  ),
                  child: Text(
                    'Sign in ',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height:20 ,),
              Text(
                error,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
              )
            ],
          ),
        ),
        // ElevatedButton(
        //   onPressed: () async {
        //     dynamic result = await _auth.signInAnon();
        //     if(result == null){
        //       buttonText = 'error';
        //     }
        //     else{
        //       setState(() {
        //         buttonText = result.uid;
        //       });
        //     }
        //   },
        //   child: Text(buttonText),
        // ) ,

      ),
    );
  }
}
