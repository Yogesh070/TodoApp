import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todoapp/components/task_list_gridview.dart';
import 'package:todoapp/constants/contant.dart';
import 'package:todoapp/controllers/home_controller.dart';
import 'package:todoapp/screens/about.dart';
import 'package:todoapp/screens/add_task.dart';
import 'package:todoapp/components/task_list_listview.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/controllers/task_data_controller.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();

  final List categories = [
    'Tasks',
    'Notes',
    'Meetings',
  ];

  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      await Provider.of<TaskData>(context, listen: false)
          .getTodosFromSharedPreference();
    });
  }

  @override
  Widget build(BuildContext context) {
    List optionItems = Provider.of<HomeCrontroller>(context).optionItems;
    final List<PopupMenuItem> _popUpOptions = optionItems
        .map(
          (item) => PopupMenuItem(
            value: item,
            child: Text(item),
          ),
        )
        .toList();
    return Consumer2<TaskData, HomeCrontroller>(
      builder: (context, taskController, homecontroller, child) => SafeArea(
        child: Scaffold(
          key: _drawerKey,
          body: Container(
            margin: (MediaQuery.of(context).size.width > 600)
                ? EdgeInsets.symmetric(horizontal: 48)
                : EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: AppBar(drawerKey: _drawerKey),
                ),
                CategoryList(categories: categories),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        _drawerKey.currentState!.openDrawer();
                      },
                    ),
                    PopupMenuButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      itemBuilder: (context) => _popUpOptions,
                      onSelected: (val) {
                        if (val.toString() == 'Grid View' ||
                            val.toString() == 'List View') {
                          Provider.of<HomeCrontroller>(context, listen: false)
                              .changeLayout();
                          // print('change');
                        }
                        if (val.toString() == 'About') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AboutScreen(),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
                (taskController.pinnedTaskCount > 0 ||
                        taskController.taskCount > 0)
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          'Remaining Tasks (${taskController.taskCount + taskController.pinnedTaskCount})',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      )
                    : SizedBox.shrink(),
                (taskController.pinnedTaskCount > 0 ||
                        taskController.taskCount > 0)
                    ? Expanded(
                        child: homecontroller.isListLayout
                            ? TaskListView()
                            : TaskGridView(),
                      )
                    : Expanded(
                        child: Stack(
                          children: [
                            SvgPicture.asset(
                              'assets/images/homebackground.svg',
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                            ),
                            Container(
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 400, left: 48, right: 48),
                                child: Text(
                                  'Click the button on bottom right to create a todo',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
          drawer: Drawer(
            child: ListView(
              children: [
                DrawerHeader(
                  child: Text(
                    'Todozzz App',
                    style: TextStyle(color: kPrimaryColor),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.track_changes),
                  title: Text('dfs'),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('may 6'), Text('data')],
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AboutScreen()));
                    },
                    child: Text('About'))
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                ),
                enableDrag: true,
                backgroundColor: kPrimaryColor,
                context: context,
                builder: (context) => SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: AddTaskScreen(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  const CategoryList({
    Key? key,
    required this.categories,
  }) : super(key: key);

  final List categories;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: categories
            .map(
              (category) => MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  height: 40,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                  child: Center(
                    child: Text(
                      category,
                      style: TextStyle(color: kPrimaryColor),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class AppBar extends StatelessWidget {
  const AppBar({
    Key? key,
    required GlobalKey<ScaffoldState> drawerKey,
  })  : _drawerKey = drawerKey,
        super(key: key);

  final GlobalKey<ScaffoldState> _drawerKey;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            _drawerKey.currentState!.openDrawer();
          },
          icon: Icon(Icons.menu),
        ),
        Center(
          child: Text(
            'Todozzz',
            style: kHeaderText,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notifications,
            color: kSecondaryColor,
          ),
        )
      ],
    );
  }
}
