import 'package:flutter/material.dart';

class BubbleButton extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData icon;
  final Color color;

  const BubbleButton({
    Key? key,
    this.onTap,
    this.icon = Icons.add,
    this.color = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: IconButton(
        onPressed: onTap,
        icon: Icon(icon, color: Colors.white),
        splashRadius: 24,
      ),
    );
  }
}

class DraggableFloatingButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Offset initialPosition;
  final bool visible;
  final bool snapToEdge;

  const DraggableFloatingButton({
    super.key,
    required this.child,
    this.onTap,
    this.initialPosition = const Offset(20, 100),
    this.visible = true,
    this.snapToEdge = true,
  });

  @override
  State<DraggableFloatingButton> createState() =>
      _DraggableFloatingButtonState();
}

class _DraggableFloatingButtonState extends State<DraggableFloatingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;
  Offset _startPosition = Offset.zero, _startGlobalPosition = Offset.zero;
  late Offset _position;
  late Size _screenSize;

  @override
  void initState() {
    super.initState();
    _position = widget.initialPosition;

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 550),
      reverseDuration: const Duration(milliseconds: 550),
    );

    _animation =
        Tween<Offset>(
          begin: widget.initialPosition,
          end: widget.initialPosition,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutBack,
          ),
        );

    // Cập nhật position khi animation thay đổi
    _animation.addListener(() {
      setState(() {
        _position = _animation.value;
      });
    });

    // Xử lý khi animation kết thúc
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _snapToEdge(DragEndDetails details) {
    if (!widget.snapToEdge) return;
    // Tính toán vị trí đích (gần cạnh trái hoặc phải)
    Offset targetPosition = Offset(
      _position.dx < _screenSize.width / 2 ? 0 : _screenSize.width - 56,
      _position.dy > _screenSize.height - 56
          ? _screenSize.height - 56
          : _position.dy < 0
          ? MediaQuery.paddingOf(context).top
          : _position.dy,
    );

    // Tạo animation mới từ vị trí hiện tại đến vị trí đích
    _animation = Tween<Offset>(begin: _position, end: targetPosition).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );
    _position = targetPosition;
    // Reset và chạy animation
    _animationController.reset();
    _animationController.forward();
  }

  void _onPanStart(DragStartDetails details) {
    _startPosition = _position;
    _startGlobalPosition = details.globalPosition;
    // Dừng animation nếu đang chạy
    if (_animationController.isAnimating) {
      _animationController.stop();
    }
  }

  void _onPanUpdate(DragUpdateDetails details) {
    Offset delta = details.globalPosition - _startGlobalPosition;
    setState(() {
      _position = Offset(
        (_startPosition.dx + delta.dx),
        (_startPosition.dy + delta.dy),
      );
    });
  }

  void _onPanEnd(DragEndDetails details) {
    _snapToEdge(details);
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.visible) return const SizedBox();

    _screenSize = MediaQuery.of(context).size;

    return Positioned(
      left: _position.dx,
      top: _position.dy,
      child: GestureDetector(
        onPanStart: _onPanStart,
        onPanUpdate: _onPanUpdate,
        onPanEnd: _onPanEnd,
        onTap: widget.onTap,
        child: Material(color: Colors.transparent, child: widget.child),
      ),
    );
  }
}
