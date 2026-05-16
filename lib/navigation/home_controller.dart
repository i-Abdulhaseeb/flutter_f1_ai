import 'dart:async';
import 'package:get/get.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  final RxString title = 'STRATEGY CONTROL'.obs;

  final RxInt selectedIndex = 0.obs;

  final RxDouble raceProgress = 0.0.obs;

  final RxDouble tyreDegS = 0.0.obs;
  final RxDouble tyreDegM = 0.0.obs;
  final RxDouble tyreDegH = 0.0.obs;
  final RxDouble sectorDelta = 0.0.obs;
  final RxDouble ersCharge = 0.0.obs;
  final RxInt brakeTemp = 0.obs;
  final RxString pitWindow = 'LAP 18–24'.obs;

  final RxDouble modelAccuracy = 0.0.obs;

  final RxDouble p1Probability = 0.0.obs;

  final RxBool recPulse = true.obs;

  Timer? _telemetryTimer;
  Timer? _rampTimer;

  static const double _targetTyreDegS = 12;
  static const double _targetTyreDegM = 18;
  static const double _targetTyreDegH = 4;
  static const double _targetSectorDelta = -0.142;
  static const double _targetErs = 88.4;
  static const int _targetBrakeTemp = 650;
  static const double _targetAccuracy = 94.2;
  static const double _targetP1 = 68.0;
  static const double _targetRaceProgress = 0.67;

  @override
  void onReady() {
    super.onReady();
    _animateIn();
    _startLiveTelemetry();
    _startRecPulse();
  }

  @override
  void onClose() {
    _telemetryTimer?.cancel();
    _rampTimer?.cancel();
    super.onClose();
  }

  void _animateIn() {
    const steps = 60;
    int tick = 0;
    _rampTimer = Timer.periodic(const Duration(milliseconds: 16), (t) {
      tick++;
      final f = tick / steps;
      final ease = _easeOut(f.clamp(0.0, 1.0));
      tyreDegS.value = _targetTyreDegS * ease;
      tyreDegM.value = _targetTyreDegM * ease;
      tyreDegH.value = _targetTyreDegH * ease;
      sectorDelta.value = _targetSectorDelta * ease;
      ersCharge.value = _targetErs * ease;
      brakeTemp.value = (_targetBrakeTemp * ease).round();
      modelAccuracy.value = _targetAccuracy * ease;
      p1Probability.value = _targetP1 * ease;
      raceProgress.value = _targetRaceProgress * ease;
      if (tick >= steps) t.cancel();
    });
  }

  void _startLiveTelemetry() {
    _telemetryTimer = Timer.periodic(const Duration(milliseconds: 220), (_) {
      tyreDegS.value = _jitter(_targetTyreDegS, 0.4);
      tyreDegM.value = _jitter(_targetTyreDegM, 0.5);
      tyreDegH.value = _jitter(_targetTyreDegH, 0.2);
      sectorDelta.value = _jitter(_targetSectorDelta, 0.003);
      ersCharge.value = _jitter(_targetErs, 0.3);
      brakeTemp.value = (_jitter(_targetBrakeTemp.toDouble(), 3)).round();
    });
  }

  void _startRecPulse() {
    Timer.periodic(const Duration(milliseconds: 900), (_) {
      recPulse.value = !recPulse.value;
    });
  }

  double _jitter(double base, double range) {
    final noise = (base * 0.001) * (DateTime.now().millisecond % 7 - 3);
    return (base + noise).clamp(base - range, base + range);
  }

  double _easeOut(double t) => 1 - (1 - t) * (1 - t);

  String get tyreDegDisplay =>
      'S: ${tyreDegS.value.round().toString().padLeft(2, '0')}% | '
      'M: ${tyreDegM.value.round().toString().padLeft(2, '0')}% | '
      'H: ${tyreDegH.value.round().toString().padLeft(2, '0')}%';

  String get sectorDeltaDisplay =>
      '${sectorDelta.value >= 0 ? '+' : ''}${sectorDelta.value.toStringAsFixed(3)}s';

  String get ersDisplay => '${ersCharge.value.toStringAsFixed(1)}%';

  String get brakeTempDisplay => '${brakeTemp.value}°C';

  String get accuracyDisplay => '${modelAccuracy.value.toStringAsFixed(1)}%';

  String get p1Display => 'P1 PROBABILITY: ${p1Probability.value.round()}%';
}
