import 'package:flutter/material.dart';

class TagSelector extends StatelessWidget {
  final String selectedTag;
  final ValueChanged<String> onTagSelected;
  final Map<String, Color> tagColors;
  final void Function(String) onDeleteTag;
  final void Function(String) onEditTagColor;
  final VoidCallback onAddCustomTag;

  const TagSelector({
    required this.selectedTag,
    required this.onTagSelected,
    required this.tagColors,
    required this.onDeleteTag,
    required this.onEditTagColor,
    required this.onAddCustomTag,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> defaultTags = ['Boceto', 'Pintura', 'Digital'];
    final List<String> customTags = tagColors.keys
        .where((tag) => !defaultTags.contains(tag))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: defaultTags
              .where((tag) => tagColors.containsKey(tag))
              .map((tag) {
            final isSelected = tag == selectedTag;
            return ChoiceChip(
              label: Text(tag),
              selected: isSelected,
              onSelected: (_) => onTagSelected(tag),
              selectedColor: tagColors[tag]!.withAlpha((0.5 * 255).round()),
              backgroundColor: Colors.grey[200],
              labelStyle: TextStyle(
                color: isSelected ? tagColors[tag] : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 12),
        ExpansionTile(
          title: const Text(
            'Etiquetas personalizadas',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: customTags.map((tag) {
                final isSelected = tag == selectedTag;
                final tagColor = tagColors[tag]!;
                return InputChip(
                  label: Text(tag),
                  selected: isSelected,
                  onSelected: (_) => onTagSelected(tag),
                  selectedColor: tagColor.withAlpha((0.5 * 255).round()),
                  backgroundColor: Colors.grey[200],
                  onDeleted: () => onDeleteTag(tag),
                  deleteIcon: const Icon(Icons.close),
                  labelStyle: TextStyle(
                    color: isSelected ? tagColor : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  avatar: GestureDetector(
                    onTap: () => onEditTagColor(tag),
                    child: CircleAvatar(
                      backgroundColor: tagColor,
                      radius: 12,
                      child: const Icon(
                        Icons.edit,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Agregar etiqueta personalizada'),
                onPressed: onAddCustomTag,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
