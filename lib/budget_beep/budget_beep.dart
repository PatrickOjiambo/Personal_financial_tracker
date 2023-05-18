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
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
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
              Database.saveTargetAmount(double.parse(_targetValueController.text));
              NotificationService().showNotification(title: 'Budget Beep', body: 'Your spendings have surpassed ksh. $target');
            }),
          ],
        ),
      ),
    );
  }
}
