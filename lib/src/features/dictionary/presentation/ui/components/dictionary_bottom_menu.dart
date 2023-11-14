import 'package:diccon_evo/src/features/dictionary/data/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_divider/wave_divider.dart';
import 'package:diccon_evo/src/common/common.dart';

class DictionaryBottomMenu extends StatelessWidget {
  const DictionaryBottomMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final chatListBloc = context.read<ChatListBloc>();
    return IconButton(onPressed: (){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                leading: const Icon(Icons.add_circle_outline),
                title: Text('Create a new section'.i18n),
                onTap: (){
                  context.showAlertDialog(
                    title: "Close this session?",
                    content: "Clear all the bubbles in this translation session.",
                    action: () {
                      //resetSuggestion();
                      chatListBloc.add(CreateNewChatList());
                    },
                  );
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: WaveDivider(thickness: .3,),
              ),
              ListTile(
                leading: const Icon(Icons.auto_awesome_outlined),
                title: Text('Auto detect language'.i18n),),
              ListTile(title: Text('Force translate Vietnamese to English'.i18n),),
              ListTile(title: Text('Force translate English to Vietnamese'.i18n),),


            ],
          ),
        );
      });
    }, icon: Icon(Icons.add_circle_outline));
  }
}
