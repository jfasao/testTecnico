Ext.grid.GridView.prototype.handleHdMenuClick = function(item){
    var index = this.hdCtxIndex;
    var cm = this.cm, ds = this.ds;
    switch (item.getItemId()) {
        case "asc":
            ds.sort(cm.getDataIndex(index), "ASC");
            break;
        case "desc":
            ds.sort(cm.getDataIndex(index), "DESC");
            break;
        default:
            index = cm.getIndexById(item.getItemId().substr(4));
            if (index != -1) {
                if (item.checked && cm.getColumnsBy(this.isHideableColumn, this).length <= 1) {
                    this.onDenyColumnHide();
                    return false;
                }
                cm.setHidden(index, item.checked);
            }
    }
    return true;
};


Ext.ux.grid.GridFilters.prototype.onMenu = function(filterMenu){
    var filter = this.getMenuFilter();
    if(filter){
        this.menu.menu = filter.menu;
        this.menu.setChecked(filter.active, false);
    }

    this.menu.setVisible(filter !== undefined && filter !== null);
    this.sep.setVisible(filter !== undefined && filter !== null);
}