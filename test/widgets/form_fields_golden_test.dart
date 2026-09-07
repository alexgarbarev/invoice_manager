import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invoice_manager/widgets/form_fields.dart';
import '../helpers/golden_test_helpers.dart';

void main() {
  group('FormField Golden Tests', () {
    testWidgets('StringTextField - empty state', (WidgetTester tester) async {
      await tester.pumpWidgetWithMaterial(
        const StringTextField(label: 'Test Field'),
      );

      await expectLater(
        find.byType(StringTextField),
        matchesGoldenFile('goldens/form_fields/string_field_empty.png'),
      );
    });

    testWidgets('StringTextField - with value', (WidgetTester tester) async {
      final controller = TextEditingController(text: 'Sample Text');
      
      await tester.pumpWidgetWithMaterial(
        StringTextField(
          label: 'Test Field',
          controller: controller,
        ),
      );

      await expectLater(
        find.byType(StringTextField),
        matchesGoldenFile('goldens/form_fields/string_field_with_value.png'),
      );
    });

    testWidgets('StringTextField - with error', (WidgetTester tester) async {
      final controller = TextEditingController(text: '');
      
      await tester.pumpWidgetWithMaterial(
        StringTextField(
          label: 'Test Field',
          controller: controller,
          validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
        ),
      );

      await tester.tap(find.byType(TextFormField));
      await tester.pump();
      await tester.showKeyboard(find.byType(TextFormField));
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(StringTextField),
        matchesGoldenFile('goldens/form_fields/string_field_error.png'),
      );
    });

    testWidgets('DateField - default state', (WidgetTester tester) async {
      await tester.pumpWidgetWithMaterial(
        DateField(
          label: 'Invoice Date',
          value: DateTime(2024, 9, 7),
          onTap: () {},
        ),
      );

      await expectLater(
        find.byType(DateField),
        matchesGoldenFile('goldens/form_fields/date_field_default.png'),
      );
    });

    testWidgets('DateField - different dates', (WidgetTester tester) async {
      final key1 = GlobalKey();
      final key2 = GlobalKey();
      
      await tester.pumpWidgetWithMaterial(
        Column(
          children: [
            DateField(
              key: key1,
              label: 'Recent Date',
              value: DateTime(2024, 1, 1),
              onTap: () {},
            ),
            const SizedBox(height: 12),
            DateField(
              key: key2,
              label: 'Past Date',
              value: DateTime(2023, 1, 15),
              onTap: () {},
            ),
          ],
        ),
      );

      await expectLater(
        find.byKey(key1),
        matchesGoldenFile('goldens/form_fields/date_field_recent.png'),
      );

      await expectLater(
        find.byKey(key2),
        matchesGoldenFile('goldens/form_fields/date_field_past.png'),
      );
    });

    testWidgets('SelectField - with items', (WidgetTester tester) async {
      await tester.pumpWidgetWithMaterial(
        SelectField<String>(
          label: 'Status',
          value: 'draft',
          items: ['draft', 'sent', 'paid'],
          displayBuilder: (s) => s.toUpperCase(),
          onChanged: (value) {},
        ),
      );

      await expectLater(
        find.byType(SelectField<String>),
        matchesGoldenFile('goldens/form_fields/select_field_default.png'),
      );
    });

    testWidgets('SelectField - null value', (WidgetTester tester) async {
      await tester.pumpWidgetWithMaterial(
        SelectField<String>(
          label: 'Select Option',
          value: null,
          items: ['option1', 'option2', 'option3'],
          displayBuilder: (s) => s,
          onChanged: (value) {},
        ),
      );

      await expectLater(
        find.byType(SelectField<String>),
        matchesGoldenFile('goldens/form_fields/select_field_null.png'),
      );
    });

    testWidgets('Multiple fields - layout verification', (WidgetTester tester) async {
      final testKey = GlobalKey();
      
      await tester.pumpWidgetWithMaterial(
        Container(
          key: testKey,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const StringTextField(label: 'Name'),
              const SizedBox(height: 12),
              DateField(
                label: 'Date',
                value: DateTime(2024, 9, 7),
                onTap: () {},
              ),
              const SizedBox(height: 12),
              SelectField<String>(
                label: 'Category',
                value: 'cat1',
                items: ['cat1', 'cat2'],
                displayBuilder: (s) => s,
                onChanged: (value) {},
              ),
            ],
          ),
        ),
      );

      await expectLater(
        find.byKey(testKey),
        matchesGoldenFile('goldens/form_fields/multiple_fields_layout.png'),
      );
    });

    testWidgets('StringTextField - multiline', (WidgetTester tester) async {
      await tester.pumpWidgetWithMaterial(
        const StringTextField(
          label: 'Description',
          maxLines: 4,
        ),
      );

      await expectLater(
        find.byType(StringTextField),
        matchesGoldenFile('goldens/form_fields/string_field_multiline.png'),
      );
    });

    testWidgets('StringTextField - numeric input', (WidgetTester tester) async {
      await tester.pumpWidgetWithMaterial(
        const StringTextField(
          label: 'Price',
          keyboardType: TextInputType.numberWithOptions(decimal: true),
        ),
      );

      await expectLater(
        find.byType(StringTextField),
        matchesGoldenFile('goldens/form_fields/string_field_numeric.png'),
      );
    });
  });
}
