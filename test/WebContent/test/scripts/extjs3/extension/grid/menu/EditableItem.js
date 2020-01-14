Ext.namespace("Ext.ux.menu");

Ext.ux.menu.EditableItem = Ext.extend(Ext.menu.BaseItem, {
    itemCls : "x-editable-menu-item",
    hideOnClick: false,
    
    initComponent: function(){
        
        Ext.ux.menu.EditableItem.superclass.initComponent.call(this);
        this.addEvents({keyup: true});
        this.editor = this.editor || new Ext.form.TextField();
        if(this.text)
            this.editor.setValue(this.text);
    },
    
    onRender: function(container){
        this.el = container.createChild( Ext.apply({
            cls: this.itemCls,
            cn:[{ tag:'img',
                 src: this.icon||Ext.BLANK_IMAGE_URL,
                 cls: this.itemCls+'-icon'+(this.iconCls?' '+this.iconCls:'')
                 },
                 {tag : 'div' , cls: this.itemCls+'-editor x-form-field'}
                 ]
           },!!this.tooltip ? {qtip: this.tooltip} : false ));
        
        Ext.apply(this.config, {width: 125});
        
        Ext.ux.menu.EditableItem.superclass.onRender.apply(this, arguments);
        
        this.editor.render(this.el.child('.'+ this.itemCls+'-editor'));
        this.relayEvents(this.editor.el, ["keyup"]);
        
        this.el.swallowEvent(['keydown','keypress']);
        Ext.each(["keydown", "keypress"], function (eventName) {
            this.el.on(eventName, function (e) {
                if (e.isNavKeyPress())
                  e.stopPropagation();
            }, this);
        }, this);
                
    },
    
    getValue: function(){
        return this.editor.getValue();
    },
    
    setValue: function(value){
        this.editor.setValue(value);
    },
    
    isValid: function(preventMark){
        return this.editor.isValid(preventMark);
    }
}); 



