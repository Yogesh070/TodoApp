import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/constants/contant.dart';
import 'package:todoapp/controllers/task_data_controller.dart';

class AddTaskScreen extends StatefulWidget {
  static const TextStyle subtitleStyle = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _priorityController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _priorityController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priorityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Add new Task',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: TextField(
              controller: _titleController,
              autofocus: true,
              cursorColor: Colors.white,
              maxLength: 50,
              style: TextStyle(fontSize: 24, color: Colors.white),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'What you need to do??',
                hintStyle: TextStyle(
                  fontSize: 20,
                  color: Color(0xffECE6E6),
                ),
              ),
              onChanged: (newVal) {},
            ),
          ),
          SizedBox(
            height: 32,
          ),
          Divider(
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'Description',
              style: AddTaskScreen.subtitleStyle,
            ),
          ),
          TextField(
            style: TextStyle(fontSize: 18, color: Colors.white),
            cursorColor: Colors.white,
            controller: _descriptionController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Description',
              hintStyle: TextStyle(
                fontSize: 20,
                color: Color(0xffECE6E6),
              ),
            ),
          ),
          SizedBox(
            height: 32,
          ),
          Text(
            'Priority',
            style: AddTaskScreen.subtitleStyle,
          ),
          Row(
            children: [
              PriorityCheckbox(
                title: 'High',
                priority: Priorites.high,
              ),
              PriorityCheckbox(
                title: 'medium',
                priority: Priorites.medium,
              ),
              PriorityCheckbox(
                title: 'Low',
                priority: Priorites.low,
              ),
              PriorityCheckbox(
                title: 'None',
                priority: Priorites.none,
              ),
            ],
          ),
          Align(
            child: SaveButton(
              onPressed: () {
                Provider.of<TaskData>(context, listen: false).addTask(
                    _titleController.text,
                    _descriptionController.text,
                    _priorityController.text);
                Navigator.pop(context);
              },
            ),
            alignment: Alignment.bottomRight,
          ),
        ],
      ),
    );
  }
}

class SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SaveButton({Key? key, required this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text('Save'),
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        ),
        backgroundColor: MaterialStateProperty.all(Colors.white),
        foregroundColor: MaterialStateProperty.all(kPrimaryColor),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}

enum Priorites { low, medium, high, none }

class PriorityCheckbox extends StatefulWidget {
  final String? title;
  final Priorites? priority;
  PriorityCheckbox({Key? key, required this.title, required this.priority})
      : super(key: key);

  @override
  _PriorityCheckboxState createState() => _PriorityCheckboxState();
}

class _PriorityCheckboxState extends State<PriorityCheckbox> {
  Priorites? _priority = Priorites.none;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
            fillColor: MaterialStateProperty.all(Colors.white),
            // toggleable: true,
            value: widget.priority!,
            groupValue: _priority,
            onChanged: (Priorites? newval) {
              setState(() {
                _priority = newval;
                // print(_priority);
              });
              print(_priority);
              print(widget.priority);
            }),
        // Checkbox(
        //   visualDensity: VisualDensity.compact,
        //   side: BorderSide(color: Colors.white),
        //   value: true,
        //   onChanged: (val) {},
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(20),
        //   ),
        // ),
        Text(
          widget.title!,
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
