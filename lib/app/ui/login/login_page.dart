import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:water_quality/app/common/shared_code.dart';
import 'package:water_quality/app/widgets/custom_text_field.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../blocs/blocs.dart';
import '../../common/color_values.dart';
import '../../repositories/repositories.dart';
import '../../routes/router.gr.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
      ),
      body: BlocProvider(
        create: (context) =>
            MeterBloc(RepositoryProvider.of<MeterRepository>(context)),
        child: BlocBuilder<MeterBloc, MeterState>(
          builder: (context, state) {
            if (state is MeterInitial) {
              context.loaderOverlay.hide();
            }
            if (state is MeterLoading) {
              context.loaderOverlay.show();
            }
            if (state is MeterError) {
              context.loaderOverlay.hide();
              Future.delayed(Duration.zero, () {
                SharedCode.showSnackBar(context, true, state.error);
              });
            }
            if (state is MeterRetrieved) {
              Future.delayed(Duration.zero, () {
                context.loaderOverlay.hide();
                AutoRouter.of(context).navigate(const HomeRoute());
              });
            }

            return SafeArea(
              child: SizedBox(
                height: 100.h,
                width: 100.w,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(SharedCode.defaultPadding),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Image.asset(
                                'assets/logo.png',
                                height: 8.h,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Image.asset('assets/key.png',
                                height: 20.w, width: 20.w),
                            SizedBox(height: 2.h),
                            Text(
                              AppLocalizations.of(context).apiKeyAuth,
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold, fontSize: 18.sp),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              AppLocalizations.of(context).authText,
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  color: ColorValues.darkGrey),
                            ),
                            SizedBox(height: 5.h),
                            CustomTextField(
                              controller: _nameController,
                              validator: SharedCode.emptyValidator,
                              hintText:
                                  AppLocalizations.of(context).enterApiKey,
                              suffixIcon: const Icon(Icons.key,
                                  color: ColorValues.iconGrey),
                            ),
                            SizedBox(height: 2.h),
                            CustomTextField(
                              controller: _passwordController,
                              validator: SharedCode.emptyValidator,
                              maxLines: 1,
                              isPassword: true,
                              hintText:
                                  AppLocalizations.of(context).enterPassword,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    SharedCode.buildBottomButton(
                        buttonText: AppLocalizations.of(context).submit,
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            BlocProvider.of<MeterBloc>(context).add(
                                GetMeterIdEvent(_nameController.text,
                                    _passwordController.text));
                          }
                        }),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
