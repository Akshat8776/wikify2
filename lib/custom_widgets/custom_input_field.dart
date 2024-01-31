
import 'package:blocimplement/cubits/loading_cubit.dart';
import 'package:blocimplement/provider/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomInputField extends StatefulWidget {
  final TextEditingController textController;
  Function addItem;

   CustomInputField(
      {super.key,
      required this.textController,
        required this.addItem
      });

  @override
  // ignore: library_private_types_in_public_api
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 10),
      decoration: const BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.all(Radius.circular(45)),
      ),
      margin: const EdgeInsets.all(20),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        style: Theme.of(context).textTheme.displaySmall!.copyWith(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
        controller: widget.textController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          isDense: true,
          border: InputBorder.none,
          suffixIcon: IconButton(
            onPressed: () {
              // widget.textController.text =
              //     allWordsCapitilize(widget.textController.text.trim());
              String text = widget.textController.text;


              onSubmit(text);
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          focusColor: Colors.white,
          hintText: "Type to search",
          hintStyle: const TextStyle(
            // fontStyle: FontStyle.italic,

            fontSize: 20,
            color: Colors.blue,
          ),
        ),
        onSubmitted: (text) {
          text = allWordsCapitilize(text.trim());
          onSubmit(text);
        },
      ),
    );
  }

  onSubmit(String text)async {
    if (text.isNotEmpty) {
      widget.addItem();
      widget.textController.text = text;
      ResultProvider resultProvider=ResultProvider();
      await resultProvider.searchWord(widget.textController.text, context);
      // widget.textController.text = "";
      // context.read<LoadingCubit>().noInternet();
    } else {
      Fluttertoast.showToast(
          msg: "Nothing there!!!", toastLength: Toast.LENGTH_SHORT);
      context.read<LoadingCubit>().free();
    }
    FocusScope.of(context).unfocus();
  }

  String allWordsCapitilize(String str) {
    return str.toLowerCase().split(' ').map((word) {
      String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
      return word[0].toUpperCase() + leftText;
    }).join(' ');
  }

}
