import 'package:flutter/material.dart';
import '../theme/sukun_theme.dart';

class CategoryFilterChips extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final ValueChanged<String> onSelected;
  final Map<String, String>? displayLabels;

  const CategoryFilterChips({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onSelected,
    this.displayLabels,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final cat = categories[index];
          final isSelected = cat == selectedCategory;
          final label = displayLabels != null ? (displayLabels![cat] ?? cat) : cat;

          return ChoiceChip(
            label: Text(label),
            selected: isSelected,
            onSelected: (_) => onSelected(cat),
            selectedColor: SukunColors.emeraldPrimary.withOpacity(0.2),
            backgroundColor: isDark ? SukunColors.carbonCardSurface : SukunColors.nurCardSurface,
            labelStyle: TextStyle(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected
                  ? SukunColors.emeraldPrimary
                  : (isDark ? SukunColors.carbonTextSecondary : SukunColors.nurTextSecondary),
            ),
            side: BorderSide(
              color: isSelected
                  ? SukunColors.emeraldPrimary
                  : (isDark ? SukunColors.carbonBorder : SukunColors.nurBorder),
              width: 1,
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          );
        },
      ),
    );
  }
}
