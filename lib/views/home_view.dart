import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../navigation/home_controller.dart';
import '../theme/app_theme.dart';
import 'tabs/home_tab_view.dart';
import 'tabs/predict_tab_view.dart';
import 'tabs/analytics_tab_view.dart';
import 'tabs/settings_tab_view.dart';

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

// ─────────────────────────────────────────────────────────────────────────────
// Root shell view
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
          // Screen Contents switched via selectedIndex
          Positioned.fill(
            child: Obx(() {
              switch (controller.selectedIndex.value) {
                case 0:
                  return const HomeTabView();
                case 1:
                  return const PredictTabView();
                case 2:
                  return const AnalyticsTabView();
                case 3:
                  return const SettingsTabView();
                default:
                  return const HomeTabView();
              }
            }),
          ),

          // Top Header (AppBar)
          Positioned(top: 0, left: 0, right: 0, child: _Header(d: d)),

          // Bottom Navigation Bar
          Positioned(bottom: 0, left: 0, right: 0, child: _BottomNav(d: d)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Header (AppBar)
// ─────────────────────────────────────────────────────────────────────────────
class _Header extends StatefulWidget {
  final _D d;
  const _Header({required this.d});

  @override
  State<_Header> createState() => _HeaderState();
}

class _HeaderState extends State<_Header> with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        height: widget.d.headerH,
        decoration: BoxDecoration(
          color: AppTheme.background.withOpacity(0.80),
          border: const Border(
            bottom: BorderSide(color: Color(0x1AFFFFFF), width: 1),
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x26E10600),
              blurRadius: 15,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: widget.d.margin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left: Icon + Brand Name
            Row(
              children: [
                Icon(
                  Icons.leaderboard_rounded,
                  color: AppTheme.primary,
                  size: widget.d.ws(22),
                ),
                SizedBox(width: widget.d.ws(10)),
                Text(
                  'STRATEGY CONTROL',
                  style: AppTheme.labelCaps.copyWith(
                    fontFamily: 'SpaceGrotesk',
                    fontSize: widget.d.ws(15),
                    color: AppTheme.primary,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                    letterSpacing: widget.d.ws(0.5),
                  ),
                ),
              ],
            ),
            // Right: API Pulse + Status
            Row(
              children: [
                FadeTransition(
                  opacity: _pulseAnimation,
                  child: Container(
                    width: widget.d.ws(8),
                    height: widget.d.ws(8),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.primaryContainer,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xCCE10600),
                          blurRadius: 6,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: widget.d.ws(6)),
                Text(
                  'API: ONLINE',
                  style: AppTheme.labelCaps.copyWith(
                    fontSize: widget.d.ws(10),
                    color: AppTheme.primaryFixed,
                    fontWeight: FontWeight.w700,
                    letterSpacing: widget.d.ws(1.2),
                  ),
                ),
              ],
            ),
          ],
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
      icon: Icons.home_outlined,
      activeIcon: Icons.home_rounded,
      label: 'Home',
    ),
    _NavItem(
      icon: Icons.query_stats_rounded,
      activeIcon: Icons.query_stats_rounded,
      label: 'Predict',
    ),
    _NavItem(
      icon: Icons.timeline_rounded,
      activeIcon: Icons.timeline_rounded,
      label: 'Analytics',
    ),
    _NavItem(
      icon: Icons.settings_outlined,
      activeIcon: Icons.settings_rounded,
      label: 'Settings',
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
                        isActive ? _items[i].activeIcon : _items[i].icon,
                        size: d.ws(22),
                        color: isActive
                            ? AppTheme.primary
                            : AppTheme.onSurfaceVariant.withOpacity(0.6),
                        shadows: isActive
                            ? const [
                                Shadow(
                                  color: Color(0x99E10600),
                                  blurRadius: 8,
                                ),
                              ]
                            : null,
                      ),
                      SizedBox(height: d.hs(3)),
                      Text(
                        _items[i].label,
                        style: AppTheme.labelCaps.copyWith(
                          fontSize: d.ws(9.5),
                          color: isActive
                              ? AppTheme.primary
                              : AppTheme.onSurfaceVariant.withOpacity(0.6),
                          fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                          letterSpacing: d.ws(0.5),
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
