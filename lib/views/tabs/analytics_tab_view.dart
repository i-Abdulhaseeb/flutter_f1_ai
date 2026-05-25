import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/analytics_controller.dart';
import '../../theme/app_theme.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Dimensions helper
// ─────────────────────────────────────────────────────────────────────────────
class _D {
  final double sw, sh;
  const _D(this.sw, this.sh);
  factory _D.of(BuildContext ctx) {
    final s = MediaQuery.sizeOf(ctx);
    return _D(s.width, s.height);
  }
  double ws(double v) => v * sw / 390;
  double hs(double v) => v * sh / 844;
  double ms(double v) => v * (sw < sh ? sw : sh) / 390;

  double get margin => ws(20);
  double get gutter => ws(16);
  double get stackGap => ws(12);
  double get cardPad => ws(16);
  double get headerH => hs(56);
  double get navH => hs(64);
}

class AnalyticsTabView extends GetView<AnalyticsController> {
  const AnalyticsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final d = _D.of(context);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        top: d.headerH + d.gutter,
        bottom: d.navH + d.gutter,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: d.margin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _FilterControls(d: d),
            SizedBox(height: d.stackGap),
            _PerformanceVelocityCard(d: d),
            SizedBox(height: d.stackGap),
            _ConstructorAndEfficiencyGrid(d: d),
            SizedBox(height: d.stackGap),
            _InsightsGrid(d: d),
            SizedBox(height: d.stackGap),
            _NeuralInsightsCard(d: d),
            SizedBox(height: d.gutter),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Filter Controls
// ─────────────────────────────────────────────────────────────────────────────
class _FilterControls extends GetView<AnalyticsController> {
  final _D d;
  const _FilterControls({required this.d});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          // Season Selector
          Obx(
            () => PopupMenuButton<String>(
              color: const Color(0xFF2A2A2A),
              offset: const Offset(0, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              onSelected: controller.setSeason,
              itemBuilder: (context) => controller.seasons
                  .map(
                    (s) => PopupMenuItem(
                      value: s,
                      child: Text(
                        s,
                        style: AppTheme.labelCaps.copyWith(color: Colors.white),
                      ),
                    ),
                  )
                  .toList(),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: d.ws(16),
                  vertical: d.hs(8),
                ),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.event_rounded,
                      size: d.ws(14),
                      color: AppTheme.onSurfaceVariant,
                    ),
                    SizedBox(width: d.ws(8)),
                    Text(
                      'SEASON: ${controller.selectedSeason.value}',
                      style: AppTheme.labelCaps.copyWith(
                        fontSize: d.ws(11),
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: d.ws(4)),
                    Icon(
                      Icons.expand_more_rounded,
                      size: d.ws(14),
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: d.ws(10)),

          // Circuit Selector
          Obx(
            () => PopupMenuButton<String>(
              color: const Color(0xFF2A2A2A),
              offset: const Offset(0, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              onSelected: controller.setCircuit,
              itemBuilder: (context) => controller.circuits
                  .map(
                    (c) => PopupMenuItem(
                      value: c,
                      child: Text(
                        c,
                        style: AppTheme.labelCaps.copyWith(color: Colors.white),
                      ),
                    ),
                  )
                  .toList(),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: d.ws(16),
                  vertical: d.hs(8),
                ),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.map_rounded,
                      size: d.ws(14),
                      color: AppTheme.onSurfaceVariant,
                    ),
                    SizedBox(width: d.ws(8)),
                    Text(
                      'CIRCUIT: ${controller.selectedCircuit.value}',
                      style: AppTheme.labelCaps.copyWith(
                        fontSize: d.ws(11),
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: d.ws(4)),
                    Icon(
                      Icons.expand_more_rounded,
                      size: d.ws(14),
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: d.ws(10)),

          // Refine Button
          GestureDetector(
            onTap: () {
              // Can trigger refinement or simple splash animation
              Get.snackbar(
                'Refine Telemetry',
                'Recalibrating model parameters for ${controller.selectedCircuit.value}...',
                backgroundColor: AppTheme.primaryContainer.withOpacity(0.9),
                colorText: Colors.white,
                snackPosition: SnackPosition.TOP,
                duration: const Duration(seconds: 2),
                margin: const EdgeInsets.all(16),
                borderRadius: 8,
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: d.ws(16),
                vertical: d.hs(8),
              ),
              decoration: BoxDecoration(
                color: AppTheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(color: Color(0x4DE10600), blurRadius: 10),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.filter_list_rounded,
                    size: d.ws(14),
                    color: Colors.white,
                  ),
                  SizedBox(width: d.ws(8)),
                  Text(
                    'REFINE',
                    style: AppTheme.labelCaps.copyWith(
                      fontSize: d.ws(11),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Performance Velocity Line Chart Card
// ─────────────────────────────────────────────────────────────────────────────
class _PerformanceVelocityCard extends StatelessWidget {
  final _D d;
  const _PerformanceVelocityCard({required this.d});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(d.cardPad),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Performance Velocity',
                    style: AppTheme.headlineMd.copyWith(
                      color: Colors.white,
                      fontSize: d.ws(20),
                    ),
                  ),
                  SizedBox(height: d.hs(2)),
                  Text(
                    'Driver Performance over Season',
                    style: AppTheme.bodySm.copyWith(
                      color: AppTheme.onSurfaceVariant,
                      fontSize: d.ws(13),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '+4.2%',
                    style: AppTheme.telemetryNum.copyWith(
                      color: AppTheme.primary,
                      fontSize: d.ws(18),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'VS PREV PERIOD',
                    style: AppTheme.labelCaps.copyWith(
                      fontSize: d.ws(8.5),
                      color: AppTheme.onSurfaceVariant,
                      letterSpacing: d.ws(0.5),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: d.hs(16)),
          SizedBox(
            height: d.hs(150),
            child: CustomPaint(
              painter: _LineChartPainter(),
              size: Size.infinite,
            ),
          ),
          SizedBox(height: d.hs(10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: ['BHR', 'SAU', 'AUS', 'JPN', 'CHN', 'MIA']
                .map(
                  (label) => Text(
                    label,
                    style: AppTheme.labelCaps.copyWith(
                      fontSize: d.ws(10),
                      color: AppTheme.onSurfaceVariant.withOpacity(0.6),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // 1. Draw horizontal grids and Y axis labels
    final gridPaint = Paint()
      ..color = Colors.white.withOpacity(0.04)
      ..strokeWidth = 1.0;

    final double h = size.height;
    final double w = size.width;

    final yP1 = h * 0.20;
    final yP5 = h * 0.40;
    final yP10 = h * 0.60;
    final yP20 = h * 0.85;

    canvas.drawLine(Offset(0, yP1), Offset(w, yP1), gridPaint);
    canvas.drawLine(Offset(0, yP5), Offset(w, yP5), gridPaint);
    canvas.drawLine(Offset(0, yP10), Offset(w, yP10), gridPaint);
    canvas.drawLine(Offset(0, yP20), Offset(w, yP20), gridPaint);

    // Text rendering helper
    void drawText(String text, double yOffset) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: text,
          style: TextStyle(
            color: Colors.white.withOpacity(0.25),
            fontSize: 8.5,
            fontFamily: 'JetBrains Mono',
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(0, yOffset - 10));
    }

    drawText('P1', yP1);
    drawText('P5', yP5);
    drawText('P10', yP10);
    drawText('P20', yP20);

    double sx(double x) => x * w / 400;
    double sy(double y) => y * h / 100;

    final fillPath = Path()
      ..moveTo(sx(0), sy(80))
      ..quadraticBezierTo(sx(50), sy(70), sx(100), sy(85))
      ..quadraticBezierTo(sx(150), sy(100), sx(200), sy(40))
      ..quadraticBezierTo(sx(250), sy(-20), sx(300), sy(60))
      ..quadraticBezierTo(sx(350), sy(140), sx(400), sy(20))
      ..lineTo(sx(400), h)
      ..lineTo(sx(0), h)
      ..close();

    final fillGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        const Color(0xFFFFB4A8).withOpacity(0.22),
        const Color(0xFFFFB4A8).withOpacity(0.0),
      ],
    );

    final fillPaint = Paint()
      ..shader = fillGradient.createShader(Rect.fromLTWH(0, 0, w, h))
      ..style = PaintingStyle.fill;

    canvas.drawPath(fillPath, fillPaint);

    final strokePath = Path()
      ..moveTo(sx(0), sy(80))
      ..quadraticBezierTo(sx(50), sy(70), sx(100), sy(85))
      ..quadraticBezierTo(sx(150), sy(100), sx(200), sy(40))
      ..quadraticBezierTo(sx(250), sy(-20), sx(300), sy(60))
      ..quadraticBezierTo(sx(350), sy(140), sx(400), sy(20));

    final strokePaint = Paint()
      ..color = const Color(0xFFE10600)
      ..strokeWidth = 2.2
      ..style = PaintingStyle.stroke;

    canvas.drawPath(strokePath, strokePaint);

    final dotPaint = Paint()..color = const Color(0xFFE10600);
    final dotGlow = Paint()
      ..color = const Color(0xFFE10600).withOpacity(0.4)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);

    canvas.drawCircle(Offset(sx(100), sy(85)), 6, dotGlow);
    canvas.drawCircle(Offset(sx(100), sy(85)), 3, dotPaint);

    canvas.drawCircle(Offset(sx(200), sy(40)), 3.2, dotPaint);

    canvas.drawCircle(Offset(sx(400), sy(20)), 8, dotGlow);
    canvas.drawCircle(Offset(sx(400), sy(20)), 4, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─────────────────────────────────────────────────────────────────────────────
// Constructor strategy accuracy list & Live Efficiency Card
// ─────────────────────────────────────────────────────────────────────────────
class _ConstructorAndEfficiencyGrid extends GetView<AnalyticsController> {
  final _D d;
  const _ConstructorAndEfficiencyGrid({required this.d});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Constructor Strategy Accuracy Card
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(d.cardPad),
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainer,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Constructor Strategy Accuracy'.toUpperCase(),
                    style: AppTheme.labelCaps.copyWith(
                      fontSize: d.ws(10),
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: d.ws(1.2),
                    ),
                  ),
                  Icon(
                    Icons.query_stats_rounded,
                    size: d.ws(16),
                    color: AppTheme.onSurfaceVariant,
                  ),
                ],
              ),
              SizedBox(height: d.hs(16)),
              _buildConstructorRow('RBR', controller.rbrAccuracy, isRbr: true),
              SizedBox(height: d.hs(12)),
              _buildConstructorRow('FER', controller.ferAccuracy),
              SizedBox(height: d.hs(12)),
              _buildConstructorRow('MCL', controller.mclAccuracy),
              SizedBox(height: d.hs(12)),
              _buildConstructorRow('MER', controller.merAccuracy),
            ],
          ),
        ),
        SizedBox(height: d.stackGap),

        // Live Efficiency Card
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(d.cardPad),
          decoration: BoxDecoration(
            color: AppTheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Color(0x33E10600),
                blurRadius: 15,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                right: -d.ws(10),
                top: -d.hs(15),
                child: Opacity(
                  opacity: 0.16,
                  child: Icon(
                    Icons.bolt_rounded,
                    size: d.ws(80),
                    color: Colors.white,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Live Efficiency'.toUpperCase(),
                    style: AppTheme.labelCaps.copyWith(
                      fontSize: d.ws(10.5),
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withOpacity(0.85),
                    ),
                  ),
                  SizedBox(height: d.hs(6)),
                  Obx(
                    () => Text(
                      '${controller.liveEfficiency.value}',
                      style: TextStyle(
                        fontFamily: 'SpaceGrotesk',
                        fontSize: d.ws(36),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.0,
                      ),
                    ),
                  ),
                  SizedBox(height: d.hs(16)),
                  Row(
                    children: [
                      Icon(
                        Icons.trending_up_rounded,
                        size: d.ws(13),
                        color: Colors.white,
                      ),
                      SizedBox(width: d.ws(4)),
                      Obx(
                        () => Text(
                          controller.efficiencyTrend.value,
                          style: AppTheme.bodySm.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: d.ws(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: d.hs(2)),
                  Text(
                    'System processing at peak delta.',
                    style: AppTheme.bodySm.copyWith(
                      color: Colors.white.withOpacity(0.70),
                      fontSize: d.ws(12),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildConstructorRow(
    String team,
    RxDouble progressObs, {
    bool isRbr = false,
  }) {
    return Row(
      children: [
        SizedBox(
          width: d.ws(44),
          child: Text(
            team,
            style: AppTheme.labelCaps.copyWith(
              fontSize: d.ws(10.5),
              color: AppTheme.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: d.hs(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(99),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) => Align(
                alignment: Alignment.centerLeft,
                child: Obx(() {
                  final pct = progressObs.value;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    width: constraints.maxWidth * pct,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: isRbr
                          ? AppTheme.primaryContainer
                          : AppTheme.primary.withOpacity(0.40),
                      borderRadius: BorderRadius.circular(99),
                      boxShadow: isRbr
                          ? [
                              const BoxShadow(
                                color: Color(0x99E10600),
                                blurRadius: 6,
                              ),
                            ]
                          : null,
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
        SizedBox(width: d.ws(12)),
        SizedBox(
          width: d.ws(32),
          child: Obx(
            () => Text(
              '${(progressObs.value * 100).round()}%',
              textAlign: TextAlign.right,
              style: AppTheme.telemetryNum.copyWith(
                fontSize: d.ws(11.5),
                color: Colors.white,
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Consistency & Pit stop driver/team cards
// ─────────────────────────────────────────────────────────────────────────────
class _InsightsGrid extends StatelessWidget {
  final _D d;
  const _InsightsGrid({required this.d});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Consistent Driver Card
        Expanded(
          child: Container(
            padding: EdgeInsets.all(d.cardPad),
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainer,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.verified_rounded,
                      size: d.ws(16),
                      color: AppTheme.primary,
                    ),
                    SizedBox(width: d.ws(6)),
                    Expanded(
                      child: Text(
                        'Consistency Peak'.toUpperCase(),
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme.labelCaps.copyWith(
                          fontSize: d.ws(9.5),
                          color: AppTheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: d.hs(10)),

                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: d.hs(90),
                    width: double.infinity,
                    color: Colors.black,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        ColorFiltered(
                          colorFilter: const ColorFilter.matrix([
                            0.2126,
                            0.7152,
                            0.0722,
                            0,
                            0,
                            0.2126,
                            0.7152,
                            0.0722,
                            0,
                            0,
                            0.2126,
                            0.7152,
                            0.0722,
                            0,
                            0,
                            0,
                            0,
                            0,
                            1,
                            0,
                          ]),
                          child: Opacity(
                            opacity: 0.65,
                            child: Image.asset(
                              'assets/images/verstappen_helmet.png',
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => const Center(
                                child: Icon(
                                  Icons.person_rounded,
                                  color: Colors.white24,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.8),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: d.hs(6),
                          left: d.ws(8),
                          child: Text(
                            'M. Verstappen',
                            style: AppTheme.labelCaps.copyWith(
                              fontFamily: 'SpaceGrotesk',
                              fontSize: d.ws(11),
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: d.hs(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '0.012s',
                          style: AppTheme.telemetryNum.copyWith(
                            fontSize: d.ws(17),
                            color: AppTheme.primary,
                          ),
                        ),
                        Text(
                          'LAP VARIANCE',
                          style: AppTheme.labelCaps.copyWith(
                            fontSize: d.ws(7.5),
                            color: AppTheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      size: d.ws(15),
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: d.stackGap),

        // Best Team Performance Card
        Expanded(
          child: Container(
            padding: EdgeInsets.all(d.cardPad),
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainer,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.groups_rounded,
                      size: d.ws(16),
                      color: AppTheme.primary,
                    ),
                    SizedBox(width: d.ws(6)),
                    Expanded(
                      child: Text(
                        'Pit Excellence'.toUpperCase(),
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme.labelCaps.copyWith(
                          fontSize: d.ws(9.5),
                          color: AppTheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: d.hs(10)),
                // Pit Grayscale image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: d.hs(90),
                    width: double.infinity,
                    color: Colors.black,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        ColorFiltered(
                          colorFilter: const ColorFilter.matrix([
                            0.2126,
                            0.7152,
                            0.0722,
                            0,
                            0,
                            0.2126,
                            0.7152,
                            0.0722,
                            0,
                            0,
                            0.2126,
                            0.7152,
                            0.0722,
                            0,
                            0,
                            0,
                            0,
                            0,
                            1,
                            0,
                          ]),
                          child: Opacity(
                            opacity: 0.65,
                            child: Image.asset(
                              'assets/images/red_bull_pit.png',
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => const Center(
                                child: Icon(
                                  Icons.garage_rounded,
                                  color: Colors.white24,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.8),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: d.hs(6),
                          left: d.ws(8),
                          child: Text(
                            'RED BULL RACING',
                            style: AppTheme.labelCaps.copyWith(
                              fontFamily: 'SpaceGrotesk',
                              fontSize: d.ws(11),
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: d.hs(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '1.82s',
                          style: AppTheme.telemetryNum.copyWith(
                            fontSize: d.ws(17),
                            color: AppTheme.primary,
                          ),
                        ),
                        Text(
                          'AVG. STOP TIME',
                          style: AppTheme.labelCaps.copyWith(
                            fontSize: d.ws(7.5),
                            color: AppTheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      size: d.ws(15),
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Advanced Metrics / Neural Insights Footer Card
// ─────────────────────────────────────────────────────────────────────────────
class _NeuralInsightsCard extends GetView<AnalyticsController> {
  final _D d;
  const _NeuralInsightsCard({required this.d});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(d.cardPad),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDim,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.05), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Neural Insights'.toUpperCase(),
            style: AppTheme.labelCaps.copyWith(
              fontSize: d.ws(10.5),
              fontWeight: FontWeight.w600,
              color: AppTheme.onSurfaceVariant,
              letterSpacing: d.ws(1.2),
            ),
          ),
          SizedBox(height: d.hs(12)),
          // Row 1
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: d.ws(10),
              vertical: d.hs(8),
            ),
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainerHighest.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: d.ws(3),
                      height: d.hs(26),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryContainer,
                        borderRadius: BorderRadius.circular(99),
                      ),
                    ),
                    SizedBox(width: d.ws(12)),
                    Text(
                      'Predictive Accuracy (Race Pace)',
                      style: AppTheme.bodySm.copyWith(
                        color: Colors.white,
                        fontSize: d.ws(12.5),
                      ),
                    ),
                  ],
                ),
                Obx(
                  () => Text(
                    controller.predictiveAccuracy.value,
                    style: AppTheme.telemetryNum.copyWith(
                      fontSize: d.ws(14),
                      color: AppTheme.primary,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: d.hs(8)),
          // Row 2
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: d.ws(10),
              vertical: d.hs(8),
            ),
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainerHighest.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: d.ws(3),
                      height: d.hs(26),
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withOpacity(0.20),
                        borderRadius: BorderRadius.circular(99),
                      ),
                    ),
                    SizedBox(width: d.ws(12)),
                    Text(
                      'Strategy Confidence Score',
                      style: AppTheme.bodySm.copyWith(
                        color: Colors.white,
                        fontSize: d.ws(12.5),
                      ),
                    ),
                  ],
                ),
                Obx(
                  () => Text(
                    controller.strategyConfidence.value,
                    style: AppTheme.telemetryNum.copyWith(
                      fontSize: d.ws(14),
                      color: AppTheme.onSurfaceVariant,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
