import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app/app_theme.dart';

/// Branded first screen — one composition: brand, line, CTA, SSL atmosphere.
class LandingHomeScreen extends StatefulWidget {
  const LandingHomeScreen({
    super.key,
    required this.onOpenPlayers,
    required this.onOpenTournaments,
  });

  final VoidCallback onOpenPlayers;
  final VoidCallback onOpenTournaments;

  @override
  State<LandingHomeScreen> createState() => _LandingHomeScreenState();
}

class _LandingHomeScreenState extends State<LandingHomeScreen>
    with TickerProviderStateMixin {
  late final AnimationController _enter;
  late final AnimationController _float;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;
  late final Animation<double> _iconScale;

  @override
  void initState() {
    super.initState();
    _enter = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _float = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )..repeat(reverse: true);

    _fade = CurvedAnimation(parent: _enter, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _enter, curve: Curves.easeOutCubic));
    _iconScale = Tween<double>(begin: 0.86, end: 1).animate(
      CurvedAnimation(parent: _enter, curve: Curves.easeOutBack),
    );

    _enter.forward();
  }

  @override
  void dispose() {
    _enter.dispose();
    _float.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const _SslCourtBackdrop(),
          CustomPaint(painter: _CourtLinesPainter()),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(28, 24, 28, 16 + bottom),
              child: FadeTransition(
                opacity: _fade,
                child: SlideTransition(
                  position: _slide,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(flex: 2),
                      AnimatedBuilder(
                        animation: _float,
                        builder: (context, child) {
                          final y = math.sin(_float.value * math.pi) * 8;
                          return Transform.translate(
                            offset: Offset(0, y),
                            child: child,
                          );
                        },
                        child: ScaleTransition(
                          scale: _iconScale,
                          child: Image.asset(
                            'assets/branding/ssl_logo.png',
                            width: 112,
                            height: 112,
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      Text(
                        'Super Smash\nLeague Manager',
                        style: GoogleFonts.outfit(
                          fontSize: 40,
                          height: 1.05,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.ink,
                          letterSpacing: -1.0,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Run Super Smash League tournaments offline — players, draws, scores, rankings.',
                        style: GoogleFonts.dmSans(
                          fontSize: 17,
                          height: 1.45,
                          color: AppTheme.ink.withValues(alpha: 0.72),
                        ),
                      ),
                      const Spacer(flex: 3),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: widget.onOpenTournaments,
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: AppTheme.primary,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Start with tournaments'),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: widget.onOpenPlayers,
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            foregroundColor: AppTheme.primary,
                            side: const BorderSide(
                              color: AppTheme.primary,
                              width: 1.5,
                            ),
                          ),
                          child: const Text('Open player pool'),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Poster-inspired red / green / gold wash (readable dark ink on top).
class _SslCourtBackdrop extends StatelessWidget {
  const _SslCourtBackdrop();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFFBF5),
            Color(0xFFF5E6A8),
            Color(0xFFB8D9B5),
            Color(0xFFD4A0A0),
          ],
          stops: [0.0, 0.32, 0.68, 1.0],
        ),
      ),
    );
  }
}

/// Soft badminton-court line geometry — atmosphere, not clutter.
class _CourtLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.ink.withValues(alpha: 0.06)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final inset = size.width * 0.08;
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        inset,
        size.height * 0.12,
        size.width - inset * 2,
        size.height * 0.55,
      ),
      const Radius.circular(8),
    );
    canvas.drawRRect(rect, paint);

    // Centre line
    final midY = rect.center.dy;
    canvas.drawLine(
      Offset(rect.left, midY),
      Offset(rect.right, midY),
      paint,
    );

    // Net suggestion
    final netPaint = Paint()
      ..color = AppTheme.ink.withValues(alpha: 0.1)
      ..strokeWidth = 3;
    canvas.drawLine(
      Offset(rect.left + 12, midY),
      Offset(rect.right - 12, midY),
      netPaint,
    );

    // Service boxes
    final boxH = rect.height * 0.18;
    canvas.drawLine(
      Offset(rect.left, midY - boxH),
      Offset(rect.right, midY - boxH),
      paint,
    );
    canvas.drawLine(
      Offset(rect.left, midY + boxH),
      Offset(rect.right, midY + boxH),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
