import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:water_quality/app/common/shared_code.dart';
import 'package:water_quality/app/routes/router.gr.dart';
import 'package:water_quality/app/widgets/add_data_dialog.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:water_quality/app/widgets/card_data.dart';

import '../../../data/models/add_record_response_model.dart';
import '../../../data/models/record_response_model.dart';
import '../../blocs/blocs.dart';
import '../../common/color_values.dart';
import '../../repositories/repositories.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MeterData> _list = [];
  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      bottomNavigationBar: SharedCode.buildBottomButton(
          buttonText: AppLocalizations.of(context).addNew,
          onPressed: () async {
            var data = await showDialog(context: context, builder: (_) => const AddDataDialog());
            if (data is MeterData) {
              Future.delayed(Duration.zero, () {
                BlocProvider.of<MeterBloc>(_context).add(AddMeterEvent(data));
              });
            }
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

            if (state is AddMeterLoaded) {
              context.loaderOverlay.hide();
              Future.delayed(Duration.zero, () {
                SharedCode.showSnackBar(context, false, 'Data berhasil ditambahkan');
              });
              Data? modelData = state.model.data;
              MeterData data = MeterData(
                  createdAt: modelData?.createdAt,
                  salinity: modelData?.salinity,
                  oxygen: modelData?.oxygen,
                  acidity: modelData?.acidity,
                  temperature: modelData?.temperature);
              _list.add(data);
              return _buildMainBody();
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
                  _buildBody(),
                ],
              ),
            ),
          ],
        ),
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
                AppLocalizations.of(context).listNebulizer,
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

  Widget _buildTopWidget() {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50))),
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 2.h),
              Stack(
                children: [
                  ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(50)),
                      child: Image.asset('assets/nebulizer.png',
                          fit: BoxFit.cover, height: 35.h)),
                  Container(
                    margin: EdgeInsets.only(top: 18.h, left: 45.w),
                    padding: EdgeInsets.only(right: 3.w),
                    child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                          text: AppLocalizations.of(context).splashText,
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500),
                          children: [
                            TextSpan(
                              text: ' ${AppLocalizations.of(context).water}',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold),
                            ),
                            const TextSpan(text: '.')
                          ]),
                    ),
                  )
                ],
              ),
            ],
          ),
          _buildAppBar(),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: SharedCode.defaultPadding, vertical: 2.h),
      child: Row(
        children: [
          Image.asset('assets/logo-white.png', height: 10.w, width: 10.w),
          SizedBox(width: 4.w),
          Text(
            AppLocalizations.of(context).waterApp,
            style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 13.sp,
                color: Colors.white),
          ),
          const Spacer(),
          InkWell(
              onTap: () {
                AutoRouter.of(context).navigate(const ProfileRoute());
              },
              child: const CircleAvatar(backgroundColor: Colors.white)),
        ],
      ),
    );
  }
}
