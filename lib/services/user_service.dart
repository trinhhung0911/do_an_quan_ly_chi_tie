import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quan_ly_chi_tieu/configs/constants.dart';
import 'package:quan_ly_chi_tieu/models/cost_collect.dart';
import 'package:quan_ly_chi_tieu/models/cost_spend.dart';
import 'package:quan_ly_chi_tieu/models/get_user.dart';
import 'package:quan_ly_chi_tieu/models/users.dart';
import 'package:quan_ly_chi_tieu/storage/secure_storge.dart';

class UserService{
  //Create user
  Future<dynamic> createUser({required Users user}) async {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: user.email, password: user.password);
    var userId = userCredential.user!.uid;
    CollectionReference users = FirebaseFirestore.instance.collection(CollectionName.users.name);
    user.uid = userId;
    await users.doc(userId).set(user.toJson());
  }
  //GetUser
  Future<List<GetUser>> getUsers() async {

   List<GetUser> getUsers=[];
    var idUser=await SecureStorage().getString(key: SecureStorage.userId);

    //thông tin user
     Users? users;
   CollectionReference usersCollection = FirebaseFirestore.instance.collection(CollectionName.users.name);
    var data = await usersCollection.get();
    for (var item in data.docs) {
      var e = Users.formJson(item.data() as Map<String, dynamic>)..id = item.id;
      if(e.uid == idUser) {
        users =e;
      }
    }
    //tổng tất cả tiền chi tiêu
   int sumSpendAll=0;
   CollectionReference sumSpendAllCollection = FirebaseFirestore.instance.collection(CollectionName.costSpend.name);
   var dataSumSpendAll = await sumSpendAllCollection.get();
   for (var item in dataSumSpendAll.docs) {
     var e = CostSpend.formJson(item.data() as Map<String, dynamic>)..id = item.id;
     if(e.idUser == idUser) {
       sumSpendAll=sumSpendAll+e.money;
     }
   }
  // tổng tiền thu nhập
   int sumCollectdAll=0;
   CollectionReference sumCollectAllCollection = FirebaseFirestore.instance.collection(CollectionName.costCollect.name);
   var dataSumCollectAll = await sumCollectAllCollection.get();
   for (var item in dataSumCollectAll.docs) {
     var e = CostCollect.formJson(item.data() as Map<String, dynamic>)..id = item.id;
     if(e.idUser == idUser) {
       sumCollectdAll=sumCollectdAll+e.money;
     }
   }
     GetUser a= GetUser(user: users,sumAllSpend:sumSpendAll,sumAllCollect: sumCollectdAll );
     getUsers.add(a);
     return getUsers;
  }




  //GetSumSpendUsers
  Future<int> getSumSpendUsers() async {
    int sumSpend=0;
    var idUser=await SecureStorage().getString(key: SecureStorage.userId);
    CollectionReference usersCollection = FirebaseFirestore.instance.collection(CollectionName.costSpend.name);
    var data = await usersCollection.get();
    for (var item in data.docs) {
      var e = CostSpend.formJson(item.data() as Map<String, dynamic>)..id = item.id;
      if(e.idUser == idUser) {
       sumSpend=sumSpend+e.money;
      }
    }
    return sumSpend;
  }
}