import 'package:flutter/material.dart';
import 'package:todoapp/Pages/todopage.dart';

class DialogTodo extends StatefulWidget {
  const DialogTodo({super.key});

  @override
  State<DialogTodo> createState() => _DialogTodoState();
}

class _DialogTodoState extends State<DialogTodo> {
  Map data = {"Task": "", "Time": "", "Dropdown": "AT HOME", "Changed": false};
  @override
  Widget build(BuildContext context) {
    List option = ["AT OFFICE", "AT HOME", "AWAY"];
    return AlertDialog(
      title: const Text("Add Task"),
      content: const Text("Add the Task for the List"),
      actions: [
        TextFormField(
          decoration: const InputDecoration(hintText: "Task"),
          onChanged: (value) => {
            setState(() {
              data["Task"] = value;
              data['Time'] =
                  "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}";
              data['Changed'] = true;
              // data = {
              //   "Task": value,
              //   "Time":
              //       "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}"
              // };
            })
          },
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            const Text("Location :- "),
            DropdownButton(
              value: data['Dropdown'],
              // value: Text(data['Dropdown']),
              items: option
                  .map<DropdownMenuItem<String>>(
                      (e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) => {
                setState(() {
                  data["Dropdown"] = value;
                })
              },
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context, data);
            },
            child: const Text("Add Task")),
      ],
    );
  }
}
