import 'dart:math';
import 'package:collection/collection.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.cyan),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  List<Set<int>> listOfSets = <Set<int>>[];

  final int nElementsWithMax = 69;
  final int kTaken = 6;
  final int requiredResults = 3;
  

  Set<int> randomNumber = {0}; // Initialize with a default value
  final random = Random();

  void generateRandomNumber() {
    setState(() {
      randomNumber.add(random.nextInt(69)); // Or your desired range
    });
  }

  void generateListOfRandomNumbers() {
    for (int i = 0; i < requiredResults; i++) {
      bool isInList = false;
      Set<int> anewSet;
      do {
        anewSet = Set.of(listRandom(nElementsWithMax, kTaken));
        isInList = listOfSets.firstWhereOrNull((x) => anewSet.intersection(x).length == anewSet.length) != null;
      } while (isInList);
      setState(() {listOfSets.add(anewSet);});       
    }
  }

List<int> listRandom(int maxNumber, int numberOfGenerations) {

  final random = Random();
  var currentOptions = List<int>.generate(maxNumber, (i) => i);

  var list = List.generate(numberOfGenerations, (_) {
    final index = random.nextInt(currentOptions.length);
    final result = currentOptions[index];
    currentOptions.removeAt(index);    
    return result;
  });
  return list;
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Random Generator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Number Generated:'),
            Text(
              listOfSets.toString(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            TextButton(
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: generateListOfRandomNumbers,
              child: Text('Generate Numbers'),
            ),
          ],
        ),
      ),
    );
  }
}
