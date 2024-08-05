import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/blocs.dart';
import '../../models/model_todo.dart';

class SearchAndFilterTodo extends StatelessWidget {
  SearchAndFilterTodo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          decoration: const InputDecoration(
            hintText: 'Search todos...',
            border: InputBorder.none,
            filled: true,
            contentPadding: EdgeInsets.symmetric(vertical: 15),
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (String? newSearchTerm) {
            if (newSearchTerm != null) {
              context
                  .read<TodoSearchBloc>()
                  .add(setSearchTermEvent(newSearchTerm: newSearchTerm));
            }
          },
        ),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            filterButton(context, Filter.all),
            filterButton(context, Filter.pending),
            filterButton(context, Filter.completed),
          ],
        ),
      ],
    );
  }

  Widget filterButton(BuildContext context, Filter filter) {
    return TextButton(
      onPressed: () {
        context
            .read<TodoFilterBloc>()
            .add(ChangeFilterEvent(newFilter: filter));
      },
      child: Text(
        filter == Filter.all
            ? 'All'
            : filter == Filter.pending
            ? 'Pending'
            : 'Completed',
        style: TextStyle(
          fontSize: 18.0,
          color: textColor(context, filter),
        ),
      ),
    );
  }

  Color textColor(BuildContext context, Filter filter) {
    final currentFilter = context.watch<TodoFilterBloc>().state.filter;
    return currentFilter == filter ? Colors.blue : Colors.grey;
  }
}