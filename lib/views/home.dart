import 'package:flutter/material.dart';
import 'package:sub_journal/nav_drawer/persis_nav.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _selectedItem = 'Dashboard';
  String _selectedSubItem = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_selectedItem + (_selectedSubItem.isNotEmpty ? ' - $_selectedSubItem' : '')),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      drawer: PersistentNavigationDrawer(
        selectedItem: _selectedItem,
        selectedSubItem: _selectedSubItem,
        onItemSelected: (item, subItem) {
          setState(() {
            _selectedItem = item;
            _selectedSubItem = subItem ?? '';
          });
          // Don't close the drawer
        },
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Change View According to selectedItem
            Text(
              'Current Page: $_selectedItem',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            if (_selectedSubItem.isNotEmpty)
              Text(
                'Sub Page: $_selectedSubItem',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
          ],
        ),
      ),
    );
  }
}