import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:invoice_manager/repositories/app_repository.dart';
import 'package:provider/provider.dart';

import '../services/backup_service.dart';
import 'companies_management_modal.dart';
import 'contract_management_modal.dart';
import 'contractors_management_modal.dart';

class SettingsModal extends StatefulWidget {
  const SettingsModal({super.key});

  @override
  State<SettingsModal> createState() => _SettingsModalState();
}

class _SettingsModalState extends State<SettingsModal> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: 900,
          height: 600,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(right: 12),
                child: Row(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TabBar(
                        controller: _tabController,
                        labelStyle: const TextStyle(fontWeight: FontWeight.w600),
                        tabs: const [
                          Tab(text: 'Backup & Restore'),
                          Tab(text: 'Contractors'),
                          Tab(text: 'Contracts'),
                          Tab(text: 'Companies'),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              Divider(height: 1),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Builder(
                      builder: (context) => Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.backup, size: 64, color: Colors.grey),
                            const SizedBox(height: 16),
                            const Text(
                              'Backup & Restore',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Export or import your data as ZIP archive',
                              style: TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () async {
                                    final backupService = BackupService(
                                      context.read<AppRepository>().database,
                                    );
                                    final zipData = await backupService.exportToZip();
                                    final timestamp = DateTime.now().millisecondsSinceEpoch;
                                    await FileSaver.instance.saveFile(
                                      name: 'invoice_manager_backup_$timestamp',
                                      bytes: zipData,
                                      mimeType: MimeType.zip,
                                    );
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Data exported successfully')),
                                      );
                                    }
                                  },
                                  icon: const Icon(Icons.download),
                                  label: const Text('Export Backup'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 12,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                ElevatedButton.icon(
                                  onPressed: () async {
                                    final result = await FilePicker.pickFiles(
                                      type: FileType.custom,
                                      allowedExtensions: ['zip'],
                                    );
                                    print('selected ${result.length}');
                                    if (result.isNotEmpty) {
                                      final appRepo = context.read<AppRepository>();
                                      final backupService = BackupService(appRepo.database);
                                      final bytes = await result.first.readAsBytes();
                                      await backupService.importData(bytes);
                                      print('Import completed');

                                      appRepo.notifyAfterImport();

                                      if (context.mounted) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text('Data imported successfully'),
                                          ),
                                        );
                                      }
                                    }
                                  },
                                  icon: const Icon(Icons.upload),
                                  label: const Text('Import Backup'),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            const Text(
                              'Note: Import will replace all existing data with data from the backup.',
                              style: TextStyle(color: Colors.orange, fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const ContractorsManagementModal(),
                    const ContractManagementModal(),
                    const CompaniesManagementModal(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
