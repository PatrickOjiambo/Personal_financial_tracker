import 'package:spend/dashboard.dart';

import 'fetch_sms.dart';
import 'package:flutter/material.dart';
import 'my_drawer.dart';

import 'list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  MessageRetriever _retriever = MessageRetriever();

  @override
  void initState() {
    super.initState();
    _initAsync();
  }

  Future<void> _initAsync() async {
    _retriever.queryMessages(['MPESA', 'Omosh']).then((_) {
      return _retriever.analyzeMessages();
    }).then((_) {
      // Initialization is complete
    }).catchError((error) {
      // Handle initialization errors
    });
  }
  var currentPage = DrawerSections.dashboard;

  @override
  Widget build(BuildContext context) {
var container;
if (currentPage == DrawerSections.dashboard ) {
  container = DashboardPage();
} else if (currentPage == DrawerSections.transactions) {
  container = MessageListScreen();
}

// } else if (id == 3) {
//   currentPage = DrawerSections.events;
// } else if (id == 4) {
//   currentPage = DrawerSections.setting;
// } else if (id == 5) {
//   currentPage = DrawerSections.notifications;
// } else if (id == 6) {
//   currentPage = DrawerSections.sendFeedback;
// } else if (id == 7) {
//   currentPage = DrawerSections.privacy;
// }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: const Text("SpendSense"),
        ),
        body: container,
        drawer: Drawer(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  MyHeaderDrawer(),
                  MyDrawerList(),
                ],
              ),
            ),
          ),
        ));
  }

  // ignore: non_constant_identifier_names
  Widget MyDrawerList() {
    return Container(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        //Shows the list of menu drawer
          children: [
            menuItem(1, "Dashboard", Icons.dangerous_outlined,
                currentPage == DrawerSections.dashboard ? true : false),
            menuItem(2, "Transactions", Icons.monetization_on_outlined,
                currentPage == DrawerSections.transactions ? true : false),

          ]),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.dashboard;
            } else if (id == 2) {
              currentPage = DrawerSections.transactions;
            }
          });
        },
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(
                  child: Icon(
                    icon,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

enum DrawerSections {
  dashboard,
  transactions

}


