import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../config/properties.dart';
import '../../../data/handlers/file_handler.dart';
import '../../../data/data_providers/user_handler.dart';
import '../../../data/models/user_info.dart';
import '../../../data/services/auth_service.dart';

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
    await UserHandler().deleteUserDataFile();

    /// Remove local file
    await FileHandler(Properties.wordHistoryFileName).deleteOnUserData();
    await FileHandler(Properties.storyHistoryFileName).deleteOnUserData();
    await FileHandler(Properties.storyBookmarkFileName).deleteOnUserData();
    await FileHandler(Properties.topicHistoryFileName).deleteOnUserData();
    await FileHandler(Properties.essentialFavouriteFileName).deleteOnUserData();
    await Future.delayed(const Duration(seconds: 2));
  }

  FutureOr<void> _userSyncData(
      UserSyncEvent sync, Emitter<UserState> emit) async {
    emit(UserLoginState(isSyncing: true, userInfo: sync.userInfo));
    await UserHandler().downloadUserDataFile();
    await UserHandler().uploadUserDataFile(Properties.wordHistoryFileName);
    await UserHandler().uploadUserDataFile(Properties.storyHistoryFileName);
    await UserHandler().uploadUserDataFile(Properties.storyBookmarkFileName);
    await UserHandler().uploadUserDataFile(Properties.topicHistoryFileName);
    await UserHandler().uploadUserDataFile(Properties.essentialFavouriteFileName);
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
    await FileHandler(Properties.wordHistoryFileName).deleteOnUserData();
    await FileHandler(Properties.storyHistoryFileName).deleteOnUserData();
    await FileHandler(Properties.storyBookmarkFileName).deleteOnUserData();
    await FileHandler(Properties.topicHistoryFileName).deleteOnUserData();
    await FileHandler(Properties.essentialFavouriteFileName).deleteOnUserData();
    /// Reset properties
    Properties.userInfo = UserInfo("", "", "", "");
    await Future.delayed(const Duration(seconds: 2));
    emit(UserLogoutCompletedState());
    emit(UserUninitialized());
  }
}
