import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProgressUpdateDialog extends StatefulWidget {
  final double initialProgress;
  final ValueChanged<double> onUpdate;

  const ProgressUpdateDialog({
    super.key,
    required this.initialProgress,
    required this.onUpdate,
  });

  @override
  State<ProgressUpdateDialog> createState() => _ProgressUpdateDialogState();
}

class _ProgressUpdateDialogState extends State<ProgressUpdateDialog> {
  late double _progress;

  @override
  void initState() {
    super.initState();
    _progress = widget.initialProgress;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Update Progress'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('${(_progress * 100).toInt()}%'),
          SizedBox(height: 16.h),
          Slider(
            value: _progress,
            onChanged: (value) => setState(() => _progress = value),
            divisions: 100,
            label: '${(_progress * 100).toInt()}%',
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            widget.onUpdate(_progress);
            Navigator.pop(context);
          },
          child: const Text('Update'),
        ),
      ],
    );
  }
} 