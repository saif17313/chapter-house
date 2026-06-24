import 'package:chapter_house/src/app/chapter_house_app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('renders the Chapter House bootstrap shell', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: ChapterHouseApp()));

    await tester.pump();

    expect(find.text('Chapter House'), findsOneWidget);
    expect(find.text('Foundation shell ready.'), findsOneWidget);
  });
}
