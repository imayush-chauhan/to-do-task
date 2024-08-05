import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/blocs.dart';

class CreateTodo extends StatefulWidget {
  const CreateTodo({Key? key}) : super(key: key);

  @override
  _CreateTodoState createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  final TextEditingController newTodoController = TextEditingController();

  @override
  void dispose() {
    newTodoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15,bottom: 5),
      child: TextField(
        controller: newTodoController,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        onChanged: (_)=> setState((){}),
        decoration:  InputDecoration(
          labelText: 'Add New Task...',
          enabledBorder: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(),
          suffixIcon: TextButton(
              onPressed: newTodoController.text.isNotEmpty ? (){
                if (newTodoController.text.trim().isNotEmpty) {
                  context.read<TodoListBloc>().add(AddTodoEvent(newTodoController.text));
                  newTodoController.clear();
                  setState(() {});
                }
              } : null,
              child: const Text("Add"),
          )
        ),
        onSubmitted: (String? todoDesc) {
          if (todoDesc != null && todoDesc.trim().isNotEmpty) {
            context.read<TodoListBloc>().add(AddTodoEvent(todoDesc));
            newTodoController.clear();
          }
        },

      ),
    );
  }
}
