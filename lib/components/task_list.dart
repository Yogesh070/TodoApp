import 'package:flutter/material.dart';

class TaskLists extends StatelessWidget {
  final List task = [
    {
      'title': 'Complete task and o',
      'date': 'May 6',
      'priority': 'low',
    },
    {
      'title': 'Complete task and do work',
      'date': 'May 4',
      'priority': 'high',
    },
    {
      'title': 'Complete',
      'date': 'May 8',
      'priority': 'low',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: task.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: ListTile(
              minVerticalPadding: 16,
              tileColor: Colors.white,
              leading: Icon(Icons.track_changes),
              title: Text(task[index]['title']),
              trailing: Column(
                children: [
                  Text(task[index]['date']),
                  Text(task[index]['priority'])
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
