import 'package:flutter/material.dart';
import 'package:todoapp/Pages/dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TodoList extends StatefulWidget {
  const TodoList({super.key});
  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  void initState() {
    super.initState();
    getdata();
  }

  void allclear() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Remove data for the 'counter' key.
    await prefs.remove('mytodo');
  }

  void setdata(data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<String>? alltodo = prefs.getStringList('mytodo');
    if (alltodo == null) {
      prefs.setStringList("mytodo", []);
    } else {
      String encode = json.encode(data);
      alltodo.add(encode);
      prefs.setStringList("mytodo", alltodo);
    }
  }

  void getdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List? alltodos = prefs.getStringList("mytodo");
    if (alltodos == null) {
      prefs.setStringList("mytodo", []);
    } else {
      sharedstorage = alltodos;
      setState(() {});
    }
  }

  void deleteData(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? alltodo = prefs.getStringList('mytodo');
    if (alltodo == null) {
      prefs.setStringList("mytodo", []);
    } else {
      alltodo.removeAt(index);
      prefs.setStringList("mytodo", alltodo);
      getdata();
    }
  }

  List sharedstorage = [];
  List<Map> data = [
    {
      "Task": "BreakFast",
      "Time":
          "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}",
      "Dropdown": "AT HOME"
    },
    {
      "Task": "Jog",
      "Time":
          "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}",
      "Dropdown": "AWAY"
    },
    {
      "Task": "Preparing Task",
      "Time":
          "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}",
      "Dropdown": "AT OFFICE"
    },
    {
      "Task": "Meeting at 10",
      "Time":
          "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}",
      "Dropdown": "AT OFFICE"
    },
    {
      "Task": "Programming",
      "Time":
          "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}",
      "Dropdown": "AT OFFICE"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TODO"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/emp');
              },
              icon: Icon(Icons.person))
        ],
      ),
      body: ListView.separated(
          // reverse: true,
          itemCount: sharedstorage.length,
          // itemExtent: 60,
          padding: const EdgeInsets.all(20),
          separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
          itemBuilder: (context, index) {
            var sd = json.decode(sharedstorage[index]);

            return ListTile(
              shape: const RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              title: Text("${sd["Task"]}"),

              subtitle: Text("${sd["Dropdown"]} ${sd["Time"]} "),

              leading: const Icon(Icons.add_task_rounded),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => {deleteData(index)},
              ),

              // tileColor: ,
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Map todotask = await showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => const DialogTodo());
          if (todotask['Changed'] == true) {
            setState(() {
              // data.add(todotask);
              setdata(todotask);
              getdata();
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
