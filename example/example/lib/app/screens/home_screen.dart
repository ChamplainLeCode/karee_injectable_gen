import 'package:example/app/entities/user.dart';
import 'package:karee_core/karee_core.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import '../entities/utils/Style.dart';
import 'package:flutter/material.dart' hide Page;
import 'package:example/app/entities/pageable.dart';

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
    var args = ModalRoute.of(context)?.settings.arguments;
    var users = args == null ? null : args as Future<Page<User>>;
    users?.then((page) {
      print('\n\n##############################');
      print(page);
      print('\n\n##############################');
    });
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
                // if (await launcher.canLaunch(KareeConstants.KAREE_GITHUB)) {
                //   await launcher.launch(KareeConstants.KAREE_GITHUB);
                // }
                KareeRouter.goto('/users', parameter: '20');
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
