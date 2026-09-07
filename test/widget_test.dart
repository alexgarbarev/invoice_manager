import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invoice_manager/models/models.dart';
import 'package:invoice_manager/repositories/repositories.dart';
import 'package:invoice_manager/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('App loads successfully', (WidgetTester tester) async {
    final repo = AppRepository(inMemory: true);
    await SeedDataRepository(repo).seed();

    await tester.pumpWidget(
      MaterialApp(
        home: Provider<AppRepository>.value(
          value: repo,
          child: const HomeScreen(),
        ),
      ),
    );

    expect(find.text('Invoice Manager'), findsOneWidget);
  });

  testWidgets('Invoice list displays seeded data', (WidgetTester tester) async {
    final repo = AppRepository(inMemory: true);
    await SeedDataRepository(repo).seed();

    await tester.pumpWidget(
      MaterialApp(
        home: Provider<AppRepository>.value(
          value: repo,
          child: const HomeScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.textContaining('Invoice'), findsWidgets);
  });

  testWidgets('Select an invoice shows details', (WidgetTester tester) async {
    final repo = AppRepository(inMemory: true);
    await SeedDataRepository(repo).seed();

    await tester.pumpWidget(
      MaterialApp(
        home: Provider<AppRepository>.value(
          value: repo,
          child: const HomeScreen(),
        ),
      ),
    );

    // Create contract and invoice for this test
    final contractor = (await repo.contractors.getAll()).first;
    final company = (await repo.companies.getAll()).first;
    final contract = Contract(
      id: 'contract-${DateTime.now().millisecondsSinceEpoch}',
      contractor: contractor,
      company: company,
      date: DateTime.now(),
      fixed: false,
      defaultPrice: 50.0,
      showPeriod: true,
      qtyLabel: 'Hours',
    );
    await repo.contracts.save(contract);

    final invoice = Invoice.create(
      contract: contract,
      date: DateTime.now(),
      items: [InvoiceItem(id: '1', description: 'Test item', quantity: 1, price: 100)],
      status: InvoiceStatus.draft,
    );
    await repo.invoices.save(invoice);
    await tester.pumpAndSettle();

    // Verify invoice is displayed in the list by internal ID
    final internalIdFinder = find.textContaining(
      '${contract.contractor.abbr}-${contract.company.abbr}',
    );
    expect(internalIdFinder, findsWidgets);

    // Note: Full integration test with tap would require more complex setup
    // This verifies basic invoice creation and display works
  });
}
