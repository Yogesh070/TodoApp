import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/constants/contant.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/controllers/home_controller.dart';
import 'package:todoapp/controllers/task_data_controller.dart';
import 'package:todoapp/model/task_model.dart';
import 'package:todoapp/screens/edit_screen.dart';

class TaskTile extends StatelessWidget {
  final Task? task;

  const TaskTile({
    Key? key,
    this.task,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    return Consumer2<HomeCrontroller, TaskData>(
        builder: (context, homeContoller, taskdata, child) {
      return Container(
        constraints: BoxConstraints(maxHeight: 100),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
            minLeadingWidth: mediaWidth > 600 ? 80 : 40,
            onLongPress: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context)
                                .removeCurrentSnackBar();
                            showCupertinoDialog(
                              barrierDismissible: true,
                              context: context,
                              builder: (_) => CupertinoAlertDialog(
                                title: Column(
                                  children: [
                                    Text(
                                      'Reminder',
                                      style: TextStyle(
                                          fontSize: 18, color: kPrimaryColor),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: Text(
                                        'Selected task will be deleted',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  CupertinoDialogAction(
                                    child: Text('Delete'),
                                    onPressed: () {
                                      taskdata.deleteTask(task!);
                                      Navigator.pop(context);
                                    },
                                  ),
                                  CupertinoDialogAction(
                                    child: Text('Cancel'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Text('Delete'),
                        ),
                      ),
                      Expanded(
                          child: task!.isPinned!
                              ? TextButton(
                                  onPressed: () {
                                    taskdata.unpinTask(task!);
                                    ScaffoldMessenger.of(context)
                                        .removeCurrentSnackBar();
                                  },
                                  child: Text('Unpin'),
                                )
                              : TextButton(
                                  onPressed: () {
                                    taskdata.pinTask(task!);
                                    ScaffoldMessenger.of(context)
                                        .removeCurrentSnackBar();
                                  },
                                  child: Text('Pin'),
                                )),
                    ],
                  ),
                ),
              );
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            contentPadding: homeContoller.isListLayout
                ? EdgeInsets.symmetric(horizontal: 16)
                : (homeContoller.isListLayout && mediaWidth > 600)
                    ? EdgeInsets.all(32)
                    : homeContoller.isGridLayout
                        ? EdgeInsets.symmetric(horizontal: 16)
                        : EdgeInsets.symmetric(horizontal: 0),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTask(
                    selectedTask: task,
                  ),
                ),
              );
            },
            minVerticalPadding: 24,
            tileColor: Colors.white,
            leading: Transform.scale(
              scale: 1.3,
              child: Checkbox(
                onChanged: (checkState) {
                  taskdata.updateTask(task!);
                },
                value: task!.isDone!,
                side: BorderSide(
                  width: 0.8,
                  color: kSecondaryColor,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                activeColor: kSecondaryColor,
              ),
            ),
            title: homeContoller.isGridLayout
                ? Wrap(
                    children: [
                      Text(task!.title!),
                      SizedBox(
                        width: 8,
                        // height: 8,
                      ),
                      _prorityContainer(task!.priority!)
                    ],
                  )
                : Text(task!.title!),
            horizontalTitleGap: 0,
            subtitle: homeContoller.isGridLayout
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(task!.description!),
                  )
                : SizedBox.shrink(),
            trailing: homeContoller.isListLayout
                ? Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    child: Column(
                      children: [
                        Expanded(
                            child: Text(
                                '${DateFormat.MMMd().format(task!.date!)}')),
                        (task!.priority!.toLowerCase() != 'none')
                            ? _prorityContainer(task!.priority!)
                            : SizedBox.shrink()
                      ],
                    ),
                  )
                : SizedBox.shrink()),
      );
    });
  }
}

Widget _prorityContainer(String priority) {
  priority = priority.toLowerCase();
  Color _prirorityColor(String priority) {
    return priority == 'priorites.low'
        ? Colors.green
        : priority == 'priorites.medium'
            ? Colors.orange.shade500
            : priority == 'priorites.high'
                ? Colors.red
                : Colors.black54;
  }

  return Container(
    height: 20,
    width: 48,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        // color: Color(0xffF7F7F7),
        color: _prirorityColor(priority)),
    child: Center(
        child: Text(
      priority == 'priorites.low'
          ? 'Low'
          : priority == 'priorites.medium'
              ? 'Med'
              : priority == 'priorites.high'
                  ? 'High'
                  : 'None',
      style: TextStyle(
        // color: _prirorityColor(priority),
        color: Color(0xffF7F7F7),
        fontSize: 10,
      ),
    )),
  );
}
