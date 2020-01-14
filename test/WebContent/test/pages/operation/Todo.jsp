 <%@ taglib prefix="s" uri="/struts-tags"%>
 <style>

  .upload-icon {
            background: url('../altec/scripts/extjs3/examples/shared/icons/fam/image_add.png') no-repeat 0 0 !important;
        }
 </style>
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

     

function reloadgrilla(){
	storeTodo.reload(); 
	Ext.getCmp('fpDocumentos').disable();
}

function verGrilla(){ 	
	 storeTodo.load({params:{start:0, limit:recordCount}});
		Ext.getCmp('fpDocumentos').disable();
}

 
		
	
</script>



<body>

	<s:form   name="formReporteTodos" method="post"  id="formReporteTodos" theme="simple">
	</s:form>
	<table width="100%" align="center" cellpadding="2" cellspacing="0">
		<tr>
			<td>
				<div id="gridTodoDiv"></div>

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
   defaults:{
	        anchor: '95%',
	        allowBlank: false,
	        msgTarget: 'side'
    		}         
});


var myReaderTodo= new Ext.data.JsonReader({
	totalProperty: 'totalCount',
	root: 'todos',
	id: 'id',	
	fields:[{name: 'id', mapping: 'id'},
	    	{name: 'descripcion', mapping: 'descripcion'},
	    	{name: 'estado9descripcion', mapping: 'estado9descripcion'}
  			]
	});
	
	

var myHttpProxyTodo = new Ext.data.HttpProxy({
		url: '../generic/grillaTodo.action',
		method:'POST',
		autoLoad:false
		});

var storeTodo = new Ext.data.Store({
	 proxy: myHttpProxyTodo,
 	 reader: myReaderTodo,
	 remoteSort: true,
	 baseParams: {limit:20},
	 sortInfo: {
		    field: 'descripcion',
		    direction: 'asc' // or 'DESC' (case sensitive for local sorting)
		}
 });



var sm2 = new Ext.grid.CheckboxSelectionModel({singleSelect:true});

var filtersTodo = new Ext.ux.grid.GridFilters({
	  filters:[
	    {type: 'string',  dataIndex: 'descripcion'},
	    {type: 'string',  dataIndex: 'estado9descripcion'}
	    ]});

Ext.onReady(function(){

	Ext.QuickTips.init();


	function eliminarTodo(){ 
		if(Ext.getCmp('gridTodo').getSelectionModel().getCount()==1){				
			Ext.MessageBox.confirm('Eliminar Todo','¿Realmente Desea eliminar la Todo '+ Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.descripcion+'?',eliminarPress);
		}else{
			Ext.MessageBox.alert("Atención","Debe seleccionar un registro para eliminar");
		}
	}
	function eliminarPress(btn)
	{
		if(btn=='yes'){
			   fps.getForm().submit({
		            url: '../generic/TodoActionremove.action',                        
		            params : 
			            {
				            'id':Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.id
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
		                                },{id: 'descripcion', 
				                            header: "Descripción",	                                    
				                            sortable: true,
				                            dataIndex: 'descripcion',
				                            width : 650
				                        },
				                       	{id: 'estado9descripcion', 
							                 header: "Estado",	                                    
							                 sortable: true,
							                 dataIndex: 'estado9descripcion',
							                 width : 150
							                
							             }               	     	    								                                                 
		                               	]);
	
	function handleActivateTodo(){

		if(gridTodo.getSelectionModel().getCount()>0){
			Ext.getCmp('fpDocumentos').enable();
		}else{
			Ext.getCmp('fpDocumentos').disable();
		}
	};
	
	var gridTodo = new Ext.grid.EditorGridPanel({
		iconCls:'icon-grid',   
		title:'TODOS',	    
		height:screenHeight,
	  	autoWidth:true,
	  	stripeRows: true,
	  	listeners: {rowclick: handleActivateTodo},
	    id:'gridTodo',
		autoExpandColumn: 'descripcion',  
	    //renderTo:'gridTodoDiv',
	    store: storeTodo,    
	    cm: cmodel,
	    sm: sm2,    
	    enableColumnMove:true,
	    enableColumnResize:true,	
	    plugins: [filtersTodo],    
	    trackMouseOver:true,
	    loadMask: true,    
	    tbar:[{
			    text:'Agregar',
			    iconCls:'add',
			    id:'agregarBoton',
			   // hidden:(<%=request.getAttribute("ALTA")%>!=null)?false:true,    
			    handler:function (){saveOrUpdateTodo("ALTA");}
			}, '-', {
				text:'Editar',
			    iconCls:'editar',
			    id:'editarBoton',	        
			    //hidden:(<%=request.getAttribute("MODIFICAR")%>!=null)?false:true,    
			    handler:function (){saveOrUpdateTodo("MODIFICAR");}
	    	},'-',{
		        text:'Eliminar',
		        iconCls:'eliminar',
		        id:'eliminar',	            
		        //hidden:(<%=request.getAttribute("ELIMINAR")%>!=null)?false:true,
		        handler:eliminarTodo
	    	} ,'-',{
	  		    text: 'pdf',		   
	  		    iconCls:'pdf',
	  		    tabIndex:4,
				//hidden:(<%=request.getAttribute("ALTA")%>!=null)?false:true,
	  		    handler: function(){printTodo('PDF');}
  			  }
	    ],
	    bbar: new Ext.PagingToolbar({
	        pageSize:parseInt((screen.height-320)/25),
	        store: storeTodo,	       
	        displayInfo: true,
	        displayMsg: 'Mostrando {0} - {1} de {2}',
	        plugins: [filtersTodo,new Ext.ux.ProgressBarPager(),new Ext.ux.SlidingPager()],
	        emptyMsg: "No hay paginas para mostrar",            
	        items:[
	               {
	              pressed: false,
	              enableToggle:true,
	              text: 'Borrar Filtros',
	              cls: 'x-btn-text-icon details',
	               toggleHandler: function()
	              {
	            	   filtersTodo.clearFilters();
	 	              }	              
	          }
	          ]
	    })
	});

	
		
	gridTodo.on('afteredit', afterEdit, this ); function afterEdit(val) {     val.record.commit(); };



	function saveOrUpdateTodo(status)
	{	
		
		var descripcionTodo = new Ext.form.TextField({
			name:'abmObjet.descripcion',
			id:'descripcion',		
			allowBlank:false,
			blankText : 'Este campo es requerido.',	
			msgTarget:'side',
			labelStyle: 'font:normal 10px Verdana;text-align: right;',
			fieldLabel:'Descripción',		
			width:370
			});

		
		var todoId = new Ext.form.Hidden({
			name:'abmObjet.id',
			id:'id'		
			});

		var nameEstado = new Ext.data.JsonStore({
	 		fields: ['id','descripcion'],    
	 	    proxy: new Ext.data.HttpProxy({ method: 'POST', url:'../generic/doComboEstado.action'}),
	 	    autoLoad:false
	 	});


	 	var cmbEstado= new Ext.form.ComboBox({
	 	    id:'cmbEstado',
		 	name:'estadoId',
		 	store: nameEstado,       
		 	hiddenName: "estadoId",		 	
		 	allowBlank:false,
			blankText : 'Este campo es requerido.',	
	        msgTarget:'side',
		 	displayField:'descripcion',
		 	valueField: 'id',
		 	typeAhead: false,     		 	  
		 	triggerAction: 'all',
		 	emptyText:'Seleccione una Estado..',              
		 	loadingText: 'cargando...',
		 	minChars:2, 
		 	forceSelection : true,
		 	selectOnFocus:true,
		 	 labelStyle: 'font:normal 10px Verdana;text-align: right;',
			fieldLabel:'Estado',	
		 	listWidth:300,     	
		 	width: 300,
		 	mode: 'remote'	
	 	});
		
		
		var navTodo = new Ext.FormPanel({
			 id:'navTodo',
		     baseCls: 'x-plain',		
			 method:'POST',				
			 height: 150,
			 labelWidth: 100, 			          
			 width: 550, 
			 border:false,
			 monitorValid:true,
		     listeners:{clientvalidation:function(form, valid){  		 										
						if (valid){
								Ext.getCmp('guardarRecTodo').enable();
						}else{
								Ext.getCmp('guardarRecTodo').disable();
						}													    		                            					
					}
				}, 
			 bodyStyle:'background-color:#F5f5f5;padding:10px 10px 10px 10px;',		
			 items: [{bodyStyle:'background-color:#Ffffff;padding:10px 10px 10px 10px;',
		            layout:'form',		            				 		
		            items:
			            [todoId,descripcionTodo, cmbEstado]}]				
		});	 
		
		if (status=='MODIFICAR'){
			if(Ext.getCmp('gridTodo').getSelectionModel().getCount()==1){
				accion = 'update';
			}else{
				Ext.MessageBox.alert("Atención","Debe seleccionar un registro para editar");
				return;
			} 
		}else {
			accion = 'save';			
		}


		
		var winTodo = new Ext.Window({
		      title: 'Agregar/Editar Todo',	     
		      width: 570,
		      closeAction : 'destroy',
		      id:'winTodo',
		      height: 150,
		      resizable :false,
		      shadow : true,
		      shadowOffset : 8,
		      modal:true,
		      plain: false,		      
		      maximizable :false,	
		      closable :false,
		                
		      items: [navTodo],
		      tbar:[{
			          text:'Guardar',
			          id: 'guardarRecTodo',
			          iconCls:'add',
				      handler:function(){ 
				    	  navTodo.getForm().submit({
					            url: '../generic/TodoAction'+accion+'.action',  
					            params:{'estadoId':cmbEstado.getValue()} ,
					            waitMsg: 'Grabando...',                
					            waitTitle : 'Procesando petición', 
					            failure : function(fps, o){   
					                msg('Error', o.result.msg, Ext.Msg.ERROR );	  
					                reloadgrilla();              
					            },                          
					            success: function(fps, o){
					                msg('Información', o.result.msg ,Ext.Msg.INFO); 
					                winTodo.destroy(); 
					                reloadgrilla();		                  
					            }                       
				        	});
				     }			     
			     },{
			          text:'Cerrar',
			          iconCls:'eliminar',
			          handler:function(){winTodo.destroy();}    
			    }]   
		 });	
			
		winTodo.show();
		descripcionTodo.focus(false,500);
		cmbEstado.validate();

		if (accion=='update'){
			//console.log(Ext.getCmp('gridTodo').getSelectionModel().getSelected());
			Ext.getCmp('navTodo').getForm().loadRecord(
					Ext.getCmp('gridTodo').getSelectionModel().getSelected()
					
					);	
				descripcionTodo.setValue(descripcionTodo.getValue().split('&#39;').join("'"));
				
				rec = Ext.data.Record.create(
		    			{name: 'id'},
		    			{name: 'descripcion'}
		    			);
				ident = Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.estado9id;
				val = Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.estado9descripcion;
		    	tmprec = new rec({id:ident, descripcion:val});
		    	nameEstado.add(tmprec);
		    	cmbEstado.setValue(ident);
			}	

		

		
	}
	
	function printTodo(obj){
		
		
		document.formReporteTodos.action="../generic/printTodos.action?type="+obj;
		document.formReporteTodos.target="_blank";
		document.formReporteTodos.submit();

				     			
	};

	/**
 	*
 	*Se agrega pestaña de manejo de documentos
 	*
 	*/
 	
 	
 	  var fibasic = new Ext.ux.form.FileUploadField({
 	        width: 200
 	    });
 	    
 	 var myHttpProxyDocumentos = new Ext.data.HttpProxy({
 		url: '../generic/grillaByTodoDocumento.action',
 		method:'POST',
 		autoLoad:false
 		});
 	
 	    var myReaderDocumentos= new Ext.data.JsonReader({
 			totalProperty: 'totalCount',
 			root: 'docs',
 			id: 'documentoId',	
 			fields:[{name: 'documentoId', mapping: 'documentoId'},
 			        {name: 'nombreDoc', mapping: 'nombreDoc'},
 			    	{name: 'contentType', mapping: 'contentType'},
 			    	{name: 'comentario', mapping: 'comentario'},
 			    	{name: 'ruta', mapping: 'ruta'}
 		  			]
 			});
 		
 	    


 	   var storeDocumentos = new Ext.data.Store({
 		  proxy: myHttpProxyDocumentos,
 		  reader: myReaderDocumentos,
 		  remoteSort: true,
 		  sortInfo: {
 			    field: 'documentoId',
 			    direction: 'asc' // or 'DESC' (case sensitive for local sorting)
 			}
 		 });
 	   
 	   var sDocumentosmodel = new Ext.grid.CheckboxSelectionModel({singleSelect:true});

 	   var rowNumbererDocumentos = new Ext.grid.RowNumberer({
 		    width :30,
 			renderer:function(v, p, record, rowIndex){
 							return "<p style='color:#2C66D8;'>"+(rowIndex+1)+"</p>";
 					}});
 	   
 	   cmodelDocumentos = new Ext.grid.ColumnModel([
 					 rowNumbererDocumentos,
 	                 sDocumentosmodel,
 			                                
 					{
 						id : 'documentoId',
 						header : "Documento Id",
 						sortable : false,
 						dataIndex : 'documentoId',
 						width : 100
 					}, {
 						id : 'nombreDoc',
 						header : "Nombre Archivo",
 						sortable : false,
 						dataIndex : 'nombreDoc',
 						width : 100
 					}, {
 						id : 'comentario',
 						header : "Comentario",
 						sortable : false,
 						dataIndex : 'comentario',
 						width : 180
 					}, {
 						id : 'ruta',
 						header : "Ruta",
 						sortable : false,
 						dataIndex : 'ruta',
 						width : 80
 					}]);

 					var gridDocumentos = new Ext.grid.EditorGridPanel({
 						title : 'Documentos',
 						iconCls : 'icon-grid',
 						autoScroll:true,
 						height : 400,//(screen.height - 700),
 						width : parseInt(screenWidth / 2) - 100,
 						stripeRows : true,
 						id : 'gridDocumentos',
 						sm : sDocumentosmodel,
 						store : storeDocumentos,
 						autoExpandColumn : 'nombreDoc',
 						cm : cmodelDocumentos
 					});
 					
 					function handleActivateDocumento(){
 						if(gridTodo.getSelectionModel().getCount()>0){
 							storeDocumentos.load({params:{limit:14,'todoId':Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.id}});
 							
 						}
 					};
 					
 					var fpDocumentos = new Ext.FormPanel(
 							{
 								
 								fileUpload : true,
 								listeners: {activate: handleActivateDocumento},	
 								id:'fpDocumentos',
 								width : screenWidth,
 								height : screenHeight,
 								frame : true,
 								title : 'Documentos',
 								//     autoHeight: true,
 								bodyStyle : 'padding: 10px 10px 0 10px;',
 								labelWidth : 50,
 								defaults : {
 									anchor : '95%',
 									allowBlank : true,
 									msgTarget : 'side'
 								},
 								items : [{
 						            xtype: 'fileuploadfield',
 						            id: 'documentosFile',
 						            width:(screen.width-100),
 						            labelStyle: 'font:normal 10px Verdana;',
 						            emptyText: 'Archivo de Documento...',
 						            fieldLabel: 'Documento',
 						            name: 'documentosFile',
 						            buttonText: '',
 						            buttonCfg: {
 						                iconCls: 'detalle'
 						            }
 						        },
 								gridDocumentos 
 								],
 								buttons : [{
 											text : 'Importar',
 											handler : function() {
 													if (fpDocumentos.getForm().isValid()) {
 														fpDocumentos.getForm().submit({
 																		url : '../generic/uploadDocumentoTodo.action',
 																		params:{'id':Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.id},
 																		waitMsg : 'Procesando...',
 																		waitTitle : 'Procesando petición', 
 																		success : function(fp,o) {
 																			msg('Información', o.result.msg ,Ext.Msg.INFO); 
 																			Ext.getCmp('gridDocumentos').getStore().loadData(o.result.documentos);
 																			
 																		},
 																		failure : function(fps, o){   
 															                msg('Error', o.result.msg, Ext.Msg.ERROR );	  
 															                             
 															            }  
 															});
 													}
 											}
 										},{
 											text : 'Descargar',
 											handler : function() {
 												
 												fpDocumentos.getForm().submit({
 																url : '../generic/downLoadDocumento.action',
 																method:'POST',
 																params:{'idArchivo':Ext.getCmp('gridDocumentos').getSelectionModel().getSelected().data.documentoId},
 																/*waitMsg : 'Procesando...',
 																//waitTitle : 'Procesando petición', 
 																failure : function(fps, o){   
 																	                msg('Error', o.result.msg, Ext.Msg.ERROR );	  
 																	                
 													    		},                          
 															    success: function(fps, o){
 																	                msg('Información', o.result.msg ,Ext.Msg.INFO);
 																	                console.log(o.result.msg);
 																	               
 													    		}  */
 													});
 												console.log("aca");
 												
 											}
 										}]
 							});
 	
 	
 /**
 *
 *Fin carga documentos
 *
 */
 	

	var PadrePanel = new Ext.TabPanel({
		id:"TodoMainPanel",
	//	layout:'anchor',
		title:'Todos',
		renderTo:'gridTodoDiv',
		activeTab:'gridTodo',
		autoWidth:true,
		items:[gridTodo,fpDocumentos],
		height:screen.height-330,	
	});
	
});


</script>

