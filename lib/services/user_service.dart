import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quan_ly_chi_tieu/configs/constants.dart';
import 'package:quan_ly_chi_tieu/models/users.dart';

class UserService{
  Future<dynamic> createUser({required Users user}) async {
    UserCredential userCredential =
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: user.email, password: user.password);
    var userId = userCredential.user!.uid;
    CollectionReference employees = FirebaseFirestore.instance.collection(CollectionName.users.name);
    user.uId = userId;
    await employees.doc(userId).set(user.toJson());
  }

}