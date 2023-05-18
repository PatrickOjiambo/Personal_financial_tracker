import 'package:flutter/material.dart';
import 'backup/database.dart';
import 'budget_beep/budget_beep.dart';

// ignore: must_be_immutable
class DashboardPage extends StatefulWidget {
  DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final quarterHeight = screenHeight / 3;
    final eighthHeight = screenHeight / 4;
    final thirdScreen = screenHeight / 6;
//This is the top row
    var top = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          text: const TextSpan(
            text: 'DashBoard',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontFamily: 'Roboto'),
          ),
        )
      ],
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
    );

//     var slider = LinearProgressIndicator(

//   value: totalAmount/targetAmount,
//   backgroundColor: Colors.grey[200],
//   valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),

// );




//This contains the two widgets that are side by side.
    var breakdown = Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              color: Color.fromARGB(255, 47, 48, 49)
            ),
            height: eighthHeight,
            
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
        
                Text('Income', style: TextStyle(color: Colors.white, fontSize: 18)),
                Icon(Icons.insert_chart_outlined_outlined, color: Color.fromARGB(255, 47, 153, 33)),
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
              color: Color.fromARGB(255, 47, 48, 49)
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Spending', style: TextStyle(color: Colors.white, fontSize: 18)),
                Icon(Icons.insert_chart_outlined_outlined, color: Color.fromARGB(255, 160, 16, 16)),
              ],
            ),
          ),
        ),
      ],
    );
   return Container(
  decoration: BoxDecoration(
    color: Color.fromARGB(255, 63, 61, 61),
    borderRadius: BorderRadius.circular(10.0), // Set border radius to 10 pixels
  ),
  child: Padding(
    padding: EdgeInsets.all(16.0), // Add 16 pixels of padding on all sides
    child: Column(
      children: [
        top,
        SizedBox(height: 16.0),
        overall,
        SizedBox(height: 16.0),
        breakdown,
      ],
    ),
  ),
);

  }
}

//Create another box to store the target amount.
//Update the UI to resemble SA App.
//Finish the documentation. Don't include screenshots.
