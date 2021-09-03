import 'package:flutter/material.dart';
import 'package:todo_list/util/constants.dart';
import 'package:todo_list/widgets/app_title.dart';

class StartScreen extends StatelessWidget {
  static const String id = 'start_screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: kDefaultPadding,
          child: Container(
            margin: const EdgeInsets.only(bottom: 40, top: 120),
            child: Column(
              children: [
                AppIconTitle(),
                Expanded(child: Container()),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Make To-Do lists and notes quickly',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                ElevatedButton(
                    child: const Text('CREATE ACCOUNT'),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/register');
                    }),
                const SizedBox(height: 20),
                ElevatedButton(
                  child: const Text('LOGIN'),
                  onPressed: () => Navigator.pushNamed(context, '/login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
