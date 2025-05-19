import 'package:hive/hive.dart';
import '../models/user.dart';

class UserRepository {
  static const String _userBoxName = 'userBox';

  Future<void> saveUser(User user) async {
    final box = await Hive.openBox<User>(_userBoxName);
    await box.put('currentUser', user);
    await box.close();
  }

  Future<User?> getCurrentUser() async {
    final box = await Hive.openBox<User>(_userBoxName);
    final user = box.get('currentUser');
    await box.close();
    return user;
  }

  Future<void> clearUser() async {
    final box = await Hive.openBox<User>(_userBoxName);
    await box.clear();
    await box.close();
  }
}