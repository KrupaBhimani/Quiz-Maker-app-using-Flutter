import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OptionTile extends StatefulWidget {

  final String option, decription, correctAnswer, optionSelected;
  OptionTile(
      {@required this.optionSelected,@required this.correctAnswer,@required this.decription,@required this.option});

  @override
  _OptionTileState createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              border: Border.all(color: widget.decription == widget.optionSelected ? widget.optionSelected == widget.correctAnswer ?
              Colors.green.withOpacity(0.7) :
              Colors.red.withOpacity(0.7) : Colors.grey, width: 1.4
              ),
              borderRadius: BorderRadius.circular(30)
            ),
            alignment:Alignment.center,
            child: Text("${widget.option}" , style: TextStyle(
              color: widget.optionSelected == widget.decription ?
              widget.correctAnswer == widget.optionSelected ? Colors.green.withOpacity(0.7) : Colors.red
                  : Colors.black54,
            ),),
          ),
          SizedBox(width: 8,),
          Text(widget.decription, style: TextStyle(fontSize: 16, color: Colors.black54),)
        ],
      ),
    );
  }
}
