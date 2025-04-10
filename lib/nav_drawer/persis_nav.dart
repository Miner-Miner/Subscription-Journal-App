import 'package:flutter/material.dart';

class PersistentNavigationDrawer extends StatefulWidget {
  final String selectedItem;
  final String selectedSubItem;
  final Function(String, String?) onItemSelected;

  const PersistentNavigationDrawer({
    super.key,
    required this.selectedItem,
    required this.selectedSubItem,
    required this.onItemSelected,
  });

  @override
  State<PersistentNavigationDrawer> createState() => _PersistentNavigationDrawerState();
}

class _PersistentNavigationDrawerState extends State<PersistentNavigationDrawer> {
  // Track which menu items are expanded
  final Map<String, bool> _expandedItems = {
    'User': false,
    'Category': false,
    'Tag': false,
    'Book': false,
    'Subscription': false,
  };

  @override
  void initState() {
    super.initState();
    // Expand the current selected item's parent if it has a subitem selected
    if (widget.selectedSubItem.isNotEmpty) {
      _expandedItems[widget.selectedItem] = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Admin Panel',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          // Dashboard - no submenu
          _buildMenuItem(
            title: 'Dashboard',
            icon: Icons.dashboard,
            isSelected: widget.selectedItem == 'Dashboard' && widget.selectedSubItem.isEmpty,
            onTap: () {
              widget.onItemSelected('Dashboard', null);
            },
          ),
          // User - with submenu
          _buildExpandableMenuItem(
            title: 'User',
            icon: Icons.people,
            isExpanded: _expandedItems['User']!,
            isSelected: widget.selectedItem == 'User',
            subItems: const ['All Users', 'Approved Users', 'Pending Users'],
            selectedSubItem: widget.selectedSubItem,
            onTap: (subItem) {
              widget.onItemSelected('User', subItem);
            },
            onExpand: (isExpanded) {
              setState(() {
                _expandedItems['User'] = isExpanded;
              });
            },
          ),
          // Category - with submenu
          _buildExpandableMenuItem(
            title: 'Category',
            icon: Icons.category,
            isExpanded: _expandedItems['Category']!,
            isSelected: widget.selectedItem == 'Category',
            subItems: const ['Add Category', 'List Categories'],
            selectedSubItem: widget.selectedSubItem,
            onTap: (subItem) {
              widget.onItemSelected('Category', subItem);
            },
            onExpand: (isExpanded) {
              setState(() {
                _expandedItems['Category'] = isExpanded;
              });
            },
          ),
          // Tag - with submenu
          _buildExpandableMenuItem(
            title: 'Tag',
            icon: Icons.tag,
            isExpanded: _expandedItems['Tag']!,
            isSelected: widget.selectedItem == 'Tag',
            subItems: const ['Add Tag', 'List Tags'],
            selectedSubItem: widget.selectedSubItem,
            onTap: (subItem) {
              widget.onItemSelected('Tag', subItem);
            },
            onExpand: (isExpanded) {
              setState(() {
                _expandedItems['Tag'] = isExpanded;
              });
            },
          ),
          // Project - with submenu
          _buildExpandableMenuItem(
            title: 'Book',
            icon: Icons.book,
            isExpanded: _expandedItems['Book']!,
            isSelected: widget.selectedItem == 'Book',
            subItems: const ['Add Book', 'List Books'],
            selectedSubItem: widget.selectedSubItem,
            onTap: (subItem) {
              widget.onItemSelected('Book', subItem);
            },
            onExpand: (isExpanded) {
              setState(() {
                _expandedItems['Book'] = isExpanded;
              });
            },
          ),
          // Subscription - with submenu
          _buildExpandableMenuItem(
            title: 'Subscription',
            icon: Icons.subscriptions,
            isExpanded: _expandedItems['Subscription']!,
            isSelected: widget.selectedItem == 'Subscription',
            subItems: const ['All Subscriptions', 'Pending', 'Approved', 'Denied'],
            selectedSubItem: widget.selectedSubItem,
            onTap: (subItem) {
              widget.onItemSelected('Subscription', subItem);
            },
            onExpand: (isExpanded) {
              setState(() {
                _expandedItems['Subscription'] = isExpanded;
              });
            },
          ),
          // Notification - no submenu
          _buildMenuItem(
            title: 'Notification',
            icon: Icons.notifications,
            isSelected: widget.selectedItem == 'Notification' && widget.selectedSubItem.isEmpty,
            onTap: () {
              widget.onItemSelected('Notification', null);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      selected: isSelected,
      selectedTileColor: Colors.blue.withOpacity(0.1),
      onTap: onTap,
    );
  }

  Widget _buildExpandableMenuItem({
    required String title,
    required IconData icon,
    required bool isExpanded,
    required bool isSelected,
    required List<String> subItems,
    required String selectedSubItem,
    required Function(String) onTap,
    required Function(bool) onExpand,
  }) {
    return ExpansionTile(
      leading: Icon(icon),
      title: Text(title),
      initiallyExpanded: isExpanded,
      onExpansionChanged: onExpand,
      children: subItems.map((subItem) {
        return Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: ListTile(
            title: Text(subItem),
            selected: isSelected && selectedSubItem == subItem,
            selectedTileColor: Colors.blue.withOpacity(0.1),
            onTap: () {
              onTap(subItem);
            },
          ),
        );
      }).toList(),
    );
  }
}