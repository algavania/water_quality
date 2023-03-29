import 'package:auto_route/auto_route.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../data/models/record_response_model.dart';
import '../common/shared_code.dart';
import '../routes/router.gr.dart';

class CardData extends StatefulWidget {
  const CardData({Key? key, required this.index, required this.list}) : super(key: key);
  final int index;
  final List<MeterData> list;

  @override
  State<CardData> createState() => _CardDataState();
}

class _CardDataState extends State<CardData> {
  @override
  Widget build(BuildContext context) {
    return _buildCardData(widget.index);
  }

  Widget _buildCardData(int index) {
    MeterData data = widget.list[index];
    String date = DateFormat('dd MMMM yyyy HH:mm').format(data.createdAt ?? DateTime.now());
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ExpandablePanel(
        header: Row(
          children: [
            Image.asset('assets/logo.png', height: 10.w, width: 10.w),
            SizedBox(width: 5.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Text('Water Quality Data ${index + 1}',
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold, fontSize: 13.sp)),
                ),
                Text(date, style: TextStyle(fontSize: 10.sp))
              ],
            )
          ],
        ),
        collapsed: const SizedBox.shrink(),
        expanded: Column(
          children: [
            SizedBox(height: 2.h),
            Row(
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
            SizedBox(height: 2.h),
            Row(
              children: [
                Expanded(flex: 3, child: Container()),
                Expanded(
                    flex: 2,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          AutoRouter.of(context).navigate(DetailRoute(data: data, list: widget.list));
                        },
                        child: const Text('Detail'))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
