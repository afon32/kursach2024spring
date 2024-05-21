

// import 'package:flutter/material.dart';

// Padding selectLevelOrCategory(String title, List listOfSomething, String selected){
//   return Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(2.0),
//                       child: Container(
//                         padding: const EdgeInsets.all(5.0),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(5.0),
//                             color: const Color.fromARGB(255, 137, 148, 160)),
//                         child: const Text('Выберите категорию документа:'),
//                       ),
//                     ),
//                     Padding(
//                         padding: const EdgeInsets.all(2.0),
//                         child: Container(
//                           padding: const EdgeInsets.only(right: 5.0, left: 5.0),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10.0),
//                               color: const Color.fromARGB(255, 137, 148, 160)),
//                           child: DropdownButton<String>(
//                             value: selectedCategory,
//                             icon: const Icon(Icons.arrow_downward),
//                             elevation: 16,
//                             style: const TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold),
//                             underline: Container(
//                               height: 2,
//                               color: Colors.deepPurpleAccent,
//                             ),
//                             onChanged: (String? value) {
//                               setState(() {
//                                 selectedCategory = value!;
//                               });
//                               print(selectedCategory);
//                             },
//                             items: categories
//                                 .map<DropdownMenuItem<String>>((String value) {
//                               return DropdownMenuItem<String>(
//                                 value: value,
//                                 child: Text(value),
//                               );
//                             }).toList(),
//                           ),
//                         )),
//                   ]));

// }