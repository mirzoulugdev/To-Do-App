import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../logic/provider/todos.dart';

class AddToDo extends StatefulWidget {
  AddToDo({
    super.key,
  });

  @override
  State<AddToDo> createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
  final TextEditingController _todoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime? selectedDate;

  void selectDate(BuildContext context) {
    showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030, 12, 31),
    ).then(
      (value) {
        if (value != null) {
          setState(() {
            selectedDate = value;
          });
        } else {
          selectedDate == null;
        }
      },
    );
  }

  bool checkDate() {
    if (selectedDate == null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Notification"),
            content: const Text("Please select date!"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
      return false;
    } else {
      return true;
    }
  }

  bool _save() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final todos = Provider.of<Todos>(context);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          const SizedBox(height: 25),
          Form(
            key: _formKey,
            child: TextFormField(
              controller: _todoController,
              decoration: InputDecoration(
                labelText: "Write your task...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please write your task!";
                } else if (value.length < 6) {
                  return "Please write your task full format!";
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.topLeft,
            child: selectedDate != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      DateFormat("dd MMMM yyyy").format(selectedDate!),
                    ),
                  )
                : TextButton(
                    onPressed: () {
                      selectDate(context);
                    },
                    child: const Text("Select Date"),
                  ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (_save() && checkDate()) {
                    setState(() {
                      todos.addTodo(
                        title: _todoController.text.trim(),
                        date: selectedDate!,
                        isDone: false,
                      );
                    });
                    print("Save bo'ldi");
                    Navigator.of(context).pop();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "SAVE",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  "CANCEL",
                  style: TextStyle(
                    color: Colors.orange.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}



// 