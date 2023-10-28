import 'package:equatable/equatable.dart';

class UserInfo extends Equatable {
  final String uid;
  final String displayName;
  final String photoURL;
  final String email;

  final String phoneNumber;
  const UserInfo(
      {required this.phoneNumber,
      required this.uid,
      required this.displayName,
      required this.photoURL,
      required this.email});

  static UserInfo empty() {
    return const UserInfo(
        uid: "", displayName: "", photoURL: "", email: "", phoneNumber: "");
  }

  UserInfo copyWith({String? phoneNumber, String? uid, String? displayName,
      String? photoURL, String? email}) {
    return UserInfo(
        uid: uid ?? this.uid,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        displayName: displayName ?? this.displayName,
        photoURL: photoURL ?? this.photoURL,
        email: email ?? this.email);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [uid];
}
