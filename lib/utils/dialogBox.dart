import 'package:flutter/material.dart';
import 'package:todo/utils/my_buttons.dart';

class Dialogbox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  Dialogbox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0),
      ),
      backgroundColor: Colors.white,
      content: SizedBox(
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Enter Your Task...',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Save Button
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: MyButton(text: 'Save', onPressed: onSave),
                ),

                // Cancel Button
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                  child: MyButton(text: 'Cancel', onPressed: onCancel),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
