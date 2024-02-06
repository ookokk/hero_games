class UserModel {
  String fullName;
  String email;
  DateTime birthDate;
  String? biography;
  List<String>? hobbies;

  UserModel({
    required this.fullName,
    required this.email,
    required this.birthDate,
    this.biography,
    this.hobbies,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['fullName'],
      email: json['email'],
      birthDate: DateTime.parse(json['birthDate']),
      biography: json['biography'],
      hobbies: List<String>.from(json['hobbies']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'birthDate': birthDate.toIso8601String(),
      'biography': biography,
      'hobbies': hobbies,
    };
  }
}
