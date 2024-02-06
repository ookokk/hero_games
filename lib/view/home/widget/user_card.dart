import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final String name;
  final String email;
  final String birthDate;
  final String bio;
  const UserCard(
      {Key? key,
      required this.name,
      required this.email,
      required this.birthDate,
      required this.bio})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 1.5,
        color: Theme.of(context).cardColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildInfoRow(context, name, Icons.perm_contact_cal),
              buildInfoRow(context, email, Icons.mail),
              buildInfoRow(context, birthDate, Icons.date_range),
              buildInfoRow(context, bio, Icons.info_outlined),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildInfoRow(BuildContext context, String text, IconData iconData) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: Text(
              text,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          Expanded(
              child: Icon(
            iconData,
            color: Theme.of(context).shadowColor,
          ))
        ],
      ),
    );
  }
}
