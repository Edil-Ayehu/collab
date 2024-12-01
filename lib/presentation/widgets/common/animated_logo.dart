import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedLogo extends StatelessWidget {
  final Animation<double> animation;
  final double size;
  final Color color;

  const AnimatedLogo({
    super.key,
    required this.animation,
    this.size = 120,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Container(
          width: size.w,
          height: size.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Transform.rotate(
                angle: animation.value * 2 * 3.14159,
                child: Icon(
                  Icons.group_work_rounded,
                  size: (size * 0.5).w,
                  color: color,
                ),
              ),
              if (animation.value > 0.5)
                Transform.scale(
                  scale: (animation.value - 0.5) * 2,
                  child: Icon(
                    Icons.check_circle_outline,
                    size: (size * 0.3).w,
                    color: color.withOpacity(0.5),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
} 