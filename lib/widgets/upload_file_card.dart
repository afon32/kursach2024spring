import 'package:flutter/material.dart';

Padding uploadFileInfo(String name, String post, String email) {
  return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 226, 103, 0),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.black)),
          //color: Colors.blueAccent,
          child: Column(
            children: [
              //Имя
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white),
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [const Text('Имя:'), Text(name)],
                    )),
              ),
              //Должность
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white),
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [const Text('Должность:'), Text(post)],
                    )),
              ),
              //E-mail
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white),
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [const Text('E-mail:'), Text(email)],
                    )),
              ),
            ],
          )));
}
