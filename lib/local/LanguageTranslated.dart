import 'package:flutter/cupertino.dart';

import 'AppLocalizations.dart';

String? getTransrlate (BuildContext context,String key){
  return AppLocalizations.of(context)?.translate(key);
}