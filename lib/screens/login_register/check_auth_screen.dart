import 'package:barkibu/utils/utils.dart';
import 'package:flutter/material.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: TokenSecureStorage.readToken(),
          builder: (BuildContext build, AsyncSnapshot<String> snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();
            if (snapshot.data == '') {
              Future.microtask(() => SkipAnimation.pushReplacement(context, '/login_screen'));
            } else {
              Future.microtask(() => SkipAnimation.pushReplacement(context, '/selection_screen'));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
