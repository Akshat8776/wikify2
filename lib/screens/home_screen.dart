// import 'dart:convert';
// import 'package:blocimplement/enums/states_enum.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:blocimplement/cubits/loading_cubit.dart';
// import '/custom_widgets/app_bar.dart';
// import '/custom_widgets/custom_input_field.dart';
// import '/custom_widgets/loading_states.dart';
// import '/custom_widgets/cache_history.dart';
// import '/model/recents.dart';
// // import '/provider/result_provider.dart';
// import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// import '/global/global.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   // ignore: library_private_types_in_public_api
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen>
//     with SingleTickerProviderStateMixin {
//   String query = "";
//   List<Recents> list = List<Recents>.empty(growable: true);
//   TextEditingController textController = TextEditingController();
//
//   @override
//   void initState() {
//     loadData();
//     super.initState();
//   }
//
//   void loadData() {
//     List<String>? listString = sharedPreferences!.getStringList('list');
//     if (listString != null) {
//       setState(() {
//         list = listString
//             .map((item) => Recents.fromMap(json.decode(item)))
//             .toList();
//       });
//     } else {
//       list = List<Recents>.empty(growable: true);
//     }
//   }
//
//   removeData() async {
//     await sharedPreferences!.remove('list');
//     loadData();
//   }
//
//   removeItem(Recents item) async {
//     for (int i = 0; i < list.length; i++) {
//       if (list[i].title == item.title) {
//         list.removeAt(i);
//       }
//     }
//     saveData();
//   }
//
//   addItem(Recents item) {
//     for (int i = 0; i < list.length; i++) {
//       if (list[i].title == item.title) {
//         list.removeAt(i);
//       }
//     }
//     list.insert(0, item);
//     saveData();
//   }
//
//   void saveData() {
//     List<String> stringList =
//         list.map((item) => json.encode(item.toMap())).toList();
//     sharedPreferences!.setStringList('list', stringList);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Stack(
//         children: [
//           ValueListenableBuilder(
//             valueListenable: globaltheme,
//             builder: (context, value, child) {
//               return Container(
//                 color: col.value,
//               );
//             },
//           ),
//           BlocBuilder<LoadingCubit,Current_State>(
//               builder: (context, state) {
//                 // return Container();
//                 // print('Hi'+context.read());
//             return Column(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Appbar(),
//                 CustomInputField(
//                     textController: textController,
//                     resultProvider: context.read(),
//                     addItem: () {
//                       addItem(Recents(title: textController.text));
//                     }),
//                 SizedBox(
//                   height: 100,
//                   child: LoadingStates(
//                     current_state: state,
//                   ),
//                 ),
//                 const SizedBox(),
//                 CacheHistory(
//                     resultProvider: context.read(),
//                     recentList: list,
//                     removeRecents: () => removeData(),
//                     loadList: () => loadData(),
//                     removeRecentItem: (String val) {
//                       removeItem(Recents(title: val));
//                     })
//               ],
//             );
//           })
//         ],
//       ),
//     );
//   }
// }
