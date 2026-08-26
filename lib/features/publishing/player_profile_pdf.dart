import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../data/database/database.dart';
import '../../data/repositories/ranking_repository.dart';

Future<void> exportPlayerProfilePdf({
  required Player player,
  required List<PlayerRankingRow> singlesRanks,
  required List<String> partnershipLines,
  required int matchesPlayed,
  required int matchesWon,
  required int matchesLost,
  required int titlesWon,
}) async {
  final doc = pw.Document();
  final fmt = DateFormat.yMMMd();
  final eligible = SslEligibility.isU19Eligible(player.dateOfBirth);

  doc.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (context) => [
        pw.Text(
          'Super Smash League Manager',
          style: pw.TextStyle(fontSize: 11, color: PdfColors.grey700),
        ),
        pw.SizedBox(height: 6),
        pw.Text(
          'Player Profile',
          style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 12),
        pw.Text(player.fullName,
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
        pw.Text('Gender: ${player.gender}'),
        pw.Text('DOB: ${fmt.format(player.dateOfBirth)}'),
        pw.Text(
          eligible ? 'Age category: U19' : 'Age category: Ineligible (not U19)',
        ),
        pw.Text('Club/school: ${player.clubOrSchool ?? '—'}'),
        pw.SizedBox(height: 12),
        pw.Text('Career stats',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Text(
          'Played $matchesPlayed · Won $matchesWon · Lost $matchesLost · '
          'Titles $titlesWon',
        ),
        pw.SizedBox(height: 12),
        pw.Text('Current singles rankings (rolling 12 months)',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        if (singlesRanks.isEmpty)
          pw.Text('No singles ranking points in period.')
        else
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              for (final r in singlesRanks)
                pw.Text('#${r.rank} — ${r.totalPoints} pts'),
            ],
          ),
        pw.SizedBox(height: 12),
        pw.Text('Doubles partnerships',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        if (partnershipLines.isEmpty)
          pw.Text('No registered pairs.')
        else
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [for (final line in partnershipLines) pw.Text(line)],
          ),
      ],
    ),
  );

  await Printing.layoutPdf(
    onLayout: (_) async => doc.save(),
    name: 'SSL_Profile_${player.fullName.replaceAll(' ', '_')}.pdf',
  );
}
