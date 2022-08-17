import 'dart:io';

import 'package:relive_datalayer/relive_datalayer.dart';

void main(List<String> args) async {
  final ReliveDataLayer reliveDataLayer = ReliveDataLayer();
  final response = reliveDataLayer.upload(File(
    "bin/hello.txt",
  ));
  print(await response);
}
