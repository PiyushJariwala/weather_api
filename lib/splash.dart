import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    _navigtor();
    super.initState();
  }

  void _navigtor()
  async{
    await Future.delayed(Duration(seconds: 2),);
    Navigator.pushReplacementNamed(context, '/myscreen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.blue.shade400,
        child: Stack(
          children: [
            Center(
              child: FaIcon(
                FontAwesomeIcons.cloudSun,
                size: 150,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 250),
              child: Center(
                child: Text(
                  "Today\'s Weather",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
