import 'package:flutter/material.dart';

// Define constant values for better readability
const double markerTop = 20.0;
const double paddingHorizontal = 10.0;
const double height = 225.0;
const double lineWidth = 2.0;
const double borderWidth = 5.0;
const double indicatorSize = 50.0;

class CustomOverlay extends StatefulWidget {
  final bool showLineAnimation;

  const CustomOverlay({super.key, required this.showLineAnimation});

  @override
  _CustomOverlayState createState() => _CustomOverlayState();
}

class _CustomOverlayState extends State<CustomOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.showLineAnimation
            ? AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Positioned(
                    top: markerTop + 5,
                    child: Container(
                      width: MediaQuery.of(context).size.width -
                          (2 * paddingHorizontal),
                      height: lineWidth,
                      color: Colors.red.withOpacity(0.5),
                      margin: EdgeInsets.only(
                        left: paddingHorizontal,
                        right: 0.0,
                        top: _animationController.value * height,
                      ),
                    ),
                  );
                },
              )
            : const SizedBox(),
        Positioned(
          top: height + 50,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: const Text(
              "Align the barcode within the frame to scan",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
