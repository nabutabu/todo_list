import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/data/models/user_registration.dart';
import 'package:todo_list/data/provider/user_provider.dart';
import 'package:todo_list/data/remote/response.dart';
import 'package:todo_list/screens/register_children/add_age.dart';
import 'package:todo_list/screens/register_children/add_email_pass.dart';
import 'package:todo_list/screens/register_children/add_name.dart';
import 'package:todo_list/screens/register_children/add_profile_photo.dart';
import 'package:todo_list/util/constants.dart';
import 'package:todo_list/widgets/progress_hud.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = 'register_screen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final UserRegistration _userRegistration = UserRegistration();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final int _endScreenIndex = 3;
  int _currentScreenIndex = 0;
  bool _isLoading = false;
  late UserProvider _userProvider;

  @override
  void initState() {
    super.initState();
    _userProvider = Provider.of<UserProvider>(context, listen: false);
  }

  void registerUser() async {
    setState(() {
      _isLoading = true;
    });

    await _userProvider
        .registerUser(_userRegistration, _scaffoldKey)
        .then((response) {
      if (response is Success) {
        Navigator.pop(context);
        Navigator.pushNamed(context, '/');
      }
      else {
        print('not successful');
      }
    });

    setState(() {
      _isLoading = false;
    });
  }

  void goBackPressed() {
    if (_currentScreenIndex == 0) {
      Navigator.pop(context);
      Navigator.pushNamed(context, '/start');
    } else {
      setState(() {
        _currentScreenIndex--;
      });
    }
  }

  Widget getSubScreen() {
    switch (_currentScreenIndex) {
      case 0:
        return NameScreen(
            onChanged: (value) => {_userRegistration.name = value});
      case 1:
        return AgeScreen(
            onChanged: (value) => {_userRegistration.age = value.toInt()});
      case 2:
        return AddPhotoScreen(
            onPhotoChanged: (value) =>
            {_userRegistration.localProfilePhotoPath = value});
      case 3:
        return EmailAndPasswordScreen(
            emailOnChanged: (value) => {_userRegistration.email = value},
            passwordOnChanged: (value) => {_userRegistration.password = value});
      default:
        return Container();
    }
  }

  bool canContinueToNextSubScreen() {
    switch (_currentScreenIndex) {
      case 0:
        return (_userRegistration.name.length >= 2);
      case 1:
        return (_userRegistration.age >= 13 && _userRegistration.age <= 120);
      case 2:
        return _userRegistration.localProfilePhotoPath.isNotEmpty;
      default:
        return false;
    }
  }

  String getInvalidRegistrationMessage() {
    switch (_currentScreenIndex) {
      case 0:
        return "Name is too short";
      case 1:
        return "Invalid age";
      case 2:
        return "Invalid photo";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        appBar: AppBar(title: const Text('Register')),
        body: CustomModalProgressHUD(
          offset: const Offset(5.0, 5.0),
          inAsyncCall: _isLoading,
          child: Container(
            margin: const EdgeInsets.only(bottom: 40),
            child: Column(
              children: [
                Container(
                  child: LinearPercentIndicator(
                      lineHeight: 8,
                      percent: (_currentScreenIndex / _endScreenIndex),
                      progressColor: kAccentColor,
                      padding: EdgeInsets.zero),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      padding: kDefaultPadding.copyWith(
                          left: kDefaultPadding.left / 2.0,
                          right: 0.0,
                          bottom: 4.0,
                          top: 4.0),
                      child: IconButton(
                        padding: EdgeInsets.all(0.0),
                        icon: Icon(
                          _currentScreenIndex == 0
                              ? Icons.clear
                              : Icons.arrow_back,
                          color: kSecondaryColor,
                          size: 42.0,
                        ),
                        onPressed: () {
                          goBackPressed();
                        },
                      )),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Container(
                      width: double.infinity,
                      child: getSubScreen(),
                      padding: kDefaultPadding.copyWith(top: 0, bottom: 0)),
                ),
                Container(
                  padding: kDefaultPadding,
                  child: _currentScreenIndex == (_endScreenIndex)
                      ? ElevatedButton(
                          child: const Text('REGISTER'),
                          onPressed: _isLoading == false
                              ? () => {registerUser()}
                              : null)
                      : ElevatedButton(
                          child: const Text('CONTINUE'),
                          onPressed: () {
                            if (canContinueToNextSubScreen()) {
                              setState(() {
                                _currentScreenIndex++;
                              });
                            } else {
                              final snackBar = SnackBar(
                                content: Text(getInvalidRegistrationMessage()),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
