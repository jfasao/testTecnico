 
 <script type="text/javascript">
 
 var msg = function(title, msg, tipoMsg){

     Ext.Msg.show({
         title: title,
         msg: msg,
         minWidth: 400,
         closable:false,
         modal: true,            
         icon: tipoMsg,
         buttons: Ext.Msg.OK
     });
     };

     

function reloadgrilla()
{
	storeEstado.reload(); 
}

function verGrilla()
{ 	
	 storeEstado.load({params:{start:0, limit:recordCount}});
}

 
		
	
</script>



 <body >			
	<table width="100%"  align="center" cellpadding="2" cellspacing="0">
				<tr>
				<td>
				<div id="gridEstadoDiv" >
				</div>
				
			 </td>	
		</tr>		
	</table>
</body>





<script type="text/javascript">

var fps =     new Ext.form.FormPanel({
    baseCls: 'x-plain',   
    el: 'formGeneric',
   layoutConfig:'ColumnLayout',     
   method:'POST',
   defaults: 
	{
        anchor: '95%',
        allowBlank: false,
        msgTarget: 'side'
    }         
});


var myReaderEstado= new Ext.data.JsonReader({
	totalProperty: 'totalCount',
	root: 'estados',
		id: 'id',	
	fields:[{name: 'id', mapping: 'id'},
	    	{name: 'descripcion', mapping: 'descripcion'}
  			]
	});
	
	

var myHttpProxyEstado = new Ext.data.HttpProxy({
		url: '../generic/grillaEstado.action',
		method:'POST',
		autoLoad:false
		});

var storeEstado = new Ext.data.Store({
	 proxy: myHttpProxyEstado,
 	 reader: myReaderEstado,
 	 remoteSort: true,
	 baseParams: {limit:parseInt((screen.height-320)/25)},
	 sortInfo: {
		    field: 'descripcion',
		    direction: 'asc' // or 'DESC' (case sensitive for local sorting)
		}
 });



var sm2 = new Ext.grid.CheckboxSelectionModel({singleSelect:true});

var filtersEstado = new Ext.ux.grid.GridFilters({
	  filters:[
	    {type: 'string',  dataIndex: 'descripcion'}
	    ]});

Ext.onReady(function(){

		Ext.QuickTips.init();

	function eliminarEstado(){ 
		if(Ext.getCmp('gridEstado').getSelectionModel().getCount()==1){				
			Ext.MessageBox.confirm('Eliminar el Estado','¿Realmente Desea eliminar el  Estado '+ Ext.getCmp('gridEstado').getSelectionModel().getSelected().data.descripcion+'?',eliminarPress);
		}else{
			Ext.MessageBox.alert("Atención","Debe seleccionar un registro para eliminar");
		}
	}
	function eliminarPress(btn)
	{
		if(btn=='yes'){
			   fps.getForm().submit({
		            url: '../generic/EstadoActionremove.action',                        
		            params : 
			            {
				            'id':Ext.getCmp('gridEstado').getSelectionModel().getSelected().data.id
				        },               
				        waitMsg: 'Eliminando...',                
			            waitTitle : 'Procesando petición', 
			            failure : function(fps, o){   
			                msg('Error', o.result.msg, Ext.Msg.ERROR );	  
			                reloadgrilla();              
			            }    ,                          
			            success: function(fps, o){
			                msg('Información', o.result.msg ,Ext.Msg.INFO); 
			                reloadgrilla();		                  
			            }                         
		        });
		}	
	}

	cmodel = new Ext.grid.ColumnModel([
		                          		sm2,
		                           		{id: 'id', 
		                                    header: "Ident",	                                    
		                                    sortable: true,
		                                    dataIndex: 'id',
		                                    hidden:true,
		                                        width : 50
		                                } ,
		                                {id: 'descripcion', 
				                            header: "Descripción",	                                    
				                            sortable: true,
				                            dataIndex: 'descripcion',
				                            width : 300
				                        }                      	     	    								                                                 
		                               	]);
	
	var gridEstado = new Ext.grid.EditorGridPanel({
		iconCls:'icon-grid',   
		title:'',	    
		height:screenHeight,
	  	autoWidth:true,
	  	stripeRows: true,
	    id:'gridEstado',
	    renderTo:'gridEstadoDiv',
	    store: storeEstado,    
	    cm: cmodel,
	    sm: sm2,    
	    enableColumnMove:true,
	    enableColumnResize:true,	
	    plugins: [filtersEstado],    
	    trackMouseOver:true,
	    loadMask: true,  
		autoExpandColumn: 'descripcion',  
	    tbar:[
			{
			    text:'Agregar',
			    iconCls:'add',
			    id:'agregarBoton',
			    //hidden:(<%=request.getAttribute("ALTA")%>!=null)?false:true,    
			    handler:function (){saveOrUpdateEstado("ALTA");}
			}, '-',{
				text:'Editar',
			    iconCls:'editar',
			    id:'editarBoton',	        
			      //  hidden:(<%=request.getAttribute("MODIFICAR")%>!=null)?false:true,    
			    handler:function (){saveOrUpdateEstado("MODIFICAR");}
	    	},'-',{
		        text:'Eliminar',
		        iconCls:'eliminar',
		        id:'eliminar',	            
		        //hidden:(<%=request.getAttribute("ELIMINAR")%>!=null)?false:true,
		        handler:eliminarEstado
	    	} 
	    ],
	    bbar: new Ext.PagingToolbar({
	        pageSize:parseInt((screen.height-320)/25),
	        store: storeEstado,	       
	        displayInfo: true,
	        displayMsg: 'Mostrando {0} - {1} de {2}',
	        plugins: [filtersEstado,new Ext.ux.ProgressBarPager(),new Ext.ux.SlidingPager()],
	        emptyMsg: "No hay paginas para mostrar",            
	        items:[
	               {
	              pressed: false,
	              enableToggle:true,
	              text: 'Borrar Filtros',
	              cls: 'x-btn-text-icon details',
	               toggleHandler: function() { filtersEstado.clearFilters(); }	              
	          }
	          ]
	    })
	});

	
		
	gridEstado.on('afteredit', afterEdit, this ); function afterEdit(val) {     val.record.commit(); };



	function saveOrUpdateEstado(status){	
		
		var descripcionEstado = new Ext.form.TextField({
			name:'abmObjet.descripcion',
			id:'descripcion',		
			allowBlank:false,
			msgTarget:'side',
			blankText : 'Este campo es requerido.',
			labelStyle: 'font:normal 10px Verdana;text-align: right;',
			fieldLabel:'Descripción',		
			width:300
			});

		var estadoId = new Ext.form.Hidden({
			name:'abmObjet.id',
			id:'id'		
			});
		

		var navEstado = new Ext.FormPanel({
			id:'navEstado',
		    baseCls: 'x-plain',		
			method:'POST',	
			labelWidth: 100,				
			height: 130,
			width: 475, 
			border:false,
			monitorValid:true,
		      listeners:{clientvalidation:function(form, valid)
			 		{  		 										
						if (valid)
							{
								Ext.getCmp('guardarRecEstado').enable();
								}else{
								Ext.getCmp('guardarRecEstado').disable();
							}													    		                            					
					}
				},   
			 bodyStyle:'background-color:#F5f5f5;padding:10px 10px 10px 10px;',		
			 items: [{bodyStyle:'background-color:#Ffffff;padding:10px 10px 10px 10px;',
		            layout:'form',	
						            				 		
		            items:
			            [estadoId,descripcionEstado]}]				
		});	 
		
		if (status=='MODIFICAR'){
			if(Ext.getCmp('gridEstado').getSelectionModel().getCount()==1){
			
				accion = 'update';
			}else{
								
					Ext.MessageBox.alert("Atención","Debe seleccionar un registro para editar");
					return;
			} 
		}else{
			accion = 'save';			
		}


		
		var winEstado = new Ext.Window({
		      title: 'Agregar/Editar Tipo de Estado',	     
		      width: 490,
		      closeAction : 'destroy',
		      id:'winEstado',
		      height: 130,
		      resizable :false,
		      shadow : true,
		      shadowOffset : 8,
		      modal:true,
		      plain: false,
		      maximizable :false,	
		      closable :false,      
		      items: [navEstado],
		      tbar:[{
		          text:'Guardar',
		          id: 'guardarRecEstado',
		          iconCls:'add',
			      handler:function(){ 
			     
			    	  navEstado.getForm().submit({
				            url: '../generic/EstadoAction'+accion+'.action', 
							waitMsg: 'Grabando...',                
				            waitTitle : 'Procesando petición', 
				            failure : function(fps, o){   
				                msg('Error', o.result.msg, Ext.Msg.ERROR );	  
				                reloadgrilla();              
				            }    ,                          
				            success: function(fps, o){
				                msg('Información', o.result.msg ,Ext.Msg.INFO); 
				                winEstado.destroy(); 
				                reloadgrilla();		                  
				            }                       
				        });
			     	}			     
			     },{
			          text:'Cerrar',
			          iconCls:'eliminar',
			          handler:function(){ winEstado.destroy();}    
			     }]   
		 });	
			
		winEstado.show();
		descripcionEstado.validate(); 
		
		if (accion=='update'){
			Ext.getCmp('navEstado').getForm().loadRecord(
					Ext.getCmp('gridEstado').getSelectionModel().getSelected()
					);	
			descripcionEstado.setValue(descripcionEstado.getValue().split('&#39;').join("'"));
			}	
	
		descripcionEstado.focus(false,500);

		
	}

verGrilla();
	
});


</script>

