import 'package:diccon_evo/src/common/common.dart';
part 'user_info.freezed.dart';
@freezed
class UserInfo with _$UserInfo {
  const factory UserInfo({
    required String uid,
    required String displayName,
    required String photoURL,
    required String email,
    required String phoneNumber,
  }) = _UserInfo;
  static UserInfo empty() {
    return const UserInfo(
        uid: "", displayName: "", photoURL: "", email: "", phoneNumber: "");
  }
}
