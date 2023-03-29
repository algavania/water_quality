import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../common/shared_code.dart';

class TopBarWidget extends StatelessWidget {
  const TopBarWidget({Key? key, this.isAvatar = false}) : super(key: key);
  final bool isAvatar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: SharedCode.defaultPadding, vertical: 2.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              AutoRouter.of(context).pop();
            },
            child: Row(
              children: [
                const Icon(Icons.chevron_left, color: Colors.white),
                Text(
                  AppLocalizations.of(context).back,
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp,
                      color: Colors.white),
                )
              ],
            ),
          ),
          const Spacer(),
          isAvatar ? CircleAvatar(backgroundColor: Colors.white, radius: 10.w,child: Container(),) : Image.asset('assets/logo-white.png', height: 10.w, width: 10.w),
        ],
      ),
    );
  }
}
