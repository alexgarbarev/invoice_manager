import 'dart:io';
import 'dart:typed_data';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../models/models.dart';
import '../repositories/app_repository.dart';
import 'markdown_pdf_builder.dart';

class InvoicePdfService {
  static Future<void> exportInvoicePdf(Invoice invoice, AppRepository repo) async {
    final pdf = await _generatePdfDocument(invoice, repo);
    final bytes = await pdf.save();

    if (kIsWeb) {
      await _savePdfWeb(bytes, invoice.displayId);
    } else {
      await _savePdfDesktop(bytes, invoice.id);
    }
  }

  static Future<pw.Document> _generatePdfDocument(Invoice invoice, AppRepository repo) async {
    final pdf = pw.Document();

    final contract = invoice.contract;
    final contractor = contract.contractor;
    final company = contract.company;

    final dateFormat = DateFormat('dd MMMM yyyy', contract.locale);

    const tableCornerRadius = 8.0;

    final currencyPrefix = company.currencyPrefix ?? '\$';
    final currencyFormat = NumberFormat.currency(
      symbol: currencyPrefix,
      decimalDigits: 2,
    );

    var myTheme = pw.ThemeData.withFont(
      base: pw.Font.ttf(await rootBundle.load('assets/fonts/Roboto-Regular.ttf')),
      bold: pw.Font.ttf(await rootBundle.load('assets/fonts/Roboto-Bold.ttf')),
      italic: pw.Font.ttf(await rootBundle.load('assets/fonts/Roboto-Italic.ttf')),
      boldItalic: pw.Font.ttf(await rootBundle.load('assets/fonts/Roboto-BoldItalic.ttf')),
    );

    pdf.addPage(
      pw.Page(
        theme: myTheme,
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              pw.Row(
                mainAxisAlignment: .spaceBetween,
                crossAxisAlignment: .start,
                children: [
                  pw.Flexible(
                    child: pw.Column(
                      crossAxisAlignment: .start,
                      children: [
                        pw.Text(
                          contractor.fullName,
                          style: pw.TextStyle(fontSize: 28, fontWeight: pw.FontWeight.bold),
                        ),
                        pw.SizedBox(height: 16),
                        pw.Text(
                          contract.contractorRoleSublabelOrDefault,
                          style: const pw.TextStyle(fontSize: 16, color: PdfColors.grey700),
                        ),
                        pw.SizedBox(height: 4),
                        if (contract.description != null)
                          pw.Text(
                            contract.description!,
                            style: const pw.TextStyle(fontSize: 14),
                          ),
                        pw.SizedBox(height: 4),
                        pw.Text(
                          '${contract.contractorAgreementLabelOrDefault} ${dateFormat.format(contract.date)}',
                          style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey700),
                        ),
                      ],
                    ),
                  ),

                  pw.Container(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Column(
                      crossAxisAlignment: .end,
                      children: [
                        pw.Text(
                          contract.invoiceTitleOrDefault,
                          style: pw.TextStyle(
                            fontSize: 28,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromInt(Colors.blueGrey.toARGB32()),
                          ),
                        ),
                        pw.SizedBox(height: 12),
                        pw.Table(
                          tableWidth: .min,
                          children: [
                            pw.TableRow(
                              children: [
                                pw.Text(
                                  '${contract.invoiceIdLabelOrDefault}: ',
                                  textAlign: .right,
                                  style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey),
                                ),
                                pw.Text(
                                  invoice.displayId,
                                  textAlign: .left,
                                  style: const pw.TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            pw.TableRow(
                              children: [
                                pw.Text(
                                  '${contract.dateLabelOrDefault}: ',
                                  textAlign: .right,
                                  style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey),
                                ),
                                pw.Text(
                                  dateFormat.format(invoice.date),
                                  textAlign: .left,
                                  style: const pw.TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            pw.TableRow(
                              children: [
                                pw.Text(
                                  '${contract.dueDateLabelOrDefault}: ',
                                  textAlign: .right,
                                  style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey),
                                ),
                                pw.Text(
                                  dateFormat.format(invoice.dueDate),
                                  textAlign: .left,
                                  style: const pw.TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 16),

              // Sides
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: .start,
                      children: [
                        MarkdownPdfBuilder(
                          text: contractor.contractorInfo ?? '',
                          linkColor: PdfColors.blue700,
                        ).build(),
                        if (contractor.signature != null) ...[
                          pw.SizedBox(height: 16),
                          pw.Row(
                            children: [
                              pw.Text('Signed: '),
                              pw.SizedBox(width: 8),
                              pw.Stack(
                                children: [
                                  pw.Container(
                                    width: 100,
                                    height: 24,
                                    decoration: const pw.BoxDecoration(
                                      border: const pw.Border(
                                        bottom: const pw.BorderSide(color: PdfColors.grey700),
                                      ),
                                    ),
                                  ),
                                  pw.Padding(
                                    padding: const pw.EdgeInsets.only(left: 24, top: 4),
                                    child: pw.Image(
                                      pw.MemoryImage(contractor.signature!),
                                      height: 32,
                                      fit: pw.BoxFit.contain,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: .end,
                      children: [
                        MarkdownPdfBuilder(
                          textAlign: .right,
                          text: company.companyInfo ?? '',
                          linkColor: PdfColors.blue700,
                        ).build(),
                      ],
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 24),
              pw.Container(
                decoration: pw.BoxDecoration(
                  borderRadius: const pw.BorderRadius.all(pw.Radius.circular(tableCornerRadius)),
                  border: pw.Border.all(color: PdfColors.grey300, width: 1),
                ),
                child: pw.Table(
                  border: pw.TableBorder.symmetric(
                    inside: const pw.BorderSide(color: PdfColors.grey300, width: 1),
                  ),
                  children: [
                    pw.TableRow(
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.grey200,
                        borderRadius: const pw.BorderRadius.only(
                          topLeft: const pw.Radius.circular(tableCornerRadius),
                          topRight: const pw.Radius.circular(tableCornerRadius),
                        ),
                      ),
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            contract.descriptionLabelOrDefault,
                            style: pw.TextStyle(fontWeight: .bold),
                          ),
                        ),
                        if (contract.showPeriod)
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text(
                              contract.periodLabelOrDefault,
                              style: pw.TextStyle(fontWeight: .bold),
                            ),
                          ),
                        if (!contract.fixed) ...[
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text(
                              contract.qtyLabelOrDefault,
                              style: pw.TextStyle(fontWeight: .bold),
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text(
                              contract.priceLabelOrDefault,
                              style: pw.TextStyle(fontWeight: .bold),
                            ),
                          ),
                        ],
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            contract.amountLabelOrDefault,
                            style: pw.TextStyle(fontWeight: .bold),
                          ),
                        ),
                      ],
                    ),
                    ...invoice.items.map((item) {
                      return pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text(
                              item.description,
                            ),
                          ),
                          if (contract.showPeriod)
                            pw.Padding(
                              padding: const pw.EdgeInsets.all(8),
                              child: pw.Text(
                                item.period ?? '',
                              ),
                            ),
                          if (!contract.fixed) ...[
                            pw.Padding(
                              padding: const pw.EdgeInsets.all(8),
                              child: pw.Text(
                                item.quantity.toString(),
                              ),
                            ),
                            pw.Padding(
                              padding: const pw.EdgeInsets.all(8),
                              child: pw.Text(
                                currencyFormat.format(item.price),
                              ),
                            ),
                          ],
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text(
                              currencyFormat.format(item.totalAmount),
                            ),
                          ),
                        ],
                      );
                    }),
                    pw.TableRow(
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.grey200,
                        borderRadius: const pw.BorderRadius.only(
                          bottomLeft: const pw.Radius.circular(tableCornerRadius),
                          bottomRight: const pw.Radius.circular(tableCornerRadius),
                        ),
                      ),
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            contract.totalLabelOrDefault,
                            style: pw.TextStyle(fontWeight: .bold),
                          ),
                        ),
                        if (contract.showPeriod)
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text(''),
                          ),
                        if (!contract.fixed) ...[
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text(''),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text(''),
                          ),
                        ],
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            currencyFormat.format(invoice.totalAmount),
                            style: pw.TextStyle(fontWeight: .bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 24),
              MarkdownPdfBuilder(
                text: contractor.paymentInfo ?? '',
                linkColor: PdfColors.blue700,
              ).build(),
              pw.Spacer(),
              pw.Divider(),
              pw.SizedBox(height: 8),
              MarkdownPdfBuilder(
                fontSize: 10,
                text: contract.footnoteOrDefault,
                linkColor: PdfColors.blue700,
              ).build(),
            ],
          );
        },
      ),
    );

    return pdf;
  }

  static Future<void> _savePdfWeb(Uint8List bytes, String invoiceId) async {
    await FileSaver.instance.saveFile(name: invoiceId, bytes: bytes, mimeType: MimeType.pdf);
  }

  static Future<void> _savePdfDesktop(Uint8List bytes, String invoiceId) async {
    final directory = await getApplicationDocumentsDirectory();
    final fileName = '$invoiceId.pdf';
    final file = File('${directory.path}/$fileName');
    await file.writeAsBytes(bytes);
  }
}
