import 'package:game_on/model/user_model.dart';
import 'package:game_on/view/bottom/bottom_nav_bar.dart';
import 'package:game_on/view/home/rummy/teen_patti/view_model/service/firebase_services.dart';

import '../../../../../../material_imports.dart';
import 'local_data_base_service.dart';

class AuthService extends ChangeNotifier {
  final _firestoreService = FireBaseServices();
  // final  _localDBService = LocalDBService();
  UserModel? _userData;
  UserModel? get userData => _userData;

  // Future<void> loginOrRegister(
  //     BuildContext context, String name, String password) async {
  //   if (name.isEmpty || password.isEmpty) {
  //     _showAlert(context, 'Error', 'Please fill all fields.');
  //     return;
  //   }
  //
  //   try {
  //     UserModel? existingUser = await _firestoreService.getUserByName(name);
  //
  //     if (existingUser != null) {
  //       await _localDBService.saveUserSession(existingUser);
  //       FeedbackProvider.navigateToHome(context);
  //       _userData = existingUser;
  //       _showAlert(
  //           context, '🎉 Welcome Back!', 'You have successfully logged in!');
  //     } else {
  //       String? newUserId =
  //           await _firestoreService.registerUser(name, password);
  //       if (newUserId != null) {
  //         UserModel newUser =
  //             UserModel(id: newUserId, name: name, password: password,walletBalance: 50000);
  //         await _localDBService.saveUserSession(newUser);
  //         _userData = newUser;
  //         FeedbackProvider.navigateToHome(context);
  //         _showAlert(context, '🎯 Registration Successful!', 'Enjoy the game!');
  //       }
  //     }
  //   } catch (error) {
  //     debugPrint('Error: $error');
  //     _showAlert(context, '❌ Error', 'Something went wrong!');
  //   }
  //   notifyListeners();
  // }

  Future<void> getSessionUser() async {
    // _userData = await _localDBService.getSessionUser();
    print("user data: $_userData");
    notifyListeners();
  }

  // Future<void> logout(BuildContext context) async {
  //   await _localDBService.clearSession();
  //   Navigator.pushNamedAndRemoveUntil(context, RouteName.loginActivity, (context)=>false);
  // }

  void _showAlert(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))
        ],
      ),
    );
  }
}
