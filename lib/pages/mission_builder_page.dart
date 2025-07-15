import 'package:flutter/material.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MissionBuilderPage extends StatefulWidget {
  @override
  _MissionBuilderPageState createState() => _MissionBuilderPageState();
}

class _MissionBuilderPageState extends State<MissionBuilderPage> {
  final TextEditingController _titleController = TextEditingController();

  final ScrollController _sidebarScrollController = ScrollController();
  final ScrollController _mainScrollController = ScrollController();

  final List<String> deploymentZones = ['DZ Alpha', 'DZ Bravo', 'DZ Charlie'];
  final List<String> secondaryObjectives = [
    'Hold the Center',
    'Wipe the Elite',
  ];
  final List<String> variables = ['Night Fight', 'Radiation Storm'];

  List<Map<String, dynamic>> primaryObjectives = [];
  bool isLoadingPrimaryObjectives = true;

  List<String> selectedDeploymentZones = [];
  List<Map<String, dynamic>> selectedPrimaryObjectives = [];
  List<String> selectedSecondaryObjectives = [];
  List<String> selectedVariables = [];

  @override
  void initState() {
    super.initState();
    _loadPrimaryObjectives();
  }

  void _loadPrimaryObjectives() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('primaryObjectives')
        .where('enabled', isEqualTo: true)
        .orderBy('sortOrder')
        .get();

    setState(() {
      primaryObjectives = snapshot.docs.map((doc) => doc.data()).toList();
      isLoadingPrimaryObjectives = false;
    });
  }

  @override
  void dispose() {
    _sidebarScrollController.dispose();
    _mainScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mission Builder'),
        actions: [IconButton(icon: Icon(Icons.person), onPressed: () {})],
      ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Scrollbar(
              controller: _sidebarScrollController,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: _sidebarScrollController,
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildStringModulePicker(
                      'Deployment Zones',
                      deploymentZones,
                    ),
                    _buildPrimaryObjectivesPicker(),
                    _buildStringModulePicker(
                      'Secondary Objectives',
                      secondaryObjectives,
                    ),
                    _buildStringModulePicker('Variables', variables),
                  ],
                ),
              ),
            ),
          ),
          VerticalDivider(width: 2, thickness: 2, color: Colors.grey[800]),
          Expanded(
            flex: 2,
            child: Scrollbar(
              controller: _mainScrollController,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: _mainScrollController,
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        hintText: 'Optional Mission Title',
                        filled: true,
                        fillColor: Colors.grey[900],
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 24),
                    _buildStringDropZone(
                      title: 'Deployment Zone',
                      items: selectedDeploymentZones,
                      onReorder: (oldIndex, newIndex) =>
                          _reorder(selectedDeploymentZones, oldIndex, newIndex),
                    ),
                    _buildPrimaryObjectivesDropZone(
                      title: 'Primary Objective',
                      items: selectedPrimaryObjectives,
                      onReorder: (oldIndex, newIndex) => _reorderMap(
                        selectedPrimaryObjectives,
                        oldIndex,
                        newIndex,
                      ),
                    ),
                    _buildStringDropZone(
                      title: 'Secondary Objectives',
                      items: selectedSecondaryObjectives,
                      onReorder: (oldIndex, newIndex) => _reorder(
                        selectedSecondaryObjectives,
                        oldIndex,
                        newIndex,
                      ),
                    ),
                    _buildStringDropZone(
                      title: 'Variables',
                      items: selectedVariables,
                      onReorder: (oldIndex, newIndex) =>
                          _reorder(selectedVariables, oldIndex, newIndex),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStringModulePicker(String title, List<String> items) {
    return Card(
      color: Colors.grey[850],
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 120,
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Scrollbar(
              thumbVisibility: true,
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Draggable<String>(
                      data: item,
                      feedback: Material(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 200),
                          child: _buildDraggableCard(item),
                        ),
                      ),
                      childWhenDragging: Opacity(
                        opacity: 0.4,
                        child: _buildDraggableCard(item),
                      ),
                      child: _buildDraggableCard(item),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrimaryObjectivesPicker() {
    if (isLoadingPrimaryObjectives) {
      return Center(child: CircularProgressIndicator());
    }

    return Card(
      color: Colors.grey[850],
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              "Primary Objectives",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 120,
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Scrollbar(
              thumbVisibility: true,
              child: ListView.builder(
                itemCount: primaryObjectives.length,
                itemBuilder: (context, index) {
                  final item = primaryObjectives[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Draggable<Map<String, dynamic>>(
                      data: item,
                      feedback: Material(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 250),
                          child: _buildPrimaryObjectiveCard(item),
                        ),
                      ),
                      childWhenDragging: Opacity(
                        opacity: 0.4,
                        child: _buildPrimaryObjectiveCard(item),
                      ),
                      child: _buildPrimaryObjectiveCard(item),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrimaryObjectiveCard(Map<String, dynamic> item) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    item['title'] ?? '',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text('VP: ${item['victoryPoints'] ?? ''}'),
                ),
                //If this item is selected, we add the Delete icon gesturedetector
                if(selectedPrimaryObjectives.contains(item))
                   GestureDetector(
                    onTap: () {
                      setState(() {
                        primaryObjectives.add(item);
                        selectedPrimaryObjectives.remove(item);
                      });
                    },
                    child: const Icon(Icons.delete),
                  ),
              ],
            ),
            if (item['body'] != null) ...[
              SizedBox(height: 4),
              Text(item['body'], style: TextStyle(fontSize: 14)),
            ],
            if (item['footnote'] != null) ...[
              SizedBox(height: 4),
              Text(
                item['footnote'],
                style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[400],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDraggableCard(String text) {
    return Card(
      child: Padding(padding: const EdgeInsets.all(8.0), child: Text(text)),
    );
  }

  Widget _buildStringDropZone({
    required String title,
    required List<String> items,
    required void Function(int oldIndex, int newIndex) onReorder,
  }) {
    return DragTarget<String>(
      onWillAccept: (_) => true,
      onAccept: (data) {
        setState(() {
          items.add(data);
        });
      },
      builder: (context, candidateData, rejectedData) {
        return _buildDropZoneUI<String>(
          title: title,
          items: items,
          itemBuilder: _buildDraggableCard,
          onReorder: onReorder,
        );
      },
    );
  }

  // List<Map<String, dynamic>> primaryObjectives = [];
  // bool isLoadingPrimaryObjectives = true;

  // List<String> selectedDeploymentZones = [];
  // List<Map<String, dynamic>> selectedPrimaryObjectives = [];
  Widget _buildPrimaryObjectivesDropZone({
    required String title,
    required List<Map<String, dynamic>> items,
    required void Function(int oldIndex, int newIndex) onReorder,
  }) {
    return DragTarget<Map<String, dynamic>>(
      onWillAccept: (_) => true,
      onAccept: (data) {
        setState(() {
          primaryObjectives.remove(data);
          items.add(data);
        });
      },
      builder: (context, candidateData, rejectedData) {
        return _buildDropZoneUI<Map<String, dynamic>>(
          title: title,
          items: items,
          itemBuilder: _buildPrimaryObjectiveCard,
          onReorder: onReorder,
        );
      },
    );
  }

  Widget _buildDropZoneUI<T>({
    required String title,
    required List<T> items,
    required Widget Function(T item) itemBuilder,
    required void Function(int oldIndex, int newIndex) onReorder,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 12),
      color: Colors.black87,
      child: SizedBox(
        height: 200,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Expanded(
                child: DragAndDropLists(
                  children: [
                    DragAndDropList(
                      canDrag: false,
                      children: items
                          .asMap()
                          .entries
                          .map(
                            (entry) => DragAndDropItem(
                              child: itemBuilder(entry.value),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                  onItemReorder:
                      (oldItemIndex, oldListIndex, newItemIndex, newListIndex) {
                        if (oldListIndex == 0 && newListIndex == 0) {
                          onReorder(oldItemIndex, newItemIndex);
                        }
                      },
                  onListReorder: (_, __) {},
                  axis: Axis.vertical,
                  listPadding: EdgeInsets.zero,
                  listDecoration: BoxDecoration(),
                  lastItemTargetHeight: 40,
                  addLastItemTargetHeightToTop: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _reorder(List<String> list, int oldIndex, int newIndex) {
    setState(() {
      final item = list.removeAt(oldIndex);
      list.insert(newIndex, item);
    });
  }

  void _reorderMap(
    List<Map<String, dynamic>> list,
    int oldIndex,
    int newIndex,
  ) {
    setState(() {
      final item = list.removeAt(oldIndex);
      list.insert(newIndex, item);
    });
  }
}
