import 'package:flutter/material.dart';
import '../../core/theme/sukun_theme.dart';
import '../../core/ui_kit/ui_kit.dart';

class MosqueItem {
  final String name;
  final String address;
  final double distanceMeters;
  final int walkingMinutes;

  const MosqueItem({
    required this.name,
    required this.address,
    required this.distanceMeters,
    required this.walkingMinutes,
  });
}

class NearbyMosquesScreen extends StatelessWidget {
  const NearbyMosquesScreen({super.key});

  static const List<MosqueItem> sampleMosques = [
    MosqueItem(
      name: 'Fatih Camii ve Külliyesi',
      address: 'Ali Kuşçu, Hattat Nafiz Cd., Fatih/İstanbul',
      distanceMeters: 450,
      walkingMinutes: 6,
    ),
    MosqueItem(
      name: 'Yavuz Selim Camii',
      address: 'Balat, Yavuz Selim Cd., Fatih/İstanbul',
      distanceMeters: 920,
      walkingMinutes: 12,
    ),
    MosqueItem(
      name: 'Süleymaniye Camii',
      address: 'Süleymaniye, Prof. Sıddık Sami Onar Cd., Fatih/İstanbul',
      distanceMeters: 1400,
      walkingMinutes: 18,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('En Yakın Cami ve Mescitler', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 12),
        itemCount: sampleMosques.length,
        itemBuilder: (context, index) {
          final m = sampleMosques[index];
          return SukunSurfaceCard(
            enableGlass: true,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: SukunColors.emeraldPrimary.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.mosque_outlined, color: SukunColors.emeraldPrimary, size: 24),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        m.name,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        m.address,
                        style: const TextStyle(fontSize: 12, color: Colors.white54),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.directions_walk_rounded, color: SukunColors.goldAccent, size: 14),
                          const SizedBox(width: 4),
                          Text(
                            '${m.walkingMinutes} dk yürüme (${m.distanceMeters} m)',
                            style: const TextStyle(color: SukunColors.goldAccent, fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.directions_rounded, color: SukunColors.emeraldPrimary),
                  tooltip: 'Yol Tarifi Başlat',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${m.name} için rota başlatıldı.')),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
