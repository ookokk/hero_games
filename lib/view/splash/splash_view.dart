import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hero_games_case/const/device_size.dart';

import 'splash_state/splash_state.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends SplashState<SplashView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            height: DeviceSize.kHeight(context) * 0.2,
            child: SvgPicture.asset('assets/register.svg'),
          ),
        )
      ],
    );
  }
}
