import 'package:fbissalama/utilities/assets.dart';
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(children: <Widget>[
      Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              AppAssets.backgroundLogin,
            ),
          ),
        ),
        height: size.height,
      ),
      Container(
        height: size.height,
        decoration: BoxDecoration(
            color: Colors.white,
            gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                Colors.black38,
                Colors.black.withOpacity(0.5),
                Colors.black38,
              ],
            )),
      ),
    ]);
  }
}
