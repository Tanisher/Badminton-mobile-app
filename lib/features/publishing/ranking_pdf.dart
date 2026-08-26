import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../data/repositories/ranking_repository.dart';
import '../../data/repositories/tournament_repository.dart';
import '../rankings/providers.dart';

Future<void> exportRankingsPdf({
  required WidgetRef ref,
  required String eventType,
}) async {
  final repo = ref.read(rankingRepositoryProvider);
  final now = DateTime.now();
  final start = RankingRepository.rollingWindowStart(now);
  final fmt = DateFormat.yMMMd();

  final doc = pw.Document();
  final title = TournamentEventType.label(eventType);
  final period =
      '${fmt.format(start)} – ${fmt.format(now)} (rolling 12 months)';

  if (isDoublesEvent(eventType)) {
    final rows =
        await repo.computePartnershipRankingPoints(eventType: eventType);
    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          _header('SSL Rankings — $title', period),
          if (rows.isEmpty)
            pw.Text('No partnership rankings in this period.')
          else
            pw.TableHelper.fromTextArray(
              headers: const ['Rank', 'Partnership', 'Points'],
              data: [
                for (final r in rows)
                  ['${r.rank}', r.displayName, '${r.totalPoints}'],
              ],
            ),
        ],
      ),
    );
  } else {
    final rows = await repo.computePlayerRankingPoints(eventType: eventType);
    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          _header('SSL Rankings — $title', period),
          if (rows.isEmpty)
            pw.Text('No player rankings in this period.')
          else
            pw.TableHelper.fromTextArray(
              headers: const ['Rank', 'Player', 'Points'],
              data: [
                for (final r in rows)
                  ['${r.rank}', r.playerName, '${r.totalPoints}'],
              ],
            ),
        ],
      ),
    );
  }

  await Printing.layoutPdf(
    onLayout: (_) async => doc.save(),
    name: 'SSL_Rankings_$eventType.pdf',
  );
}

pw.Widget _header(String title, String period) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(
        'Super Smash League Manager',
        style: pw.TextStyle(fontSize: 11, color: PdfColors.grey700),
      ),
      pw.SizedBox(height: 4),
      pw.Text(
        title,
        style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
      ),
      pw.Text(period, style: const pw.TextStyle(fontSize: 10)),
      pw.SizedBox(height: 16),
    ],
  );
}

Future<Uint8List?> loadSslLogoBytes() async {
  try {
    final data = await rootBundle.load('assets/branding/ssl_logo.png');
    return data.buffer.asUint8List();
  } catch (_) {
    return null;
  }
}
