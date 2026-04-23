import 'package:flutter/material.dart';
import 'package:flutter_main/features/question/widgets/answer_text_field.dart';
import 'package:flutter_main/models/question.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../providers/question_edit_provider.dart';

class BuildAnswerTile extends StatefulWidget {
  final QuestionEditProvider provider;
  final List<TextEditingController> optionControllers; // 👈 부모에서 받기
  final VoidCallback onAddOption;                      // 👈 부모에서 받기
  final Function(int) onRemoveOption;                  // 👈 부모에서 받기

  const BuildAnswerTile({
    super.key,
    required this.provider,
    required this.optionControllers,
    required this.onAddOption,
    required this.onRemoveOption,
  });

  @override
  State<BuildAnswerTile> createState() => _BuildAnswerTileState();
}

class _BuildAnswerTileState extends State<BuildAnswerTile> {
  @override
  Widget build(BuildContext context) {
    if (widget.provider.answerType != AnswerType.multipleChoice) {
      return SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text('선지'),
        ),
        for (int i = 0; i < widget.optionControllers.length; i++)
          Row(
            children: [
              AnswerTextField(
                label: i == 0 ? '했음' : i == 1 ? '안했음' : '',
                controller: widget.optionControllers[i],
              ),
              
              SizedBox(width: 8),
              GestureDetector(
                onTap: () => widget.onRemoveOption(i),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFEBEE),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    FontAwesomeIcons.trashCan,
                    color: Color(0xFFE53935),
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: TextButton.icon(
            onPressed: widget.onAddOption,
            icon: Icon(Icons.add),
            label: Text('선지 추가'),
          ),
        ),
      ],
    );
  }
}