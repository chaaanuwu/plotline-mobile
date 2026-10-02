import 'package:flutter/material.dart';

class GenderSelector extends StatefulWidget {
  final String? initialGender;
  final ValueChanged<String> onGenderSelected;
  final String? errorText;

  const GenderSelector({
    super.key,
    this.initialGender,
    required this.onGenderSelected,
    this.errorText,
  });

  @override
  State<GenderSelector> createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  late String? selectedGender;

  final List<Map<String, dynamic>> genders = [
    {'label': 'Male', 'value': 'Male', 'icon': Icons.male},
    {'label': 'Female', 'value': 'Female', 'icon': Icons.female},
    {'label': 'Other', 'value': 'Other', 'icon': Icons.transgender},
  ];

  @override
  void initState() {
    super.initState();
    selectedGender = widget.initialGender;
  }

  @override
  void didUpdateWidget(covariant GenderSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialGender != oldWidget.initialGender) {
      setState(() {
        selectedGender = widget.initialGender;
      });
    }
  }

  void _selectGender(String gender) {
    setState(() {
      selectedGender = gender;
    });
    widget.onGenderSelected(gender);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final hasError = widget.errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: hasError ? colorScheme.error : colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: genders.map((gender) {
            final isSelected = selectedGender == gender['value'];

            return Expanded(
              child: GestureDetector(
                onTap: () => _selectGender(gender['value']),
                behavior: HitTestBehavior.opaque,
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected
                            ? colorScheme.primary
                            : colorScheme.surfaceContainerHighest,
                        border: isSelected
                            ? Border.all(
                                color: colorScheme.primary.withValues(
                                  alpha: 0.5,
                                ),
                                width: 3,
                              )
                            : Border.all(
                                color: hasError
                                    ? colorScheme.error
                                    : colorScheme.outline.withValues(
                                        alpha: 0.2,
                                      ),
                                width: hasError ? 1.5 : 1,
                              ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: colorScheme.primary.withValues(
                                    alpha: 0.3,
                                  ),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                ),
                              ]
                            : [],
                      ),
                      child: Icon(
                        gender['icon'],
                        size: 30,
                        color: isSelected
                            ? colorScheme.onPrimary
                            : colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      gender['label'],
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.w500,
                        color: isSelected
                            ? colorScheme.primary
                            : colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),

        // Always reserves space for error message
        SizedBox(
          height: 24,
          child: Padding(
            padding: const EdgeInsets.only(left: 12, top: 4),
            child: Text(
              widget.errorText ?? '',
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.error,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
