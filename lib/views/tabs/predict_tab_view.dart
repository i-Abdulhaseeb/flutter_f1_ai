import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class PredictTabView extends StatelessWidget {
  const PredictTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.sizeOf(context).width;
    final sh = MediaQuery.sizeOf(context).height;
    final margin = sw * 20 / 390;
    final headerH = sh * 56 / 844;
    final navH = sh * 64 / 844;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        top: headerH + margin,
        bottom: navH + margin,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: margin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xB3121212),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0x1AFFFFFF), width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.psychology_outlined, color: AppTheme.primary, size: 24),
                      const SizedBox(width: 8),
                      Text(
                        'PREDICTIVE ENGINE',
                        style: AppTheme.labelCaps.copyWith(
                          color: AppTheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Race Simulation Model',
                    style: AppTheme.headlineMd.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Configure telemetry parameters and run multi-agent Monte Carlo simulations to calculate real-time overtaking probabilities and tire wear predictions.',
                    style: AppTheme.bodySm.copyWith(color: AppTheme.onSurfaceVariant.withOpacity(0.8)),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.02),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white.withOpacity(0.05)),
                    ),
                    child: Column(
                      children: [
                        _parameterRow('Simulation Count', '10,000 runs'),
                        const Divider(color: Colors.white10, height: 16),
                        _parameterRow('Model Iteration', 'v4.8.2-alpha'),
                        const Divider(color: Colors.white10, height: 16),
                        _parameterRow('Confidence Threshold', '95.0%'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _parameterRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label.toUpperCase(),
          style: AppTheme.labelCaps.copyWith(fontSize: 10, color: AppTheme.onSurfaceVariant.withOpacity(0.5)),
        ),
        Text(
          value,
          style: AppTheme.telemetryNum.copyWith(fontSize: 12, color: Colors.white),
        ),
      ],
    );
  }
}
