import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:f1_flutter/navigation/home_controller.dart';
import '../theme/app_theme.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(painter: _GridPainter()),

          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.leaderboard_rounded,
                  size: 64,
                  color: AppTheme.primaryContainer,
                  shadows: const [
                    Shadow(color: Color(0x99E10600), blurRadius: 20),
                  ],
                ),
                const SizedBox(height: 24),
                Obx(
                  () =>
                      Text(controller.title.value, style: AppTheme.headlineMd),
                ),
                const SizedBox(height: 12),
                Text(
                  'HOME SCREEN — PLACEHOLDER',
                  style: AppTheme.labelCaps.copyWith(
                    color: AppTheme.onSurfaceVariant.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 40),
                _StatusChip(label: 'TELEMETRY ACTIVE'),
                const SizedBox(height: 8),
                _StatusChip(label: 'STRATEGY ENGINE READY'),
              ],
            ),
          ),

          const Positioned(
            top: 20,
            left: 20,
            child: _CornerLine(top: true, left: true),
          ),
          const Positioned(
            top: 20,
            right: 20,
            child: _CornerLine(top: true, left: false),
          ),
          const Positioned(
            bottom: 20,
            left: 20,
            child: _CornerLine(top: false, left: true),
          ),
          const Positioned(
            bottom: 20,
            right: 20,
            child: _CornerLine(top: false, left: false),
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String label;
  const _StatusChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.primaryContainer.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(4),
        color: AppTheme.primaryContainer.withOpacity(0.08),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.primaryContainer,
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryContainer.withOpacity(0.8),
                  blurRadius: 6,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: AppTheme.labelCaps.copyWith(
              color: AppTheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _CornerLine extends StatelessWidget {
  final bool top;
  final bool left;
  const _CornerLine({required this.top, required this.left});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(28, 28),
      painter: _CornerPainter(top: top, left: left),
    );
  }
}

class _CornerPainter extends CustomPainter {
  final bool top;
  final bool left;
  _CornerPainter({required this.top, required this.left});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0x4DE10600)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final x = left ? 0.0 : size.width;
    final y = top ? 0.0 : size.height;
    final dx = left ? size.width : -size.width;
    final dy = top ? size.height : -size.height;

    canvas.drawLine(Offset(x, y), Offset(x + dx, y), paint);
    canvas.drawLine(Offset(x, y), Offset(x, y + dy), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE10600).withOpacity(0.04)
      ..strokeWidth = 0.5;

    const spacing = 40.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
