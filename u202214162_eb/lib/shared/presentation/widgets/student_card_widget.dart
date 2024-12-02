import 'package:flutter/material.dart';
import 'package:u202214162_eb/core/app_constants.dart';

class StudentCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                AppConstants.STUDENT_PHOTO_URL,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name: ${AppConstants.STUDENT_NAME}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  'Student Code: ${AppConstants.STUDENT_CODE}',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 5),
                Text(
                  'API: ${AppConstants.getApiName(AppConstants.STUDENT_CODE)}',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}