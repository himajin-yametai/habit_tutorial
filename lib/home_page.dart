import 'dart:async';

import 'package:flutter/material.dart';
import 'package:habit_tutorial/util/habit_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List habitList = [
    ['Exercise', false, 0, 10],
    ['Read', false, 0, 30],
    ['Meditate', false, 0, 60],
    ['Code', false, 0, 80],
  ];

  void habitStarted(int index) {
    setState(() {
      habitList[index][1] = !habitList[index][1];
    });

    if (habitList[index][1]) {
      if(habitList[index][2] == habitList[index][3]) {
        habitList[index][2] = 0;
      }
      Timer.periodic(const Duration(seconds: 1), (timer) { 
        setState(() {
          if (!habitList[index][1]) {
            timer.cancel();
          } else {
            if(++habitList[index][2] == habitList[index][3]) {
              timer.cancel();
              habitList[index][1] = false;
            }
          }
        });
      });
    }
  }

  void settingsOpened(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Settings for ' + habitList[index][0]),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text('Consistency is key.'),
        centerTitle: false,
      ),
      body: ListView.builder(
        itemCount: habitList.length,
        itemBuilder: (context, index) {
          return HabitTile(
            habitName: habitList[index][0],
            onTap: () {
              habitStarted(index);
            },
            settingsTapped: () {
              settingsOpened(index);
            }, 
            habitStarted: habitList[index][1],
            timeSpent: habitList[index][2], 
            timeGoal: habitList[index][3], 
          );
        },
      ),
    );
  }
}