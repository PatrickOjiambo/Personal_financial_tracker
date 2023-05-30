import 'package:spend/backup/backup_data.dart';
import 'package:spend/budget_beep/budget_beep.dart';
import 'package:spend/dashboard.dart';
import 'package:spend/list.dart';
import 'mpesa.dart';
import 'absa.dart';
import 'stanchart.dart';
import 'equity.dart';
import 'fetch_sms.dart';
import 'package:flutter/material.dart';
import 'my_drawer.dart';

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
    _retriever.queryMessages(
        ['MPESA', 'Absa bank', 'Equity bank', 'StanChart']).then((_) {
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
    if (currentPage == DrawerSections.dashboard) {
      container = DashboardPage();
    } else if (currentPage == DrawerSections.transactions) {
      container = MessageListScreen();
    } else if (currentPage == DrawerSections.absabank) {
      container = AbsaListScreen();
    } else if (currentPage == DrawerSections.equity_bank) {
      container = EquityListScreen();
    } else if (currentPage == DrawerSections.mpesa) {
      container = MpesaListScreen();
    } else if (currentPage == DrawerSections.stanchart) {
      container = StanchartListScreen();
    } else if (currentPage == DrawerSections.backup_data) {
      container = BackupPage();
    } else if (currentPage == DrawerSections.budget_beep) {
      container = BudgetBeep();
    }

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
        backgroundColor: Colors.indigo,
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
      ),
    );
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
          menuItem(1, "Dashboard", Icons.dashboard,
              currentPage == DrawerSections.dashboard ? true : false),
          menuItem(2, "Transactions", Icons.monetization_on_outlined,
              currentPage == DrawerSections.transactions ? true : false),
          menuItem(6, "Mpesa", Icons.account_balance,
              currentPage == DrawerSections.mpesa ? true : false),
          menuItem(3, "Absa Bank", Icons.account_balance,
              currentPage == DrawerSections.absabank ? true : false),
          menuItem(4, "Equity Bank", Icons.account_balance,
              currentPage == DrawerSections.equity_bank ? true : false),
          menuItem(5, "Stanchart bank", Icons.account_balance,
              currentPage == DrawerSections.stanchart ? true : false),
          menuItem(7, "Backup data", Icons.backup,
              currentPage == DrawerSections.backup_data ? true : false),
          menuItem(8, "Budget Beep", Icons.account_balance_wallet,
              currentPage == DrawerSections.budget_beep ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(
            () {
              if (id == 1) {
                currentPage = DrawerSections.dashboard;
              } else if (id == 2) {
                currentPage = DrawerSections.transactions;
              } else if (id == 3) {
                currentPage = DrawerSections.absabank;
              } else if (id == 4) {
                currentPage = DrawerSections.equity_bank;
              } else if (id == 5) {
                currentPage = DrawerSections.stanchart;
              } else if (id == 6) {
                currentPage = DrawerSections.mpesa;
              } else if (id == 8) {
                currentPage = DrawerSections.budget_beep;
              } else {
                currentPage = DrawerSections.backup_data;
              }
            },
          );
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
          ),
        ),
      ),
    );
  }
}

enum DrawerSections {
  dashboard,
  transactions,
  mpesa,
  stanchart,
  equity_bank,
  absabank,
  backup_data,
  budget_beep
}
