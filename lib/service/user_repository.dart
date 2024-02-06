import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hero_games_case/model/user_model.dart';
import 'cache_manager.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUser(UserModel user) async {
    String? currentUid = await CacheManager.getString('uid');
    await _firestore.collection('users').doc(currentUid).set({
      'fullName': user.fullName,
      'email': user.email,
      'birthDate': user.birthDate,
      'biography': user.biography,
      'hobbies': user.hobbies,
    });
  }

  Future<UserModel?> getUser() async {
    String? currentUid = await CacheManager.getString('uid');
    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(currentUid).get();
    if (snapshot.exists) {
      return UserModel(
        fullName: snapshot['fullName'],
        email: snapshot['email'],
        birthDate: snapshot['birthDate'].toDate(),
        biography: snapshot['biography'],
        hobbies: (snapshot['hobbies'] != null)
            ? List<String>.from(snapshot['hobbies'])
            : [], // Provide an empty list if 'hobbies' is null
      );
    } else {
      return null;
    }
  }

  Future<void> updateUserHobbies(String email, List<String> hobbies) async {
    String? currentUid = await CacheManager.getString('uid');
    await _firestore.collection('users').doc(currentUid).update({
      'hobbies': hobbies,
    });
  }

  Future<void> updateUserBiography(String email, String? biography) async {
    String? currentUid = await CacheManager.getString('uid');

    await _firestore.collection('users').doc(currentUid).update({
      'biography': biography,
    });
  }

  Future<List<UserModel>> getUserList() async {
    QuerySnapshot snapshot = await _firestore.collection('users').get();

    return snapshot.docs.map((doc) {
      return UserModel(
        fullName: doc['fullName'],
        email: doc['email'],
        birthDate: doc['birthDate'].toDate(),
        biography: doc['biography'],
        hobbies:
            (doc['hobbies'] != null) ? List<String>.from(doc['hobbies']) : [],
      );
    }).toList();
  }
}
