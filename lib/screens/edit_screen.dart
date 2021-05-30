import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/constants/contant.dart';
import 'package:todoapp/controllers/task_data_controller.dart';
import 'package:todoapp/model/task_model.dart';

class EditTask extends StatefulWidget {
  final Task? selectedTask;
  EditTask({this.selectedTask});
  static const optionItems = ['Pin on top', 'Reminder', 'Delete'];

  @override
  _EditTaskState createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  late TextEditingController _titleController;

  late TextEditingController _descriptionController;

  late TextEditingController _priorityController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.selectedTask!.title);
    _descriptionController =
        TextEditingController(text: widget.selectedTask!.description);
    _priorityController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priorityController.dispose();
    super.dispose();
  }

  final List<PopupMenuItem> _popUpOptions = EditTask.optionItems
      .map(
        (item) => PopupMenuItem(
          value: item,
          child: Text(item),
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        iconTheme: IconThemeData(color: kPrimaryColor),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.share)),
          PopupMenuButton(
            itemBuilder: (context) => _popUpOptions,
            onSelected: (newval) {
              if (newval.toString().toLowerCase() == 'delete') {
                Provider.of<TaskData>(context, listen: false)
                    .deleteTask(widget.selectedTask!);
                Navigator.pop(context);
              }
            },
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              TextField(
                autofocus: false,
                maxLines: 2,
                maxLength: 50,
                controller: _titleController,
                style: TextStyle(fontSize: 24),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Title',
                  hintStyle: TextStyle(
                    fontSize: 20,
                    // color: Color(0xffECE6E6),
                  ),
                ),
              ),
              Divider(
                color: kPrimaryColor,
              ),
              TextField(
                maxLines: null,
                controller: _descriptionController,
                autofocus: false,
                style: TextStyle(fontSize: 18),
                cursorColor: Colors.white,
                // controller: _descriptionController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Description',
                  hintStyle: TextStyle(
                    fontSize: 20,
                    // color: Color(0xffECE6E6),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
