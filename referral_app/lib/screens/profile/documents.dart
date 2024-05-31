// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class Documents extends StatefulWidget {
//   const Documents({super.key});

//   @override
//   State<Documents> createState() => _DocumentsState();
// }

// class _DocumentsState extends State<Documents> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Documents",
//           style: TextStyle(color: Colors.black),
//         ),
//         forceMaterialTransparency: true,
//         leading: IconButton(
//           onPressed: () {
//             Get.back();
//           },
//           icon: const Icon(
//             Icons.keyboard_arrow_left_rounded,
//             color: Colors.black,
//             size: 40,
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Bank ID",
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.w300)),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Text(
//                       "Canceled Check",
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
//                     ),
//                   ],
//                 ),
//                 ElevatedButton(
//                     onPressed: () {},
//                     style: ButtonStyle(
//                         minimumSize:
//                             MaterialStateProperty.all(const Size(120, 45)),
//                         shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(5)))),
//                     child: const Text(
//                       "View",
//                       style: TextStyle(fontSize: 18),
//                     ))
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Personal ID",
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.w300)),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Text(
//                       "Voter ID",
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
//                     ),
//                   ],
//                 ),
//                 ElevatedButton(
//                     onPressed: () {},
//                     style: ButtonStyle(
//                         minimumSize:
//                             MaterialStateProperty.all(const Size(120, 45)),
//                         shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(5)))),
//                     child: const Text(
//                       "View",
//                       style: TextStyle(fontSize: 18),
//                     ))
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("PAN ID",
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.w300)),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Text(
//                       "PAN Card",
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
//                     ),
//                   ],
//                 ),
//                 ElevatedButton(
//                     onPressed: () {},
//                     style: ButtonStyle(
//                         minimumSize:
//                             MaterialStateProperty.all(const Size(120, 45)),
//                         shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(5)))),
//                     child: const Text(
//                       "View",
//                       style: TextStyle(fontSize: 18),
//                     ))
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
