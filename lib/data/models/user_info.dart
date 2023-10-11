import 'package:equatable/equatable.dart';

class UserInfo extends Equatable {
  final String id;
  final String name;
  final String avatarUrl;
  final String email;

  const UserInfo({required this.id, required this.name, required this.avatarUrl, required this.email});

  static UserInfo empty(){
    return const UserInfo(id: "", name: "", avatarUrl: "", email: "");
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id];


}
