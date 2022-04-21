import 'package:quan_ly_chi_tieu/models/users.dart';
import 'package:quan_ly_chi_tieu/services/user_service.dart';

class UserRepository{
  Future<dynamic> createUser({required Users user,
  }) async {
    await UserService().createUser(user: user);
  }

}