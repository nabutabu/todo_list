import 'package:flutter/material.dart';

class NameScreen extends StatelessWidget {
  final Function(String) onChanged;

  NameScreen({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Column(
            children: [
              Text(
                'My first',
                style: Theme.of(context).textTheme.headline3,
              ),
              Text(
                'name is',
                style: Theme.of(context).textTheme.headline3,
              ),
            ],
          ),
        ),
        SizedBox(height: 25),
        Expanded(
          child: TextField(
            onChanged: onChanged,
            textCapitalization: TextCapitalization.words,
          ),
        ),
      ],
    );
  }
}
