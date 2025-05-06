import 'package:flutter/material.dart';
import 'app.dart';
import 'core/di/dependency_injection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setupGetIt();
  runApp(const SupplyChainApp());
}
