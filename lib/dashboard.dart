// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'backup/database.dart';

// ignore: must_be_immutable
class DashboardPage extends StatefulWidget {
  DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final target = Database.getTargetAmount();
  final spend = Database.getTotalCreditAmount();
  final inco = Database.getTotalDebitAmount();
  final total = Database.getTotalAmount();
  final absa = Database.getAbsaAmount();
  final mpesa = Database.getMpesaAmount();
  final equity = Database.getEquityAmount();
  final stanchart = Database.getStanchartAmount();
  late double progress2 = total / target;
  double progress = 0.5;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final quarterHeight = screenHeight / 3;
    final eighthHeight = screenHeight / 4;
    final thirdScreen = screenHeight / 8;
//This is the top row
    var top = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          text: const TextSpan(
            text: 'DashBoard',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 32, 123, 175),
                fontStyle: FontStyle.italic,
                fontFamily: 'Roboto'),
          ),
        )
      ],
    );

    //Below is the data for the overall widget
    var overdata = Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.0),
          Text(
            'Ksh. ${total}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            'Mpesa: Ksh.${mpesa}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            'Absa: Ksh.${absa}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            'Stanchart: Ksh.${stanchart}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            'Equity: Ksh.${equity}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
    //This is the biggest widget in the screen
    var overall = Container(
      height: quarterHeight,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.indigo, Colors.blue],
        ),
      ),
      child: Container(child: overdata),
    );

//This is the code for the slider
    // var slider = Container(
    //   height: thirdScreen,
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.all(Radius.circular(12.0)),
    //     gradient: LinearGradient(
    //       begin: Alignment.topLeft,
    //       end: Alignment.bottomRight,
    //       colors: [Colors.indigo, Colors.blue],
    //     ),
    //   ),

    // );
    // var inslider = ClipRRect(
    //     borderRadius: BorderRadius.all(Radius.circular(12.0)),
    //     child: LinearProgressIndicator(
    //       value: progress,
    //       backgroundColor: Colors.grey[300],
    //       valueColor: AlwaysStoppedAnimation<Color>(Colors.transparent),
    //     ),
    //   );

//This is data below the two widgets below
    var break1 = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(height: 8.0),
        Text('Income',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
        SizedBox(height: 8.0),
        Icon(Icons.bar_chart, color: Color.fromARGB(255, 47, 153, 33)),
        SizedBox(height: 8.0),
      ],
    );
    var break2 = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(height: 8.0),
        Text(
          'Spending',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 16.0,
        ),
        Icon(Icons.bubble_chart_sharp, color: Color.fromARGB(255, 160, 16, 16)),
        SizedBox(width: 8.0)
      ],
    );
    var income = Padding(
      padding: EdgeInsets.all(22.0),
      child: Text(
        '   ${inco}',
        style: TextStyle(
          color: Color.fromARGB(255, 23, 139, 23),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    var spending = Padding(
      padding: EdgeInsets.fromLTRB(16.0, 22.0, 16.0, 16.0),
      child: Text(
        '  ${spend}',
        style: TextStyle(
          color: Color.fromARGB(255, 182, 17, 17),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
//This contains the two widgets that are side by side.
    var breakdown = Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                color: Color.fromARGB(255, 208, 215, 221)),
            height: eighthHeight,
            child: Column(
              children: [
                break1,
                SizedBox(height: 22.0),
                income,
              ],
            ),
          ),
        ),
        SizedBox(width: 16.0),
        Expanded(
          flex: 1,
          child: Container(
            height: eighthHeight,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                color: Color.fromARGB(255, 200, 205, 211)),
            child: Column(
              children: [
                break2,
                SizedBox(height: 22.0),
                spending,
              ],
            ),
          ),
        ),
      ],
    );
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 223, 210, 210),
        borderRadius:
            BorderRadius.circular(10.0), // Set border radius to 10 pixels
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0), // Add 16 pixels of padding on all sides
        child: Column(
          children: [
            top,
            SizedBox(height: 16.0),
            overall,
            SizedBox(height: 16.0),
            // slider,
            // SizedBox(height: 16.0),
            breakdown,
          ],
        ),
      ),
    );
  }
}
