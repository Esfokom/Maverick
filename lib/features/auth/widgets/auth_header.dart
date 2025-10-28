import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key, this.subtitle});

  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Maverick',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 36,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
            color: theme.colorScheme.onSurface,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          Text(
            subtitle!,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: theme.textTheme.bodyMedium?.color?.withOpacity(0.8),
            ),
          ),
        ],
      ],
    );
  }
}
