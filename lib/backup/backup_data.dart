import 'package:flutter/material.dart';

import 'back_restore.dart';

class BackupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Backup Data'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.backup,
              size: 100,
              color: Color.fromARGB(255, 42, 172, 17),
            ),
            SizedBox(height: 16),
            Text(
              'Create a backup of your data',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                backupDatabase();
              },
              child: Text(
                'Backup Now',
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                textStyle: TextStyle(color: Colors.white),
                backgroundColor: Color.fromARGB(255, 35, 165, 23),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
