import 'package:flutter/material.dart';

String docLevel = 'A';
List level = [false, false, false, false];

void helpLevelSelection(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Выбор уровня документа'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Информация подлежит строгому контролю и может быть передана только сильно ограниченному кругу лиц?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                level[0] = true;
                Navigator.of(context).pop();
                helpLevelSelection2(context);
              },
              child: const Text('Да'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                helpLevelSelection2(context);
              },
              child: const Text('Нет'),
            ),
          ],
        );
      });
}

void helpLevelSelection2(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Выбор уровня документа'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Информация может быть передана только чётко определённым группам лиц, ролей, исполнителей, команде проекта?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                level[1] = true;
                Navigator.of(context).pop();
                helpLevelSelection3(context);
              },
              child: const Text('Да'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                helpLevelSelection3(context);
              },
              child: const Text('Нет'),
            ),
          ],
        );
      });
}

void helpLevelSelection3(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Выбор уровня документа'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Может ли эта информация быть передана любому прохожему на улице?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                helpLevelSelection4(context);
              },
              child: const Text('Да'),
            ),
            TextButton(
              onPressed: () {
                level[2] = true;
                Navigator.of(context).pop();
                helpLevelSelection4(context);
              },
              child: const Text('Нет'),
            ),
          ],
        );
      });
}

void helpLevelSelection4(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Выбор уровня документа'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Была ли публикация согласована напрямую с отделом по корпоративным коммуникациям?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                level[3] = true;
                Navigator.of(context).pop();
                finalDialog(context);
              },
              child: const Text('Да'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                finalDialog(context);
              },
              child: const Text('Нет'),
            ),
          ],
        );
      });
}

String checking() {
  if (level[0]) {
    return 'D';
  } else if (level[1])
    return 'C';
  else if (level[2])
    return 'B';
  else
    return 'A';
}

void finalDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Результат'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Рекомендуемый класс доступа: ${checking()}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                level[3] = true;
                Navigator.of(context).pop();
              },
              child: const Text('Закрыть'),
            ),
          ],
        );
      });
}
