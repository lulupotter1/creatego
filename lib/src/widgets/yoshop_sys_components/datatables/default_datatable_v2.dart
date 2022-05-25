import 'package:creatego/creatego_theme.dart';
import 'package:pluto_grid/pluto_grid.dart';

class DefaultDatatableV2 extends StatelessWidget {
  DefaultDatatableV2({
    Key? key,
    required this.columns,
    required this.rows,
    this.columnGroups,
    this.onLoaded,
    this.onChanged,
    this.onSelected,
    this.onRowChecked,
    this.onRowDoubleTap,
    this.onRowSecondaryTap,
    this.onRowsMoved,
    this.createHeader,
    this.createFooter,
    this.configuration,
    this.hasDefaultFooter = false,
    this.mode = PlutoGridMode.normal,
  }) : super(key: key) {
    configuration ??= PlutoGridConfiguration(
        gridBorderColor: ThemeColors.coolgray200,
        columnTextStyle:
            ThemeTextMedium.xxs.copyWith(color: ThemeColors.coolgray500),
        gridBorderRadius: BorderRadius.circular(6),
        enableGridBorderShadow: true,
        activatedColor: ThemeColors.coolgray100,
        activatedBorderColor: ThemeColors.coolgray300,
        cellTextStyle: ThemeTextRegular.sm,
        columnHeight: 40,
        rowHeight: 56);
  }

  final List<TableColumn> columns;

  final List<PlutoRow> rows;

  final List<PlutoColumnGroup>? columnGroups;

  final PlutoOnLoadedEventCallback? onLoaded;

  final PlutoOnChangedEventCallback? onChanged;

  final PlutoOnSelectedEventCallback? onSelected;

  final PlutoOnRowCheckedEventCallback? onRowChecked;

  final PlutoOnRowDoubleTapEventCallback? onRowDoubleTap;

  final PlutoOnRowSecondaryTapEventCallback? onRowSecondaryTap;

  final PlutoOnRowsMovedEventCallback? onRowsMoved;

  final CreateHeaderCallBack? createHeader;

  final CreateFooterCallBack? createFooter;

  PlutoGridConfiguration? configuration;

  /// [PlutoGridMode.normal]
  /// Normal grid with cell editing.
  ///
  /// [PlutoGridMode.select]
  /// Editing is not possible, and if you press enter or tap on the list,
  /// you can receive the selected row and cell from the onSelected callback.
  final PlutoGridMode? mode;

  final bool hasDefaultFooter;

  List<PlutoColumn> get plutoColumn {
    List<PlutoColumn> list = [];
    list.addAll(columns.map<PlutoColumn>((e) => PlutoColumn(
        title: e.title,
        field: e.title,
        width: e.width,
        type: e.dataType!,
        enableContextMenu: e.enableContextMenu,
        enableSorting: e.enableSorting,
        backgroundColor: e.backgroundColor,
        cellPadding: e.cellPadding,
        enableColumnDrag: e.enableColumnDrag,
        enableDropToResize: e.enableResizer,
        enableRowChecked: e.hasCheckbox,
        enableRowDrag: e.enableRowDrag,
        textAlign: e.cellTextAlign,
        frozen: e.frozen,
        hide: e.isHidden,
        enableEditingMode: e.enableEditingMode,
        minWidth: e.minWidth,
        sort: e.sort,
        titleTextAlign: e.titleTextAlign,
        titlePadding: e.titlePadding,
        titleSpan: e.titleSpan)));

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      elevation: 1,
      borderRadius: BorderRadius.circular(6),
      child: PlutoGrid(
        configuration: configuration,
        onRowChecked: onRowChecked,
        mode: mode,
        columns: plutoColumn,
        rows: rows,
        onChanged: onChanged,
        onLoaded: onLoaded,
        onSelected: onSelected,
        onRowDoubleTap: onRowDoubleTap,
        onRowSecondaryTap: onRowSecondaryTap,
        onRowsMoved: onRowsMoved,
        createHeader: createHeader,
        createFooter: hasDefaultFooter
            ? (stateManager) {
                return _DefaultDTFooterWidget();
              }
            : createFooter,
        columnGroups: columnGroups,
        key: key,
      ),
    );
  }
}

class TableColumn {
  /// A title to be displayed on the screen.
  /// If a titleSpan value is set, the title value is not displayed.
  final String title;

  /// Set the column type.
  PlutoColumnType? dataType;

  /// Set the width of the column.
  double width;

  double minWidth;

  /// Customisable title padding.
  /// It takes precedence over defaultColumnTitlePadding in PlutoGridConfiguration.
  double? titlePadding;

  /// Entering the Enter key or tapping the cell enters the Editing mode.
  bool enableEditingMode;

  /// Customize the column with TextSpan or WidgetSpan instead of the column's title string.
  ///
  /// ```
  /// titleSpan: const TextSpan(
  ///   children: [
  ///     WidgetSpan(
  ///       child: Text(
  ///         '* ',
  ///         style: TextStyle(color: Colors.red),
  ///       ),
  ///     ),
  ///     TextSpan(text: 'column title'),
  ///   ],
  /// ),
  /// ```
  InlineSpan? titleSpan;

  /// Customisable cell padding.
  /// It takes precedence over defaultCellPadding in PlutoGridConfiguration.
  double? cellPadding;

  /// Text alignment in Cell. (Left, Right, Center)
  PlutoColumnTextAlign cellTextAlign;

  /// Text alignment in Title. (Left, Right, Center)
  PlutoColumnTextAlign titleTextAlign;

  /// Freeze the column to the left and right.
  PlutoColumnFrozen frozen;

  /// Set column sorting.
  PlutoColumnSort sort;

  Color? backgroundColor;

  /// Change the position of the column by dragging the column title.
  bool enableColumnDrag;

  /// Change the position of the row by dragging the icon in the cell.
  bool enableRowDrag;

  /// A checkbox appears in the cell of the column.
  bool hasCheckbox;

  /// Sort rows by tapping on the column heading.
  bool enableSorting;

  /// Displays the right icon of the column title.
  bool enableContextMenu;

  /// Display the right icon for drop to resize the column
  /// Valid only when [enableContextMenu] is disabled.
  bool enableResizer;

  /// Hide the column.
  bool isHidden;

  TableColumn({
    required this.title,
    this.dataType,
    PlutoColumnCheckReadOnly? checkReadOnly,
    this.width = PlutoGridSettings.columnWidth,
    this.minWidth = PlutoGridSettings.minColumnWidth,
    this.titlePadding,
    this.titleSpan,
    this.cellPadding,
    this.cellTextAlign = PlutoColumnTextAlign.left,
    this.titleTextAlign = PlutoColumnTextAlign.center,
    this.frozen = PlutoColumnFrozen.none,
    this.sort = PlutoColumnSort.none,
    this.backgroundColor = ThemeColors.coolgray50,
    this.enableEditingMode = true,
    this.enableColumnDrag = false,
    this.enableRowDrag = false,
    this.hasCheckbox = false,
    this.enableSorting = true,
    this.enableContextMenu = false,
    this.enableResizer = false,
    this.isHidden = false,
  }) {
    dataType ??= PlutoColumnType.text();
  }
}

//TODO: NOT IMPLEMENTED YET
class _DefaultDTFooterWidget extends StatelessWidget {
  const _DefaultDTFooterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: SpacedRow(
        children: [
          SpacedRow(
            horizontalSpace: 15,
            children: [
              YSButton(
                  text: "Previous",
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  bgColor: ThemeColors.coolgray700),
              YSButton(
                  text: "Next",
                  onPressed: () {},
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  bgColor: ThemeColors.coolgray700)
            ],
          ),
        ],
      ),
    );
  }
}
