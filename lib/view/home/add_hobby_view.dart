import 'package:flutter/material.dart';
import 'package:hero_games_case/model/user_model.dart';
import 'package:hero_games_case/widget/custom_app_bar.dart';
import 'package:hero_games_case/widget/custom_text_field.dart';

class AddHobbyView extends StatefulWidget {
  final UserModel user;
  const AddHobbyView({Key? key, required this.user}) : super(key: key);

  @override
  State<AddHobbyView> createState() => _AddHobbyViewState();
}

class _AddHobbyViewState extends State<AddHobbyView> {
  final TextEditingController _hobbyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomTextField(
                controller: _hobbyController,
                hintText: 'Biography',
                obscureText: false,
                icon: Icon(
                  Icons.info_outlined,
                  color: Theme.of(context).shadowColor,
                ))
          ],
        ),
      ),
    );
  }
}
