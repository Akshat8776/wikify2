// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:blocimplement/cubits/loading_cubit.dart';
import 'package:blocimplement/custom_widgets/app_bar.dart';
import 'package:blocimplement/custom_widgets/custom_input_field.dart';
import 'package:blocimplement/custom_widgets/loading_states.dart';
import 'package:blocimplement/enums/states_enum.dart';
import 'package:blocimplement/utils/preference_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../custom_widgets/cache_history.dart';
import '../global/global.dart';
import '../model/recents.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController textEditingController = TextEditingController();
  String query = "";
  List<Recents> list = List<Recents>.empty(growable: true);

  @override
  void initState() {

    super.initState();
    PreferenceUtils.init();
    loadData();

  }

  void loadData() async{
    List<String>? listString = await PreferenceUtils.getCacheList();
    if (listString != null) {
      setState(() {
        list = listString
            .map((item) => Recents.fromMap(json.decode(item)))
            .toList();
      });
    } else {
      list = List<Recents>.empty(growable: true);
    }
  }

  removeData() async {
    await PreferenceUtils.removeAllCache();
    loadData();
  }

  removeItem(Recents item) async {
    for (int i = 0; i < list.length; i++) {
      if (list[i].title == item.title) {
        list.removeAt(i);
      }
    }
    saveData();
  }

  addItem(Recents item) {
    for (int i = 0; i < list.length; i++) {
      if (list[i].title == item.title) {
        list.removeAt(i);
      }
    }
    list.insert(0, item);
    print('hi');
    print(item.title);
    saveData();
  }

  void saveData() {
    List<String> stringList =
        list.map((item) => json.encode(item.toMap())).toList();
    PreferenceUtils.setCacheList(stringList);
  }

  @override
  Widget build(BuildContext context) {
    // print(context.read<LoadingCubit>());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          ValueListenableBuilder(
            valueListenable: globaltheme,
            builder: (context, value, child) {
              return Container(
                color: col.value,
              );
            },
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Appbar(),
              Container(
                  child: CustomInputField(
                      textController: textEditingController,
                      addItem: () {
                        print(textEditingController.text);
                        addItem(Recents(title: textEditingController.text));
                      })),
              BlocBuilder<LoadingCubit, LoadingState>(builder: (context, state) {
                return Column(children: [
                  if (state.current_state == Current_State.IDLE)
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.green,
                    )
                  else if (state.current_state == Current_State.NO_INTERNET)
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey,
                    )
                  else if (state.current_state == Current_State.SEARCHING)
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.red,
                    )
                  else
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.yellowAccent,
                    ),
                  LoadingStates(),
                  SizedBox(height: 20,),
                  CacheHistory(
                      // resultProvider: context.read(),
                      recentList: list,
                      removeRecents: () => removeData(),
                      loadList: () => loadData(),
                      removeRecentItem: (String val) {
                        removeItem(Recents(title: val));
                      })
                ]);
              }),
            ],
          ),
        ],
      ),
    );
  }
}
