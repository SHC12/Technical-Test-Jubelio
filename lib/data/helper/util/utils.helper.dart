import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:technical_test/presentation/shared/custom_dlalog_widget.dart';

class UtilsHelper {
  String stringToRupiah(int value) {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0);
    String result = formatter.format(value);
    return result;
  }

  popUpMessage(var message, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => CustomDialogWidget(
              message: message,
            ));
  }
}
