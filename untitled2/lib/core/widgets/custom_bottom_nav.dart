import 'package:flutter/material.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(40), topLeft: Radius.circular(40)),
        color: Colors.amberAccent,
      ),
      width: MediaQuery.sizeOf(context).width,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List<Widget>.generate(3, (index) {
          return IconButton(
              iconSize: 30,
              onPressed: () {
                // // إرسال Event عند الضغط على الزر
                // context
                //     .read<BottomNavBloc>()
                //     .add(ToggleNavEvent(index: index));
              },
              icon: const Icon(Icons.access_alarms_sharp));
          // icon: index == 0
          //     ? Icon(
          //         Icons.home,
          //         color: state is ToggleNavState &&
          //                 state.selectedIndex == index
          //             ? accentColor
          //             : state is StartState
          //                 ? accentColor
          //                 : secondaryColor,
          //       )
          //     : index == 1
          //         ? Icon(
          //             Icons.shopping_cart,
          //             color: state is ToggleNavState &&
          //                     state.selectedIndex == index
          //                 ? accentColor
          //                 :secondaryColor,
          //           )
          //         : Icon(
          //             Icons.person,
          //             color: state is ToggleNavState &&
          //                     state.selectedIndex == index
          //                 ? accentColor
          //                 : secondaryColor,
          //           ));
        }),
      ),
    );
  }
}
