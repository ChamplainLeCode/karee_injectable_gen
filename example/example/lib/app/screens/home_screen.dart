import 'package:karee_core/karee_core.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import '../entities/utils/Style.dart';
import 'package:flutter/material.dart';

/*
 * @Author Champlain Marius Bakop
 * @email champlainmarius20@gmail.com
 * @github ChamplainLeCode
 * 
 */

@Screen('home', isInitial: true)
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: Container(
        alignment: Alignment.center,
        color: Style.primaryColor.withOpacity(0.125),
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/karee.png', package: 'karee_core')),
            Text(
              'Another way to build Beatiful Application using Flutter with MVC',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w200),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text('Version: [ v2.0.0 ]'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (await launcher.canLaunch(KareeConstants.KAREE_GITHUB)) {
                  await launcher.launch(KareeConstants.KAREE_GITHUB);
                }
              },
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.primaries.first)),
              child: Text('Get\'s started'),
            )
          ],
        ),
      )),
    );
  }
}
