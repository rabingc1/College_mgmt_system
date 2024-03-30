import 'package:firebase_auth/firebase_auth.dart';

class FirebaseauthService{
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndAndPassword(String email, String password)async{
  try{
    UserCredential credential= await _auth.createUserWithEmailAndPassword(email: email, password: password);
        return credential.user;
  }catch(e){
    print("some error please check signup session");
  }
  return null;
  }
  Future<User?> signInWithEmailAndAndPassword(String email, String password)async{
    try{
      UserCredential credential= await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    }catch(e){
      print("some error please check in signin session");
    }
    return null;
  }





}