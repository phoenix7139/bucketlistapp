import 'package:flutter/material.dart';

import 'task.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  final List<Task> tasks = new List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                  color: Color(0xff5a348b),
                  gradient: LinearGradient(
                      colors: [Color(0xff00b3b3), Color(0xff00ffcc)],
                      begin: Alignment.centerLeft,
                      end: Alignment(-0.5, -2)),
                ),
                child: _myHeaderContent(),
              ),
            ),
            Positioned(
              top: 260.0,
              left: 18.0,
              child: Container(
                color: Colors.white,
                width: 380.0,
                height: MediaQuery.of(context).size.height / 1.5,
                child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, position) {
                      return Dismissible(
                        key: Key(tasks[position].toString()),
                        background: _myHiddenContainer(tasks[position].status),
                        child: _myListContainer(
                            tasks[position].taskname,
                            tasks[position].subtask,
                            tasks[position].tasktime,
                            tasks[position].status),
                  onDismissed: (direction) {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Deleted"),
                        duration: Duration(seconds: 1),)
                    );
                    if (tasks.contains(tasks.removeAt(position))) {
                      setState(() {
                        tasks.remove(tasks.removeAt(position));
                      });
                    }
                  },
                      );
                    }),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Colors.amber,
        foregroundColor: Color(0xffffffff),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                final taskval = TextEditingController();
                final subval = TextEditingController();
                final tasktime = TextEditingController();

                Color taskcolor;
             


                return AlertDialog(
                  title: Text('New Task'),
                  content: Container(
                    height: 250.0,
                    child: Column(
                      children: <Widget>[
                        Container(
                            child: TextField(
                          controller: subval,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Task Title',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        )),
                        Container(
                            child: TextField(
                          controller: taskval,
                          obscureText: false,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Task Description',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        )),
                        Container(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Task priority',),
                            new GestureDetector(
                              onTap: () {
                                taskcolor = Color(0xff080808);
                              },
                              child: Container(
                                width: 20.0,
                                height: 20.0,
                                color: Color(0xff080808),
                              ),
                            ),
                            new GestureDetector(
                              onTap: () {
                                taskcolor = Color(0xff404040);

                              },
                              child: Container(
                                width: 20.0,
                                height: 20.0,
                                color: Color(0xff404040),
                              ),
                            ),
                            new GestureDetector(
                              onTap: () {
                                taskcolor = Color(0xff888888);
                              },
                              child: Container(
                                width: 20.0,
                                height: 20.0,
                                color: Color(0xff888888),
                              ),
                            ),
                            new GestureDetector(
                              onTap: () {
                                taskcolor = Color(0xffC8C8C8);
                              },
                              child: Container(
                                width: 20.0,
                                height: 20.0,
                                color: Color(0xffC8C8C8),
                              ),
                            ),
                          ],
                        )),
                        Container(
                            child: TextField(
                          controller: tasktime,
                          obscureText: false,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Task Duration',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        )),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      color: Colors.amber,
                      child: Text('Add',
                          style: new TextStyle(color: Colors.white)),
                      onPressed: () {
                       if(taskval != null && taskcolor != null) 
                       {

                        setState(() {
                          tasks.add(new Task(taskval.text, subval.text,
                              tasktime.text, taskcolor));
                        });
                       }
                        
                        Navigator.pop(context);
                      },
                    )
                  ],
                );
              });
        },
        tooltip: 'Add item to bucketlist',
        child: new Icon(Icons.add),
      ),
    );
  }

  Widget _myHeaderContent() {
    return Align(
      child: ListTile(
        leading:
            Text('GLUG', style: TextStyle(fontSize: 50.0, color: Colors.amber)),
        title: Text('Bucket',
            style: TextStyle(fontSize: 34.0, color: Colors.white)),
        subtitle:
            Text('List', style: TextStyle(fontSize: 24.0, color: Colors.white)),
        trailing: Image.asset('assets/glug.jpg'),
      ),
    );
  }

  Widget _myHiddenContainer(Color taskColor) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: taskColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                  icon: Icon(Icons.ac_unit),
                  color: Colors.white,
                  onPressed: () {})),
          Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                  icon: Icon(Icons.ac_unit),
                  color: Colors.white,
                  onPressed: () {})),
        ],
      ),
    );
  }

  Widget _myListContainer(
      String taskName, String subTask, String taskTime, Color taskColor) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            height: 80.0 + ((taskName.length + subTask.length)/30)*20.0,
            child: Material(
              color: Colors.white,
              elevation: 14.0,
              shadowColor: Colors.grey,
              child: Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 80.0 + ((taskName.length + subTask.length)/30)*20.0,
                      width: 10.0,
                      color: taskColor,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  child: Text(taskName,
                                      style: TextStyle(
                                          fontSize: 24.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                )),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                child: Text(subTask,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.black,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Text(
                                taskTime,
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.black),
                              ),
                            )))
                  ],
                ),
              ),
            )));
  }
}
