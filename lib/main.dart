import 'package:flutter/material.dart';
import 'package:supply_chain_bolt/core/di/dependency_injection.dart';

import 'app.dart';
import 'core/di/dependency_injection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupGetIt();
  runApp(const SupplyChainApp());
}
