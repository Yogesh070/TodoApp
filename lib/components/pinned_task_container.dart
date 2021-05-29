import 'package:flutter/material.dart';
import 'package:todoapp/components/task_tile.dart';
import 'package:todoapp/constants/contant.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/controllers/home_controller.dart';
import 'package:todoapp/controllers/task_data_controller.dart';

class PinnedTaskContainer extends StatelessWidget {
  const PinnedTaskContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskController, child) => Expanded(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Container(
                    height: 24,
                    width: 40,
                    child: Image.asset(
                      'assets/icon/pin.png',
                      color: kSecondaryColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'Pinned',
                      style: TextStyle(fontSize: 12, color: kPrimaryColor),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Provider.of<HomeCrontroller>(context).isListLayout
                  ? ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: taskController.pinnedTaskCount,
                      itemBuilder: (context, index) {
                        final task = taskController.pinnedTask[index];
                        return TaskTile(
                          task: task,
                        );
                      })
                  : GridView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: taskController.pinnedTaskCount,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing:
                            MediaQuery.of(context).size.width > 600 ? 30 : 16.0,
                      ),
                      itemBuilder: (context, index) {
                        final task = taskController.pinnedTask[index];
                        return TaskTile(
                          task: task,
                        );
                      }),
            ),
            taskController.taskCount > 0
                ? Divider(color: kPrimaryColor)
                : SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
