import 'package:flutter/material.dart';
import 'package:pawcontrol/constants/colors.dart';

class CustomListTile extends StatefulWidget {
  final String? title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final Function(String)? onTitleChanged;
  final Function(String)? onSubtitleChanged;

  const CustomListTile({
    Key? key,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTitleChanged,
    this.onSubtitleChanged,
  }) : super(key: key);

  @override
  _CustomListTileState createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  late TextEditingController _titleController;
  late TextEditingController _subtitleController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _subtitleController = TextEditingController(text: widget.subtitle);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        setState(() {
          _isEditing = !_isEditing;
        });
      },
      title: _isEditing
          ? TextFormField(
              controller: _titleController,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18.0,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              onChanged: widget.onTitleChanged,
            )
          : Text(
              widget.title ?? '',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18.0,
              ),
            ),
      subtitle: _isEditing
          ? TextFormField(
              controller: _subtitleController,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              onChanged: widget.onSubtitleChanged,
            )
          : (widget.subtitle != null ? Text(widget.subtitle!) : null),
      leading: widget.leading,
      trailing: widget.trailing,
      contentPadding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 12.0),
      tileColor: ColorsApp.grey300,
    );
  }
}
