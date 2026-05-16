import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../navigation/home_controller.dart';
import '../theme/app_theme.dart';

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
  double get heroH => hs(192);
  double get navH => hs(64);
}

// ─────────────────────────────────────────────────────────────────────────────
// Root view
// ─────────────────────────────────────────────────────────────────────────────
class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final d = _D.of(context);

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
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
                    _HeroCard(d: d),
                    SizedBox(height: d.gutter),
                    _InfoCards(d: d),
                    SizedBox(height: d.gutter),
                    _TelemetrySection(d: d),
                    SizedBox(height: d.gutter * 1.5),
                    _StartPredictionButton(d: d),
                    SizedBox(height: d.gutter),
                    _EncryptedLabel(),
                    SizedBox(height: d.gutter),
                  ],
                ),
              ),
            ),
          ),

          Positioned(top: 0, left: 0, right: 0, child: _Header(d: d)),

          Positioned(bottom: 0, left: 0, right: 0, child: _BottomNav(d: d)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Header
// ─────────────────────────────────────────────────────────────────────────────
class _Header extends StatelessWidget {
  final _D d;
  const _Header({required this.d});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        height: d.headerH,
        decoration: BoxDecoration(
          color: AppTheme.background.withOpacity(0.85),
          border: const Border(
            bottom: BorderSide(color: Color(0x1AFFFFFF), width: 1),
          ),
          boxShadow: const [
            BoxShadow(color: Color(0x26E10600), blurRadius: 15),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: d.margin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.leaderboard_rounded,
                  color: AppTheme.primary,
                  size: 22,
                ),
                SizedBox(width: d.ws(8)),
                Text(
                  'STRATEGY CONTROL',
                  style: AppTheme.labelCaps.copyWith(
                    fontSize: d.ws(14),
                    color: AppTheme.onSurface,
                    fontWeight: FontWeight.w900,
                    letterSpacing: d.ws(1.5),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: d.ws(8),
                vertical: d.hs(4),
              ),
              decoration: BoxDecoration(
                color: AppTheme.primaryContainer.withOpacity(0.12),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'API: ONLINE',
                style: AppTheme.labelCaps.copyWith(
                  fontSize: d.ws(10),
                  color: AppTheme.primaryContainer,
                  fontWeight: FontWeight.w700,
                  letterSpacing: d.ws(1.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Hero / Mission Directive card
// ─────────────────────────────────────────────────────────────────────────────
class _HeroCard extends StatelessWidget {
  final _D d;
  const _HeroCard({required this.d});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: double.infinity,
        height: d.heroH,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ColorFiltered(
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
              child: Opacity(
                opacity: 0.45,
                child: Image.asset(
                  'assets/images/HOME_DASHBOARD_PNG.png',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      Container(color: const Color(0xFF1A0000)),
                ),
              ),
            ),

            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Color(0xFF131313)],
                  stops: [0.3, 1.0],
                ),
              ),
            ),

            Positioned(
              bottom: d.hs(16),
              left: d.ws(16),
              right: d.ws(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Mission Directive',
                    style: AppTheme.labelCaps.copyWith(
                      fontSize: d.ws(10),
                      color: AppTheme.primaryContainer,
                      letterSpacing: d.ws(1.5),
                    ),
                  ),
                  SizedBox(height: d.hs(4)),
                  Text(
                    'WELCOME TO F1 PREDICTOR',
                    style: AppTheme.labelCaps.copyWith(
                      fontFamily: 'SpaceGrotesk',
                      fontSize: d.ws(26),
                      height: 1.1,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                      letterSpacing: -0.5,
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
}

// ─────────────────────────────────────────────────────────────────────────────
// 3 Info cards
// ─────────────────────────────────────────────────────────────────────────────
class _InfoCards extends GetView<HomeController> {
  final _D d;
  const _InfoCards({required this.d});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CardLabel(icon: Icons.event_rounded, label: 'SCHEDULE', d: d),
              SizedBox(height: d.hs(4)),
              Text(
                'Next Race: Monaco GP',
                style: AppTheme.bodyLg.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: d.ws(18),
                ),
              ),
              SizedBox(height: d.hs(8)),

              Obx(
                () => _GlowProgressBar(
                  value: controller.raceProgress.value,
                  height: d.hs(4),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: d.stackGap),

        _GlassCard(
          leftBorder: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CardLabel(
                icon: Icons.stars_rounded,
                label: 'GRID FAVOURITE',
                d: d,
              ),
              SizedBox(height: d.hs(4)),
              Text(
                'Top Predicted: Max Verstappen',
                style: AppTheme.bodyLg.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: d.ws(18),
                ),
              ),
              SizedBox(height: d.hs(6)),
              Obx(
                () => Text(
                  controller.p1Display,
                  style: AppTheme.telemetryNum.copyWith(
                    fontSize: d.ws(14),
                    color: AppTheme.primaryContainer,
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: d.stackGap),

        _GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CardLabel(
                icon: Icons.precision_manufacturing_rounded,
                label: 'SYSTEM HEALTH',
                d: d,
              ),
              SizedBox(height: d.hs(4)),
              Obx(
                () => Text(
                  'Model Accuracy: ${controller.accuracyDisplay}',
                  style: AppTheme.bodyLg.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: d.ws(18),
                  ),
                ),
              ),
              SizedBox(height: d.hs(4)),
              Text(
                'Based on last 5 sessions',
                style: AppTheme.bodySm.copyWith(
                  color: AppTheme.onSurfaceVariant.withOpacity(0.55),
                  fontStyle: FontStyle.italic,
                  fontSize: d.ws(12),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Telemetry section
// ─────────────────────────────────────────────────────────────────────────────
class _TelemetrySection extends GetView<HomeController> {
  final _D d;
  const _TelemetrySection({required this.d});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'LIVE TELEMETRY',
                    style: AppTheme.labelCaps.copyWith(
                      color: AppTheme.primaryContainer,
                      fontSize: d.ws(10),
                      letterSpacing: d.ws(1.5),
                    ),
                  ),
                  SizedBox(height: d.hs(2)),
                  Text(
                    'Real-time performance streams from server nodes',
                    style: AppTheme.bodySm.copyWith(
                      color: AppTheme.onSurfaceVariant,
                      fontSize: d.ws(12),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: d.ws(8)),
            Row(
              children: [
                Obx(
                  () => AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    width: d.ws(7),
                    height: d.ws(7),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: controller.recPulse.value
                          ? AppTheme.primaryContainer
                          : AppTheme.primaryContainer.withOpacity(0.3),
                      boxShadow: controller.recPulse.value
                          ? [
                              BoxShadow(
                                color: AppTheme.primaryContainer.withOpacity(
                                  0.8,
                                ),
                                blurRadius: 6,
                              ),
                            ]
                          : [],
                    ),
                  ),
                ),
                SizedBox(width: d.ws(4)),
                Text(
                  'REC: 220MS',
                  style: AppTheme.labelCaps.copyWith(
                    fontSize: d.ws(9),
                    color: Colors.white.withOpacity(0.4),
                  ),
                ),
              ],
            ),
          ],
        ),

        SizedBox(height: d.hs(10)),

        _GlassCard(
          verticalPad: d.hs(14),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Obx(
              () => Row(
                children: [
                  _TelItem(
                    label: 'TYRE DEG',
                    value: controller.tyreDegDisplay,
                    d: d,
                    highlight: false,
                  ),
                  _TelDivider(d: d),
                  _TelItem(
                    label: 'SECTOR 1 DELTA',
                    value: controller.sectorDeltaDisplay,
                    d: d,
                    highlight: true,
                  ),
                  _TelDivider(d: d),
                  _TelItem(
                    label: 'PIT WINDOW',
                    value: controller.pitWindow.value,
                    d: d,
                    highlight: false,
                  ),
                  _TelDivider(d: d),
                  _TelItem(
                    label: 'BRAKE TEMP',
                    value: controller.brakeTempDisplay,
                    d: d,
                    highlight: false,
                  ),
                  _TelDivider(d: d),
                  _TelItem(
                    label: 'ERS CHARGE',
                    value: controller.ersDisplay,
                    d: d,
                    highlight: false,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TelItem extends StatelessWidget {
  final String label;
  final String value;
  final bool highlight;
  final _D d;

  const _TelItem({
    required this.label,
    required this.value,
    required this.highlight,
    required this.d,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: AppTheme.labelCaps.copyWith(
            fontSize: d.ws(8),
            color: AppTheme.onSurfaceVariant.withOpacity(0.5),
            letterSpacing: d.ws(1),
          ),
        ),
        SizedBox(height: d.hs(3)),
        Text(
          value,
          style: AppTheme.telemetryNum.copyWith(
            fontSize: d.ws(13),
            color: highlight ? AppTheme.primaryContainer : Colors.white,
            fontStyle: FontStyle.normal,
          ),
        ),
      ],
    );
  }
}

class _TelDivider extends StatelessWidget {
  final _D d;
  const _TelDivider({required this.d});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: d.hs(32),
      color: Colors.white.withOpacity(0.1),
      margin: EdgeInsets.symmetric(horizontal: d.ws(16)),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Start Prediction button
// ─────────────────────────────────────────────────────────────────────────────
class _StartPredictionButton extends StatefulWidget {
  final _D d;
  const _StartPredictionButton({required this.d});

  @override
  State<_StartPredictionButton> createState() => _StartPredictionButtonState();
}

class _StartPredictionButtonState extends State<_StartPredictionButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _anim;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _scale = Tween<double>(
      begin: 1.0,
      end: 0.96,
    ).animate(CurvedAnimation(parent: _anim, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _anim.forward(),
      onTapUp: (_) => _anim.reverse(),
      onTapCancel: () => _anim.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          width: double.infinity,
          height: widget.d.hs(64),
          decoration: BoxDecoration(
            color: AppTheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Color(0x4DE10600),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.play_circle_filled_rounded,
                color: Colors.white,
                size: widget.d.ws(22),
              ),
              SizedBox(width: widget.d.ws(10)),
              Text(
                'START PREDICTION',
                style: AppTheme.labelCaps.copyWith(
                  fontSize: widget.d.ws(14),
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  letterSpacing: widget.d.ws(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Encrypted label
// ─────────────────────────────────────────────────────────────────────────────
class _EncryptedLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'ENCRYPTED CONNECTION ESTABLISHED – HIGH STAKES SIMULATION ENABLED',
        textAlign: TextAlign.center,
        style: AppTheme.labelCaps.copyWith(
          fontSize: 9,
          color: Colors.white.withOpacity(0.25),
          fontStyle: FontStyle.italic,
          letterSpacing: 1.4,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Bottom Navigation Bar
// ─────────────────────────────────────────────────────────────────────────────
class _BottomNav extends GetView<HomeController> {
  final _D d;
  const _BottomNav({required this.d});

  static const List<_NavItem> _items = [
    _NavItem(
      icon: Icons.home_rounded,
      activeIcon: Icons.home_rounded,
      label: 'HOME',
    ),
    _NavItem(
      icon: Icons.query_stats_rounded,
      activeIcon: Icons.query_stats_rounded,
      label: 'PREDICT',
    ),
    _NavItem(
      icon: Icons.timeline_rounded,
      activeIcon: Icons.timeline_rounded,
      label: 'ANALYTICS',
    ),
    _NavItem(
      icon: Icons.settings_rounded,
      activeIcon: Icons.settings_rounded,
      label: 'SETTINGS',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: d.navH,
      decoration: BoxDecoration(
        color: const Color(0xE60E0E0E),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
        border: const Border(
          top: BorderSide(color: Color(0x0DFFFFFF), width: 1),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x80000000),
            blurRadius: 20,
            offset: Offset(0, -8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_items.length, (i) {
          return Expanded(
            child: Obx(() {
              final isActive = controller.selectedIndex.value == i;
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => controller.selectedIndex.value = i,
                child: AnimatedScale(
                  duration: const Duration(milliseconds: 150),
                  scale: isActive ? 1.0 : 0.92,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _items[i].icon,
                        size: d.ws(22),
                        color: isActive
                            ? AppTheme.primaryContainer
                            : AppTheme.onSurfaceVariant.withOpacity(0.5),
                        shadows: isActive
                            ? const [
                                Shadow(color: Color(0x99E10600), blurRadius: 8),
                              ]
                            : null,
                      ),
                      SizedBox(height: d.hs(3)),
                      Text(
                        _items[i].label,
                        style: AppTheme.labelCaps.copyWith(
                          fontSize: d.ws(8.5),
                          color: isActive
                              ? AppTheme.primaryContainer
                              : AppTheme.onSurfaceVariant.withOpacity(0.5),
                          letterSpacing: d.ws(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          );
        }),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

class _GlassCard extends StatelessWidget {
  final Widget child;
  final bool leftBorder;
  final double? verticalPad;

  const _GlassCard({
    required this.child,
    this.leftBorder = false,
    this.verticalPad,
  });

  @override
  Widget build(BuildContext context) {
    final d = _D.of(context);

    final baseCard = Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: d.cardPad,
        vertical: verticalPad ?? d.hs(14),
      ),
      decoration: BoxDecoration(
        color: const Color(0xB3121212),
        borderRadius: BorderRadius.circular(12),

        border: Border.all(color: const Color(0x1AFFFFFF), width: 1),
      ),
      child: child,
    );

    if (!leftBorder) return baseCard;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          baseCard,
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            child: Container(
              width: 3,
              decoration: const BoxDecoration(color: AppTheme.primaryContainer),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Card label row
// ─────────────────────────────────────────────────────────────────────────────
class _CardLabel extends StatelessWidget {
  final IconData icon;
  final String label;
  final _D d;

  const _CardLabel({required this.icon, required this.label, required this.d});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: d.ws(13), color: AppTheme.onSurfaceVariant),
        SizedBox(width: d.ws(6)),
        Text(
          label,
          style: AppTheme.labelCaps.copyWith(
            fontSize: d.ws(9),
            color: AppTheme.onSurfaceVariant,
            letterSpacing: d.ws(1.2),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Glow progress bar
// ─────────────────────────────────────────────────────────────────────────────
class _GlowProgressBar extends StatelessWidget {
  final double value;
  final double height;

  const _GlowProgressBar({required this.value, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(99),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(99),
        child: AnimatedFractionallySizedBox(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          widthFactor: value.clamp(0.0, 1.0),
          heightFactor: 1.0,
          alignment: Alignment.centerLeft,
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.primaryContainer,
              borderRadius: BorderRadius.circular(99),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xCCE10600),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
