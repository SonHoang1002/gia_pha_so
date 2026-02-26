import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gia_pha_so/src/presentation/provider/bloc/bubble_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        BlocProvider.of<BubbleBloc>(context).init(
          isVisible: true,
          onTap: _showBubbleMenu,
          icon: Icons.menu,
          color: Colors.blue,
        );
        setState(() {});
      }
    });
  }

  void _showBubbleMenu() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 800),
      pageBuilder: (context, animation1, animation2) {
        return const SizedBox();
      },
      transitionBuilder: (context, animation1, animation2, child) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: LiquidGrassOverlay(
            animation: CurvedAnimation(
              parent: animation1,
              curve: Curves.linear,
            ),
            child: _buildMenuContent(context),
          ),
        );
      },
    );
  }

  Widget _buildMenuContent(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildMenuItem(
            icon: Icons.home_rounded,
            label: 'Home',
            color: const Color(0xFF4CAF50),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          _buildMenuItem(
            icon: Icons.person_rounded,
            label: 'Profile',
            color: const Color(0xFF2196F3),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          _buildMenuItem(
            icon: Icons.settings_rounded,
            label: 'Settings',
            color: const Color(0xFFFF9800),
            onTap: () {
              // Navigator.of(context).pop();

              // Điều hướng đến Settings
            },
          ),
          _buildMenuItem(
            icon: Icons.logout_rounded,
            label: 'Logout',
            color: const Color(0xFFF44336),
            onTap: () {
              // Navigator.of(context).pop();

              // Xử lý logout
            },
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
    bool isLast = false,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30),
          splashColor: color.withValues(alpha: 0.3),
          highlightColor: color.withValues(alpha: 0.1),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 16),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Gia phả số'),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Trang chủ'),
              onTap: () {
                // Navigator.pushNamed(context, '/logout');
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Bài viết'),
              onTap: () {
                // Navigator.pushNamed(context, '/profile');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Album'),
              onTap: () {
                // Navigator.pushNamed(context, '/settings');
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Chiến dịch'),
              onTap: () {
                // Navigator.pushNamed(context, '/logout');
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Sự kiện'),
              onTap: () {
                // Navigator.pushNamed(context, '/logout');
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Người dùng'),
              onTap: () {
                // Navigator.pushNamed(context, '/logout');
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cài đặt'),
              onTap: () {
                // Navigator.pushNamed(context, '/logout');
              },
            ),
          ],
        ),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Text(
            "Home Screen",
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/family-tree');
            },
            child: const Text("Gia pha của bạn"),
          ),
        ],
      ),
    );
  }
}

class LiquidGrassOverlay extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  const LiquidGrassOverlay({
    super.key,
    required this.animation,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        return Stack(
          alignment: Alignment.center,
          children: [
            // Background với hiệu ứng liquid grass
            Positioned.fill(
              child: CustomPaint(
                painter: LiquidGrassPainter(
                  progress: animation.value,
                  size: MediaQuery.of(context).size,
                ),
              ),
            ),

            // Blur effect cho background
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 2 * animation.value,
                  sigmaY: 2 * animation.value,
                ),
                child: Container(color: Colors.transparent),
              ),
            ),

            // Menu content với animation
            Transform.scale(
              scale: Tween<double>(begin: 0.5, end: 1.0)
                  .animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.elasticOut,
                    ),
                  )
                  .value,
              child: FadeTransition(
                opacity: Tween<double>(begin: 0, end: 1).animate(animation),
                child: child,
              ),
            ),
          ],
        );
      },
    );
  }
}

class LiquidGrassPainter extends CustomPainter {
  final double progress;
  final Size size;

  LiquidGrassPainter({required this.progress, required this.size});

  @override
  void paint(Canvas canvas, Size _) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Layer 1 - Xanh nhạt (nền)
    _drawGrassLayer(
      canvas: canvas,
      paint: paint
        ..color = const Color(0xFF4CAF50).withValues(alpha: 0.3 * progress),
      offset: 20,
      amplitude: 40 * progress,
      frequency: 0.03,
      phase: 0,
    );

    // Layer 2 - Xanh vừa
    _drawGrassLayer(
      canvas: canvas,
      paint: paint
        ..color = const Color(0xFF2E7D32).withValues(alpha: 0.4 * progress),
      offset: 40,
      amplitude: 30 * progress,
      frequency: 0.05,
      phase: math.pi / 2,
    );

    // Layer 3 - Xanh đậm (trên cùng)
    _drawGrassLayer(
      canvas: canvas,
      paint: paint
        ..color = const Color(0xFF1B5E20).withValues(alpha: 0.5 * progress),
      offset: 60,
      amplitude: 20 * progress,
      frequency: 0.08,
      phase: math.pi,
    );

    // Layer 4 - Hiệu ứng lấp lánh
    _drawSparkles(canvas);
  }

  void _drawGrassLayer({
    required Canvas canvas,
    required Paint paint,
    required double offset,
    required double amplitude,
    required double frequency,
    required double phase,
  }) {
    final path = Path();
    path.moveTo(0, size.height);

    for (double x = 0; x <= size.width; x += 5) {
      double y =
          size.height -
          offset -
          amplitude *
              math.sin((x * frequency) + (progress * 4 * math.pi) + phase);

      if (x == 0) {
        path.lineTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  void _drawSparkles(Canvas canvas) {
    final random = math.Random(42);
    final sparklePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.3 * progress)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 20 * progress; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;

      canvas.drawCircle(Offset(x, y), 2 * progress, sparklePaint);
    }
  }

  @override
  bool shouldRepaint(covariant LiquidGrassPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
