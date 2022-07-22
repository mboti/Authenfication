import 'package:flutter/material.dart';

class Values {

  GlobalKey<FormState> getKey(String debug) {
    return GlobalKey<FormState>(debugLabel: debug);
  }
}