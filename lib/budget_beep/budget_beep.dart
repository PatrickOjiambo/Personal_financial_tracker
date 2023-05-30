import 'package:flutter/material.dart';
import 'package:spend/budget_beep/notifi_service.dart';
import 'package:spend/reusable_widget/reusable_widget.dart';
import 'package:spend/backup/database.dart';

class BudgetBeep extends StatefulWidget {
  const BudgetBeep({super.key});

  @override
  State<BudgetBeep> createState() => _BudgetBeepState();
}

class _BudgetBeepState extends State<BudgetBeep> {
  final TextEditingController _targetValueController = TextEditingController();
  final target = Database.getTargetAmount();
  @override
  Widget build(BuildContext context) {
    var top = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          text: const TextSpan(
            text: 'Reminder',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 24, 124, 182),
                fontStyle: FontStyle.italic,
                fontFamily: 'Roboto'),
          ),
        ),
      ],
    );
    showAlertDialog(BuildContext context) {
      // set up the button
      Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Reminder set"),
        content:
            Text(" You will be alerted when your spendings reach Ksh.$target."),
        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
             const SizedBox(
              height: 20,
            ),
            top,
            const SizedBox(
              height: 20,
            ),
            reusableTextField1(
              "Enter the target amount",
              Icons.monetization_on,
              false,
              _targetValueController,
            ),
            const SizedBox(
              height: 20,
            ),
            reusableButton1(context, false, () {
              Database.saveTargetAmount(
                  double.parse(_targetValueController.text));
              showAlertDialog(context);
              NotificationService().showNotification(
                  title: 'Budget Beep',
                  body: 'Your spendings have surpassed ksh. $target');
            }),
          ],
        ),
      ),
    );
  }
}
