import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../logic/provider/todos.dart';
import 'features/add_to_do.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  void askAboutDelete({required int id, required Todos todos}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Notification"),
          content: const Text(
            "Are you sure delete this task?",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("CANCEL"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  todos.deleteTodo(index: id);
                });
                Navigator.of(context).pop();
              },
              child: const Text("DELETE"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final todos = Provider.of<Todos>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 300,
                color: const Color.fromRGBO(244, 194, 127, 1),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 3,
                                color: const Color.fromRGBO(217, 88, 82, 1),
                              ),
                            ),
                          ),
                          Container(
                            width: 85,
                            height: 85,
                            decoration: BoxDecoration(
                              color: Colors.amber.shade700,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.person_outline_outlined,
                              size: 70,
                              color: Colors.orange.shade900,
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        "Monica Gamage",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "@monicagamage",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(217, 88, 82, 1),
                        ),
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(247, 160, 45, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          "Log Out",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      textAlign: TextAlign.start,
                      "Tasks List",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 3,
                          color: const Color.fromRGBO(244, 194, 127, 1),
                        ),
                      ),
                      child: Center(
                        child: IconButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return AddToDo();
                              },
                            );
                          },
                          hoverColor: Colors.amber.shade100,
                          icon: const Icon(
                            Icons.add,
                            color: Color.fromRGBO(244, 194, 127, 1),
                            size: 30,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Container(
                width: 360,
                height: 380,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(2, 4), // soya yo'nalishi
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: todos.todoList.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.format_list_bulleted_rounded,
                              size: 100,
                            ),
                            Text(
                              "No Task",
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: todos.todoList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: IconButton(
                              onPressed: () {
                                setState(() {
                                  todos.todoList[index].isDone =
                                      !todos.todoList[index].isDone;
                                });
                              },
                              icon: !todos.todoList[index].isDone
                                  ? const Icon(
                                      Icons.circle_outlined,
                                    )
                                  : const Icon(
                                      Icons.check_circle_outline,
                                      color: Colors.green,
                                    ),
                            ),
                            title: Text(
                              todos.todoList[index].title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                decoration: !todos.todoList[index].isDone
                                    ? TextDecoration.none
                                    : TextDecoration.lineThrough,
                              ),
                            ),
                            subtitle: Text(
                              DateFormat("dd MMMM yyyy")
                                  .format(todos.todoList[index].date!),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                askAboutDelete(
                                  id: index,
                                  todos: todos,
                                );
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red.shade700,
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
