import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:othello/logic/board/board.dart';
import 'package:othello/providers/providers.dart';

class BoardSizeInput extends ConsumerStatefulWidget {
  const BoardSizeInput({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  ConsumerState<BoardSizeInput> createState() => _BoardSizeInputState();
}

class _BoardSizeInputState extends ConsumerState<BoardSizeInput> {
  late TextEditingController _sizeController;

  @override
  void initState() {
    _sizeController = TextEditingController(
        text: ref.read(boardDimensionProvider).toString());
    super.initState();
  }

  @override
  void dispose() {
    _sizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Container(
        constraints: const BoxConstraints(
          maxHeight: 80,
          maxWidth: 175,
        ),
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          children: [
            Flexible(
              child: TextFormField(
                textAlign: TextAlign.center,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: _sizeController,
                onChanged: (String? nValue) {
                  if (nValue != null && nValue.isNotEmpty) {
                    ref.read(boardDimensionProvider.notifier).state =
                        int.parse(nValue);
                  }
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(2.0),
                ),
                validator: BoardValidator.validateBoardDimension,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: TextFormField(
                readOnly: true,
                controller: _sizeController,
                textAlign: TextAlign.center,
                validator: BoardValidator.validateBoardDimension,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(2.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
