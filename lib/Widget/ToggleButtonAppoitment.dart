// import 'package:flutter/material.dart';
//
// class ToggleButton extends StatefulWidget {
//   final Function(bool isClick) onTap;
//   const ToggleButton({Key? key, required this.onTap}) : super(key: key);
//
//   @override
//   State<ToggleButton> createState() => _ToggleButtonState();
// }
//
// bool isClick = false;
//
// class _ToggleButtonState extends State<ToggleButton> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           isClick = !isClick;
//         });
//         widget.onTap(isClick);
//       },
//       child: Stack(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 6, left: 5),
//             child: Container(
//               height: 26,
//               width: 59,
//               decoration: BoxDecoration(
//                 color: isClick ? Colors.green : Colors.red,
//                 borderRadius: BorderRadius.circular(20.0),
//                 // border: Border.all(),
//               ),
//             ),
//           ),
//           Padding(
//             padding: isClick
//                 ? const EdgeInsets.only(left: 35)
//                 : const EdgeInsets.only(left: 0),
//             child: Container(
//               height: 38,
//               width: 38,
//               decoration: const BoxDecoration(),
//               child: Card(
//                 elevation: 10,
//                 color: Colors.white,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20.0)),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class AppoinmentToggle extends StatefulWidget {
  final bool value;
  final Function(bool isClick) onTap;
  const AppoinmentToggle({Key? key, required this.onTap,required this.value}) : super(key: key);

  @override
  State<AppoinmentToggle> createState() => _AppoinmentToggleState();
}

class _AppoinmentToggleState extends State<AppoinmentToggle> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap(!widget.value);
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 5),
            child: Container(
              height: 26,
              width: 59,
              decoration: BoxDecoration(
                color: widget.value ? Colors.green : Colors.green,
                borderRadius: BorderRadius.circular(20.0),
                // border: Border.all(),
              ),
            ),
          ),
          Padding(
            padding: widget.value
                ? const EdgeInsets.only(left: 35)
                : const EdgeInsets.only(left: 0),
            child: Container(
              height: 38,
              width: 38,
              decoration: const BoxDecoration(),
              child: Card(
                elevation: 10,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



