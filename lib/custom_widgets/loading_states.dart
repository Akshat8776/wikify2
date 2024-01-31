import 'package:blocimplement/cubits/loading_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/enums/states_enum.dart';
// import '/provider/result_provider.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '/global/global.dart';

class LoadingStates extends StatelessWidget {

  const LoadingStates({super.key});
  @override
  Widget build(BuildContext context) {
    print(context.read<LoadingCubit>().state.current_state);

    return context.read<LoadingCubit>().state.current_state == Current_State.SEARCHING
        ? Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: Align(
                // alignment: Alignment.center,
                child: LoadingAnimationWidget.discreteCircle(
              color: Colors.grey,
              size: 50,
            )),
          )
        : context.read<LoadingCubit>().state.current_state == Current_State.NO_ITEM
            ? Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Align(
                    // alignment: Alignment.center,
                    child: Text("No results found.",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 20,
                              color: textColor,
                            ))),
              )
            : context.read<LoadingCubit>().state.current_state == Current_State.NO_INTERNET
                ? Align(
                    alignment: Alignment.center,
                    child: Text("No internet connection detected...",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: textColor, fontSize: 15)))
                : Align(
                    // alignment: Alignment.center,
                    child: Text(
                      "Type what you are looking for...",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 18,
                            color: textColor,
                          ),
                    ),
                  );
  }
}
