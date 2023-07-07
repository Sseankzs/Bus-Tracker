import 'package:flutter/material.dart';
import 'package:user/internal_route.dart';

class ETA extends StatelessWidget {
  const ETA({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const Internal();
              },
            ),
          );
        },
        child: const Text('Internal Route'),
      ),
    );
  }
}
