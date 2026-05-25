import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class SettingsTabView extends StatelessWidget {
  const SettingsTabView({super.key});

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
                      const Icon(Icons.settings_outlined, color: AppTheme.primary, size: 24),
                      const SizedBox(width: 8),
                      Text(
                        'SYSTEM CONTROL PANEL',
                        style: AppTheme.labelCaps.copyWith(
                          color: AppTheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Application Settings',
                    style: AppTheme.headlineMd.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Configure connection ports, security options, and layout preferences for the Strategy Control Node.',
                    style: AppTheme.bodySm.copyWith(color: AppTheme.onSurfaceVariant.withOpacity(0.8)),
                  ),
                  const SizedBox(height: 24),
                  _settingsToggle('Telemetry Sync', true),
                  const Divider(color: Colors.white10, height: 24),
                  _settingsToggle('Encryption Protocol', true),
                  const Divider(color: Colors.white10, height: 24),
                  _settingsToggle('Performance Overlay', false),
                  const Divider(color: Colors.white10, height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Node Identifier',
                        style: AppTheme.bodyLg.copyWith(color: Colors.white, fontSize: 14),
                      ),
                      Text(
                        'F1-NODE-JPN-01',
                        style: AppTheme.telemetryNum.copyWith(fontSize: 12, color: AppTheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _settingsToggle(String label, bool initialValue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTheme.bodyLg.copyWith(color: Colors.white, fontSize: 14),
        ),
        Switch(
          value: initialValue,
          onChanged: (_) {},
          activeColor: AppTheme.primaryContainer,
          activeTrackColor: AppTheme.primaryContainer.withOpacity(0.3),
          inactiveThumbColor: Colors.grey,
          inactiveTrackColor: Colors.white12,
        ),
      ],
    );
  }
}
