import 'package:karee_core/karee_core.dart';
import 'package:flutter/material.dart';

@Screen('user_page')
class UserHomeScreen extends StatefulWidget {
  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  @override
  Widget build(BuildContext context) {
    print(
        '\n\n################\n#### Router into \nctx =  \nkaree_core ${KareeRouter.navigatorKey.currentState?.context}\n####################');
    return Scaffold(
        appBar: AppBar(
          title: Text('User Page'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              constraints: BoxConstraints(minHeight: 60),
              child: Wrap(
                  alignment: WrapAlignment.center,
                  children: ['Admin', 'Comptable', 'Dev', 'Visitor', 'Enseignant', 'CP', 'Architect']
                      .map((e) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: ElevatedButton(
                            onPressed: () => KareeRouter.goto('/users/${e.toLowerCase()}', parameter: e.toUpperCase()),
                            child: Text(e),
                          )))
                      .toList()),
            ),
            Expanded(
                child: RouterWidget(
              name: #userRouter,
            ))
          ],
        ));
  }
}
