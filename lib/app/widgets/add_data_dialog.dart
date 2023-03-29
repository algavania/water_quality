import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:water_quality/data/models/record_response_model.dart';

import '../common/color_values.dart';
import '../common/shared_code.dart';
import 'custom_text_field.dart';

class AddDataDialog extends StatefulWidget {
  const AddDataDialog({Key? key}) : super(key: key);

  @override
  State<AddDataDialog> createState() => _AddDataDialogState();
}

class _AddDataDialogState extends State<AddDataDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _acidityController = TextEditingController();
  final TextEditingController _salinityController = TextEditingController();
  final TextEditingController _oxygenController = TextEditingController();
  final TextEditingController _tempController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SharedCode.buildPopUp(
      context: context,
      child: AlertDialog(
        actionsPadding: EdgeInsets.fromLTRB(6.w, 0, 6.w, 3.h),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context).addNewData,
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold, fontSize: 16.sp)),
                SizedBox(height: 1.h),
                Text(
                  AppLocalizations.of(context).addDataText,
                  style: TextStyle(fontSize: 10.sp),
                ),
                SizedBox(height: 3.h),
                CustomTextField(
                  backgroundColor: ColorValues.lighterGrey,
                  label: 'Keasaman',
                  controller: _acidityController,
                  textInputType: TextInputType.number,
                  validator: SharedCode.emptyValidator,
                  hintText: AppLocalizations.of(context).hintText('acidity'),
                  isDense: true,
                ),
                SizedBox(height: 3.h),
                CustomTextField(
                  backgroundColor: ColorValues.lighterGrey,
                  label: 'Oksigen',
                  controller: _oxygenController,
                  textInputType: TextInputType.number,
                  validator: SharedCode.emptyValidator,
                  hintText: AppLocalizations.of(context).hintText('oxygen'),
                  isDense: true,
                ),
                SizedBox(height: 3.h),
                CustomTextField(
                  backgroundColor: ColorValues.lighterGrey,
                  label: 'Garam',
                  controller: _salinityController,
                  textInputType: TextInputType.number,
                  validator: SharedCode.emptyValidator,
                  hintText: AppLocalizations.of(context).hintText('salinity'),
                  isDense: true,
                ),
                SizedBox(height: 3.h),
                CustomTextField(
                  backgroundColor: ColorValues.lighterGrey,
                  label: 'Suhu',
                  controller: _tempController,
                  textInputType: TextInputType.number,
                  validator: SharedCode.emptyValidator,
                  hintText:
                      AppLocalizations.of(context).hintText('temperature'),
                  isDense: true,
                ),
              ],
            ),
          ),
        ),
        actions: [
          Row(
            children: [
              Expanded(
                  child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'))),
              SizedBox(width: 2.w),
              Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? true) {
                          MeterData data = MeterData(
                              createdAt: DateTime.now(),
                              acidity: double.tryParse(_acidityController.text),
                              oxygen: int.tryParse(_oxygenController.text),
                              temperature: int.tryParse(_tempController.text),
                              salinity: double.tryParse(_salinityController.text));
                          Navigator.pop(context, data);
                        }
                      },
                      child: const Text('Submit'))),
            ],
          ),
        ],
      ),
    );
  }
}
