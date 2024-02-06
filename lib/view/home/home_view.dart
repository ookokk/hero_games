import 'package:flutter/material.dart';
import 'package:hero_games_case/model/user_model.dart';
import 'package:hero_games_case/service/user_repository.dart';
import 'package:hero_games_case/view/home/widget/user_card.dart';
import 'package:hero_games_case/widget/custom_app_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  late List<UserModel> userList = []; // Provide an initial value

  @override
  void initState() {
    super.initState();
    _loadUserList();
  }

  Future<void> _loadUserList() async {
    List<UserModel> users = await UserRepository().getUserList();
    setState(() {
      userList = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: userList.length,
          itemBuilder: (context, index) {
            if (userList.isEmpty) {
              return const CircularProgressIndicator(); // or any loading indicator
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
