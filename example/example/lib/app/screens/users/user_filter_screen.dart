import 'package:example/core/core.dart';
import 'package:flutter/material.dart';

@Screen('user_filter')
class UserFilterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(KareeRouter.navigatorKey.currentContext!);

    return Container(
      child: Text(ModalRoute.of(context)?.settings.arguments?.toString() ?? ' No'),
    );
  }
}
