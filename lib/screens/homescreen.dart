import 'package:flutter/material.dart';
import 'package:todoapp/components/task_list.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _drawerKey,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      _drawerKey.currentState.openDrawer();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Remaining Tasks',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Expanded(
                child: TaskLists(),
              ),
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Text('data'),
              ),
              ListTile(
                leading: Icon(Icons.track_changes),
                title: Text('dfs'),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('may 6'), Text('data')],
                ),
              ),
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
          onPressed: () {},
        ),
      ),
    );
  }
}
