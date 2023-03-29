import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:water_quality/app/common/shared_code.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:water_quality/services/shared_preferences_service.dart';

import '../../common/color_values.dart';
import '../../routes/router.gr.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  bool _isLoggedIn = false;

  @override
  void initState() {
    _isLoggedIn = SharedPreferencesService.getMeterId() != null;
    if (_isLoggedIn) {
      Future.delayed(const Duration(seconds: 3), () {
        AutoRouter.of(context).navigate(const HomeRoute());
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorValues.primaryBlue,
      body: Container(
        height: 100.h,
        width: 100.w,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/splash-bg.png')
          )
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(SharedCode.defaultPadding),
              child: Column(
                children: [
                  SizedBox(height: 5.h),
                  Center(
                    child: Image.asset(
                      'assets/logo.png',
                      height: 8.h,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                        text: AppLocalizations.of(context).splashText,
                        style: GoogleFonts.inter(color: Colors.black, fontSize: 35.sp, fontWeight: FontWeight.w500),
                        children: [
                          TextSpan(
                            text: ' ${AppLocalizations.of(context).water}',
                            style: GoogleFonts.inter(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                          ),
                          const TextSpan(text: '.')
                        ]
                    ),
                  )
                ],
              ),
            ),
            if (!_isLoggedIn) const Spacer(),
            if (!_isLoggedIn) SharedCode.buildBottomButton(buttonText: AppLocalizations.of(context).gettingStarted, onPressed: () {
              AutoRouter.of(context).replace(const LoginRoute());
            }),
          ],
        ),
      ),
    );
  }
}
