import 'package:flutter/material.dart';

class ScoresDialog extends StatelessWidget {
  final Future<List<Map<String, dynamic>>> scoresFuture;

  const ScoresDialog({super.key, required this.scoresFuture});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final fontSize = screenHeight * 0.02;

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: scoresFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          final List<Map<String, dynamic>> scores = snapshot.data ?? [];
          return Dialog(
            elevation: 16,
            backgroundColor: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Text(
                    'Puntuaciones',
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: scores.length,
                      itemBuilder: (context, index) {
                        final score = scores[index];
                        return ListTile(
                          leading: Text('${index + 1}',
                              style: TextStyle(fontSize: fontSize)),
                          title: Text('${score['name']} - ${score['score']}',
                              style: TextStyle(fontSize: fontSize)),
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cerrar', style: TextStyle(fontSize: fontSize)),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
