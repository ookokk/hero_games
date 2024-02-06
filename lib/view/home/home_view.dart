import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hero_games_case/model/user_model.dart';
import 'package:hero_games_case/service/auth_manager.dart';
import 'package:hero_games_case/service/cache_manager.dart';
import 'package:hero_games_case/service/user_repository.dart';
import 'package:hero_games_case/view/home/widget/user_card.dart';
import 'package:hero_games_case/widget/custom_alert.dart';

import 'add_hobby_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  late List<UserModel> userList = [];
  final FirebaseAuth auth = FirebaseAuth.instance;
  late UserModel? currentUser;

  @override
  void initState() {
    super.initState();
    _loadUserList();
  }

  Future<void> _loadUserList() async {
    List<UserModel> users = await UserRepository().getUserList();
    currentUser = await UserRepository().getUser();
    setState(() {
      userList = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authManager = AuthManager();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).shadowColor,
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddHobbyView(
                                user: currentUser as UserModel,
                              )));
                },
                child: Text(
                  'Hobbies',
                  style: Theme.of(context).textTheme.labelMedium,
                )),
            TextButton(
                onPressed: () async {
                  final String? ahmet = await CacheManager.getString('uid');
                  print(ahmet);
                },
                child: Text(
                  'print',
                  style: Theme.of(context).textTheme.labelMedium,
                )),
            TextButton(
                onPressed: () async {
                  CustomAlert().showAuthAlertDialog(true, context, 'Warning',
                      'Are you sure you really want to log out?', 'Logout', () {
                    try {
                      authManager.signOut();
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/login', (route) => false);
                    } catch (e) {
                      debugPrint('Çıkış yapılamadı');
                    }
                  });
                },
                child: Text(
                  'LOGOUT',
                  style: Theme.of(context).textTheme.labelLarge,
                ))
          ],
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1.6,
            crossAxisCount: 1,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 0.0,
          ),
          itemCount: userList.length,
          itemBuilder: (context, index) {
            if (userList.isEmpty) {
              return const CircularProgressIndicator();
            }
            return UserCard(
              name: userList[index].fullName,
              email: userList[index].email,
              birthDate: userList[index].birthDate.toString(),
              bio: userList[index].biography ?? 'asd',
            );
          },
        ),
      ),
    );
  }
}
