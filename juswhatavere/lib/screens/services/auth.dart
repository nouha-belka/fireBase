import 'package:firebase_auth/firebase_auth.dart';
import 'package:juswhatavere/models/user_costume.dart';
import 'package:juswhatavere/screens/services/database.dart';


class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on Firebase user
  UserCostume? _userFromFirebaseUser(User? user){
    return user != null ? UserCostume(uid: user.uid) : null;
  }

  Stream<UserCostume?>? get user {
    return _auth.authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user));
    // .map(_userFromFirebaseUser);
  }

  //sign in anonymous
  Future signInAnon() async{
    try{
      // AuthResult ==> UserCredential
      UserCredential result = await _auth.signInAnonymously();
      //FirebaseUser ==> User
      User? user = result.user ;
      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign in with email
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user ;
      return _userFromFirebaseUser(user);
    }catch(e){
      return null;
    }
  }

  //register with email

  Future registerWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user ;
      await DataBaseService(uid: user!.uid).updateUserData('0', 'nouha', 100);
      return _userFromFirebaseUser(user);
    }catch(e){
      return null;
    }
  }

  //sign out
  Future signOutApp() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return  null;
    }
  }
}