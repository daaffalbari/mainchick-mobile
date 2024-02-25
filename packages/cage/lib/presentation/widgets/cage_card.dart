import 'package:core/utils/constants.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/cage.dart';
import '../pages/cage_detail_page.dart';
import 'fcr_ip.dart';
import 'harvest.dart';
import 'heading.dart';

class CageCard extends StatelessWidget {
  const CageCard(this.cage, {Key? key}) : super(key: key);

  final Cage cage;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            CageDetailPage.routeName,
            arguments: cage,
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 23,
            horizontal: defaultMargin,
          ),
          child: Column(
            children: [
              Heading(cage: cage),
              const SizedBox(height: 29.5),
              // TODO nilai growth
              FcrIp(
                fcr: cage.fcr,
                ip: cage.ip,
                growth: '-10',
              ),
              const SizedBox(height: 19.5),
              const Harvest(),
            ],
          ),
        ),
      ),
    );
  }
}
