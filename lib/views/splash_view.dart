import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';
import 'package:f1_flutter/theme/app_theme.dart';

class _SplashDimens {
  final double sw;
  final double sh;

  const _SplashDimens({required this.sw, required this.sh});

  factory _SplashDimens.of(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return _SplashDimens(sw: size.width, sh: size.height);
  }

  double ws(double v) => v * sw / 390;
  double hs(double v) => v * sh / 844;
  double ms(double v) => v * (sw < sh ? sw : sh) / 390;

  // ── Spacing ────────────────────────────────────────────────────────────────
  double get edgeMargin => ws(20);
  double get footerBottom => hs(48);
  double get brandingGap => hs(16);
  double get subtitleGap => hs(8);
  double get sectorItemGap => ws(16);
  double get footerLabelBarGap => hs(8);
  double get footerBarSectorGap => hs(12);
  double get pulseDotGap => ws(8);

  // ── Icon & glow ────────────────────────────────────────────────────────────
  double get iconGlowSize => ms(120);
  double get iconSize => ms(80);

  // ── Corner bracket ─────────────────────────────────────────────────────────
  double get cornerSize => ms(32);
  double get cornerStroke => ms(1.5);

  // ── Progress bar ───────────────────────────────────────────────────────────
  double get progressBarH => hs(6);

  // ── Pulse dot ──────────────────────────────────────────────────────────────
  double get pulseDotSize => ms(6);

  // ── Typography ─────────────────────────────────────────────────────────────
  double get titleFontSize => ws(28);
  double get subtitleFontSize => ws(12);
  double get telemetryNumSize => ws(18);
  double get labelStatusSize => ws(12);
  double get sectorLabelSize => ws(8);
  double get sectorValueSize => ws(10);
  double get apiLabelSize => ws(10);
}

// ─────────────────────────────────────────────────────────────────────────────
// Root view
// ─────────────────────────────────────────────────────────────────────────────
class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final d = _SplashDimens.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          _BackgroundImage(),
          _RadialVignette(),
          _SpeedLines(),
          _CornerDecorations(d: d),
          _BrandingSection(d: d),
          _ProgressFooter(d: d),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Background Image
// ─────────────────────────────────────────────────────────────────────────────
class _BackgroundImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.30,
      child: ColorFiltered(
        colorFilter: const ColorFilter.matrix([
          0.33,
          0.59,
          0.11,
          0,
          0,
          0.33,
          0.59,
          0.11,
          0,
          0,
          0.33,
          0.59,
          0.11,
          0,
          0,
          0,
          0,
          0,
          1,
          0,
        ]),
        child: Image.asset(
          'assets/images/splash_screen_background.png',
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(color: Colors.black),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Radial Vignette
// ─────────────────────────────────────────────────────────────────────────────
class _RadialVignette extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 1.2,
          colors: [Colors.transparent, Color(0xCC000000)],
          stops: [0.0, 0.85],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Speed Lines
// ─────────────────────────────────────────────────────────────────────────────
class _SpeedLines extends StatelessWidget {
  static const List<_LineConfig> _lines = [
    _LineConfig(topFraction: 0.15, opacity: 0.30, angle: -0.087),
    _LineConfig(topFraction: 0.35, opacity: 0.10, angle: 0.052),
    _LineConfig(topFraction: 0.55, opacity: 0.40, angle: -0.035),
    _LineConfig(topFraction: 0.80, opacity: 0.20, angle: 0.070),
  ];

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        painter: _SpeedLinePainter(_lines),
        size: Size.infinite,
      ),
    );
  }
}

class _LineConfig {
  final double topFraction;
  final double opacity;
  final double angle;
  const _LineConfig({
    required this.topFraction,
    required this.opacity,
    required this.angle,
  });
}

class _SpeedLinePainter extends CustomPainter {
  final List<_LineConfig> lines;
  _SpeedLinePainter(this.lines);

  @override
  void paint(Canvas canvas, Size size) {
    for (final line in lines) {
      final y = size.height * line.topFraction;
      final paint = Paint()
        ..shader = LinearGradient(
          colors: [
            Colors.transparent,
            const Color(0xFFE10600).withOpacity(line.opacity),
            Colors.transparent,
          ],
        ).createShader(Rect.fromLTWH(0, y - 0.5, size.width, 1))
        ..strokeWidth = 1.0
        ..style = PaintingStyle.stroke;

      canvas.save();
      canvas.translate(0, y);
      canvas.rotate(line.angle);
      canvas.drawLine(Offset.zero, Offset(size.width, 0), paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─────────────────────────────────────────────────────────────────────────────
// Corner Decorations
// ─────────────────────────────────────────────────────────────────────────────
class _CornerDecorations extends StatelessWidget {
  final _SplashDimens d;
  const _CornerDecorations({required this.d});

  @override
  Widget build(BuildContext context) {
    const color = Color(0x4DE10600);

    Widget bracket({required bool top, required bool left}) => _CornerBracket(
      color: color,
      size: d.cornerSize,
      strokeW: d.cornerStroke,
      top: top,
      left: left,
    );

    return Stack(
      children: [
        Positioned(
          top: d.edgeMargin,
          left: d.edgeMargin,
          child: bracket(top: true, left: true),
        ),
        Positioned(
          top: d.edgeMargin,
          right: d.edgeMargin,
          child: bracket(top: true, left: false),
        ),
        Positioned(
          bottom: d.edgeMargin,
          left: d.edgeMargin,
          child: bracket(top: false, left: true),
        ),
        Positioned(
          bottom: d.edgeMargin,
          right: d.edgeMargin,
          child: bracket(top: false, left: false),
        ),
      ],
    );
  }
}

class _CornerBracket extends StatelessWidget {
  final Color color;
  final double size;
  final double strokeW;
  final bool top;
  final bool left;

  const _CornerBracket({
    required this.color,
    required this.size,
    required this.strokeW,
    required this.top,
    required this.left,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _BracketPainter(
          color: color,
          strokeW: strokeW,
          top: top,
          left: left,
        ),
      ),
    );
  }
}

class _BracketPainter extends CustomPainter {
  final Color color;
  final double strokeW;
  final bool top;
  final bool left;

  _BracketPainter({
    required this.color,
    required this.strokeW,
    required this.top,
    required this.left,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeW
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

// ─────────────────────────────────────────────────────────────────────────────
// Central Branding
// ─────────────────────────────────────────────────────────────────────────────
class _BrandingSection extends GetView<SplashController> {
  final _SplashDimens d;
  const _BrandingSection({required this.d});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _GlowIcon(d: d),
          SizedBox(height: d.brandingGap),
          Text(
            'STRATEGY CONTROL',
            style: AppTheme.headlineMd.copyWith(fontSize: d.titleFontSize),
          ),
          SizedBox(height: d.subtitleGap),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _PulseDot(d: d),
              SizedBox(width: d.pulseDotGap),
              Text(
                'PREDICTIVE TELEMETRY',
                style: AppTheme.labelCaps.copyWith(
                  fontSize: d.subtitleFontSize,

                  letterSpacing: d.subtitleFontSize * 0.20,
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GlowIcon extends StatelessWidget {
  final _SplashDimens d;
  const _GlowIcon({required this.d});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: d.iconGlowSize,
          height: d.iconGlowSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppTheme.primaryContainer.withOpacity(0.15),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFE10600).withOpacity(0.25),
                blurRadius: d.iconGlowSize * 0.33,
                spreadRadius: d.iconGlowSize * 0.17,
              ),
            ],
          ),
        ),
        Icon(
          Icons.leaderboard_rounded,
          size: d.iconSize,
          color: AppTheme.primaryContainer,
          shadows: const [Shadow(color: Color(0x99E10600), blurRadius: 24)],
        ),
      ],
    );
  }
}

class _PulseDot extends StatefulWidget {
  final _SplashDimens d;
  const _PulseDot({required this.d});

  @override
  State<_PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<_PulseDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _anim;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _scale = Tween<double>(
      begin: 0.6,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _anim, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sz = widget.d.pulseDotSize;
    return ScaleTransition(
      scale: _scale,
      child: Container(
        width: sz,
        height: sz,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppTheme.primaryContainer,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFE10600).withOpacity(0.8),
              blurRadius: sz * 1.3,
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Progress Footer
// ─────────────────────────────────────────────────────────────────────────────
class _ProgressFooter extends GetView<SplashController> {
  final _SplashDimens d;
  const _ProgressFooter({required this.d});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: d.footerBottom,
      left: d.edgeMargin,
      right: d.edgeMargin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Status label + percentage ──────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Obx(
                () => Text(
                  controller.statusLabel.value,
                  style: AppTheme.labelCaps.copyWith(
                    fontSize: d.labelStatusSize,
                    letterSpacing: d.labelStatusSize * 0.15,
                    color: AppTheme.onSurfaceVariant.withOpacity(0.80),
                  ),
                ),
              ),
              Obx(
                () => Text(
                  controller.progressPercent,
                  style: AppTheme.telemetryNum.copyWith(
                    fontSize: d.telemetryNumSize,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: d.footerLabelBarGap),

          // ── Progress bar ──────────────────────────────────────────────────
          Obx(
            () => _AnimatedProgressBar(
              value: controller.progress.value,
              barHeight: d.progressBarH,
            ),
          ),
          SizedBox(height: d.footerBarSectorGap),

          // ── Sector data + API status ──────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _TelemetryItem(
                    label: 'Sector 1',
                    valueObs: controller.sector1Status,
                    labelSize: d.sectorLabelSize,
                    valueSize: d.sectorValueSize,
                  ),
                  SizedBox(width: d.sectorItemGap),
                  _TelemetryItem(
                    label: 'Sector 2',
                    valueObs: controller.sector2Status,
                    labelSize: d.sectorLabelSize,
                    valueSize: d.sectorValueSize,
                  ),
                ],
              ),
              Obx(
                () => Text(
                  controller.apiStatus.value,
                  style: AppTheme.labelCaps.copyWith(
                    fontSize: d.apiLabelSize,
                    color: AppTheme.primary,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Animated Progress Bar
// ─────────────────────────────────────────────────────────────────────────────
class _AnimatedProgressBar extends StatelessWidget {
  final double value;
  final double barHeight;

  const _AnimatedProgressBar({required this.value, required this.barHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: barHeight,
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(99),
        child: Stack(
          children: [
            // Filled portion
            AnimatedFractionallySizedBox(
              duration: const Duration(milliseconds: 120),
              curve: Curves.easeOut,
              widthFactor: value,
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.primaryContainer,
                  borderRadius: BorderRadius.circular(99),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFE10600).withOpacity(0.5),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
            ),
            // Shimmer
            LayoutBuilder(
              builder: (context, constraints) =>
                  _ShimmerOverlay(barWidth: constraints.maxWidth * value),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shimmer overlay
// ─────────────────────────────────────────────────────────────────────────────
class _ShimmerOverlay extends StatefulWidget {
  final double barWidth;
  const _ShimmerOverlay({required this.barWidth});

  @override
  State<_ShimmerOverlay> createState() => _ShimmerOverlayState();
}

class _ShimmerOverlayState extends State<_ShimmerOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _anim;
  late final Animation<double> _slide;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
    _slide = Tween<double>(
      begin: -1,
      end: 2,
    ).animate(CurvedAnimation(parent: _anim, curve: Curves.linear));
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _slide,
      builder: (_, __) => Transform.translate(
        offset: Offset(_slide.value * 60, 0),
        child: Transform(
          transform: Matrix4.skewX(-0.2),
          child: Container(
            width: 40,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.white.withOpacity(0.3),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Telemetry item (Sector 1 / Sector 2)
// ─────────────────────────────────────────────────────────────────────────────
class _TelemetryItem extends StatelessWidget {
  final String label;
  final RxString valueObs;
  final double labelSize;
  final double valueSize;

  const _TelemetryItem({
    required this.label,
    required this.valueObs,
    required this.labelSize,
    required this.valueSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: AppTheme.labelCaps.copyWith(
            fontSize: labelSize,
            color: AppTheme.onSurfaceVariant.withOpacity(0.40),
          ),
        ),
        Obx(
          () => Text(
            valueObs.value,
            style: AppTheme.labelCaps.copyWith(
              fontSize: valueSize,
              color: AppTheme.onSurfaceVariant,
              fontStyle: FontStyle.normal,
            ),
          ),
        ),
      ],
    );
  }
}
