import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unadtelemedicina/utils/provider.dart';
import 'package:unadtelemedicina/widgets/numerico_dart.dart';

class ConferenciaPage extends StatefulWidget {
  const ConferenciaPage({super.key});

  @override
  State<ConferenciaPage> createState() => _ConferenciaPageState();

}

class _ConferenciaPageState extends State<ConferenciaPage> {
  @override
  Widget build(BuildContext context) {
    final watch = context.watch<TextProvider>();
      return Scaffold(
          appBar: AppBar(
            title: Text(
              'Telemedicina - Ubaté',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            elevation: 0,

          ),
          body: const Column(
                  children: [
                    Expanded(child: Numerico()),
                  ],
                ),

        );
  }
}
