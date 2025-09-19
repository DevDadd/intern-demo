import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBox extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final Widget? suffix;
  final int minLines;
  final VoidCallback? onSuffixTap; // callback khi bấm suffix

  const CustomBox({
    super.key,
    required this.controller,
    required this.label,
    this.suffix,
    this.minLines = 1,
    this.onSuffixTap,
  });

  @override
  State<CustomBox> createState() => _CustomBoxState();
}

class _CustomBoxState extends State<CustomBox> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isFocused = _focusNode.hasFocus;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: GoogleFonts.manrope(
            color: Colors.white70,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF272B30),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isFocused ? const Color(0xFF1AAF74) : Colors.transparent,
              width: 2,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  focusNode: _focusNode,
                  keyboardType: TextInputType.multiline,
                  minLines: widget.minLines,
                  maxLines: null,
                  style: GoogleFonts.manrope(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
              if (widget.suffix != null) ...[
                GestureDetector(
                  onTap: widget.onSuffixTap,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: widget.suffix!,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
