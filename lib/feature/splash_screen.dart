import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shelter_super_app/app/assets/app_assets.dart';

class SplashScreen extends StatefulWidget {
  final Completer<int> initializationStatus;

  const SplashScreen({
    super.key,
    required this.initializationStatus,
  });

  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  late Image logoImage;

  @override
  void initState() {
    super.initState();
    logoImage = Image.asset(
      width: 220,
      AppAssets.ilLogo,
    );
  }

  @override
  void didChangeDependencies() {
    precacheImage(logoImage.image, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: ScreenUtilInit(
        child: Material(
          child: ColoredBox(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                logoImage,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
