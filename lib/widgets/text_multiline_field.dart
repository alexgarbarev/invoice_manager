import 'package:flutter/material.dart';

class TextMultilineField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final int minLines;
  final int? maxLines;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;

  const TextMultilineField({
    super.key,
    required this.label,
    required this.controller,
    this.minLines = 4,
    this.maxLines,
    this.validator,
    this.keyboardType,
    this.onChanged,
  });

  @override
  State<TextMultilineField> createState() => _TextMultilineFieldState();
}

class _TextMultilineFieldState extends State<TextMultilineField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey),
        ),
        const SizedBox(height: 4),
        TextFormField(
          controller: widget.controller,
          minLines: widget.minLines,
          maxLines: widget.maxLines ?? 10,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
