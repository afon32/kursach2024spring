// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';

// Padding documentInfoColumn(BuildContext context,
//     String name, String author, String description, Timestamp date) {
//   return Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Container(
//           decoration: BoxDecoration(
//               color: const Color.fromARGB(255, 226, 103, 0),
//               borderRadius: BorderRadius.circular(10.0),
//               border: Border.all(color: Colors.black)),
//           //color: Colors.blueAccent,
//           child: Column(
//             children: [
//               //Имя
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Container(
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10.0),
//                         color: Colors.white),
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [const Text('Название:'), Flexible(child: Text(name, overflow: TextOverflow.fade,))],
//                     )),
//               ),
//               //Должность
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Container(
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10.0),
//                         color: Colors.white),
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [const Text('Автор:'), Text(author)],
//                     )),
//               ),
//               //E-mail
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Container(
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10.0),
//                         color: Colors.white),
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [const Text('Дата публикации:'), Text(DateFormat('dd.MM.yy  hh:mm').format(date.toDate()))],
//                     )),
//               ),
//               Padding(
//                   padding: const EdgeInsets.all(5.0),
//                   child: Container(
//                     width: MediaQuery.of(context).size.width * 0.8,
//                     decoration: BoxDecoration(
//                       color: Colors.grey, // Серый фон
//                       borderRadius:
//                           BorderRadius.circular(10.0), // Закругленные края
//                     ),
//                     child: Padding(padding: const EdgeInsets.all(5.0) ,child:Text(description)),
//                   ))
//             ],
//           )));
// }
