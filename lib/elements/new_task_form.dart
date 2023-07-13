import 'package:flutter/material.dart';
import 'package:to_do_app/elements/buttons.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow,
      content: Container(
        height: 120,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          // get task input
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Ajoutez une nouvelle tâche",
            ),
          ),

          // buttons save cancel
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // save button
              CustomButtons(text: "Ajouter", onPressed: onSave),

              const SizedBox(width: 8),

              // cancel button
              CustomButtons(text: "Annuler", onPressed: onCancel),
            ],
          )
        ]),
      ),
    );
  }
}
