
import 'package:flutter_bloc/flutter_bloc.dart';

class ClickableWordCubit extends Cubit<int>{
  ClickableWordCubit() : super(-1);

  void setSelectedIndex(int newIndex){
    emit(newIndex);
  }
}