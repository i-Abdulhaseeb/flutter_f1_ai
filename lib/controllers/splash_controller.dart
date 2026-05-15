import 'dart:async';
import 'package:get/get.dart';
import 'package:f1_flutter/routes/app_routes.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final RxDouble progress = 0.0.obs;
  final RxString statusLabel = 'LOADING TELEMETRY...'.obs;
  final RxString sector1Status = 'SYNC_OK'.obs;
  final RxString sector2Status = 'CALC_INIT'.obs;
  final RxString apiStatus = 'API: ONLINE'.obs;
  final RxBool pulseActive = true.obs;

  Timer? _progressTimer;
  Timer? _labelTimer;
  Timer? _navigationTimer;

  // Loading phases: progress checkpoints with status labels
  static const List<_LoadPhase> _phases = [
    _LoadPhase(
      target: 0.18,
      label: 'LOADING TELEMETRY...',
      s1: 'SYNC_OK',
      s2: 'CALC_INIT',
      api: 'API: ONLINE',
    ),
    _LoadPhase(
      target: 0.35,
      label: 'FETCHING RACE DATA...',
      s1: 'SYNC_OK',
      s2: 'CALC_LOAD',
      api: 'API: ONLINE',
    ),
    _LoadPhase(
      target: 0.55,
      label: 'PROCESSING SECTORS...',
      s1: 'SECTOR_OK',
      s2: 'PROC_RUN',
      api: 'API: ONLINE',
    ),
    _LoadPhase(
      target: 0.72,
      label: 'CALIBRATING MODEL...',
      s1: 'CALIB_RUN',
      s2: 'MODEL_INIT',
      api: 'API: ONLINE',
    ),
    _LoadPhase(
      target: 0.84,
      label: 'SYNCING STRATEGY...',
      s1: 'STRAT_SYNC',
      s2: 'DELTA_CALC',
      api: 'API: ONLINE',
    ),
    _LoadPhase(
      target: 1.00,
      label: 'READY.',
      s1: 'ALL_OK',
      s2: 'COMPLETE',
      api: 'API: ONLINE',
    ),
  ];

  int _currentPhase = 0;

  @override
  void onReady() {
    super.onReady();
    _startLoading();
  }

  @override
  void onClose() {
    _progressTimer?.cancel();
    _labelTimer?.cancel();
    _navigationTimer?.cancel();
    super.onClose();
  }

  void _startLoading() {
    const tickInterval = Duration(milliseconds: 30);
    _progressTimer = Timer.periodic(tickInterval, (timer) {
      if (_currentPhase >= _phases.length) {
        timer.cancel();
        return;
      }

      final phase = _phases[_currentPhase];
      final target = phase.target;
      final step = 0.004 + (progress.value < 0.5 ? 0.003 : 0.001);

      if (progress.value < target) {
        progress.value = (progress.value + step).clamp(0.0, target);
      } else {
        statusLabel.value = phase.label;
        sector1Status.value = phase.s1;
        sector2Status.value = phase.s2;
        apiStatus.value = phase.api;
        _currentPhase++;
      }

      if (progress.value >= 1.0) {
        timer.cancel();
        _navigationTimer = Timer(const Duration(milliseconds: 600), () {
          Get.offNamed(AppRoutes.home);
        });
      }
    });
  }

  String get progressPercent => '${(progress.value * 100).round()}%';
}

class _LoadPhase {
  final double target;
  final String label;
  final String s1;
  final String s2;
  final String api;
  const _LoadPhase({
    required this.target,
    required this.label,
    required this.s1,
    required this.s2,
    required this.api,
  });
}
