import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:badminton_manager/app/app_theme.dart';
import 'package:badminton_manager/features/home/home_shell.dart';
import 'package:badminton_manager/features/rankings/screens/rankings_screen.dart';
import 'package:badminton_manager/main.dart';

void main() {
  testWidgets('HomeShell shows Home destination', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: HomeShell(),
        ),
      ),
    );
    await tester.pump();
    expect(find.text('Home'), findsWidgets);
    expect(find.byType(NavigationBar), findsOneWidget);
  });

  testWidgets('RankingsScreen builds event tabs', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: AppTheme.light(),
          home: const RankingsScreen(),
        ),
      ),
    );
    await tester.pump();
    expect(find.text('Rankings'), findsOneWidget);
  });

  testWidgets('BadmintonManagerApp constructs', (tester) async {
    expect(const BadmintonManagerApp(), isA<Widget>());
  });
}
