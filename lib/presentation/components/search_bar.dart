import 'package:flutter/material.dart';
import '../../bloc/tracks_bloc.dart';

class MySearchBar extends StatefulWidget {
  final TracksBloc bloc;

  const MySearchBar({super.key, required this.bloc});
  @override
  _MySearchBarState createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  final _controller = TextEditingController();
  bool _showClearButton = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _showClearButton = _controller.text.isNotEmpty;
      });
      widget.bloc.add(SearchTermChangedEvent(searchTerm: _controller.text));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: 'Search songs...',
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          suffixIcon: _showClearButton
              ? IconButton(
            icon: Icon(Icons.clear, color: Colors.grey),
            onPressed: () {
              _controller.clear();
              widget.bloc.add(SearchTermChangedEvent( searchTerm: ''));
            },
          )
              : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}