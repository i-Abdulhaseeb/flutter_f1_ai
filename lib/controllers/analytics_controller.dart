import 'dart:async';
import 'package:get/get.dart';

class AnalyticsController extends GetxController {
  final RxString selectedSeason = '2024'.obs;
  final RxString selectedCircuit = 'Suzuka'.obs;

  final List<String> seasons = const ['2024', '2023', '2022'];
  final List<String> circuits = const [
    'Suzuka',
    'Monaco',
    'Silverstone',
    'Spa',
    'Monza',
  ];

  // Constructor Accuracy
  final RxDouble rbrAccuracy = 0.94.obs;
  final RxDouble ferAccuracy = 0.82.obs;
  final RxDouble mclAccuracy = 0.88.obs;
  final RxDouble merAccuracy = 0.76.obs;

  // Live Efficiency
  final RxDouble liveEfficiency = 98.2.obs;
  final RxString efficiencyTrend = '+2.4 pts'.obs;

  // Insights & Side-by-side metrics
  final RxString lapVariance = '0.012s'.obs;
  final RxString avgStopTime = '1.82s'.obs;
  final RxString predictiveAccuracy = '99.1%'.obs;
  final RxString strategyConfidence = 'High'.obs;

  Timer? _telemetryTimer;

  @override
  void onInit() {
    super.onInit();
    _startLiveJitter();
  }

  @override
  void onClose() {
    _telemetryTimer?.cancel();
    super.onClose();
  }

  void _startLiveJitter() {
    _telemetryTimer = Timer.periodic(const Duration(milliseconds: 600), (_) {
      final effNoise = (DateTime.now().millisecond % 5 - 2) * 0.1;
      liveEfficiency.value = double.parse((98.2 + effNoise).toStringAsFixed(1));

      final rbrNoise = (DateTime.now().millisecond % 3 - 1) * 0.005;
      rbrAccuracy.value = (0.94 + rbrNoise).clamp(0.90, 0.98);

      final ferNoise = (DateTime.now().millisecond % 4 - 2) * 0.003;
      ferAccuracy.value = (0.82 + ferNoise).clamp(0.78, 0.86);

      final mclNoise = (DateTime.now().millisecond % 3 - 1) * 0.004;
      mclAccuracy.value = (0.88 + mclNoise).clamp(0.84, 0.92);

      final merNoise = (DateTime.now().millisecond % 5 - 2) * 0.002;
      merAccuracy.value = (0.76 + merNoise).clamp(0.72, 0.80);
    });
  }

  void setSeason(String season) {
    selectedSeason.value = season;
  }

  void setCircuit(String circuit) {
    selectedCircuit.value = circuit;
  }
}
