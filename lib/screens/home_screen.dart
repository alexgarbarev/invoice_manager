import 'dart:async';

import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedInvoiceId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: .start,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0) - const .only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: .spaceEvenly,
                    children: [
                      Expanded(
                        child: Text(
                          'Invoice Manager',
                          textAlign: .center,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.settings),
                        onPressed: () => _showSettings(context),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: InvoiceListPanel(
                    selectedInvoiceId: selectedInvoiceId,
                    onSelect: (id) {
                      setState(() {
                        selectedInvoiceId = id;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          const VerticalDivider(width: 1),
          Expanded(
            flex: 2,
            child: Container(
              color: Theme.of(context).colorScheme.surfaceContainer,
              child: Column(
                children: [
                  Flexible(
                    child: InvoiceDetailsPanel(invoiceId: selectedInvoiceId),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSettings(BuildContext context) {
    unawaited(showDialog(context: context, builder: (context) => const SettingsModal()));
  }
}
