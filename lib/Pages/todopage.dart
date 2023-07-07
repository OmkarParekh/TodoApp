import 'package:flutter/material.dart';
import 'package:todoapp/Pages/dialog.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});
  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
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
      appBar: AppBar(title: const Text("TODO")),
      body: ListView.separated(
          // reverse: true,
          itemCount: data.length,
          // itemExtent: 60,
          padding: const EdgeInsets.all(20),
          separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
          itemBuilder: (context, index) {
            // int itemCount = data.length;
            // int indexrev = itemCount - 1 - index;
            return ListTile(
              shape: const RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              title: Text("${data[index]["Task"]}"),

              subtitle:
                  Text("${data[index]["Dropdown"]} ${data[index]["Time"]} "),

              leading: const Icon(Icons.add_task_rounded),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => {setState(() => data.removeAt(index))},
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
              data.add(todotask);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
      // body: Container(
      //   child: SingleChildScrollView(
      //       child: Container(
      //         child: Column(
      //                 children: [
      //         SizedBox(
      //           height: 300,
      //           child: ListView.builder(
      //             itemCount: 100,
      //             itemExtent: 100,
      //             itemBuilder: (context, index) => ListTile(
      //               title: Text("Data $index"),
      //             ),
      //           ),
      //         )
      //                 ],
      //               ),
      //       )),
      // ),
    );
  }
}
