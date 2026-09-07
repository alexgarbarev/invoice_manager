import 'package:markdown/markdown.dart' as md;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class MarkdownPdfBuilder {
  final String text;
  final double fontSize;
  final PdfColor? textColor;
  final PdfColor linkColor;
  final pw.TextAlign? textAlign;

  MarkdownPdfBuilder({
    required this.text,
    this.fontSize = 12,
    this.textColor,
    this.textAlign,
    this.linkColor = PdfColors.blue700,
  });

  pw.Widget build() {
    final doc = md.Document();
    final nodes = doc.parse(text);

    return pw.Column(
      crossAxisAlignment: textAlign == .right ? .end : .start,
      children: nodes.map(_buildNode).toList(),
    );
  }

  pw.Widget _buildNode(md.Node node) {
    if (node is md.Text) {
      return pw.Text(
        textAlign: textAlign,
        node.textContent,
        style: pw.TextStyle(fontSize: fontSize, color: textColor),
      );
    } else if (node is md.Element) {
      return _buildElement(node);
    }
    return pw.SizedBox.shrink();
  }

  pw.Widget _buildElement(md.Element element) {
    final tag = element.tag;
    final children = element.children ?? [];

    if (tag == 'p') {
      if (children.isEmpty) {
        return pw.SizedBox.shrink();
      }
      return pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 4),
        child: pw.RichText(textAlign: textAlign, text: _buildTextSpan(children)),
      );
    } else if (tag == 'strong') {
      return pw.RichText(textAlign: textAlign, text: _buildBoldSpan(children));
    } else if (tag == 'em') {
      return pw.RichText(textAlign: textAlign, text: _buildItalicSpan(children));
    } else if (tag == 'a') {
      return _buildLink(element, children);
    } else if (tag == 'br') {
      return pw.SizedBox(height: 4);
    } else {
      return pw.RichText(textAlign: textAlign, text: _buildTextSpan(children));
    }
  }

  pw.TextSpan _buildTextSpan(List<md.Node> children) {
    return pw.TextSpan(
      style: pw.TextStyle(fontSize: fontSize, color: textColor),
      children: children.map(_buildInlineSpan).toList(),
    );
  }

  pw.TextSpan _buildBoldSpan(List<md.Node> children) {
    return pw.TextSpan(
      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
      children: children.map(_buildInlineSpan).toList(),
    );
  }

  pw.TextSpan _buildItalicSpan(List<md.Node> children) {
    return pw.TextSpan(
      style: pw.TextStyle(fontStyle: pw.FontStyle.italic),
      children: children.map(_buildInlineSpan).toList(),
    );
  }

  pw.InlineSpan _buildInlineSpan(md.Node node) {
    if (node is md.Text) {
      return pw.TextSpan(
        text: node.textContent,
        style: pw.TextStyle(fontSize: fontSize, color: textColor),
      );
    } else if (node is md.Element) {
      return _buildInlineElement(node);
    }
    return const pw.TextSpan(text: '');
  }

  pw.InlineSpan _buildInlineElement(md.Element element) {
    final tag = element.tag;
    final children = element.children ?? [];

    if (tag == 'strong') {
      return pw.TextSpan(
        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
        children: children.map(_buildInlineSpan).toList(),
      );
    } else if (tag == 'em') {
      return pw.TextSpan(
        style: pw.TextStyle(fontStyle: pw.FontStyle.italic),
        children: children.map(_buildInlineSpan).toList(),
      );
    } else if (tag == 'a') {
      return _buildLinkSpan(element, children);
    } else {
      return pw.TextSpan(children: children.map(_buildInlineSpan).toList());
    }
  }

  pw.TextSpan _buildLinkSpan(md.Element element, List<md.Node> children) {
    final href = element.attributes['href'];
    if (href == null) {
      return pw.TextSpan(children: children.map(_buildInlineSpan).toList());
    }

    return pw.TextSpan(
      style: pw.TextStyle(color: linkColor, decoration: pw.TextDecoration.underline),
      children: children.map(_buildInlineSpan).toList(),
      annotation: pw.AnnotationUrl(href),
    );
  }

  pw.Widget _buildLink(md.Element element, List<md.Node> children) {
    final href = element.attributes['href'];
    if (href == null) {
      return pw.RichText(text: _buildTextSpan(children));
    }

    return pw.RichText(
      text: pw.TextSpan(
        style: pw.TextStyle(fontSize: fontSize, color: textColor),
        children: children.map((child) {
          if (child is md.Text) {
            return pw.TextSpan(text: child.textContent);
          } else if (child is md.Element) {
            return _buildInlineElement(child);
          }
          return const pw.TextSpan(text: '');
        }).toList(),
        annotation: pw.AnnotationUrl(href),
      ),
    );
  }
}
