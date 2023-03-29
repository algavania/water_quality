import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:water_quality/app/common/shared_code.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../common/color_values.dart';
import '../../routes/router.gr.dart';

class NoInternetPage extends StatefulWidget {
  const NoInternetPage({Key? key}) : super(key: key);

  @override
  State<NoInternetPage> createState() => _NoInternetPageState();
}

class _NoInternetPageState extends State<NoInternetPage> {

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      // AutoRouter.of(context).replace(const WelcomeRoute());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0, backgroundColor: Colors.white,),
      body: SafeArea(
        child: SizedBox(
          height: 100.h,
          width: 100.w,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(SharedCode.defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/logo.png',
                        height: 8.h,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(':"(', style: GoogleFonts.inter(fontSize: 40.sp, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),),
                    SizedBox(height: 2.h),
                    Text(AppLocalizations.of(context).noInternet, style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                    SizedBox(height: 2.h),
                    Text(AppLocalizations.of(context).noInternetText, style: GoogleFonts.inter(fontWeight: FontWeight.w500, color: ColorValues.darkGrey),),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                width: 100.w,
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                ),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(AppLocalizations.of(context).openSetting),
                    ),
                    SizedBox(height: 2.h),
                    TextButton(onPressed: () {
                      AutoRouter.of(context).replace(const HomeRoute());
                    }, child: Text(AppLocalizations.of(context).skip, style: const TextStyle(color: Colors.black),))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
