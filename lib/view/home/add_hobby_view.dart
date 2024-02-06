// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hero_games_case/model/user_model.dart';
import 'package:hero_games_case/service/user_repository.dart';
import 'package:hero_games_case/widget/custom_app_bar.dart';
import 'package:hero_games_case/widget/custom_text_field.dart';

class AddHobbyView extends StatefulWidget {
  late UserModel user;
  AddHobbyView({Key? key, required this.user}) : super(key: key);

  @override
  State<AddHobbyView> createState() => _AddHobbyViewState();
}

class _AddHobbyViewState extends State<AddHobbyView> {
  final TextEditingController _hobbyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    widget.user = await UserRepository().getUser() ??
        UserModel(
            fullName: 'Error',
            email: 'Error@mail.com',
            birthDate: DateTime.now(),
            hobbies: []);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomTextField(
              controller: _hobbyController,
              hintText: 'Hobby',
              obscureText: false,
              icon: Icon(
                Icons.info_outlined,
                color: Theme.of(context).shadowColor,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _addHobbyToUser();
              },
              child: Text('Add Hobby'),
            ),
            const SizedBox(height: 16),
            Text(
              'User Hobbies:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            _buildHobbiesList(),
          ],
        ),
      ),
    );
  }

  void _addHobbyToUser() async {
    if (_hobbyController.text.isNotEmpty) {
      List<String> updatedHobbies = [
        ...widget.user.hobbies ?? [],
        _hobbyController.text,
      ];

      await UserRepository()
          .updateUserHobbies(widget.user.email, updatedHobbies);

      setState(() {
        widget.user.hobbies = updatedHobbies;
      });
      _hobbyController.clear();
    }
  }

  Widget _buildHobbiesList() {
    if (widget.user.hobbies != null && widget.user.hobbies!.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.user.hobbies!.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.user.hobbies![index]),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
