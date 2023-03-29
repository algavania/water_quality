import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:water_quality/data/models/record_response_model.dart';

import '../../common/shared_code.dart';
import '../../widgets/top_bar_widget.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, required this.data, required this.list}) : super(key: key);
  final MeterData data;
  final List<MeterData> list;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final List<MeterData> _list = [];

  @override
  void initState() {
    _list.clear();
    for (var data in widget.list) {
      if (data.salinity != null) {
        _list.add(data);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: _buildMainBody(),
    );
  }

  Widget _buildMainBody() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                _buildTopWidget(),
                _buildCard(widget.data)
              ],
            ), _buildBody()],
        ),
      ),
    );
  }

  Widget _buildTopWidget() {
    String date = DateFormat('dd MMMM yyyy HH:mm')
        .format(widget.data.createdAt ?? DateTime.now());
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
                Image.asset('assets/logo.png', height: 15.w, width: 15.w),
                SizedBox(height: 1.h),
                Text(
                  'Water Quality',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp),
                ),
                SizedBox(height: 1.h),
                Text(
                  date,
                  style:
                      GoogleFonts.inter(color: Colors.white, fontSize: 12.sp),
                ),
                SizedBox(height: 9.h),
              ],
            ),
          ),
          const TopBarWidget(),
        ],
      ),
    );
  }

  Widget _buildCard(MeterData data) {
    return Container(
      margin: EdgeInsets.only(top: 28.h, left: 20, right: 20),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 22),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(14)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SharedCode.buildTextData('Keasaman', '${data.acidity ?? '-'}', 'ph'),
          SizedBox(width: 2.w),
          SharedCode.buildTextData('Oksigen', '${data.oxygen ?? '-'}', '%'),
          SizedBox(width: 2.w),
          SharedCode.buildTextData('Garam', '${data.salinity ?? '-'}', '%'),
          SizedBox(width: 2.w),
          SharedCode.buildTextData('Suhu', '${data.temperature ?? '-'}', 'C'),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 22),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(14)),
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context).analyticsData,
            style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 14.sp),
          ),
          SizedBox(height: 2.h),
          SfCartesianChart(
              tooltipBehavior: TooltipBehavior(enable: true),
              primaryXAxis: DateTimeAxis(),
              legend: Legend(isVisible: true, position: LegendPosition.bottom, iconBorderWidth: 15),
              series: <ChartSeries>[
                LineSeries<MeterData, DateTime>(
                    name: 'Keasaman',
                    color: Colors.green,
                    dataSource: _list,
                    xValueMapper: (MeterData data, _) => data.createdAt ?? DateTime.now(),
                    yValueMapper: (MeterData data, _) => data.acidity),
                LineSeries<MeterData, DateTime>(
                    name: 'Oksigen',
                    color: Colors.blue,
                    dataSource: _list,
                    xValueMapper: (MeterData data, _) => data.createdAt ?? DateTime.now(),
                    yValueMapper: (MeterData data, _) => data.oxygen),
                LineSeries<MeterData, DateTime>(
                    name: 'Garam',
                    color: Colors.greenAccent,
                    dataSource: _list,
                    xValueMapper: (MeterData data, _) => data.createdAt ?? DateTime.now(),
                    yValueMapper: (MeterData data, _) => data.salinity),
                LineSeries<MeterData, DateTime>(
                    name: 'Suhu',
                    color: Colors.grey[300],
                    dataSource: _list,
                    xValueMapper: (MeterData data, _) => data.createdAt ?? DateTime.now(),
                    yValueMapper: (MeterData data, _) => data.temperature),

              ]
          ),
        ],
      ),
    );
  }
}