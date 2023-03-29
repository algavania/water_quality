import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';
import 'package:water_quality/services/shared_preferences_service.dart';

import '../../../data/models/record_response_model.dart';
import '../../blocs/blocs.dart';
import '../../common/color_values.dart';
import '../../common/shared_code.dart';
import '../../repositories/repositories.dart';
import '../../routes/router.gr.dart';
import '../../widgets/card_data.dart';
import '../../widgets/top_bar_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<MeterData> _list = [];
  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      bottomNavigationBar: SharedCode.buildBottomButton(
          buttonText: AppLocalizations.of(context).logout,
          color: Colors.red,
          onPressed: () async {
            await SharedPreferencesService.clear();
            Future.delayed(Duration.zero, () {
              AutoRouter.of(context).pushAndPopUntil(const LoginRoute(),
                  predicate: (Route<dynamic> route) => false);
            });
          }),
      body: BlocProvider(
        create: (context) =>
        MeterBloc(RepositoryProvider.of<MeterRepository>(context))
          ..add(const GetAllRecordEvent()),
        child: BlocBuilder<MeterBloc, MeterState>(
          builder: (context, state) {
            _context = context;
            if (state is MeterLoading || state is MeterInitial) {
              context.loaderOverlay.show();
            }
            if (state is MeterError) {
              context.loaderOverlay.hide();
              Future.delayed(Duration.zero, () {
                SharedCode.showSnackBar(context, true, state.error);
              });
            }

            if (state is MeterLoaded) {
              context.loaderOverlay.hide();
              _list = state.model.data ?? [];
              return _buildMainBody();
            }

            return Container();
          },
        ),
      ),
    );
  }

  Future<void> _refreshPage() async {
    BlocProvider.of<MeterBloc>(_context).add(const GetAllRecordEvent());
  }

  Widget _buildMainBody() {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: _refreshPage,
        child: Stack(
          children: [
            ListView(),
            SingleChildScrollView(
              child: Column(
                children: [
                  _buildTopWidget(),
                  _buildBody()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopWidget() {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50))),
      child: Stack(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 8.h),
                CircleAvatar(backgroundColor: Colors.white, radius: 10.w, child: Container()),
                SizedBox(height: 1.h),
                Text('John Doe', style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16.sp),),
                SizedBox(height: 1.h),
                Text('john.doe@gmail.com', style: GoogleFonts.inter(color: Colors.white, fontSize: 12.sp),),
                SizedBox(height: 5.h),
              ],
            ),
          ),
          const TopBarWidget(),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SharedCode.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 3.h),
          Row(
            children: [
              Expanded(
                  child: Text(
                    AppLocalizations.of(context).myHistory,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                  )),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: ColorValues.grey,
                    borderRadius: BorderRadius.circular(6)),
                child: const Icon(Icons.sort_by_alpha),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (_, index) {
                return CardData(index: index, list: _list);
              },
              separatorBuilder: (_, __) => SizedBox(height: 3.h),
              itemCount: _list.length),
          SizedBox(height: 3.h),
        ],
      ),
    );
  }
}
