import 'package:flutter/material.dart';

class TagSelector extends StatelessWidget {
  final String selectedTag;
  final ValueChanged<String> onTagSelected;
  final Map<String, Color> tagColors;

  const TagSelector({
    required this.selectedTag,
    required this.onTagSelected,
    required this.tagColors,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: tagColors.keys.map((tag) {
        final isSelected = tag == selectedTag;
        return ChoiceChip(
          label: Text(tag),
          selected: isSelected,
          onSelected: (_) => onTagSelected(tag),
          selectedColor: tagColors[tag]!.withAlpha((255 * 0.3).round()),
          backgroundColor: Colors.grey[200],
          labelStyle: TextStyle(
            color: isSelected ? tagColors[tag] : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        );
      }).toList(),
    );
  }
}
