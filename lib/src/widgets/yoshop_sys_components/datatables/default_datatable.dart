import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../creatego_theme.dart';

class DefaultDatatable extends StatefulWidget {
  int freezedColNumber;
  int freezedRowNumber;
  double? rowHeight;
  double headNamesHorizontalPadding;

  List<List<Widget>> bodyWidgets;
  List<GridColumn> headWidgets;

  final bool allowSorting;
  final bool allowEditing;
  final bool allowColumnsResizing;
  final bool showCheckboxColumn;
  final void Function(DataGridCellDoubleTapDetails)? onCellDoubleTap;
  final void Function(DataGridCellTapDetails)? onCellTap;
  final SelectionMode selectionMode;
  final void Function(List, List)? onSelectionChanged;
  Color bodyBackgroundColor;
  Color headBackgorundColor;

  ///headWidgets accepts a list of GridColumns, and GridColumns' columnName and label text must be same values!
  ///Example: GridColumn(columnName: 'Column 2', label: SizedText(text: 'Column 2'));
  ///
  DefaultDatatable({
    required this.bodyWidgets,
    required this.headWidgets,
    this.rowHeight,
    this.allowColumnsResizing = false,
    this.allowEditing = false,
    this.allowSorting = false,
    this.selectionMode = SelectionMode.none,
    this.bodyBackgroundColor = ThemeColors.white,
    this.headBackgorundColor = ThemeColors.coolgray50,
    this.freezedColNumber = 0,
    this.freezedRowNumber = 0,
    this.headNamesHorizontalPadding = 0,
    this.onCellDoubleTap,
    this.onCellTap,
    this.onSelectionChanged,
    this.showCheckboxColumn = false,
  });

  @override
  State<DefaultDatatable> createState() => _DefaultDatatableState();
}

class _DefaultDatatableState extends State<DefaultDatatable> {
  // late DataSource _dataSource;
  // late List<List<Widget>> bodyWidgets;
  // late List<GridColumn> headWidgets;

  // @override
  // void initState() {
  //   super.initState();
  //   bodyWidgets = widget.bodyWidgets;
  //   headWidgets = widget.headWidgets;
  //   _dataSource = DataSource(bodyWidgets);
  // }

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: widget.bodyBackgroundColor,
      elevation: 4,
      borderRadius: BorderRadius.circular(6),
      child: SfDataGrid(
          allowSorting: widget.allowSorting,
          allowEditing: widget.allowEditing,
          allowColumnsResizing: widget.allowColumnsResizing,
          onCellDoubleTap: widget.onCellDoubleTap,
          onCellTap: widget.onCellTap,
          showCheckboxColumn: widget.showCheckboxColumn,
          headerGridLinesVisibility: GridLinesVisibility.none,
          gridLinesVisibility: GridLinesVisibility.none,
          selectionMode: widget.selectionMode,
          onSelectionChanged: widget.onSelectionChanged,
          columnWidthMode: ColumnWidthMode.fill,
          source: DataSource(widget.bodyWidgets),
          frozenColumnsCount: widget.freezedColNumber,
          frozenRowsCount: widget.freezedRowNumber,
          rowHeight: widget.rowHeight ?? 50,
          columns: _buildColumns()),
    );
  }

  List<GridColumn> _buildColumns() {
    List<GridColumn> list = [];
    for (var element in widget.headWidgets) {
      int index = widget.headWidgets.indexOf(element);
      list.add(
        GridColumn(
            columnName: element.toString(),
            width: element.width,
            allowEditing: element.allowEditing,
            allowSorting: element.allowSorting,
            columnWidthMode: element.columnWidthMode,
            maximumWidth: element.maximumWidth,
            minimumWidth: element.minimumWidth,
            autoFitPadding: element.autoFitPadding,
            visible: element.visible,
            label: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: widget.headBackgorundColor,
                  border: Border(
                    top: const BorderSide(
                        width: 1, color: ThemeColors.coolgray200),
                    left: BorderSide(
                        width: 1,
                        color: index != 0
                            ? ThemeColors.transparent
                            : ThemeColors.coolgray200),
                    right: BorderSide(
                        width: 1,
                        color: index != widget.headWidgets.length - 1
                            ? ThemeColors.transparent
                            : ThemeColors.coolgray200),
                    bottom: const BorderSide(
                        width: 1, color: ThemeColors.coolgray200),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                child: element.label)),
      );
    }

    return list;
  }
}

class DataSource extends DataGridSource {
  late List<DataGridRow> dataGridRows;
  List<List<Widget>> bodyWidgets;

  DataSource(this.bodyWidgets) {
    _buildHeads(List dataGridRow) {
      List<DataGridCell<dynamic>> list = [];
      for (var element in dataGridRow) {
        list.add(DataGridCell(columnName: element.toString(), value: element));
      }
      return list;
    }

    dataGridRows = bodyWidgets
        .map<DataGridRow>(
            (dataGridRow) => DataGridRow(cells: _buildHeads(dataGridRow)))
        .toList();
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      int colIndex = dataGridRows.indexOf(row);
      int rowIndex = row.getCells().indexOf(dataGridCell);
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: ThemeColors.coolgray200),
          ),
        ),
        child: bodyWidgets[colIndex][rowIndex],
      );
    }).toList());
  }
}
