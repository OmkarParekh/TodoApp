import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class emp {
  String Name;
  String SurName;
  int moblie;
  String dob;
  String gender;

  emp(this.Name, this.SurName, this.moblie, this.dob, this.gender);
}

class Employee extends StatefulWidget {
  const Employee({super.key});

  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  void initState() {
    super.initState();
    getdata();
  }

  void allclear() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Remove data for the 'counter' key.
    await prefs.remove('emp');
  }

  void setdata(data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? alltodo = prefs.getStringList('emp');
    if (alltodo == null) {
      prefs.setStringList("emp", []);
    } else {
      String encode = jsonEncode(data.toJson());
      alltodo.add(encode);
      prefs.setStringList("emp", alltodo);
    }
  }

  void getdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List? alltodos = prefs.getStringList("emp");
    if (alltodos == null) {
      prefs.setStringList("emp", []);
    } else {
      sharedstorage = alltodos;
      setState(() {});
    }
  }

  void deleteData(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? alltodo = prefs.getStringList('emp');
    if (alltodo == null) {
      prefs.setStringList("emp", []);
    } else {
      alltodo.removeAt(index);
      prefs.setStringList("emp", alltodo);
      getdata();
    }
  }

  List sharedstorage = [];
  @override
  Widget build(BuildContext context) {
    print(sharedstorage);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employees"),
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
              title: Text("${sd["Name"]} ${sd["SurName"]}"),
              subtitle: Text("${sd['dob']} ${sd["moblie"]} ${sd["gender"]} "),
              leading: const Icon(Icons.add_task_rounded),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => {deleteData(index)},
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          emp emp1 = emp("Omkar", "Parekh", 123456789, "28/08/2001", 'Male');
          setdata(emp1);
          getdata();

          // Map todotask = await showDialog(
          //     barrierDismissible: false,
          //     context: context,
          //     builder: (context) => const DialogTodo());
          // if (todotask['Changed'] == true) {
          //   setState(() {
          //     // data.add(todotask);
          //     setdata(todotask);
          //     getdata();
          //   });
          // }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
