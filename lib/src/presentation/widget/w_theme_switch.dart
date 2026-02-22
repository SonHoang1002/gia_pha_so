import 'package:flutter/material.dart';

class WThemeSwitch extends StatefulWidget {
  final ThemeMode value;
  final ValueChanged<ThemeMode> onChanged;
  final Duration animationDuration;
  final double width;
  final double height;

  const WThemeSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.animationDuration = const Duration(milliseconds: 300),
    this.width = 120,
    this.height = 48,
  });

  @override
  State<WThemeSwitch> createState() => WThemeSwitchState();
}

class WThemeSwitchState extends State<WThemeSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _positionAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _indicatorColorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    // Animation cho vị trí indicator (0: Dark, 1: System, 2: Light)
    _positionAnimation = Tween<double>(
      begin: _getPositionValue(widget.value),
      end: _getPositionValue(widget.value),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Animation cho scale khi chuyển đổi
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 0.8), weight: 50),
      TweenSequenceItem(tween: Tween<double>(begin: 0.8, end: 1.0), weight: 50),
    ]).animate(_controller);

    // Animation cho màu indicator
    _indicatorColorAnimation = ColorTween(
      begin: _getIndicatorColor(ThemeMode.dark),
      end: _getIndicatorColor(ThemeMode.light),
    ).animate(_controller);

    // Set initial animation value
    _controller.value = _getPositionValue(widget.value) / 2;
  }

  @override
  void didUpdateWidget(WThemeSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.value != oldWidget.value) {
      final targetPosition = _getPositionValue(widget.value);
      _controller.animateTo(
        targetPosition / 2,
        duration: widget.animationDuration,
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _getPositionValue(ThemeMode option) {
    switch (option) {
      case ThemeMode.dark:
        return 0.0;
      case ThemeMode.system:
        return 1.0;
      case ThemeMode.light:
        return 2.0;
    }
  }

  Color _getIndicatorColor(ThemeMode option) {
    switch (option) {
      case ThemeMode.dark:
        return Colors.deepPurple;
      case ThemeMode.system:
        return Colors.blue;
      case ThemeMode.light:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleSwitch,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(widget.height / 2),
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background icons/labels
            _buildBackgroundOptions(),

            // Animated indicator
            _buildAnimatedIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundOptions() {
    final segmentWidth = widget.width / 3;

    return Row(
      children: [
        _buildOptionSegment(
          position: 0,
          label: 'D',
          description: 'Tối',
          icon: Icons.dark_mode,
        ),
        _buildOptionSegment(
          position: 1,
          label: 'S',
          description: 'Hệ thống',
          icon: Icons.settings_display,
        ),
        _buildOptionSegment(
          position: 2,
          label: 'L',
          description: 'Sáng',
          icon: Icons.light_mode,
        ),
      ],
    );
  }

  Widget _buildOptionSegment({
    required int position,
    required String label,
    required String description,
    required IconData icon,
  }) {
    final isSelected = _getPositionValue(widget.value) == position;

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: _getSegmentBorderRadius(position),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: isSelected
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: isSelected
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BorderRadius? _getSegmentBorderRadius(int position) {
    if (position == 0) {
      return const BorderRadius.only(
        topLeft: Radius.circular(24),
        bottomLeft: Radius.circular(24),
      );
    } else if (position == 2) {
      return const BorderRadius.only(
        topRight: Radius.circular(24),
        bottomRight: Radius.circular(24),
      );
    }
    return null;
  }

  Widget _buildAnimatedIndicator() {
    final segmentWidth = widget.width / 3;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Positioned(
          left: _positionAnimation.value * segmentWidth,
          top: 2,
          bottom: 2,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: segmentWidth - 4,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    _indicatorColorAnimation.value ?? Colors.blue,
                    _indicatorColorAnimation.value?.withOpacity(0.8) ??
                        Colors.blue[800]!,
                  ],
                ),
                borderRadius: BorderRadius.circular((widget.height - 4) / 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: AnimatedSwitcher(
                  duration: widget.animationDuration ~/ 2,
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child: _getIndicatorIcon(widget.value),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _getIndicatorIcon(ThemeMode option) {
    switch (option) {
      case ThemeMode.dark:
        return Icon(
          Icons.nightlight_round,
          key: const ValueKey('dark'),
          color: Colors.white,
          size: 20,
        );
      case ThemeMode.system:
        return Icon(
          Icons.settings,
          key: const ValueKey('system'),
          color: Colors.white,
          size: 20,
        );
      case ThemeMode.light:
        return Icon(
          Icons.wb_sunny,
          key: const ValueKey('light'),
          color: Colors.white,
          size: 20,
        );
    }
  }

  void _toggleSwitch() {
    final currentValue = widget.value;
    ThemeMode nextValue;

    switch (currentValue) {
      case ThemeMode.dark:
        nextValue = ThemeMode.system;
        break;
      case ThemeMode.system:
        nextValue = ThemeMode.light;
        break;
      case ThemeMode.light:
        nextValue = ThemeMode.dark;
        break;
    }

    widget.onChanged(nextValue);
  }
}
