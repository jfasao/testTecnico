/*
 * Ext JS Library 3.0.0
 * Copyright(c) 2006-2009 Ext JS, LLC
 * licensing@extjs.com
 * http://www.extjs.com/license
 */
Ext.TabPanel=Ext.extend(Ext.Panel,{monitorResize:true,deferredRender:true,tabWidth:120,minTabWidth:30,resizeTabs:false,enableTabScroll:false,scrollIncrement:0,scrollRepeatInterval:400,scrollDuration:0.35,animScroll:true,tabPosition:"top",baseCls:"x-tab-panel",autoTabs:false,autoTabSelector:"div.x-tab",activeTab:null,tabMargin:2,plain:false,wheelIncrement:20,idDelimiter:"__",itemCls:"x-tab-item",elements:"body",headerAsText:false,frame:false,hideBorders:true,initComponent:function(){this.frame=false;Ext.TabPanel.superclass.initComponent.call(this);this.addEvents("beforetabchange","tabchange","contextmenu");this.setLayout(new Ext.layout.CardLayout(Ext.apply({layoutOnCardChange:this.layoutOnTabChange,deferredRender:this.deferredRender},this.layoutConfig)));if(this.tabPosition=="top"){this.elements+=",header";this.stripTarget="header"}else{this.elements+=",footer";this.stripTarget="footer"}if(!this.stack){this.stack=Ext.TabPanel.AccessStack()}this.initItems()},onRender:function(c,a){Ext.TabPanel.superclass.onRender.call(this,c,a);if(this.plain){var f=this.tabPosition=="top"?"header":"footer";this[f].addClass("x-tab-panel-"+f+"-plain")}var b=this[this.stripTarget];this.stripWrap=b.createChild({cls:"x-tab-strip-wrap",cn:{tag:"ul",cls:"x-tab-strip x-tab-strip-"+this.tabPosition}});var e=(this.tabPosition=="bottom"?this.stripWrap:null);this.stripSpacer=b.createChild({cls:"x-tab-strip-spacer"},e);this.strip=new Ext.Element(this.stripWrap.dom.firstChild);this.edge=this.strip.createChild({tag:"li",cls:"x-tab-edge"});this.strip.createChild({cls:"x-clear"});this.body.addClass("x-tab-panel-body-"+this.tabPosition);if(!this.itemTpl){var d=new Ext.Template('<li class="{cls}" id="{id}"><a class="x-tab-strip-close" onclick="return false;"></a>','<a class="x-tab-right" href="#" onclick="return false;"><em class="x-tab-left">','<span class="x-tab-strip-inner"><span class="x-tab-strip-text {iconCls}">{text}</span></span>',"</em></a></li>");d.disableFormats=true;d.compile();Ext.TabPanel.prototype.itemTpl=d}this.items.each(this.initTab,this)},afterRender:function(){Ext.TabPanel.superclass.afterRender.call(this);if(this.autoTabs){this.readTabs(false)}if(this.activeTab!==undefined){var a=Ext.isObject(this.activeTab)?this.activeTab:this.items.get(this.activeTab);delete this.activeTab;this.setActiveTab(a)}},initEvents:function(){Ext.TabPanel.superclass.initEvents.call(this);this.on("add",this.onAdd,this,{target:this});this.on("remove",this.onRemove,this,{target:this});this.mon(this.strip,"mousedown",this.onStripMouseDown,this);this.mon(this.strip,"contextmenu",this.onStripContextMenu,this);if(this.enableTabScroll){this.mon(this.strip,"mousewheel",this.onWheel,this)}},findTargets:function(c){var b=null;var a=c.getTarget("li",this.strip);if(a){b=this.getComponent(a.id.split(this.idDelimiter)[1]);if(b.disabled){return{close:null,item:null,el:null}}}return{close:c.getTarget(".x-tab-strip-close",this.strip),item:b,el:a}},onStripMouseDown:function(b){if(b.button!==0){return}b.preventDefault();var a=this.findTargets(b);if(a.close){if(a.item.fireEvent("beforeclose",a.item)!==false){a.item.fireEvent("close",a.item);this.remove(a.item)}return}if(a.item&&a.item!=this.activeTab){this.setActiveTab(a.item)}},onStripContextMenu:function(b){b.preventDefault();var a=this.findTargets(b);if(a.item){this.fireEvent("contextmenu",this,a.item,b)}},readTabs:function(d){if(d===true){this.items.each(function(g){this.remove(g)},this)}var c=this.el.query(this.autoTabSelector);for(var b=0,a=c.length;b<a;b++){var e=c[b];var f=e.getAttribute("title");e.removeAttribute("title");this.add({title:f,contentEl:e})}},initTab:function(c,a){var d=this.strip.dom.childNodes[a];var e=this.getTemplateArgs(c);var b=d?this.itemTpl.insertBefore(d,e):this.itemTpl.append(this.strip,e);Ext.fly(b).addClassOnOver("x-tab-strip-over");if(c.tabTip){Ext.fly(b).child("span.x-tab-strip-text",true).qtip=c.tabTip}c.tabEl=b;c.on("disable",this.onItemDisabled,this);c.on("enable",this.onItemEnabled,this);c.on("titlechange",this.onItemTitleChanged,this);c.on("iconchange",this.onItemIconChanged,this);c.on("beforeshow",this.onBeforeShowItem,this)},getTemplateArgs:function(b){var a=b.closable?"x-tab-strip-closable":"";if(b.disabled){a+=" x-item-disabled"}if(b.iconCls){a+=" x-tab-with-icon"}if(b.tabCls){a+=" "+b.tabCls}return{id:this.id+this.idDelimiter+b.getItemId(),text:b.title,cls:a,iconCls:b.iconCls||""}},onAdd:function(c,b,a){this.initTab(b,a);if(this.items.getCount()==1){this.syncSize()}this.delegateUpdates()},onBeforeAdd:function(b){var a=b.events?(this.items.containsKey(b.getItemId())?b:null):this.items.get(b);if(a){this.setActiveTab(b);return false}Ext.TabPanel.superclass.onBeforeAdd.apply(this,arguments);var c=b.elements;b.elements=c?c.replace(",header",""):c;b.border=(b.border===true)},onRemove:function(c,b){Ext.destroy(Ext.get(this.getTabEl(b)));this.stack.remove(b);b.un("disable",this.onItemDisabled,this);b.un("enable",this.onItemEnabled,this);b.un("titlechange",this.onItemTitleChanged,this);b.un("iconchange",this.onItemIconChanged,this);b.un("beforeshow",this.onBeforeShowItem,this);if(b==this.activeTab){var a=this.stack.next();if(a){this.setActiveTab(a)}else{if(this.items.getCount()>0){this.setActiveTab(0)}else{this.activeTab=null}}}this.delegateUpdates()},onBeforeShowItem:function(a){if(a!=this.activeTab){this.setActiveTab(a);return false}},onItemDisabled:function(b){var a=this.getTabEl(b);if(a){Ext.fly(a).addClass("x-item-disabled")}this.stack.remove(b)},onItemEnabled:function(b){var a=this.getTabEl(b);if(a){Ext.fly(a).removeClass("x-item-disabled")}},onItemTitleChanged:function(b){var a=this.getTabEl(b);if(a){Ext.fly(a).child("span.x-tab-strip-text",true).innerHTML=b.title}},onItemIconChanged:function(d,a,c){var b=this.getTabEl(d);if(b){Ext.fly(b).child("span.x-tab-strip-text").replaceClass(c,a)}},getTabEl:function(a){return document.getElementById(this.id+this.idDelimiter+this.getComponent(a).getItemId())},onResize:function(){Ext.TabPanel.superclass.onResize.apply(this,arguments);this.delegateUpdates()},beginUpdate:function(){this.suspendUpdates=true},endUpdate:function(){this.suspendUpdates=false;this.delegateUpdates()},hideTabStripItem:function(b){b=this.getComponent(b);var a=this.getTabEl(b);if(a){a.style.display="none";this.delegateUpdates()}this.stack.remove(b)},unhideTabStripItem:function(b){b=this.getComponent(b);var a=this.getTabEl(b);if(a){a.style.display="";this.delegateUpdates()}},delegateUpdates:function(){if(this.suspendUpdates){return}if(this.resizeTabs&&this.rendered){this.autoSizeTabs()}if(this.enableTabScroll&&this.rendered){this.autoScrollTabs()}},autoSizeTabs:function(){var g=this.items.length;var b=this.tabPosition!="bottom"?"header":"footer";var c=this[b].dom.offsetWidth;var a=this[b].dom.clientWidth;if(!this.resizeTabs||g<1||!a){return}var j=Math.max(Math.min(Math.floor((a-4)/g)-this.tabMargin,this.tabWidth),this.minTabWidth);this.lastTabWidth=j;var l=this.strip.query("li:not([className^=x-tab-edge])");for(var e=0,h=l.length;e<h;e++){var k=l[e];var m=Ext.fly(k).child(".x-tab-strip-inner",true);var f=k.offsetWidth;var d=m.offsetWidth;m.style.width=(j-(f-d))+"px"}},adjustBodyWidth:function(a){if(this.header){this.header.setWidth(a)}if(this.footer){this.footer.setWidth(a)}return a},setActiveTab:function(c){c=this.getComponent(c);if(!c||this.fireEvent("beforetabchange",this,c,this.activeTab)===false){return}if(!this.rendered){this.activeTab=c;return}if(this.activeTab!=c){if(this.activeTab){var a=this.getTabEl(this.activeTab);if(a){Ext.fly(a).removeClass("x-tab-strip-active")}this.activeTab.fireEvent("deactivate",this.activeTab)}var b=this.getTabEl(c);Ext.fly(b).addClass("x-tab-strip-active");this.activeTab=c;this.stack.add(c);this.layout.setActiveItem(c);if(this.scrolling){this.scrollToTab(c,this.animScroll)}c.fireEvent("activate",c);this.fireEvent("tabchange",this,c)}},getActiveTab:function(){return this.activeTab||null},getItem:function(a){return this.getComponent(a)},autoScrollTabs:function(){this.pos=this.tabPosition=="bottom"?this.footer:this.header;var g=this.items.length;var d=this.pos.dom.offsetWidth;var c=this.pos.dom.clientWidth;var f=this.stripWrap;var e=f.dom;var b=e.offsetWidth;var h=this.getScrollPos();var a=this.edge.getOffsetsTo(this.stripWrap)[0]+h;if(!this.enableTabScroll||g<1||b<20){return}if(a<=c){e.scrollLeft=0;f.setWidth(c);if(this.scrolling){this.scrolling=false;this.pos.removeClass("x-tab-scrolling");this.scrollLeft.hide();this.scrollRight.hide();if(Ext.isAir||Ext.isWebKit){e.style.marginLeft="";e.style.marginRight=""}}}else{if(!this.scrolling){this.pos.addClass("x-tab-scrolling");if(Ext.isAir||Ext.isWebKit){e.style.marginLeft="18px";e.style.marginRight="18px"}}c-=f.getMargins("lr");f.setWidth(c>20?c:20);if(!this.scrolling){if(!this.scrollLeft){this.createScrollers()}else{this.scrollLeft.show();this.scrollRight.show()}}this.scrolling=true;if(h>(a-c)){e.scrollLeft=a-c}else{this.scrollToTab(this.activeTab,false)}this.updateScrollButtons()}},createScrollers:function(){this.pos.addClass("x-tab-scrolling-"+this.tabPosition);var c=this.stripWrap.dom.offsetHeight;var a=this.pos.insertFirst({cls:"x-tab-scroller-left"});a.setHeight(c);a.addClassOnOver("x-tab-scroller-left-over");this.leftRepeater=new Ext.util.ClickRepeater(a,{interval:this.scrollRepeatInterval,handler:this.onScrollLeft,scope:this});this.scrollLeft=a;var b=this.pos.insertFirst({cls:"x-tab-scroller-right"});b.setHeight(c);b.addClassOnOver("x-tab-scroller-right-over");this.rightRepeater=new Ext.util.ClickRepeater(b,{interval:this.scrollRepeatInterval,handler:this.onScrollRight,scope:this});this.scrollRight=b},getScrollWidth:function(){return this.edge.getOffsetsTo(this.stripWrap)[0]+this.getScrollPos()},getScrollPos:function(){return parseInt(this.stripWrap.dom.scrollLeft,10)||0},getScrollArea:function(){return parseInt(this.stripWrap.dom.clientWidth,10)||0},getScrollAnim:function(){return{duration:this.scrollDuration,callback:this.updateScrollButtons,scope:this}},getScrollIncrement:function(){return this.scrollIncrement||(this.resizeTabs?this.lastTabWidth+2:100)},scrollToTab:function(e,a){if(!e){return}var c=this.getTabEl(e);var g=this.getScrollPos(),d=this.getScrollArea();var f=Ext.fly(c).getOffsetsTo(this.stripWrap)[0]+g;var b=f+c.offsetWidth;if(f<g){this.scrollTo(f,a)}else{if(b>(g+d)){this.scrollTo(b-d,a)}}},scrollTo:function(b,a){this.stripWrap.scrollTo("left",b,a?this.getScrollAnim():false);if(!a){this.updateScrollButtons()}},onWheel:function(f){var g=f.getWheelDelta()*this.wheelIncrement*-1;f.stopEvent();var h=this.getScrollPos();var c=h+g;var a=this.getScrollWidth()-this.getScrollArea();var b=Math.max(0,Math.min(a,c));if(b!=h){this.scrollTo(b,false)}},onScrollRight:function(){var a=this.getScrollWidth()-this.getScrollArea();var c=this.getScrollPos();var b=Math.min(a,c+this.getScrollIncrement());if(b!=c){this.scrollTo(b,this.animScroll)}},onScrollLeft:function(){var b=this.getScrollPos();var a=Math.max(0,b-this.getScrollIncrement());if(a!=b){this.scrollTo(a,this.animScroll)}},updateScrollButtons:function(){var a=this.getScrollPos();this.scrollLeft[a===0?"addClass":"removeClass"]("x-tab-scroller-left-disabled");this.scrollRight[a>=(this.getScrollWidth()-this.getScrollArea())?"addClass":"removeClass"]("x-tab-scroller-right-disabled")},beforeDestroy:function(){if(this.items){this.items.each(function(a){if(a&&a.tabEl){Ext.get(a.tabEl).removeAllListeners();a.tabEl=null}},this)}if(this.strip){this.strip.removeAllListeners()}Ext.TabPanel.superclass.beforeDestroy.apply(this)}});Ext.reg("tabpanel",Ext.TabPanel);Ext.TabPanel.prototype.activate=Ext.TabPanel.prototype.setActiveTab;Ext.TabPanel.AccessStack=function(){var a=[];return{add:function(b){a.push(b);if(a.length>10){a.shift()}},remove:function(e){var d=[];for(var c=0,b=a.length;c<b;c++){if(a[c]!=e){d.push(a[c])}}a=d},next:function(){return a.pop()}}};