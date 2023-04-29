import 'package:flutter/material.dart';

class BudgetBeep extends StatefulWidget {
  @override
  _BudgetBeepState createState() => _BudgetBeepState();
}

class _BudgetBeepState extends State<BudgetBeep> {
  final _formKey = GlobalKey<FormState>();
  final _targetAmountController = TextEditingController();

  @override
  void dispose() {
    _targetAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _targetAmountController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a target amount';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'Target amount',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final targetAmount = double.parse(_targetAmountController.text);
                // Call the function to track the target amount here
              }
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}
