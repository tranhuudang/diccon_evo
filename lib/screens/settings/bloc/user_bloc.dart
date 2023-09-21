import 'dart:async';
import 'package:diccon_evo/models/user_info.dart';
import 'package:diccon_evo/screens/dictionary/cubit/word_history_list_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../config/properties.dart';
import '../../../helpers/file_handler.dart';
import '../../../services/auth_service.dart';

/// User Events
abstract class UserEvent {}

class UserDeleteDateEvent extends UserEvent {}

class UserLoginEvent extends UserEvent {}

class UserLogoutEvent extends UserEvent {}

class UserSyncEvent extends UserEvent {
  UserInfo userInfo;
  UserSyncEvent({required this.userInfo});
}

/// User State
abstract class UserState {}

abstract class UserActionState extends UserState {}

class UserUninitialized extends UserState {}

class UserLoggingoutState extends UserActionState {}

class UserLogoutCompletedState extends UserActionState {}

class UserLogoutErrorState extends UserActionState {}

class UserLoginState extends UserState {
  bool isSyncing = false;
  UserInfo userInfo;
  UserLoginState({required this.userInfo, required this.isSyncing});
}

class UserSyncingState extends UserState {}

class UserSyncCompleted extends UserActionState {}

/// Bloc
class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserUninitialized()) {
    on<UserLoginEvent>(_userLogin);
    on<UserLogoutEvent>(_userLogout);
    on<UserSyncEvent>(_userSyncData);
    on<UserDeleteDateEvent>(_deleteAllData);
  }

  FutureOr<void> _deleteAllData(
      UserDeleteDateEvent deleteAll, Emitter<UserState> emit) async {
    /// Remove online file
    await FileHandler("ass").deleteUserDataFile();

    /// Remove local file
    await FileHandler(Properties.wordHistoryFileName).deleteFile();
    await FileHandler(Properties.articleHistoryFileName).deleteFile();
    await FileHandler(Properties.articleBookmarkFileName).deleteFile();
    await FileHandler(Properties.topicHistoryFileName).deleteFile();
    await FileHandler(Properties.essentialFavouriteFileName).deleteFile();
    await Future.delayed(const Duration(seconds: 2));
  }

  FutureOr<void> _userSyncData(
      UserSyncEvent sync, Emitter<UserState> emit) async {
    emit(UserLoginState(isSyncing: true, userInfo: sync.userInfo));
    await FileHandler("asd").downloadUserDataFile();
    await FileHandler(Properties.wordHistoryFileName).uploadUserDataFile();
    await FileHandler(Properties.articleHistoryFileName).uploadUserDataFile();
    await FileHandler(Properties.articleBookmarkFileName).uploadUserDataFile();
    await FileHandler(Properties.topicHistoryFileName).uploadUserDataFile();
    await FileHandler(Properties.essentialFavouriteFileName).uploadUserDataFile();
    emit(UserLoginState(isSyncing: false, userInfo: sync.userInfo));
    emit(UserSyncCompleted());
  }

  Future _userLogin(UserLoginEvent login, Emitter<UserState> emit) async {
    AuthService authService = AuthService();
    GoogleSignInAccount? user = await authService.googleSignIn();
    Properties.userInfo = UserInfo(
        user!.id, user.displayName ?? "", user.photoUrl ?? "", user.email);
    emit(UserLoginState(userInfo: Properties.userInfo, isSyncing: false));
  }

  FutureOr<void> _userLogout(
      UserLogoutEvent logout, Emitter<UserState> emit) async {

    /// Reset User object
    emit(UserLoggingoutState());
    /// Logout Auth services
    AuthService authService = AuthService();
    authService.googleSignOut();

    /// Remove local file
    await FileHandler(Properties.wordHistoryFileName).deleteFile();
    await FileHandler(Properties.articleHistoryFileName).deleteFile();
    await FileHandler(Properties.articleBookmarkFileName).deleteFile();
    await FileHandler(Properties.topicHistoryFileName).deleteFile();
    await FileHandler(Properties.essentialFavouriteFileName).deleteFile();
    /// Reset properties
    Properties.userInfo = UserInfo("", "", "", "");
    await Future.delayed(const Duration(seconds: 2));
    emit(UserLogoutCompletedState());
    emit(UserUninitialized());
  }
}
