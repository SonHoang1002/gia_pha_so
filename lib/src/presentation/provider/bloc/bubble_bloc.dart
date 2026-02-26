import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BubbleBloc extends Cubit<BubbleButtonService> {
  BubbleBloc()
    : super(
        BubbleButtonService(
          isVisible: true,
          onTap: null,
          icon: Icons.home,
          color: Colors.blue,
        ),
      );
  void showBubbleButton() {
    emit(state.show());
  }

  void hideBubbleButton() {
    emit(state.hide());
  }

  void init({
    required bool isVisible,
    required void Function() onTap,
    required IconData icon,
    required MaterialColor color,
  }) {
    emit(
      BubbleButtonService(
        isVisible: isVisible,
        onTap: onTap,
        icon: icon,
        color: color,
      ),
    );
  }
}

class BubbleButtonService {
  BubbleButtonService({
    required bool isVisible,
    bool? snapToEdge,
    VoidCallback? onTap,
    IconData? icon,
    Color? color,
  }) {
    _isVisible = isVisible;
    _snapToEdge = snapToEdge ?? true;
    _onTap = onTap;
    _icon = icon ?? Icons.add;
    _color = color ?? Colors.blue;
  }

  bool _isVisible = false;
  bool _snapToEdge = true;
  VoidCallback? _onTap;
  IconData _icon = Icons.add;
  Color _color = Colors.blue;

  set setVisible(bool value) {
    _isVisible = value;
  }

  bool get isVisible => _isVisible;

  set setSnapToEdge(bool value) {
    _snapToEdge = value;
  }

  bool get snapToEdge => _snapToEdge;

  set setFunction(VoidCallback? callback) {
    update(onTap: callback);
  }

  VoidCallback? get onTap => _onTap;

  set setIcon(IconData icon) {
    update(icon: icon);
  }

  IconData get icon => _icon;

  set setColor(Color color) {
    update(color: color);
  }

  Color get color => _color;

  BubbleButtonService show() {
    return update(isVisible: true);
  }

  BubbleButtonService changeSnapToEdge(bool snapToEdge) {
    return update(snapToEdge: snapToEdge);
  }

  BubbleButtonService hide() {
    return update(isVisible: false);
  }

  BubbleButtonService update({
    bool? isVisible,
    bool? snapToEdge,
    VoidCallback? onTap,
    IconData? icon,
    Color? color,
  }) {
    if (isVisible != null) _isVisible = isVisible;
    if (snapToEdge != null) _snapToEdge = snapToEdge;
    if (onTap != null) _onTap = onTap;
    if (icon != null) _icon = icon;
    if (color != null) _color = color;
    return this;
  }
}
