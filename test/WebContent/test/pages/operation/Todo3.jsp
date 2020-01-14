 <%@ taglib prefix="s" uri="/struts-tags"%>

 <style>
 .labels {font:normal 10px Verdana;
 			text-align: right;}
.busqueda{
 		background-image:url(../altec/images/search_small.png) !important;
 	}
  .upload-icon {
            background: url('../altec/scripts/extjs3/examples/shared/icons/fam/image_add.png') no-repeat 0 0 !important;
        }
 </style>
 <script type="text/javascript">
 var storeDictamenTodoGlobal ='';
 var msg = function(title, msg, tipoMsg){

     Ext.Msg.show({
         title: title,
         msg: msg,
         minWidth: 200,
         closable:false,
         modal: true,            
         icon: tipoMsg,
         buttons: Ext.Msg.OK
     });
     };

     

function reloadgrilla()
{
	storeTodo.reload();
	Ext.getCmp('gridDictamenTodo').disable();
	Ext.getCmp('fpDocumentos').disable();
}

function verGrilla()
{ 	
	 storeTodo.load({params:{start:0, limit:recordCount}});
	 Ext.getCmp('gridDictamenTodo').disable();
	 Ext.getCmp('fpDocumentos').disable();
}



  
function agregarTodo(acc){

	Ext.QuickTips.init();

		

	
	var TodoId = new Ext.form.Hidden({
		name:'id',
		id:'TodoId',
		value:((acc=='update')||(acc=='ver'))?Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.TodoId:0
		});
	
	var actaTodoId = new Ext.form.Hidden({
		name:'id',
		id:'actaTodoId',
		value:((acc=='update')||(acc=='ver'))?Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.actaId:0
		});
	
	var numeroTodo = new Ext.form.NumberField({
		name:'abmObjet.TodoId',
		id:'numeroTodo',		
		//allowBlank:false,
		//blankText : 'Este campo es requerido.',	
		//msgTarget:'side',
		disabled:true,
		labelStyle: 'font:normal 10px Verdana;text-align: right;',
		fieldLabel:'Todo Nº',
		value:((acc=='update')||(acc=='ver'))?Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.TodoId:0,
		width:100
		});
		
	
	var nameSumariante = new Ext.data.JsonStore({
 		fields: ['sumarianteId','nombre'],    
 	    proxy: new Ext.data.HttpProxy({ method: 'POST', url:'../generic/comboSumariante.action'}),
 	    autoLoad:false
 	});
	var nameAsesorLetrado = new Ext.data.JsonStore({
 		fields: ['asesorLetradoId','nombre'],    
 	    proxy: new Ext.data.HttpProxy({ method: 'POST', url:'../generic/comboAsesorLetrado.action'}),
 	    autoLoad:false
 	});


 	var cmbSumariante= new Ext.form.ComboBox({
 	    id:'cmbSumariante',
	 	name:'sumarianteId',
	 	store: nameSumariante,       
	 	hiddenName: "sumarianteId",		 	
	 	allowBlank:false,
	 	displayField:'nombre',
	 	valueField: 'sumarianteId',
	 	triggerAction: 'all',
	 	emptyText:'Seleccione...',              
	 	loadingText: 'cargando...',
	 	minChars:2, 
		blankText : 'Este campo es requerido.',	
		msgTarget:'side',
		validator:function(){if((this.getValue()=='')||(this.getValue()==-1)){return false}else{return true}},
	 	forceSelection : false,
	 	selectOnFocus:true,
	 	  labelStyle: 'font:normal 10px Verdana;text-align: right;',
			fieldLabel:'Sumariante',	
	 	listWidth: 150,     	
	 	width: 150,
	 	mode: 'remote'	
	 	});

 	var nameDelegacionTodo = new Ext.data.JsonStore({
 		fields: ['localidadId','nombre'],    
 	    proxy: new Ext.data.HttpProxy({ method: 'POST', url:'../generic/comboDelegacionTodo.action'}),
 	    autoLoad:false
 	});

 	var cmbDelegacionTodo= new Ext.form.ComboBox({
 	    id:'cmbDelegacionTodo',
	 	name:'abmObjet.delegacion.localidadId',
	 	store: nameDelegacionTodo,       
	 	hiddenName: "abmObjet.delegacion.localidadId",		 	
	 	allowBlank:false,
	 	displayField:'nombre',
	 	valueField: 'localidadId',
	 	triggerAction: 'all',
	 	emptyText:'Seleccione...',              
	 	loadingText: 'cargando...',
	 	minChars:2, 
		blankText : 'Este campo es requerido.',	
		msgTarget:'side',
		validator:function(){if((this.getValue()=='')||(this.getValue()==-1)){return false}else{return true}},
	 	forceSelection : false,
	 	selectOnFocus:true,
	 	  labelStyle: 'font:normal 10px Verdana;text-align: right;',
			fieldLabel:'Delegación',	
	 	listWidth: 150,     	
	 	width: 150,
	 	mode: 'remote'	
	 	});
 	
 	var cmbAsesorLetrado= new Ext.form.ComboBox({
 	    id:'cmbAsesorLetrado',
	 	name:'asesor',
	 	store: nameAsesorLetrado,       
	 	hiddenName: "asesor",		 	
	 	allowBlank:false,
	 	displayField:'nombre',
	 	valueField: 'asesorLetradoId',
 	 	triggerAction: 'all',
	 	emptyText:'Seleccione...',              
	 	loadingText: 'cargando...',
	 	minChars:2, 
		blankText : 'Este campo es requerido.',	
		msgTarget:'side',
		validator:function(){if((this.getValue()=='')||(this.getValue()==-1)){return false}else{return true}},
		//forceSelection :true,
	 	forceSelection : false,
	 	selectOnFocus:true,
	 	  labelStyle: 'font:normal 10px Verdana;text-align: right;',
			fieldLabel:'Asesor Letrado',	
	 	listWidth: 150,     	
	 	width: 150,
	 	mode: 'remote'	
	 	});

 

	var fechaTodo = new Ext.form.DateField({ 
			fieldLabel: 'Fecha Todo',
			labelStyle: 'font:normal 10px Verdana;text-align: right;',
			format:'d/m/Y',
			altFormats:'d/m/y',
			allowBlank:false,
			msgTarget:'side',
			maxValue :new Date(), 
			value:((acc=='update')||(acc=='ver'))?Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.fecha:'',
			blankText : 'Este campo es requerido.'});

	var fechaTodoH = new Ext.form.Hidden({
		name:'fechaTodo', 
		id:'fechaTodo'
		});

	var fechaDACH = new Ext.form.Hidden({
		name:'fechaDAC', 
		id:'fechaDAC'
		});

	var fechaDAC = new Ext.form.DateField({
		id:'fechaD', 
		fieldLabel: 'Fecha del DAC',
		labelStyle: 'font:normal 10px Verdana;text-align: right;',
		format:'d/m/Y',
		altFormats:'d/m/y',
		allowBlank:true,
		disabled:true,
		msgTarget:'side',
		value:((acc=='update')||(acc=='ver'))?Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.fechaNotifDAC:'',
		blankText : 'Este campo es requerido.'});

	var numeroOrigen = new Ext.form.TextField({
		name:'abmObjet.numeroOrigen',
		id:'numeroOrigen',		
		allowBlank:true,
		blankText : 'Este campo es requerido.',	
		msgTarget:'side',
		maxLength:6,
		disabled:true,
		labelStyle: 'font:normal 10px Verdana;text-align: right;',
		fieldLabel:'Origen',	
		value:((acc=='update')||(acc=='ver'))?Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.numeroOrigen:'',	
		width:55
		});
	var letraOrigen = new Ext.form.TextField({
		name:'abmObjet.letraOrigen',
		id:'letraOrigen',		
		allowBlank:true,
		blankText : 'Este campo es requerido.',	
		msgTarget:'side',
		maxLength:6,
		disabled:true,
		labelStyle: 'font:normal 10px Verdana;text-align: right;',
		value:((acc=='update')||(acc=='ver'))?Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.letraOrigen:'',
		width:56
		});
	var anioOrigen = new Ext.form.TextField({
		name:'abmObjet.anioOrigen',
		id:'anioOrigen',		
		allowBlank:true,
		disabled:true,
		maxLength:4,
		minLength:4,
		blankText : 'Este campo es requerido.',	
		msgTarget:'side',
		labelStyle: 'font:normal 10px Verdana;text-align: right;',
		value:((acc=='update')||(acc=='ver'))?Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.anioOrigen:'',
		width:40
		});
	
	var diasClausurado = new Ext.form.NumberField({
		name:'abmObjet.diasClausurado',
		id:'diasClausurado',		
		allowBlank:true,
		blankText : 'Este campo es requerido.',	
		msgTarget:'side',
		disabled:true,
		labelStyle: 'font:normal 10px Verdana;text-align: right;',
		fieldLabel:'Días Clausurado',
		value:((acc=='update')||(acc=='ver'))?Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.diasClausura:'',		
		width:150
		});

	var numeroExpediente = new Ext.form.NumberField({
		name:'abmObjet.numeroExpediente',
		id:'numeroExpediente',		
		allowBlank:false,
		blankText : 'Este campo es requerido.',	
		msgTarget:'side',
		maxLength:6,
		allowDecimals:false,
		labelStyle: 'font:normal 10px Verdana;text-align: right;',
		fieldLabel:'Expediente',	
		value:((acc=='update')||(acc=='ver'))?Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.numeroExpediente:'',	
		width:55
		});
	
	var letraExpediente = new Ext.form.TextField({
		name:'abmObjet.letraExpediente',
		id:'letraExpediente',		
		allowBlank:false,
		blankText : 'Este campo es requerido.',	
		msgTarget:'side',
		maxLength:6,
		maskRe:/[A-Z,a-z]/,
		labelStyle: 'font:normal 10px Verdana;text-align: right;',
		value:((acc=='update')||(acc=='ver'))?Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.letraExpediente:'',
		width:56
		});
	
	var anioExpediente = new Ext.form.TextField({
		name:'abmObjet.anioExpediente',
		id:'anioExpediente',		
		allowBlank:false,
		maxLength:4,
		minLength:4,
		blankText : 'Este campo es requerido.',	
		msgTarget:'side',
		labelStyle: 'font:normal 10px Verdana;text-align: right;',
		value:((acc=='update')||(acc=='ver'))?Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.anioExpediente:'',
		width:40
		});
	
	var domicilioInsp = new Ext.form.TextField({
		name:'domicilioInsp',
		id:'domicilioInsp',		
		allowBlank:true,
		disabled:true,
		msgTarget:'side',
		value:((acc=='update')||(acc=='ver'))?Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.domicilioInspeccionado:'',
		labelStyle: 'font:normal 10px Verdana;text-align: right;',
		fieldLabel:'Dom. Insp.',		
		width:150
		});

	var domiciolioNotificacionEmpleador = new Ext.form.TextField({
		name:'abmObjet.domiciolioNotificacionEmpleador',
		id:'domiciolioNotificacionEmpleador',		
		allowBlank:false,
		disabled:false,
		msgTarget:'side',
		value:((acc=='update')||(acc=='ver'))?Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.domiciolioNotificacionEmpleador:'',
		labelStyle: 'font:normal 10px Verdana;text-align: right;',
		fieldLabel:'Dom. Notif. Emp.',		
		width:200
		});

	var namelocalidadNotificacionEmpleador = new Ext.data.JsonStore({
 		fields: ['localidadId','nombre'],    
 	    proxy: new Ext.data.HttpProxy({ method: 'POST', url:'../generic/comboLocalidad.action'}),
 	    autoLoad:false
 	});

 	var cmblocalidadNotificacionEmpleador= new Ext.form.ComboBox({
 	    id:'cmblocalidadNotificacionEmpleador',
	 	name:'abmObjet.localidadNotificacionEmpleador.localidadId',
	 	store: namelocalidadNotificacionEmpleador,       
	 	hiddenName: "abmObjet.localidadNotificacionEmpleador.localidadId",		 	
	 	allowBlank:false,
	 	displayField:'nombre',
	 	valueField: 'localidadId',
	 	triggerAction: 'all',
	 	emptyText:'Seleccione...',              
	 	loadingText: 'cargando...',
	 	minChars:2, 
		blankText : 'Este campo es requerido.',	
		msgTarget:'side',
	//	validator:function(){if((this.getValue()=='')||(this.getValue()==-1)){return false}else{return true}},
	 	forceSelection : false,
	 	selectOnFocus:true,
	 	labelStyle: 'font:normal 10px Verdana;text-align: right;',
		fieldLabel:'Loc. Notif. Empl.',	
	 	listWidth: 150,     	
	 	width: 150,
	 	mode: 'remote'	
	 	});

	
		
	var expedientePanel = new Ext.Panel({
		id:'expedientePanel',
		fieldLabel:'Expediente',
		labelStyle: 'font:normal 10px Verdana;text-align: right;',
		items: [numeroExpediente, 
				letraExpediente, 
				anioExpediente]
		});

	var origenPanel = new Ext.Panel({
		id:'origenPanel',
		fieldLabel:'Origen',
		labelStyle: 'font:normal 10px Verdana;text-align: right;',
		items: [numeroOrigen, 
				letraOrigen, 
				anioOrigen]
		});

	var DAC = new Ext.form.Checkbox({
		id:'dac',
		name:'abmObjet.dac',
		fieldLabel:'DAC',
		labelStyle: 'font:normal 10px Verdana;text-align: right;',
		checked:((acc=='update')&&(Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.dac=='true'))||((acc=='ver')&&(Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.dac=='true'))?true:false,
		listeners:{check:function(a,v){
							if (v) {
								fechaDAC.allowBlank=false;
								numeroOrigen.allowBlank=false;
								letraOrigen.allowBlank=false;
								anioOrigen.allowBlank=false;
								numeroOrigen.enable();
								letraOrigen.enable();
								anioOrigen.enable();
								cmbActas.allowBlank=true;
								fechaDAC.enable();
								domicilioInsp.allowBlank=false;
								domicilioInsp.enable();
								}
							else
							{
								fechaDAC.setValue('');
								numeroOrigen.setValue();
								letraOrigen.setValue();
								anioOrigen.setValue();
								fechaDAC.allowBlank=true;
								numeroOrigen.allowBlank=true;
								letraOrigen.allowBlank=true;
								anioOrigen.allowBlank=true;
								numeroOrigen.disable();
								letraOrigen.disable();
								anioOrigen.disable();
								cmbActas.allowBlank=false;
								fechaDAC.disable();
								cmbActas.enable();
								domicilioInsp.allowBlank=false;
								domicilioInsp.disable();
								}
							fechaDAC.validate();
							cmbActas.validate();
							numeroOrigen.validate();
							letraOrigen.validate();
							anioOrigen.validate();
							domicilioInsp.validate();
						
									}}		
		});
	var DACH = new Ext.form.Hidden({
		name:'DAC', 
		id:'DACH'
		});
	
	var clausurado = new Ext.form.Checkbox({
		id:'clausurado',
		name:'abmObjet.clausurado',
		fieldLabel:'Clausurado',
		labelStyle: 'font:normal 10px Verdana;text-align: right;',
		checked:((acc=='update')&&(Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.clausuradoPrev=='true'))||((acc=='ver')&&(Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.clausuradoPrev=='true'))?true:false,
		listeners:{check:function(a,v){
			if (v) {
				diasClausurado.allowBlank=false;
				diasClausurado.enable();
				}
			else
			{
				diasClausurado.allowBlank=true;
				diasClausurado.setValue('');
				diasClausurado.disable();
				}
			diasClausurado.validate();
		
					}}
		});

	var rebeldia = new Ext.form.Checkbox({
		id:'rebeldia',
		name:'abmObjet.rebeldia',
		fieldLabel:'Rebeldía',
		disabled:true,
		labelStyle: 'font:normal 10px Verdana;text-align: right;',
		checked:((acc=='update')&&(Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.rebeldia=='true'))||((acc=='ver')&&(Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.rebeldia=='true'))?true:false
		});
	
	var clausuradoH = new Ext.form.Hidden({
		name:'clausurado', 
		id:'clausuradoH'
		});
	var rebeldiaH = new Ext.form.Hidden({
		name:'rebeldia', 
		id:'rebeldiaH'
		});

	var persNRMascPerm = new Ext.form.NumberField({
		name:'abmObjet.persNRMascPerm',
		id:'persNRMascPerm',		
		allowBlank:false,
		blankText : 'Este campo es requerido.',	
		msgTarget:'side',
		minValue :0,
		allowDecimals :false,
		labelStyle: 'font:normal 10px Verdana;text-align: right;',
		fieldLabel:'Perm.',		
		width:35,
		value:((acc=='update')||(acc=='ver'))?Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.persNRMascPerm:0,
		listeners:{change:function(t,n,o){
			if (n!=o){
				//alert("aca");
				Ext.getCmp('persPorMascPerm').setValue(porcentaje(n,Ext.getCmp('persDetMascPerm').getValue()));	
			}
			}
		}
		});
	
	var persDetMascPerm = new Ext.form.NumberField({
		//name:'abmObjet.persNRMascPerm',
		id:'persDetMascPerm',		
		allowBlank:false,
		blankText : 'Este campo es requerido.',	
		msgTarget:'side',
		minValue :0,
		allowDecimals :false,
		labelStyle: 'font:normal 10px Verdana;text-align: right;',
		//fieldLabel:'Permanente',		
		width:35,
		disabled:true,
		value:((acc=='update')||(acc=='ver'))?Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.persDetMascPerm:0
		});
	
	var persPorMascPerm = new Ext.form.NumberField({
		//name:'abmObjet.persNRMascPerm',
		id:'persPorMascPerm',		
		allowBlank:false,
		blankText : 'Este campo es requerido.',	
		msgTarget:'side',
		minValue :0,
		allowDecimals :false,
		labelStyle: 'font:normal 10px Verdana;text-align: right;',
		fieldLabel:'%',		
		width:35,
		disabled:true,
		value:((acc=='update')||(acc=='ver'))?porcentaje(Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.persNRMascPerm,Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.persDetMascPerm):0
		});
	
	var persNRMascTrans = new Ext.form.NumberField({
		name:'abmObjet.persNRMasTrans',
		id:'persNRMascTrans',		
		allowBlank:false,
		blankText : 'Este campo es requerido.',	
		msgTarget:'side',
		minValue :0,
		allowDecimals :false,
		fieldLabel:'Trans.',
		labelStyle: 'font:normal 10px Verdana;text-align: right;',
		width:35,
		value:((acc=='update')||(acc=='ver'))?Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.persNRMascTrans:0,
		listeners:{change:function(t,n,o){
					if (n!=o){
						Ext.getCmp('persPorMascTrans').setValue(porcentaje(n,Ext.getCmp('persDetMascTrans').getValue()));	
					}
					}
				}
		});
	
	var persDetMascTrans = new Ext.form.NumberField({
		//name:'abmObjet.persNRMasTrans',
		id:'persDetMascTrans',		
		allowBlank:false,
		blankText : 'Este campo es requerido.',	
		msgTarget:'side',
		minValue :0,
		allowDecimals :false,
		//fieldLabel:'Transitorio',
		labelStyle: 'font:normal 10px Verdana;text-align: right;',
		width:35,
		disabled:true,
		value:((acc=='update')||(acc=='ver'))?Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.persDetMascTrans:0
		});
	
	var persPorMascTrans = new Ext.form.NumberField({
		//name:'abmObjet.persNRMascPerm',
		id:'persPorMascTrans',		
		allowBlank:false,
		blankText : 'Este campo es requerido.',	
		msgTarget:'side',
		minValue :0,
		allowDecimals :false,
		labelStyle: 'font:normal 10px Verdana;text-align: right;',
		fieldLabel:'%',		
		width:35,
		disabled:true,
		value:((acc=='update')||(acc=='ver'))?porcentaje(Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.persNRMascTrans,Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.persDetMascTrans):0
		});
	
	var persNRMascGol = new Ext.form.NumberField({
		name:'abmObjet.persNRMasGol',
		id:'persNRMascGol',		
		allowBlank:false,
		blankText : 'Este campo es requerido.',	
		msgTarget:'side',
		minValue :0,
		allowDecimals :false,
		fieldLabel:'Gol.',
		labelStyle: 'font:normal 10px Verdana;text-align: right;',
		width:35,
		value:((acc=='update')||(acc=='ver'))?Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.persNRMascGol:0,
		listeners:{change:function(t,n,o){
					if (n!=o){
						Ext.getCmp('persPorMascGol').setValue(porcentaje(n,Ext.getCmp('persDetMascGol').getValue()));	
					}
					}
				}
		});
	
	var persDetMascGol = new Ext.form.NumberField({
		//name:'abmObjet.persNRMasGol',
		id:'persDetMascGol',		
		allowBlank:false,
		blankText : 'Este campo es requerido.',	
		msgTarget:'side',
		minValue :0,
		allowDecimals :false,
		//fieldLabel:'Golondrina',
		labelStyle: 'font:normal 10px Verdana;text-align: right;',
		width:35,
		disabled:true,
		value:((acc=='update')||(acc=='ver'))?Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.persDetMascGol:0
		});
	
	var persPorMascGol = new Ext.form.NumberField({
		//name:'abmObjet.persNRMascPerm',
		id:'persPorMascGol',		
		allowBlank:false,
		blankText : 'Este campo es requerido.',	
		msgTarget:'side',
		minValue :0,
		allowDecimals :false,
		labelStyle: 'font:normal 10px Verdana;text-align: right;',
		fieldLabel:'%',		
		width:35,
		disabled:true,
		value:((acc=='update')||(acc=='ver'))?porcentaje(Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.persNRMascGol,Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.persDetMascGol):0
		});
	
	var persNRFemPerm = new Ext.form.NumberField({
		name:'abmObjet.persNRFemPerm',
		id:'persNRFemPerm',		
		allowBlank:false,
		blankText : 'Este campo es requerido.',	
		msgTarget:'side',
		minValue :0,
		allowDecimals :false,
		labelStyle: 'font:normal 10px Verdana;text-align: right;',
		width:35,
		value:((acc=='update')||(acc=='ver'))?Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.persNRFemPerm:0,
		listeners:{change:function(t,n,o){
					if (n!=o){
						Ext.getCmp('persPorFemPerm').setValue(porcentaje(n,Ext.getCmp('persDetFemPerm').getValue()));	
					}
					}
				}
		});
	
	var persDetFemPerm = new Ext.form.NumberField({
		//name:'abmObjet.persNRFemPerm',
		id:'persDetFemPerm',		
		allowBlank:false,
		blankText : 'Este campo es requerido.',	
		msgTarget:'side',
		minValue :0,
		allowDecimals :false,
		labelStyle: 'font:normal 10px Verdana;text-align: right;',
		width:35,
		disabled:true,
		value:((acc=='update')||(acc=='ver'))?Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.persDetFemPerm:0
		});
	
	var persPorFemPerm = new Ext.form.NumberField({
		//name:'abmObjet.persNRMascPerm',
		id:'persPorFemPerm',		
		allowBlank:false,
		blankText : 'Este campo es requerido.',	
		msgTarget:'side',
		minValue :0,
		allowDecimals :false,
		labelStyle: 'font:normal 10px Verdana;text-align: right;',
		//fieldLabel:'%',		
		width:35,
		disabled:true,
		value:((acc=='update')||(acc=='ver'))?porcentaje(Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.persNRFemPerm,Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.persDetFemPerm):0
		});
	
	var persNRFemTrans = new Ext.form.NumberField({
		name:'abmObjet.persNRFemTrans',
		id:'persNRFemTrans',		
		allowBlank:false,
		blankText : 'Este campo es requerido.',	
		msgTarget:'side',
		minValue :0,
		allowDecimals :false,
		labelStyle: 'font:normal 10px Verdana;text-align: right;',
		width:35,
		value:((acc=='update')||(acc=='ver'))?Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.persNRFemTrans:0,
		listeners:{change:function(t,n,o){
					if (n!=o){
						Ext.getCmp('persPorFemTrans').setValue(porcentaje(n,Ext.getCmp('persDetFemTrans').getValue()));	
					}
					}
				}
		});
	
	var persDetFemTrans = new Ext.form.NumberField({
		//name:'abmObjet.persNRFemTrans',
		id:'persDetFemTrans',		
		allowBlank:false,
		blankText : 'Este campo es requerido.',	
		msgTarget:'side',
		minValue :0,
		allowDecimals :false,
		labelStyle: 'font:normal 10px Verdana;text-align: right;',
		width:35,
		disabled:true,
		value:((acc=='update')||(acc=='ver'))?Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.persDetFemTrans:0
		});
	
	var persPorFemTrans = new Ext.form.NumberField({
		//name:'abmObjet.persNRMascPerm',
		id:'persPorFemTrans',		
		allowBlank:false,
		blankText : 'Este campo es requerido.',	
		msgTarget:'side',
		minValue :0,
		allowDecimals :false,
		labelStyle: 'font:normal 10px Verdana;text-align: right;',
		//fieldLabel:'%',		
		width:35,
		disabled:true,
		value:((acc=='update')||(acc=='ver'))?porcentaje(Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.persNRFemTrans,Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.persDetFemTrans):0
		});
	
	var persNRFemGol = new Ext.form.NumberField({
		name:'abmObjet.persNRFemGol',
		id:'persNRFemGol',		
		allowBlank:false,
		blankText : 'Este campo es requerido.',	
		msgTarget:'side',
		minValue :0,
		allowDecimals :false,
		labelStyle: 'font:normal 10px Verdana;text-align: right;',
		width:35,
		value:((acc=='update')||(acc=='ver'))?Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.persNRFemGol:0,
		listeners:{change:function(t,n,o){
					if (n!=o){
						Ext.getCmp('persPorFemGol').setValue(porcentaje(n,Ext.getCmp('persDetFemGol').getValue()));	
					}
					}
				}
		});
	
	var persDetFemGol = new Ext.form.NumberField({
		//name:'abmObjet.persNRFemGol',
		id:'persDetFemGol',		
		allowBlank:false,
		blankText : 'Este campo es requerido.',	
		msgTarget:'side',
		minValue :0,
		allowDecimals :false,
		labelStyle: 'font:normal 10px Verdana;text-align: right;',
		width:35,
		disabled:true,
		value:((acc=='update')||(acc=='ver'))?Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.persDetFemGol:0
		});

	var persPorFemGol = new Ext.form.NumberField({
		//name:'abmObjet.persNRMascPerm',
		id:'persPorFemGol',		
		allowBlank:false,
		blankText : 'Este campo es requerido.',	
		msgTarget:'side',
		minValue :0,
		allowDecimals :false,
		labelStyle: 'font:normal 10px Verdana;text-align: right;',
		//fieldLabel:'%',		
		width:35,
		disabled:true,
		value:((acc=='update')||(acc=='ver'))?porcentaje(Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.persNRFemGol,Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.persDetFemGol):0
		});
	
	var myReaderEmpleadores= new Ext.data.JsonReader({
    	totalProperty: 'totalCount',
    	root: 'ffis',
    		id: 'empleadorId',	
    	fields:[{name: 'empleadorId', mapping: 'empleadorId'},	        
    	        {name: 'razonSocial', mapping: 'razonSocial'},
    	        {name: 'localidad9nombre', mapping: 'localidad9nombre'},
    	        {name: 'domicilioLegal', mapping: 'domicilioLegal'},
    	        {name: 'cuit', mapping: 'cuit'}
      			]
    	});

    var myHttpProxyEmpleadores = new Ext.data.HttpProxy({
    		url: '../generic/grillaEmpleador.action',
    		method:'POST',
    		autoLoad:false
    		});
	var nameEmpleadores = new Ext.data.Store({
   	 proxy: myHttpProxyEmpleadores,
     reader: myReaderEmpleadores,
    remoteSort: true
    });

   var resultTpl = new Ext.XTemplate(
           '<tpl for="."><style>.search-item{font:normal 11px tahoma, arial, helvetica, sans-serif;padding:2px 2px 3px 3px;border:1px solid #fff;border-bottom:1px solid #eeeeee;white-space:normal;color:#555;}.search-item h3 {display:block;font:inherit;font-weight:normal;color:#222;}.search-item h3 span {float: left;font-weight:normal;margin:0 0 1px 1px;width:100px;display:block;clear:none;}</style><div class="search-item">',
               '<span>{razonSocial}</span><p>{cuit}&nbsp;&nbsp;&nbsp;&nbsp;{localidad9nombre}</p>',                  
           '</div></tpl>');
   //TODO: Esto se usa siempre para usar combos con paginacion
     Ext.form.TriggerField.override({
           afterRender : function(){
               Ext.form.TriggerField.superclass.afterRender.call(this);
               var y;
               if(Ext.isIE && !this.hideTrigger && this.el.getY() != (y = this.trigger.getY())){
                   this.el.position();
                   this.el.setY(y);
               }
           }
       });  


   var cmbEmpleadores = new Ext.form.ComboBox({
	    name:'empleadores',
       store: nameEmpleadores,
       id:'cmbEmpleadores',
       displayField:'razonSocial',
       valueField:'empleadorId',
       typeAhead: false,
       loadingText: 'Buscando Empresas...',
       width: 140,
       listWidth: 500,   
       pageSize:15,
       minChars:3,  
       hideTrigger:true,
       allowBlank:true,
       triggerAction: 'all',
       blankText:'Ingrese al menos 3 caracteres.',
       minLength : 3,
       labelStyle: 'font:normal 10px Verdana;text-align: right;',
       fieldLabel:'Localidad',
       minLengthText :'Debe introducir por lo menos 3 caracteres',
       tpl: resultTpl,
       itemSelector: 'div.search-item'  
   });

 
	var myReaderEmpleadores= new Ext.data.JsonReader({
		totalProperty: 'totalCount',
		root: 'ffis',
			id: 'Empleadores',	
		fields:[{name: 'empleadorId', mapping: 'empleadorId'},
		    	{name: 'razonSocial', mapping: 'razonSocial'},
		    	{name: 'localidad9nombre', mapping: 'localidad9nombre'},
		    	{name: 'domicilioLegal', mapping: 'domicilioLegal'}
	  			]
		});
		
		

	var myHttpProxyEmpleadores = new Ext.data.HttpProxy({
			url: '../generic/grillaEmpleadoresTodo.action',
			method:'POST',
			autoLoad:true
			});

   var storeEmpleadores = new Ext.data.Store({
		 proxy: myHttpProxyEmpleadores,
	  reader: myReaderEmpleadores,
	 remoteSort: true,
	 baseParams: {limit:14,TodoId:((acc=='update')||(acc=='ver'))?Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.TodoId:''},
	 sortInfo: {
		    field: 'razonSocial',
		    direction: 'asc' // or 'DESC' (case sensitive for local sorting)
		}
	 });

   var myReaderEmpleadoresActa= new Ext.data.JsonReader({
		totalProperty: 'totalCount',
		root: 'ffis',
			id: 'Empleadores',	
		fields:[{name: 'empleadorId', mapping: 'empleadorId'},
		    	{name: 'razonSocial', mapping: 'razonSocial'},
		    	{name: 'localidad9nombre', mapping: 'localidad9nombre'},
		    	{name: 'domicilioLegal', mapping: 'domicilioLegal'}
		    	
	  			]
		});
		
		

	var myHttpProxyEmpleadoresActa = new Ext.data.HttpProxy({
			url: '../generic/grillaEmpleadoresTodo.action',
			method:'POST',
			autoLoad:true
			});

  var storeEmpleadoresActa = new Ext.data.Store({
		 proxy: myHttpProxyEmpleadores,
	  reader: myReaderEmpleadores,
	 remoteSort: true,
	 baseParams: {limit:14,TodoId:((acc=='update')||(acc=='ver'))?Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.TodoId:''},
	 sortInfo: {
		    field: 'razonSocial',
		    direction: 'asc' // or 'DESC' (case sensitive for local sorting)
		}
	 });

 
   
   var smEmp = new Ext.grid.CheckboxSelectionModel({singleSelect:true});

   cmodelEmp = new Ext.grid.ColumnModel([
		                          		smEmp,
		                          		{id: 'razonSocial', 
		                                    header: "Razón social",	                                    
		                                    sortable: true,
		                                    dataIndex: 'razonSocial',
		                                    width : 230
		                                },
		                                {id: 'domicilioLegal', 
				                            header: "Domicilio Legal",	                                    
				                            sortable: true,
				                            dataIndex: 'domicilioLegal',
				                            width : 200
				                         },
		                                 {id: 'localidad9nombre', 
				                            header: "Localidad",	                                    
				                            sortable: true,
				                            dataIndex: 'localidad9nombre',
				                            width : 200
				                         }                                    	     	    								                                                 
		                               	]);
	
	var gridEmpleadores = new Ext.grid.EditorGridPanel({
		iconCls:'icon-grid',   
		title:'Empresas',	    
	    height:140,
	  	width:690,
	  	stripeRows: true,
	    id:'gridEmpresas',
	    store: storeEmpleadores,    
	    cm: cmodelEmp,
	    sm: smEmp,    
	    tbar:[cmbEmpleadores,
			{
			    text:'Agregar',
			    iconCls:'add',
			    id:'agregarBoton',
			    handler:agregarEmpleador
				}, '-',
	    {
	        text:'Eliminar',
	        iconCls:'eliminar',
	        id:'eliminar',	            
	        hidden:(<%=request.getAttribute("ELIMINAR")%>!=null)?false:true,
	        handler:eliminarEmpleador
	    } 
	    ]
	});

	var myReaderActasSum= new Ext.data.JsonReader({
    	totalProperty: 'totalCount',
    	root: 'ffis',
    		id: 'actaId',	
    	fields:[{name: 'actaId', mapping: 'actaId'},	        
    	        {name: 'numeroActa', mapping: 'numeroActa'},
    	        {name: 'domicilioActa', mapping: 'domicilioActa'},
    	        {name:'delegacionIdActa',mapping:'delegacionIdActa'},
    	        {name:'delegacionActa',mapping:'delegacionActa'},
    	        {name:'cantMenoresActa',mapping:'cantMenoresActa'},
    	        {name:'persMascPermActa',mapping:'persMascPermActa'},
    	        {name:'persMascTransActa',mapping:'persMascTransActa'},
    	        {name:'persMascGolActa',mapping:'persMascGolActa'},
    	        {name:'persFemPermActa',mapping:'persFemPermActa'},
    	        {name:'persFemTransActa',mapping:'persFemTransActa'},
    	        {name:'persFemGolActa',mapping:'persFemGolActa'},
    	        {name:'persFemGolActa',mapping:'persFemGolActa'},
    	        {name:'cantTrabRiesgoActa',mapping:'cantTrabRiesgoActa'},
    	        
      			]
    	});

	var myHttpProxyActasSum = new Ext.data.HttpProxy({
		url: '../generic/grillaActaTodo.action',
		method:'POST',
		autoLoad:false
		});
var nameActasSum = new Ext.data.Store({
	 proxy: myHttpProxyActasSum,
 reader: myReaderActasSum,
 remoteSort: true
});

var resultTpl = new Ext.XTemplate(
       '<table width="100%" bgcolor="#898989"><tr><td align="center"><b>Actas sin Todo</b></td></tr></table><tpl for="."><style>.search-item{font:normal 11px tahoma, arial, helvetica, sans-serif;padding:2px 2px 3px 3px;border:1px solid #fff;border-bottom:1px solid #eeeeee;white-space:normal;color:#555;}.search-item h3 {display:block;font:inherit;font-weight:normal;color:#222;}.search-item h3 span {float: left;font-weight:normal;margin:0 0 1px 1px;width:100px;display:block;clear:none;}</style><div class="search-item">',
           '<span>{numeroActa}</span><p>{domicilioActa}</p>',                  
       '</div></tpl>');
//TODO: Esto se usa siempre para usar combos con paginacion
 Ext.form.TriggerField.override({
       afterRender : function(){
           Ext.form.TriggerField.superclass.afterRender.call(this);
           var y;
           if(Ext.isIE && !this.hideTrigger && this.el.getY() != (y = this.trigger.getY())){
               this.el.position();
               this.el.setY(y);
           }
       }
   });  


var cmbActas = new Ext.form.ComboBox({
    name:'actaSumId',
   store: nameActasSum,
   id:'cmbActas',
   hiddenName:'actaSumId',
   displayField:'numeroActa',
   valueField:'actaId',
   typeAhead: false,
   loadingText: 'Buscando Actas...',
   width: 140,
   listWidth: 300,   
   pageSize:15,
   minChars:3,  
   hideTrigger:false,
   msgTarget:'side',
   allowBlank:false,
   forceSelection:true,
   triggerAction: 'all',
   blankText:'Ingrese al menos 3 caracter.',
   minLength : 3,
   labelStyle: 'font:normal 10px Verdana;text-align: right;',
   fieldLabel:'Acta',
   minLengthText :'Debe introducir por lo menos 3 caracteres',
   tpl: resultTpl,
   itemSelector: 'div.search-item',
   listeners:{'select':function(c,r,i){
	   domicilioInsp.setValue(r.data.domicilioActa);
	   rec = Ext.data.Record.create(
   			{name: 'localidadId'},
   			{name: 'nombre'}
   			);
		ident = r.data.delegacionIdActa;
		val = r.data.delegacionActa;
   	tmprec = new rec({localidadId:ident, nombre:val});
   	nameDelegacionTodo.add(tmprec);
   	cmbDelegacionTodo.setValue(ident);
   	persDetMascPerm.setValue(r.data.persMascPermActa);
   	persDetMascTrans.setValue(r.data.persMascTransActa);
   	persDetMascGol.setValue(r.data.persMascGolActa)
   	persDetFemPerm.setValue(r.data.persFemPermActa);
   	persDetFemTrans.setValue(r.data.persFemTransActa);
   	persDetFemGol.setValue(r.data.persFemGolActa);
   	
   	Ext.getCmp('persPorMascPerm').setValue(porcentaje(persNRMascPerm.getValue(),persDetMascPerm.getValue()));
   	Ext.getCmp('persPorMascTrans').setValue(porcentaje(persNRMascTrans.getValue(),persDetMascTrans.getValue()));
   	Ext.getCmp('persPorMascGol').setValue(porcentaje(persNRMascGol.getValue(),persDetMascGol.getValue()));
   	Ext.getCmp('persPorFemPerm').setValue(porcentaje(persNRFemPerm.getValue(),persDetFemPerm.getValue()));
   	Ext.getCmp('persPorFemTrans').setValue(porcentaje(persNRFemTrans.getValue(),persDetFemTrans.getValue()));
   	Ext.getCmp('persPorFemGol').setValue(porcentaje(persNRFemGol.getValue(),persDetFemGol.getValue()));
   	
   	importarEmp.enable();
   	storeEmpleadoresActa.baseParams={idActa:r.data.actaId,limit:14,TodoId:''};
	   },
	   'change':function(c,n,o){
		   if (n==''){
		   domicilioInsp.setValue('');
		   storeEmpleadores.removeAll();
		   importarEmp.disable();
		   }
	   }
   }  
}); 

var importarEmp = new Ext.Button({
		text:'Copiar del Acta',
		id:'botonEmpl',
		disabled:((acc=='update')&&(Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.actaId>0))?false:true,
		handler:function(){
	storeEmpleadoresActa.baseParams={idActa:(cmbActas.getValue()!='')?cmbActas.getValue():'',limit:14,TodoId:(acc=='update')?Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.TodoId:''}
	storeEmpleadoresActa.reload({callback:function(){
		rec = Ext.data.Record.create(
    			{name: 'empleadorId'},
    			{name: 'razonSocial'},
    			{name: 'localidad9nombre'},
    			{name: 'domicilioLegal'}
    			);
		if (storeEmpleadoresActa.getCount()>0){
			ci = storeEmpleadoresActa.getCount();
			for (i=0;i<ci;i++){
				ident = storeEmpleadoresActa.getAt(i).get('empleadorId');
				val=storeEmpleadoresActa.getAt(i).get('razonSocial');
				loc = storeEmpleadoresActa.getAt(i).get('localidad9nombre');
				dom = storeEmpleadoresActa.getAt(i).get('domicilioLegal');
				tmprec = new rec({empleadorId:ident, razonSocial:val, localidad9nombre: loc, domicilioLegal:dom});
				pos=storeEmpleadores.find('empleadorId',ident);
			//	alert(ident);
				if (pos<0){
					storeEmpleadores.add(tmprec);}
					}
				}
		}
		});
							}
});

//agreagado solapa de estados
var myReaderEstadoTodo= new Ext.data.JsonReader({
		totalProperty: 'totalCount',
		root: 'ffis',
			id: 'estadosDelTodoId',	
		fields:[{name: 'estadosDelTodoId', mapping: 'estadosDelTodoId'},
		    	{name: 'motivo9descripcion', mapping: 'motivo9descripcion'},
		    	{name: 'tipoEstado9descripcion', mapping: 'tipoEstado9descripcion'},
		    	{name: 'tipoInstrumento', mapping: 'tipoInstrumento'},
		    	{name: 'fechaInstrumento', mapping: 'fechaInstrumento'},
		    	{name: 'fecha', mapping: 'fecha'},
		    	{name: 'numeroInstrumento', mapping: 'numeroInstrumento'},
		    	{name: 'asesorInterviniente9nombre', mapping: 'asesorInterviniente9nombre'}
	  			]
		});
		
		

	var myHttpProxyEstadoTodo = new Ext.data.HttpProxy({
			url: '../generic/grillaEstadosTodo.action',
			method:'POST',
			autoLoad:false
			});

 var storeEstadoTodo = new Ext.data.Store({
		 proxy: myHttpProxyEstadoTodo,
	  reader: myReaderEstadoTodo,
	 remoteSort: true,
	 baseParams: {limit:14,TodoId:(acc=='update')||(acc=='ver')?Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.TodoId:0},
	 sortInfo: {
		    field: 'fecha',
		    direction: 'desc' // or 'DESC' (case sensitive for local sorting)
		}
	 });
 
 var smEstadoTodo = new Ext.grid.CheckboxSelectionModel({singleSelect:true});

 cmodelEstadoTodo = new Ext.grid.ColumnModel([
		                          		smEstadoTodo,
		                          		{id: 'motivo9descripcion', 
		                                    header: "Motivo",	                                    
		                                    sortable: true,
		                                    dataIndex: 'motivo9descripcion',
		                                    width : 350
		                                 },{id: 'tipoEstado9descripcion', 
				                            header: "Estado",	                                    
				                            sortable: true,
				                            dataIndex: 'tipoEstado9descripcion',
				                            width : 130
				                         },{id: 'fecha', 
					                            header: "Fecha",	                                    
					                            sortable: true,
					                            dataIndex: 'fecha',
					                            width : 120
				                         },{id: 'tipoInstrumento', 
					                            header: "Instrumento",	                                    
					                            sortable: true,
					                            dataIndex: 'tipoInstrumento',
					                            width : 120
					                     },{id: 'fechaInstrumento', 
					                            header: "Fecha Instrumento",	                                    
					                            sortable: true,
					                            dataIndex: 'fechaInstrumento',
					                            width : 120
					                     },{id: 'numeroInstrumento', 
					                            header: "N° Instrumento",	                                    
					                            sortable: true,
					                            dataIndex: 'numeroInstrumento',
					                            width : 120
					                     },{id: 'asesorInterviniente9nombre', 
					                            header: "Asesor",	                                    
					                            sortable: true,
					                            dataIndex: 'asesorInterviniente9nombre',
					                            width : 120
					                     }                                                 	     	    								                                                 
		                               	]);
	
	var gridEstadoTodo = new Ext.grid.EditorGridPanel({
		iconCls:'icon-grid',   
		title:'Estados',	    
		 height:screenHeight-80,
		 width:screen.width,
	  	stripeRows: true,
	    id:'gridEstadoTodo',
	    store: storeEstadoTodo,    
	    cm: cmodelEstadoTodo,
	    sm: smEstadoTodo
	});

	// fin agregado solapa estados  
	 
	 /**
	 agregado de infracciones
	 
	 */
	 
		var importarInfSum = new Ext.Button({
			text:'Copiar del Acta',
			id:'botonimportarInfSum',
			
			//disabled:(acc=='update')?false:true,
			handler:function(){
				
				if ((acc=='updateRes')||(acc=='update')||(acc=='ver')){
					
					if (Ext.getCmp('gridTodo').getSelectionModel().getSelected()!=null){
						sumId=Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.TodoId;
						actaId=Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.actaId;
					}else{
						sumId=TodoId.getValue();
						actaId=actaTodoId.getValue();
					}
				}else{
						sumId=0;
						actaId=cmbActas.getValue();
				}
			toInfStoreSuActa.baseParams={opt:'imp',sumId:sumId,limit:14,
					actaId:actaId};
			toInfStoreSuActa.reload({callback:function(){
			rec = Ext.data.Record.create(
	    			{name: 'code'},
	    			{name: 'desc'}
	    			);
			if (toInfStoreSuActa.getCount()>0){
				ci = toInfStoreSuActa.getCount();
				for (i=0;i<ci;i++){
					ident = toInfStoreSuActa.getAt(i).get('code');
					val=toInfStoreSuActa.getAt(i).get('desc');
					tmprec = new rec({code:ident, desc:val});
					pos=toInfStoreSu.find('code',ident);
					if (pos<0){
						toInfStoreSu.add(tmprec);
						del = fromInfStoreSu.find('code',ident);
						fromInfStoreSu.removeAt(del);
						}
						}
					}
			}
			});
								}
	});
	
		var fromInfStoreSu = new Ext.data.Store({
			proxy: new Ext.data.HttpProxy({
			url: '../generic/infraccionesNoAsignadasSu.action'		
			}),
	
			reader: new Ext.data.JsonReader({
			root: 'results',
			totalProperty: 'totalCount',
			id: 'code'
			}, [
			{name: 'code', mapping: 'code'},
			{name: 'desc', mapping: 'desc'}
			]),
			baseParams:{TodoId:((acc=='updateRes')||(acc=='update')||(acc=='ver'))?Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.TodoId:0},
			});

		var fromInfStoreSuMain = new Ext.data.Store({
			proxy: new Ext.data.HttpProxy({
			url: '../generic/infraccionesNoAsignadasSu.action'		
			}),
	
			reader: new Ext.data.JsonReader({
			root: 'results',
			totalProperty: 'totalCount',
			id: 'code'
			}, [
			{name: 'code', mapping: 'code'},
			{name: 'desc', mapping: 'desc'}
			]),
			baseParams:{TodoId:((acc=='updateRes')||(acc=='update')||(acc=='ver'))?Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.TodoId:0},
			});
	
		var toInfStoreSu = new Ext.data.Store({
			proxy: new Ext.data.HttpProxy({
			url: '../generic/infraccionesAsignadasSu.action'		
			}),
	
			reader: new Ext.data.JsonReader({
			root: 'results',
			totalProperty: 'totalCount',
			id: 'code'
			}, [
			{name: 'code', mapping: 'code'},
			{name: 'desc', mapping: 'desc'}
			]),
			baseParams:{sumId:((acc=='updateRes')||(acc=='update')||(acc=='ver'))?Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.TodoId:0,actaId:0},
			});

		var searchInfSum = new Ext.form.TextField({
			name:'searchInfSum',
			id:'searchInfSum',		
			allowBlank:true,
			blankText : 'Este campo es requerido.',	
			msgTarget:'side',
			labelStyle: 'font:normal 10px Verdana;text-align: right;',
			width:100,
			fieldLabel:'Búsqueda'
			});

		var searchButtonSum = new Ext.Button({
			id:'searchButtonSum',
			name:'searchButtonSum',
			text:'Filtrar'
			});

		function filtrarSum(){
			fromInfStoreSu.removeAll();
			cant = fromInfStoreSuMain.getCount();
			val = searchInfSum.getValue().toUpperCase();
			for (i=0;i<cant;i++){
				rec = fromInfStoreSuMain.getAt(i);
				code = new String(rec.data.code).toUpperCase();
				desc = new String(rec.data.desc).toUpperCase();
				if (desc.indexOf(val)>=0){
					fromInfStoreSu.add(fromInfStoreSuMain.getAt(i));
				}
				}
			cant = toInfStoreSu.getCount();
			for (i=0;i<cant;i++){
				rec = toInfStoreSu.getAt(i);
//				
				fromInfStoreSu.remove(rec);
				}
			}
		
		var searchPanelSum = new Ext.Panel({
			id:'searchPanelSum',
		    baseCls: 'x-plain',		
			width: screen.width, 
			bodyBorder:true,
			bodyStyle:'background-color:#888888;',
			tbar:[searchInfSum, {text:'Filtrar', id:'filtrarInfBtn', handler:filtrarSum}]
			});

		var toInfStoreSuActa = new Ext.data.Store({
			proxy: new Ext.data.HttpProxy({
			url: '../generic/infraccionesAsignadasSu.action'		
			}),
	
			reader: new Ext.data.JsonReader({
			root: 'results',
			totalProperty: 'totalCount',
			id: 'code'
			}, [
			{name: 'code', mapping: 'code'},
			{name: 'desc', mapping: 'desc'}
			]),
			baseParams:{actaId:((acc=='updateRes')||(acc=='update')||(acc=='ver'))?Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.actaId:0},
			});

			
		
		
		var transferInfraccionesSum = new Ext.Panel({
			 bodyStyle:'background-color:#888888;',
			items:[{
		    	    xtype:"itemselector",
		            name:"itemselectorSum",
		            id:'transInfSum',
		            showDrawAll:true,
		            defaultOrderBy:false,
		           // disabled:ver,
		            fieldLabel:"ItemSelector",
		            fromSortField:'code',
		            toSortField:'code',
		            fromStore:fromInfStoreSu,
		            toStore:toInfStoreSu,
		            msWidth:parseInt((screen.width-30)/2),
		            msHeight:screen.height-500,
		            valueField:"code",
		            displayField:"desc",
		            imagePath:"../altec/scripts/extjs3/extension/multiselector",
		            //switchToFrom:true,
		            toLegend:"Normas Legales aplicadas",
		            fromLegend:"Normas Legales disponibles"
		           
		    }]});
			 
			 //fin solapa Infracciones
	

	var Todo = new Ext.FormPanel({
	      //  labelAlign: 'top',
	      id:'formTodos',
	        frame:true,
	        bodyStyle:'padding:5px 5px 0',
	        method:'POST',
	        align:'center',
	        width: screen.width-5,
	        height:screenHeight-70,
	        monitorValid:true,
	        listeners:{clientvalidation:function(form, valid)
	     		{  		 										
	    			if ((valid)&&(acc!='ver'))
	    				{
	    					Ext.getCmp('guardarTodoBtn').enable();
	    					}else{
	    					Ext.getCmp('guardarTodoBtn').disable();
	    				}													    		                            					
	    		}
	    	},
	    	
	        items: [{
		       
		            layout:'column',
		            items:[{
			                columnWidth:.225,
			                layout: 'form',
							items: [numeroTodo,TodoId,expedientePanel,fechaTodoH,fechaTodo,temporalInfraccionesSum ]
				            },
				            {
				            columnWidth:.225,
				            layout: 'form',
							items: [cmbActas,domicilioInsp,cmbDelegacionTodo ]
					        },
				            {
			                columnWidth:.10,
			                layout: 'form',
							items: [DACH,DAC,clausuradoH,clausurado, rebeldia, rebeldiaH]
				            },
				            {
			                columnWidth:.225,
			                layout: 'form',
							items: [fechaDACH,fechaDAC,origenPanel, diasClausurado,cmbSumariante]
			            	},
				            {
				            columnWidth:.225,
				            layout: 'form',
							items: [cmbAsesorLetrado,domiciolioNotificacionEmpleador,cmblocalidadNotificacionEmpleador]
				            }
	            		]
	        	},{
			        layout:'column',
		            items:[{	
			            	columnWidth:.5,
			                layout:'column',
			                title:'Trabajadores No Registrados',
			                border:true,
			                items:[{
				                    columnWidth:.10,
				                    layout: 'form',
				                    items: [{html:'Masc.',bodyStyle:'font-size:12px;padding:20px 0px 0;text-align: center;'},
				                            {html:'Fem.',bodyStyle:'font-size:12px;padding:30px 0px 0;text-align: center;'}]
				                	},{
				                    columnWidth:.10,
				                    layout: 'form',
				                    labelAlign:'top',
				                    items: [persNRMascPerm,persNRFemPerm]
				                	},{
				                    columnWidth:.10,
				                    layout: 'form',
				                    labelAlign:'top',
				                    items: [persDetMascPerm,persDetFemPerm]
				                	},{
				                    columnWidth:.10,
				                    layout: 'form',
				                    labelAlign:'top',
				                    items: [persPorMascPerm,persPorFemPerm]
				                	},{
				                    columnWidth:.10,
				                    layout: 'form',
				                    labelAlign:'top',
				                    items: [persNRMascTrans,persNRFemTrans]
				                	},{
				                    columnWidth:.10,
				                    layout: 'form',
				                    labelAlign:'top',
				                    items: [persDetMascTrans,persDetFemTrans]
				                	},{
				                    columnWidth:.10,
				                    layout: 'form',
				                    labelAlign:'top',
				                    items: [persPorMascTrans,persPorFemTrans]
				                	},{
				                    columnWidth:.10,
				                    layout: 'form',
				                    labelAlign:'top',
				                    items: [persNRMascGol,persNRFemGol]
				                	},{
				                    columnWidth:.10,
				                    layout: 'form',
				                    labelAlign:'top',
				                    items: [persDetMascGol,persDetFemGol]
				                	},{
				                    columnWidth:.10,
				                    layout: 'form',
				                    labelAlign:'top',
				                    items: [persPorMascGol,persPorFemGol]
				                	}
				                ]
	            		},{	
			            	columnWidth:.5,
			                layout:'form',
			                items:[gridEmpleadores,temporalEmpresas,importarEmp]
	                    }
            		]
	        	}
	        	]
	        });

 
	
	 if (Ext.getCmp('myTPanel').findById('frmTodoAlta')!=null){
			Ext.getCmp('myTPanel').findById('frmTodoAlta').show();
		}else{
			
	Ext.getCmp('myTPanel').add({
		title: 'Agregar Todo' ,
        //iconCls: 'tabs',
         autoScroll:true,
        width: screenWidth,
        height:screenHeight,
        id:'frmTodoAlta',
        border:false, 
        listeners:{close:function(){storeTodo.reload();} ,
	    	beforeshow:function(){
			toInfStoreSu.load();
			fromInfStoreSu.load({callback:function(){
        	fromInfStoreSuMain.add(fromInfStoreSu.getRange(0,fromInfStoreSu.getCount()));
            }});
		     }},
        
        tbar:[{text:'Guardar', id:'guardarTodoBtn', handler:saveTodo}, '-',
              {text:'Cerrar', align:'left',id:'cerrarTodoBtn', handler:function(){
    																Ext.getCmp('myTPanel').remove(Ext.getCmp('myTPanel').findById('frmTodoAlta'));
            														}
			   }, '-',], 		    			     
      //  autoLoad:{url:'../pages/operation/algo.jsp'},
   		items:{
   			title:'',
   			id : 'TodosMainPanel',
   			border:false,	
   			renderTo : 'divMain',				
   			items  : {
   				xtype           : 'tabpanel',
   				activeTab       : 0,
   				id              : 'TodosTabPanel',
   				enableTabScroll : true,
   				resizeTabs      : true,		
   						
   				minTabWidth     : 100,	
   				tabWidth:150,
   				height:screenHeight-50,
   				//height:438,	
   				bodyStyle:'background:url(../altec/images/template/securitycenter.gif) center center no-repeat ;',			
   				border          : false,
   				items:[{
   			        title: 'Todos' ,
   			        id:'general',
   			     	bodyStyle:'background-color:#888888;',
   			  		width: screenWidth-40,
   			  		height:screenHeight-50,
   			        border:false,   
    			  //      autoLoad:{url:this.ref,method:'post',scripts:true,callback : function (){verGrilla();}},
   			        closable:false,
   			        items:[Todo]
   			     },
   			  {
   			        title: 'Infracciones' ,
   			        id:'infraccionesSum',								      	        
   			        border:false,  
   			     	forceLayout:true,
   			     	bodyStyle:'background-color:#888888;',
   			     	width: screen.width,
   		       	 	//height:screenHeight-150,
   			     	//listeners:{beforeshow:function(){
   			     	//storeEstadoTodo.baseParams={limit:parseInt((screen.height-320)/25),TodoId:TodoId.getValue()};
   			     	//storeEstadoTodo.load();}}	,    
   			     	items:[searchPanelSum,transferInfraccionesSum,importarInfSum],			     
   			  //      autoLoad:{url:this.ref,method:'post',scripts:true,callback : function (){verGrilla();}},
   			        closable:false
   			     },
     			  {
 			        title: 'Estados' ,
 			        id:'estados',								      	        
 			        border:false,  
 			     	forceLayout:true,
 			     	bodyStyle:'background-color:#888888;',
 			     	width: screen.width,
 		       	 	//height:screenHeight-150,
 			     	listeners:{beforeshow:function(){
 			     	storeEstadoTodo.baseParams={limit:parseInt((screen.height-320)/25),TodoId:TodoId.getValue()};
 			     	storeEstadoTodo.load();}}	,    
 			     	items:[gridEstadoTodo],			     
 			  //      autoLoad:{url:this.ref,method:'post',scripts:true,callback : function (){verGrilla();}},
 			        closable:false
 			     }]
   	}
   	},
        closable:true
     }).show();
	cmbDelegacionTodo.validate();
	cmbAsesorLetrado.validate();
	cmbSumariante.validate();
	cmbActas.validate();
	cmblocalidadNotificacionEmpleador.validate();
	numeroExpediente.focus(false,500);
    

    	if ((acc=='update')||(acc=='ver')){
			    	rec = Ext.data.Record.create(
			    			{name: 'asesorLetradoId'},
			    			{name: 'nombre'}
			    			);
					ident = Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.asesorLetradoId;
					val = Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.asesorLetrado;
			    	tmprec = new rec({asesorLetradoId:ident, nombre:val});
			    	nameAsesorLetrado.add(tmprec);
			    	cmbAsesorLetrado.setValue(ident);
			    	
			    	rec = Ext.data.Record.create(
			    			{name: 'sumarianteId'},
			    			{name: 'nombre'}
			    			);
			 		ident = parseInt(Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.sumarianteId);
					val = Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.sumariante;
			    	tmprec = new rec({sumarianteId:ident, nombre:val});
			    	nameSumariante.add(tmprec);
			    	cmbSumariante.setValue(ident);
			    	
			    	rec = Ext.data.Record.create(
			    			{name: 'localidadId'},
			    			{name: 'nombre'}
			    			);
					ident = Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.delegacionId;
					val = Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.delegacionNombre;
			    	tmprec = new rec({localidadId:ident, nombre:val});
			    	nameDelegacionTodo.add(tmprec);
			    	cmbDelegacionTodo.setValue(ident);

			    	rec = Ext.data.Record.create(
			    			{name: 'localidadId'},
			    			{name: 'nombre'}
			    			);
					ident = Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.localidadNotificacionEmpleador9localidadId;
					val = Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.localidadNotificacionEmpleador9nombre;
			    	tmprec = new rec({localidadId:ident, nombre:val});
			    	namelocalidadNotificacionEmpleador.add(tmprec);
			    	cmblocalidadNotificacionEmpleador.setValue(ident);
			    	
			    	ident = parseInt(Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.actaId);
					val = Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.acta;
					if (ident>0){
						ident = Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.actaId;
						val = Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.acta;
						dom = Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.actaDom;
				    	tmprec = new rec({actaId:ident, numeroActa:val, domicilioActa:dom});
				    	nameActasSum.add(tmprec);
				    	cmbActas.setValue(ident);
				    	domicilioInsp.setValue(dom);
			    	}
			    	
					domicilioInsp.setValue(Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.domicilioInspeccionado);
		  	        Ext.getCmp('frmTodoAlta').setTitle('Editar Todo');    
		    		Todo.getForm().loadRecord(
		    				Ext.getCmp('gridTodo').getSelectionModel().getSelected()
		    				);
					if (DAC.checked) {
		    			fechaDAC.allowBlank=false;
		    			numeroOrigen.allowBlank=false;
						letraOrigen.allowBlank=false;
						anioOrigen.allowBlank=false;
						numeroOrigen.enable();
						letraOrigen.enable();
						anioOrigen.enable();
		    			cmbActas.allowBlank=true;
		    			fechaDAC.enable();
		    			domicilioInsp.allowBlank=false;
						domicilioInsp.enable();
		    		}else{
		    			fechaDAC.setValue('');
		    			fechaDAC.allowBlank=true;
		    			numeroOrigen.allowBlank=true;
						letraOrigen.allowBlank=true;
						anioOrigen.allowBlank=true;
						numeroOrigen.disable();
						letraOrigen.disable();
						anioOrigen.disable();
		    			cmbActas.allowBlank=false;
		    			fechaDAC.disable();
		    			cmbActas.enable();
		    			domicilioInsp.allowBlank=false;
						domicilioInsp.disable();
		    		}
			
					if (clausurado.checked) {
						diasClausurado.allowBlank=false;
						diasClausurado.enable();
					}else{
						diasClausurado.allowBlank=true;
						diasClausurado.setValue('');
						diasClausurado.disable();
					}
			
					diasClausurado.validate();
					fechaDAC.validate();
					cmbActas.validate();
					numeroOrigen.validate();
					letraOrigen.validate();
					anioOrigen.validate();
					domicilioInsp.validate();
					storeEmpleadores.reload();	
    		}
	}
	 
	 
	
		
	 
	 
	 
	 
	 
}


//ASIGNACIÓN DICTAMEN TÉCNICO
function desasignarDictamen(){
	
	if(Ext.getCmp('gridDictamenTodo').getSelectionModel().getCount()==1){	
		Ext.MessageBox.confirm('Desasignar Informe Técnico','¿Realmente Desea desasignar el Dictamen Técnico número '+ Ext.getCmp('gridDictamenTodo').getSelectionModel().getSelected().data.dictamenTecnicoId+'?',desasignarPress);

	}else{
		Ext.MessageBox.alert("Atención","Debe seleccionar un registro para Desasignar");
		
	}
	
}

function desasignarPress(btn)
{
	if(btn=='yes'){
		   fps.getForm().submit({
	            url: '../generic/DictamenTecnicoActiondesasignarTodo.action',                        
	            params : 
		            {
			            'id':Ext.getCmp('gridDictamenTodo').getSelectionModel().getSelected().data.dictamenTecnicoId
			        },               
			        waitMsg: 'Aprobando...',                
		            waitTitle : 'Procesando petición', 
		            failure : function(fps, o){   
		                msg('Error', o.result.msg, Ext.Msg.ERROR );	  
		                              
		            }    ,                          
		            success: function(fps, o){
		                msg('Información', o.result.msg ,Ext.Msg.INFO);
		                storeDictamenTodoGlobal.reload();
		        		
		                //reloadgrilla();	
		                //Ext.getCmp('gridDictamenTodo').destroy();
		                //Ext.getCmp('gridDictamenTodo').disable();
		                //Ext.getCmp('desasignarDictamenBoton').disable();
		            }                         
	        });
	}	
}

function reloadDictamenes(){
	handleActivateTodo();
}

function asignarDictamen(acc){
	Ext.QuickTips.init();
	
	function fixHour(v){
		d = new String(v);
		d = (d.length<2)?'0'+d:d;
		return d;
	}

	var temporalEmpresas = new Ext.form.Hidden({
		name:'temporalEmpleadores',
		id:'temporalEmpresas'
	});

	var dictamenTecnicoId = new Ext.form.NumberField({
		name:'id',
		id:'dictamenTecnicoId',
		fieldLabel: 'Informe N°',
		labelStyle: 'font:normal 10px Verdana;text-align: right;',
		disabled:true,
		value:((acc=='update')||(acc=='ver'))?Ext.getCmp('gridDictamenTodo').getSelectionModel().getSelected().data.dictamenTecnicoId:0
	});
	
	var fechaElaboracion = new Ext.form.DateField({ 
		name:'abmObjet.fechaElaboracion',
		id: 'fechaElaboracion',
		fieldLabel: 'Fecha',
		labelStyle: 'font:normal 10px Verdana',
		format:'d/m/Y',
		altFormats:'d/m/y',
		allowBlank:false,
		msgTarget:'side',
		maxValue :new Date(), 
		value:((acc=='update')||(acc=='ver'))?Ext.getCmp('gridDictamenTodo').getSelectionModel().getSelected().data.fechaElaboracion:new Date(),
		blankText : 'Este campo es requerido.'
	});
	
	var nameInspectores = new Ext.data.JsonStore({
 		fields: ['inspectorId','nombre'],    
 	    proxy: new Ext.data.HttpProxy({ method: 'POST', url:'../generic/comboInspectoresSegEhig.action'}),
 	    autoLoad:false
 	});
	
	var cmbInspectores= new Ext.form.ComboBox({
 	    id:'cmbInspectores',
	 	name:'inspector',
	 	store: nameInspectores,       
	 	allowBlank:false,
		blankText : 'Este campo es requerido.',
		msgTarget:'side',
	 	displayField:'nombre',
	 	valueField: 'inspectorId',
	 	typeAhead: false,     		 	  
	 	triggerAction: 'all',
	 	emptyText:'Seleccione...',              
	 	loadingText: 'cargando...',
	 	minChars:2, 
	 	//forceSelection : false,
	 	selectOnFocus:true,
	 	fieldLabel: 'Inspector',
	 	labelStyle: 'font:normal 10px Verdana',
		listWidth: 300,     	
	 	width: 250,
	 	mode: 'remote'	
 	});
	
	var resumen = new Ext.form.HtmlEditor({
		name:'abmObjet.resumen',
		id:'resumen',	
		validator:function(){if((this.getValue()=='')||(this.getValue()==-1)){return false}else{return true}},
		blankText : 'Este campo es requerido.',
		labelStyle: 'font:normal 10px Verdana',
		fieldLabel:'Resumen',		
		width:320,
		height:110,
		value:((acc=='update')||(acc=='ver'))?Ext.getCmp('gridDictamenTodo').getSelectionModel().getSelected().data.resumen:' ',
	});	
	
   	var resultTpl = new Ext.XTemplate(
		'<tpl for="."><style>.search-item{font:normal 11px tahoma, arial, helvetica, sans-serif;padding:2px 2px 3px 3px;border:1px solid #fff;border-bottom:1px solid #eeeeee;white-space:normal;color:#555;}.search-item h3 {display:block;font:inherit;font-weight:normal;color:#222;}.search-item h3 span {float: left;font-weight:normal;margin:0 0 1px 1px;width:100px;display:block;clear:none;}</style><div class="search-item">',
        '<span>{razonSocial}</span><p>{cuit}&nbsp;&nbsp;&nbsp;&nbsp;{localidad9nombre}</p>',                  
        '</div></tpl>'
	);
  
    Ext.form.TriggerField.override({
    	afterRender : function(){
	        Ext.form.TriggerField.superclass.afterRender.call(this);
	        var y;
	        if(Ext.isIE && !this.hideTrigger && this.el.getY() != (y = this.trigger.getY())){
				this.el.position();
	            this.el.setY(y);
	        }
       	}
	});  

	var myReaderDictamenes= new Ext.data.JsonReader({
		totalProperty: 'totalCount',
		root: 'ffis',
		id: 'dictamenTecnicoId',	
		fields:[{name: 'dictamenTecnicoId', mapping: 'dictamenTecnicoId'},
		    {name: 'fechaElaboracion', mapping: 'fechaElaboracion'},
		    {name: 'resumen', mapping: 'resumen'},
		    {name: 'nroExp', mapping: 'nroExp'},
		    {name: 'letraExp', mapping: 'letraExp'},
		    {name: 'anioExp', mapping: 'anioExp'},
		    {name: 'inspector', mapping: 'inspector'}
	  	]
	});
		
	var myHttpProxyDictamenes = new Ext.data.HttpProxy({
		url: '../generic/grillaListaAsignacionDictamenTecnico.action',
		method:'POST',
		autoLoad:true
	});

	var storeDictamenes = new Ext.data.Store({
		proxy: myHttpProxyDictamenes,
	  	reader: myReaderDictamenes,
		remoteSort: true,
		
	});

	var smDictamen = new Ext.grid.CheckboxSelectionModel({singleSelect:false});

   	cmodelDictamen = new Ext.grid.ColumnModel([
		smDictamen,
		{id: 'dictamenTecnicoId', 
			header: "Número",	                                    
			sortable: true,
			dataIndex: 'dictamenTecnicoId',
			width : 100
		},
		{id: 'fechaElaboracion', 
			header: "Fecha",	                                    
			sortable: true,
			dataIndex: 'fechaElaboracion',
			width : 180
		},
		{id: 'inspector', 
			header: "Inspector",	                                    
			sortable: true,
			dataIndex: 'inspector',
			width : 180
		},
		{id: 'resumen', 
			header: "Resumen",	                                    
			sortable: true,
			dataIndex: 'resumen',
			width : 180
		}                     
		
	]);
	
	var gridDictamenes = new Ext.grid.EditorGridPanel({
		iconCls:'icon-grid',   
		title:'Dictamenes',	    
	    height:200,
	  	width:740,
	  	stripeRows: true,
	    id:'gridDictamentes',
	    store: storeDictamenes,    
	    cm: cmodelDictamen,
	    sm: smDictamen
	   
	});

	var resultTpl = new Ext.XTemplate(
       '<table width="100%" bgcolor="#898989"><tr><td align="center"><b>Actas sin Todo</b></td></tr></table><tpl for="."><style>.search-item{font:normal 11px tahoma, arial, helvetica, sans-serif;padding:2px 2px 3px 3px;border:1px solid #fff;border-bottom:1px solid #eeeeee;white-space:normal;color:#555;}.search-item h3 {display:block;font:inherit;font-weight:normal;color:#222;}.search-item h3 span {float: left;font-weight:normal;margin:0 0 1px 1px;width:100px;display:block;clear:none;}</style><div class="search-item">',
           '<span></span><p></p>',                  
       '</div></tpl>');
	
 	Ext.form.TriggerField.override({
    	afterRender : function(){
        	Ext.form.TriggerField.superclass.afterRender.call(this);
           	var y;
           	if(Ext.isIE && !this.hideTrigger && this.el.getY() != (y = this.trigger.getY())){
            	this.el.position();
                this.el.setY(y);
           	}
       	}
   	});  

	var nroExpDict = new Ext.form.NumberField({
		name:'abmObjet.nroExpDict',
		id:'nroExpDict',		
		allowBlank:false,
		blankText : 'Este campo es requerido.',	
		msgTarget:'side',
		maxLength:6,
		allowDecimals:false,
		labelStyle: 'font:normal 10px Verdana;text-align: right;',
		fieldLabel:'Expediente',	
		value:((acc=='update')||(acc=='ver'))?Ext.getCmp('gridDictamenes').getSelectionModel().getSelected().data.numeroExpediente:'',	
		width:55
	});

	var letraExpDict = new Ext.form.TextField({
		name:'abmObjet.letraExpDict',
		id:'letraExpDict',		
		allowBlank:false,
		blankText : 'Este campo es requerido.',	
		msgTarget:'side',
		maxLength:6,
		maskRe:/[A-Z,a-z]/,
		labelStyle: 'font:normal 10px Verdana;text-align: right;',
		value:((acc=='update')||(acc=='ver'))?Ext.getCmp('gridDictamenes').getSelectionModel().getSelected().data.letraExpediente:'',
		width:56
	});
	var anioExpDict = new Ext.form.TextField({
		name:'abmObjet.anioExpDict',
		id:'anioExpDict',		
		allowBlank:false,
		maxLength:4,
		minLength:4,
		blankText : 'Este campo es requerido.',	
		msgTarget:'side',
		labelStyle: 'font:normal 10px Verdana;text-align: right;',
		value:((acc=='update')||(acc=='ver'))?Ext.getCmp('gridDictamenes').getSelectionModel().getSelected().data.anioExpediente:'',
		width:40
	});
	
	var expedientePanel = new Ext.Panel({
		id:'expedientePanel',
		fieldLabel:'Expediente',
		border: false,
		labelStyle: 'font:normal 10px Verdana',
		items: [nroExpDict, 
		        letraExpDict, 
				anioExpDict]
	}); 
		
	var navDictamenes = new Ext.FormPanel({
		id:'navDictamenes',
		baseCls: 'x-plain',		
		method:'POST',				
		height: 500,
		labelWidth: 100, 			          
		width: 780, 
		border:false,
		monitorValid:true,
		listeners:{clientvalidation:function(form, valid){  		 										
			if ((valid)){
				//Ext.getCmp('guardarDictamenTecnico').enable();
			}else{
				//Ext.getCmp('guardarDictamenTecnico').disable();
			}													    		                            					
		}},   
		bodyStyle:'background-color:#F5f5f5;padding:10px 10px 10px 10px;',		
		items: [{bodyStyle:'background-color:#Ffffff;padding:10px 10px 10px 10px;',
			layout:'form',		            				 		
		    items:
			[gridDictamenes]}]				
	});	 
	 
	var winDictamenes = new Ext.Window({
		title:'Asignar Dictámen Técnico',	     
	    width: 800,
	    closeAction : 'destroy',
	    id:'winDictamenes',
	    height: 300,
	    resizable :false,
	    shadow : true,
	    shadowOffset : 8,
	    modal:true,
	    plain: false,
	    maximizable :false,	
	    closable :false,           
	    items: [navDictamenes],
	    tbar:[{
	    	text:'Guardar',
	        id: 'guardarDictamenes',
	        iconCls:'add',
	        hidden:(acc=='ver')?true:false,
		    handler:function(){
		    		
		    		if (gridDictamenes.getSelectionModel().getCount()>0){
		    		arrI = [];
		    		lista = gridDictamenes.getSelectionModel().getSelections();
					ci = gridDictamenes.getSelectionModel().getCount();
					for (i=0;i<ci;i++){
						arrI[i]=lista[i].data.dictamenTecnicoId;	
					}
					t = arrI.join(',');
					console.log(t);
						navDictamenes.getForm().submit({
					    	url: '../generic/DictamenTecnicoActionasignar.action',
							params: {'dictamenes': t,'TodoId': Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.TodoId},                       
					        waitMsg: 'Grabando...',                
					        waitTitle : 'Procesando petición', 
					        failure : function(fps, o){   
			                	msg('Error', o.result.msg, Ext.Msg.ERROR );	  
			           		},                          
					        success: function(fps, o){
					        	msg('Información', o.result.msg ,Ext.Msg.INFO); 
					            //winDictamenes.destroy();	
					            storeDictamenTodoGlobal.reload();
					        }                       
						});
			    	 }else{
		      			msg('Error', 'Debe seleccionar al menos un Dictámen Técnico', Ext.Msg.ERROR );
			     	 }
		     }			     
		},{
			text:'Cerrar',
			iconCls:'eliminar',
		    handler:function(){
	        	winDictamenes.destroy();
			}    
		}] 
	});	
	
	winDictamenes.show();
	storeDictamenes.load({params:{limit:14,'TodoId':Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.TodoId}});
	
	 
} 

// FIN ASIGNACIÓN DICTAMEN TÉCNICO
		
	
</script>

<style type="text/css">
	
  	.pdf {
   		background-image:url(../altec/images/report/pdf_small.gif) !important;   	
   	}
  	.rtf{
 		background-image:url(../altec/images/report/doc_small.gif) !important;
 	} 

    </style>

 <body >
 	<s:form   name="formReporteTodos" method="post"  id="formReporteTodos" theme="simple">
		<s:hidden id="TodoReporteId" name="TodoReporteId" />	
		<s:hidden id="importeReporte" name="importeReporte" />	
		<s:hidden id="antecedentesReporte" name="antecedentesReporte" />	
	</s:form>	
 		
	<table width="100%"  align="center" cellpadding="2" cellspacing="0">
				<tr>
				<td>
				<div id="gridTodoDiv" >
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


var myReaderTodo= new Ext.data.JsonReader({
	totalProperty: 'totalCount',
	root: 'ffis',
		id: 'TodoId',	
	fields:[{name: 'TodoId', mapping: 'TodoId' },
	    	{name: 'fecha', mapping: 'fecha'},
	    	{name: 'dac', mapping: 'dac'},
	    	{name: 'fechaNotifDAC', mapping: 'fechaNotifDAC'},
	    	{name: 'persNRMascPerm', mapping: 'persNRMascPerm'},
	    	{name: 'persNRMascTrans', mapping: 'persNRMascTrans'},
	    	{name: 'persNRMascGol', mapping: 'persNRMascGol'},
	    	{name: 'persNRFemPerm', mapping: 'persNRFemPerm'},
			{name: 'persNRFemTrans', mapping: 'persNRFemTrans'},
	    	{name: 'persNRFemGol', mapping: 'persNRFemGol'},
	    	{name: 'clausuradoPrev', mapping: 'clausuradoPrev'},
	    	{name: 'rebeldia', mapping: 'rebeldia'},
	    	{name: 'diasClausura', mapping: 'diasClausura'},
	    	{name: 'asesorLetradoId', mapping: 'asesorLetradoId'},
	    	{name: 'asesorLetrado', mapping: 'asesorLetrado'},
	    	{name: 'sumarianteId', mapping: 'sumarianteId'},
	    	{name: 'sumariante', mapping: 'sumariante'},
	    	{name: 'expediente', mapping: 'expediente'},
	    	{name: 'origen', mapping: 'origen'},
	    	{name: 'numeroExpediente', mapping: 'numeroExpediente'},
	    	{name: 'letraExpediente', mapping: 'letraExpediente'},
	    	{name: 'anioExpediente', mapping: 'anioExpediente'},
	    	{name: 'numeroOrigen', mapping: 'numeroOrigen'},
	    	{name: 'letraOrigen', mapping: 'letraOrigen'},
	    	{name: 'anioOrigen', mapping: 'anioOrigen'},
	    	{name: 'delegacionId', mapping: 'delegacionId'},
	    	{name: 'delegacionNombre', mapping: 'delegacionNombre'},
	    	{name: 'actaId', mapping: 'actaId'},
	    	{name: 'acta', mapping: 'acta'},
	    	{name: 'actaDom', mapping: 'actaDom'},
	    	{name: 'domicilioInspeccionado', mapping: 'domicilioInspeccionado'},
	    	{name: 'editable', mapping: 'editable'},
	    	{name: 'finalizable', mapping: 'finalizable'},
	    	{name: 'estado9descripcion', mapping: 'estado9descripcion'},
	    	{name: 'estado9estadoTodoId', mapping: 'estado9estadoTodoId'},
	    	{name: 'persDetMascPerm', mapping: 'persDetMascPerm'},
	    	{name: 'persDetMascTrans', mapping: 'persDetMascTrans'},
	    	{name: 'persDetMascGol', mapping: 'persDetMascGol'},
	    	{name: 'persDetFemPerm', mapping: 'persDetFemPerm'},
			{name: 'persDetFemTrans', mapping: 'persDetFemTrans'},
	    	{name: 'persDetFemGol', mapping: 'persDetFemGol'},
	    	{name: 'hayResolucion', mapping: 'hayResolucion'},
	    	{name: 'alerta', mapping: 'alerta'},
	    	{name: 'cantInfracciones', mapping: 'cantInfracciones'},
	    	{name: 'domiciolioNotificacionEmpleador', mapping: 'domiciolioNotificacionEmpleador'},
	    	{name: 'localidadNotificacionEmpleador9localidadId', mapping: 'localidadNotificacionEmpleador9localidadId'},
	    	{name: 'localidadNotificacionEmpleador9nombre', mapping: 'localidadNotificacionEmpleador9nombre'}
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
 baseParams: {limit:parseInt((screen.height-320)/25)},
 sortInfo: {
	    field: 'TodoId',
	    direction: 'DESC' // or 'DESC' (case sensitive for local sorting)
	}
 });



storeTodo.on('datachanged',function(){
	//Ext.getCmp('gridTodo').view.scrollToTop();
	//Ext.getCmp('gridTierras');
	});



var smTodo = new Ext.grid.CheckboxSelectionModel({singleSelect:true});

var filtersTodo = new Ext.ux.grid.GridFilters({
	  filters:[
	    {type: 'numeric',  dataIndex: 'TodoId'},
	    {type: 'date',  dataIndex: 'fecha'},
	    {type: 'boolean',  dataIndex: 'dac'},
	    {type: 'string',  dataIndex: 'acta'},
	    {type: 'string',  dataIndex: 'delegacionNombre'},
	    {type: 'boolean',  dataIndex: 'clausuradoPrev'},
	    {type: 'boolean',  dataIndex: 'rebeldia'},
	    {type: 'date',  dataIndex: 'fechaNotifDAC'},
	    {type: 'numeric',  dataIndex: 'persNRMascPerm'},
	    {type: 'numeric',  dataIndex: 'persNRMascTrans'},
	    {type: 'numeric',  dataIndex: 'persNRMascGol'},
	    {type: 'numeric',  dataIndex: 'persNRFemPerm'},
	    {type: 'numeric',  dataIndex: 'persNRFemTrans'},
	    {type: 'numeric',  dataIndex: 'persNRFemGol'},
	    {type: 'numeric',  dataIndex: 'diasClausura'},
	    {type: 'string',  dataIndex: 'numeroExpediente'},
	    {type: 'string',  dataIndex: 'letraExpediente'},
	    {type: 'string',  dataIndex: 'anioExpediente'},
	    {type: 'string',  dataIndex: 'numeroOrigen'},
	    {type: 'string',  dataIndex: 'letraOrigen'},
	    {type: 'string',  dataIndex: 'anioOrigen'},
	    {type: 'string',  dataIndex: 'domicilioInspeccionado'},
	    {type: 'string',  dataIndex: 'estado9descripcion'},
	    {type: 'string',  dataIndex: 'domiciolioNotificacionEmpleador'},
	    {type: 'string',  dataIndex: 'localidadNotificacionEmpleador9nombre'}
	    ]});

Ext.onReady(function(){

	

	function eliminarTodo(){ 
		if(Ext.getCmp('gridTodo').getSelectionModel().getCount()==1){				
			Ext.MessageBox.confirm('Anular Todo','¿Realmente Desea Anular el Todo número '+ Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.TodoId+'?',eliminarPress);
		}else{
			Ext.MessageBox.alert("Atención","Debe seleccionar un registro para Anular");
		}
	}

	
	function aprobarTodo(){ 
		 
		if(Ext.getCmp('gridTodo').getSelectionModel().getCount()==1){	
			
				if (Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.estado9estadoTodoId==0){	
					if (Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.cantInfracciones!=0){
						Ext.MessageBox.confirm('Aprobar Todo','¿Realmente Desea aprobar el Todo número '+ Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.TodoId+'?',aprobarSumPress);
					}else{
						Ext.MessageBox.alert("Atención","El Todo no Tiene Infracciones Asociadas");	
					}
				}else{
					Ext.MessageBox.confirm('Aprobar Todo','¿Realmente Desea desaprobar el Todo número '+ Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.TodoId+'?',desaprobarSumPress);
				}
			
		}else{
			Ext.MessageBox.alert("Atención","Debe seleccionar un registro para Aprobar/Desaprobar");
		}
	}

	
	
	function aprobarSumPress(btn)
	{
		if(btn=='yes'){
			   fps.getForm().submit({
		            url: '../generic/TodoActionaprobar.action',                        
		            params : 
			            {
				            'id':Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.TodoId
				        },               
				        waitMsg: 'Aprobando...',                
			            waitTitle : 'Procesando petición', 
			            failure : function(fps, o){   
			                msg('Error', o.result.msg, Ext.Msg.ERROR );	  
			                reloadgrilla();              
			            }    ,                          
			            success: function(fps, o){
			                msg('Información', o.result.msg ,Ext.Msg.INFO); 
			                reloadgrilla();	
			                Ext.getCmp('editarBotonTodo').disable();
							Ext.getCmp('eliminarTodo').disable();
							Ext.getCmp('aprobarTodo').setText('Desaprobar');
							Ext.getCmp('aprobarTodo').enable();
							Ext.getCmp('notificarTodo').setText('Notificar');
							Ext.getCmp('notificarTodo').enable();
							Ext.getCmp('finalizarTodo').enable();
							Ext.getCmp('anexo').enable();
							Ext.getCmp('cedula').enable();
			            }                         
		        });
		}	
	}

	function desaprobarSumPress(btn)
	{
		if(btn=='yes'){
			   fps.getForm().submit({
		            url: '../generic/TodoActiondesaprobar.action',                        
		            params : 
			            {
				            'id':Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.TodoId
				        },               
				        waitMsg: 'Desaprobando...',                
			            waitTitle : 'Procesando petición', 
			            failure : function(fps, o){   
			                msg('Error', o.result.msg, Ext.Msg.ERROR );	  
			                reloadgrilla();              
			            }    ,                          
			            success: function(fps, o){
			                msg('Información', o.result.msg ,Ext.Msg.INFO); 
			                reloadgrilla();	
			                Ext.getCmp('editarBotonTodo').enable();
							Ext.getCmp('eliminarTodo').enable();
							Ext.getCmp('aprobarTodo').setText('Aprobar');
							Ext.getCmp('aprobarTodo').enable();
							Ext.getCmp('notificarTodo').disable();
							Ext.getCmp('finalizarTodo').disable();
							Ext.getCmp('anexo').disable();
							Ext.getCmp('cedula').disable();
			            }                         
		        });
		}	
	}
	
	function eliminarPress(btn)
	{
		if(btn=='yes'){
			   fps.getForm().submit({
		            url: '../generic/TodoActionanular.action',                        
		            params : 
			            {
				            'id':Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.TodoId
				        },               
				        waitMsg: 'Anulando...',                
			            waitTitle : 'Procesando petición', 
			            failure : function(fps, o){   
			                msg('Error', o.result.msg, Ext.Msg.ERROR );	  
			                reloadgrilla();              
			            }    ,                          
			            success: function(fps, o){
			                msg('Información', o.result.msg ,Ext.Msg.INFO); 
			                	
			                Ext.getCmp('editarBotonTodo').disable();
							Ext.getCmp('eliminarTodo').disable();
							Ext.getCmp('aprobarTodo').disable();
							Ext.getCmp('notificarTodo').disable();
							Ext.getCmp('finalizarTodo').disable();
							reloadgrilla();
			            }                         
		        });
		}	
	}

	function eliminarMPress(btn)
	{
		if(btn=='yes'){
			   fps.getForm().submit({
		            url: '../generic/deleteMenor.action',                        
		            params : 
			            {
				            'TodoId':Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.TodoId,
				            'menorId':Ext.getCmp('gridMenores').getSelectionModel().getSelected().data.menorId
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

	function rebeldiaTodo(){ 
		if(Ext.getCmp('gridTodo').getSelectionModel().getCount()==1){	
			
				Ext.MessageBox.confirm('Declarar Rebeldía Todo','¿Realmente Desea declarar Rebeldía en Todo número '+ Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.TodoId+'?',rebeldiaSumPress);
			
		}else{
			Ext.MessageBox.alert("Atención","Debe seleccionar un registro para declarar Rebeldía");
		}
	}

	
	
	function rebeldiaSumPress(btn){
		if(btn=='yes'){
			   fps.getForm().submit({
		            url: '../generic/TodoActionrebeldia.action',                        
		            params : {'id':Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.TodoId},               
				    waitMsg: 'Aprobando...',                
			        waitTitle : 'Procesando petición', 
			        failure : function(fps, o){   
			                msg('Error', o.result.msg, Ext.Msg.ERROR );	  
			                reloadgrilla();              
			        },                          
			        success: function(fps, o){
			                msg('Información', o.result.msg ,Ext.Msg.INFO); 
			                reloadgrilla();	
			                printRebeldiaTodo('PDF');
			                printConclusionRebeldiaTodo('PDF');
			              
			        }                         
		        });
		}	
	}
		
	function finalizarTodo(){
		var TodoFinId = new Ext.form.Hidden({
			id:'TodoFinId',
			name:'TodoFinId'
			});
		

		var tipoInstrumentoSum = new Ext.form.TextField({
			name:'tipoInstrumentoSum',
			id:'tipoInstrumentoSum',		
			allowBlank:false,
			labelStyle: 'font:normal 10px Verdana;text-align: right;',
			fieldLabel:'Tipo Instrumento',	
			width:150
			});
		
		var fechaInstrumentoSum = new Ext.form.DateField({
			id:'fechaInstrumentoSum', 
			name:'fechaInstrumentoSum', 
			fieldLabel: 'Fecha Instrumento',
			labelStyle: 'font:normal 10px Verdana;text-align: right;',
			format:'d/m/Y',
			altFormats:'d/m/y',
			allowBlank:false,
			//msgTarget:'side',
			maxValue :new Date(),
			width:140
			});
		

		var numeroInstrumentoSum = new Ext.form.TextField({
			name:'numeroInstrumentoSum',
			id:'numeroInstrumentoSum',		
			allowBlank:false,
			//allowDecimals:false,
			//allowNegative :false,
			labelStyle: 'font:normal 10px Verdana;text-align: right;',
			fieldLabel:'Nro. Instrumento',	
			width:150
			});
		

	
	var nameMotivoTodo = new Ext.data.JsonStore({
		fields: ['motivoId','descripcion'],    
	    proxy: new Ext.data.HttpProxy({ method: 'POST', url:'../generic/doComboMotivoTodo.action'}),
	    autoLoad:false
	});
	
	var cmbMotivoTodo= new Ext.form.ComboBox({
	    id:'cmbMotivoTodo',
		name:'motivoTodoId',
		store: nameMotivoTodo,       
		hiddenName: "motivoTodoId",		 	
		allowBlank:false,
		displayField:'descripcion',
		valueField: 'motivoId',
		typeAhead: false,     		 	  
		triggerAction: 'all',
		emptyText:'Seleccione...',              
		loadingText: 'cargando...',
		minChars:2, 
		disabled  :false,
		blankText : 'Este campo es requerido.',	
		msgTarget:'side',
		forceSelection :false,
		selectOnFocus:true,
	    labelStyle: 'font:normal 10px Verdana;text-align: right;',
		fieldLabel:'Motivo',	
		listWidth: 150,     	
		width: 150,
		mode: 'remote'	
		});

	var nameProfecionalIntervinienteSum = new Ext.data.JsonStore({
		fields: ['asesorLetradoId','nombre'],    
	    proxy: new Ext.data.HttpProxy({ method: 'POST', url:'../generic/comboProfesional.action'}),
	    autoLoad:false
	});
	
	var cmbProfesionalIntervinienteSum= new Ext.form.ComboBox({
	    id:'cmbProfesionalIntervinienteSum',
		name:'asesorLetradoSumId',
		store: nameProfecionalIntervinienteSum,       
		hiddenName: "asesorLetradoSumId",		 	
		allowBlank:false,
		displayField:'nombre',
		valueField: 'asesorLetradoId',
		typeAhead: false,     		 	  
		triggerAction: 'all',
		emptyText:'Seleccione...',              
		loadingText: 'cargando...',
		minChars:2, 
		disabled  :false,
		blankText : 'Este campo es requerido.',	
		msgTarget:'side',
		forceSelection :false,
		selectOnFocus:true,
	    labelStyle: 'font:normal 10px Verdana;text-align: right;',
		fieldLabel:'Profesional Interviniente',	
		listWidth: 150,     	
		width: 150,
		mode: 'remote'	
		});
	
	var navEstadoTodo = new Ext.FormPanel({
		id:'navEstadoTodo',
	    baseCls: 'x-plain',		
		method:'POST',				
		height: 250,
		 //  labelWidth: 75, 			          
		 width: 375, 
		 border:false,
		 monitorValid:true,
	      listeners:{clientvalidation:function(form, valid)
		 		{  		 										
					if (valid)
						{
							Ext.getCmp('guardarESum').enable();
							}else{
							Ext.getCmp('guardarESum').disable();
						}													    		                            					
				}
			},   
		 bodyStyle:'background-color:#F5f5f5;padding:10px 10px 10px 10px;',		
		 items: [{bodyStyle:'background-color:#Ffffff;padding:10px 10px 10px 10px;',
	            layout:'form',		            				 		
	            items:
		            [TodoFinId, cmbMotivoTodo, tipoInstrumentoSum, fechaInstrumentoSum, numeroInstrumentoSum, cmbProfesionalIntervinienteSum]}]				
	});

	function agregarEstadoTodo(st){
		navEstadoTodo.getForm().submit({
            url: '../generic/finalizarTodo.action',                        
            waitMsg: 'Grabando...',                
            waitTitle : 'Procesando petición', 
            failure : function(fps, o){   
                msg('Error', o.result.msg, Ext.Msg.ERROR );	
                	  
            }    ,                          
            success: function(fps, o){
                msg('Información', o.result.msg ,Ext.Msg.INFO);
                winEstadoTodo.destroy();
                Ext.getCmp('editarBotonTodo').disable();
				Ext.getCmp('eliminarTodo').disable();
				Ext.getCmp('aprobarTodo').disable();
				Ext.getCmp('notificarTodo').disable();
				Ext.getCmp('finalizarTodo').disable();
                reloadgrilla();	
                                 
            }                       
        });
	}
	
	var winEstadoTodo = new Ext.Window({
	      title: 'Finalizar Todo',	     
	      width: 390,
	      closeAction : 'destroy',
	      id:'winEstadoTodo',
	      height: 300,
	      resizable :false,
	      shadow : true,
	      shadowOffset : 8,
	      modal:true,
	      plain: false,
	      maximizable :false,	
	      closable :false,           
	      items: [navEstadoTodo],
	      tbar:[{
	          text:'Guardar',
	          id: 'guardarESum',
	          iconCls:'add',
		      handler:function(){ 
	    	  agregarEstadoTodo(Ext.getCmp('gridTodo').getStore());
		     }			     
		     }
	          ,{
		          text:'Cerrar',
		          iconCls:'eliminar',
		          handler:function()
		          {
		          
	        	  winEstadoTodo.destroy();
			          }    
		        }]   
	 });
	
	winEstadoTodo.show();
	
	TodoFinId.setValue(Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.TodoId);
	
	}


	function notificarDesTodo(){ 
		if(Ext.getCmp('gridTodo').getSelectionModel().getCount()==1){	
			if (Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.estado9estadoTodoId==1){			
				notificarTodo();
			}else if(Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.estado9estadoTodoId==4){
				Ext.MessageBox.confirm('Desnotificar Todo','¿Realmente Desea Desnotificar el Todo número '+ Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.TodoId+'?',desnotificarSumPress);
			}
		}else{
			Ext.MessageBox.alert("Atención","Debe seleccionar un registro para Notificar/Desnotificar");
		}
	
	};
	
	function desnotificarSumPress(btn)
		{
			if(btn=='yes'){
				   fps.getForm().submit({
			            url: '../generic/TodoActiondesnotificar.action',                        
			            params : 
				            {
					            'TodoNotificacionId':Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.TodoId
					        },               
					        waitMsg: 'Desnotificando...',                
				            waitTitle : 'Procesando petición', 
				            failure : function(fps, o){   
				                msg('Error', o.result.msg, Ext.Msg.ERROR );	  
				                reloadgrilla();              
				            }    ,                          
				            success: function(fps, o){
				                msg('Información', o.result.msg ,Ext.Msg.INFO); 
				                reloadgrilla();	
				                Ext.getCmp('editarBotonTodo').disable();
								Ext.getCmp('eliminarTodo').disable();
								Ext.getCmp('aprobarTodo').setText('Desaprobar');
								Ext.getCmp('aprobarTodo').enable();
								Ext.getCmp('notificarTodo').setText('Notificar');
								Ext.getCmp('notificarTodo').enable();
								Ext.getCmp('finalizarTodo').enable();
								Ext.getCmp('anexo').disable();
								Ext.getCmp('cedula').disable();
				            }                         
			        });
			}	
		};

	function notificarTodo(){
		var TodoNotificacionId = new Ext.form.Hidden({
			id:'TodoNotificacionId',
			name:'TodoNotificacionId'
			});
		

		
		var fechaNotificacionSum = new Ext.form.DateField({
			id:'fechaNotificacionSum', 
			name:'fechaNotificacionSum', 
			fieldLabel: 'Fecha Notificación',
			labelStyle: 'font:normal 10px Verdana;text-align: right;',
			format:'d/m/Y',
			altFormats:'d/m/y',
			allowBlank:false,
			//msgTarget:'side',
			maxValue :new Date(),
			width:140
			});
		

	var navNotificacionTodo = new Ext.FormPanel({
		id:'navNotificacionTodo',
	    baseCls: 'x-plain',		
		method:'POST',				
		height: 250,
		 //  labelWidth: 75, 			          
		 width: 375, 
		 border:false,
		 monitorValid:true,
	      listeners:{clientvalidation:function(form, valid)
		 		{  		 										
					if (valid)
						{
							Ext.getCmp('guardarNotificacionSum').enable();
							}else{
							Ext.getCmp('guardarNotificacionSum').disable();
						}													    		                            					
				}
			},   
		 bodyStyle:'background-color:#F5f5f5;padding:10px 10px 10px 10px;',		
		 items: [{bodyStyle:'background-color:#Ffffff;padding:10px 10px 10px 10px;',
	            layout:'form',		            				 		
	            items:
		            [TodoNotificacionId,  fechaNotificacionSum]}]				
	});

	function agregarNotificacionTodo(st){
		navNotificacionTodo.getForm().submit({
            url: '../generic/notificacionTodo.action',                        
            waitMsg: 'Notificando...',                
            waitTitle : 'Procesando petición', 
            failure : function(fps, o){   
                msg('Error', o.result.msg, Ext.Msg.ERROR );	
                	  
            }    ,                          
            success: function(fps, o){
                msg('Información', o.result.msg ,Ext.Msg.INFO);
                winNotificacionTodo.destroy();
                Ext.getCmp('editarBotonTodo').disable();
				Ext.getCmp('eliminarTodo').disable();
				Ext.getCmp('aprobarTodo').disable();
				Ext.getCmp('notificarTodo').setText('Desnotificar');
				Ext.getCmp('notificarTodo').enable();
				Ext.getCmp('finalizarTodo').enable();
                reloadgrilla();	
                                 
            }                       
        });
	}
	
	var winNotificacionTodo = new Ext.Window({
	      title: 'Notificar Todo',	     
	      width: 390,
	      closeAction : 'destroy',
	      id:'winNotificacionTodo',
	      height: 150,
	      resizable :false,
	      shadow : true,
	      shadowOffset : 8,
	      modal:true,
	      plain: false,
	      maximizable :false,	
	      closable :false,           
	      items: [navNotificacionTodo],
	      tbar:[{
		          text:'Guardar',
		          id: 'guardarNotificacionSum',
		          iconCls:'add',
			      handler:function(){agregarNotificacionTodo(Ext.getCmp('gridTodo').getStore());}			     
			    },{
		          text:'Cerrar',
		          iconCls:'eliminar',
		          handler:function(){winNotificacionTodo.destroy();}    
		        }]   
	 });
	
	winNotificacionTodo.show();
	
	TodoNotificacionId.setValue(Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.TodoId);
	
	}

	
	
	cmodelTodo = new Ext.grid.ColumnModel([
		                          		        smTodo,
		                                        { id: 'TodoId', 
				                                  header: "Número",	                                    
				                                  sortable: true,
				                                  dataIndex: 'TodoId',
				                                  width : 80
				                                 },{ id: 'alerta', 
					                              header: "Alerta",	                                    
					                              sortable: false,
					                              dataIndex: 'alerta',
					                              width : 80
					                             },{ id: 'fecha', 
				                                    header: "Fecha",	                                    
				                                    sortable: true,
				                                    dataIndex: 'fecha',
				                                    width : 100
				                                 },
				                                 { id: 'numeroExpediente', 
						                           header: "Número Exp.",	                                    
						                           sortable: true,
						                           dataIndex: 'numeroExpediente',
						                           width : 60
						                         },   
						                         { id: 'letraExpediente', 
								                   header: "Letra Exp.",	                                    
								                   sortable: true,
								                   dataIndex: 'letraExpediente',
								                   width : 60
								                 },     
								                 { id: 'anioExpediente', 
										           header: "Año Exp.",	                                    
										           sortable: true,
										           dataIndex: 'anioExpediente',
										           width : 60
										         },
						                         { id: 'acta', 
								                   header: "Acta",	                                    
								                   sortable: true,
								                   dataIndex: 'acta',
								                   width : 100
								                 },
								                 { id: 'domicilioInspeccionado', 
										           header: "Dom. Insp.",	                                    
										           sortable: true,
										           dataIndex: 'domicilioInspeccionado',
										           width : 100
										         },
								                 { id: 'dac', 
				                                   header: "DAC",	                                    
				                                   sortable: true,
				                                   align:'center',
				                                   dataIndex: 'dac',
				                                   width : 40,
				                                   renderer:function(v){return (v=='true')?'Si':'No';}
				                                 }, 
				                                 { id: 'delegacionNombre', 
						                           header: "Delegación",	                                    
						                           sortable: true,
						                           dataIndex: 'delegacionNombre',
						                           width : 80
						                         },
		                                         { id: 'fechaNotifDAC', 
				                                   header: "Fecha DAC",	                                    
				                                   sortable: true,
				                                   dataIndex: 'fechaNotifDAC',
				                                   width : 80
				                                 },
		                                         { id: 'persNRMascPerm', 
				                                   header: "PMP",	                                    
				                                   sortable: true,
				                                   align:'center',
				                                   dataIndex: 'persNRMascPerm',
				                                   width : 40
				                                 },
				                                 { id: 'persNRMascTrans', 
						                           header: "PMT",	                                    
						                           sortable: true,
						                           align:'center',
						                           dataIndex: 'persNRMascTrans',
						                           width : 40
						                         },
						                         { id: 'persNRMascGol', 
								                   header: "PMG",	                                    
								                   sortable: true,
								                   align:'center',
								                   dataIndex: 'persNRMascGol',
								                   width : 40
								                 },
								                 { id: 'persNRFemPerm', 
										           header: "PFP",	                                    
										           sortable: true,
										           align:'center',
										           dataIndex: 'persNRFemPerm',
										           width : 40
										         },
										         { id: 'persNRFemTrans', 
												   header: "PFT",	                                    
												   sortable: true,
												   align:'center',
												   dataIndex: 'persNRFemTrans',
												   width : 40
												 },
												 { id: 'persNRFemGol', 
												   header: "PFG",	                                    
												   sortable: true,
												   align:'center',
												   dataIndex: 'persNRFemGol',
												   width : 40
												 },
												 { id: 'clausuradoPrev', 
												   header: "Clausurado",	                                    
												   sortable: true,
												   align:'center',
												   dataIndex: 'clausuradoPrev',
												   width : 80,
												   renderer:function(v){return (v=='true')?'Si':'No';}
												 },
												 { id: 'rebeldia', 
												   header: "Rebeldía",	                                    
												   sortable: true,
												   align:'center',
												   dataIndex: 'rebeldia',
												   width : 80,
												   renderer:function(v){return (v=='true')?'Si':'No';}
												},
												{ id: 'diasClausura', 
												  header: "Días Clausura",	                                    
												  sortable: true,
												  align:'center',
												  dataIndex: 'diasClausura',
												  width : 80
												},
												{ id: 'numeroOrigen', 
												  header: "Num. Origen",	                                    
												  sortable: true,
												  align:'center',
												  dataIndex: 'numeroOrigen',
												  width : 80
												},
												{ id: 'letraOrigen', 
												  header: "Let. Origen",	                                    
												  sortable: true,
												  align:'center',
												  dataIndex: 'letraOrigen',
												  width : 80
												},
												{ id: 'anioOrigen', 
												  header: "Año Origen",	                                    
												  sortable: true,
												  align:'center',
												  dataIndex: 'anioOrigen',
												  width : 80
												},
								                { id: 'estado9descripcion', 
										          header: "Estado",	                                    
										          sortable: true,
										          dataIndex: 'estado9descripcion',
										          width : 60 
								                },
								                { id: 'domiciolioNotificacionEmpleador', 
											      header: "Dom. Notif. Empl.",	                                    
											      sortable: true,
											      dataIndex: 'domiciolioNotificacionEmpleador',
											      width : 100 
									            },
								                { id: 'localidadNotificacionEmpleador9nombre', 
											      header: "Loc. Notif. Empl.",	                                    
											      sortable: true,
											      dataIndex: 'localidadNotificacionEmpleador9nombre',
											      width : 100 
									            }
														                                                                                             	     	    								                                                 
		                               	]);
	
 	function handleActivateTodo(){

		if(gridTodo.getSelectionModel().getCount()>0){
			Ext.getCmp('gridDictamenTodo').enable();
			Ext.getCmp('fpDocumentos').enable();
			
			
			if (gridTodo.getSelectionModel().getSelected().data.editable=='false'){
				
				Ext.getCmp('editarBotonTodo').disable();
				Ext.getCmp('eliminarTodo').disable();
				//Ext.getCmp('aprobarTodo').disable();
				
			}else{
				Ext.getCmp('editarBotonTodo').enable();
				Ext.getCmp('eliminarTodo').enable();
				//Ext.getCmp('aprobarTodo').enable();
			}
			
			//agregado tarea 11497
			
			if (((gridTodo.getSelectionModel().getSelected().data.estado9estadoTodoId==1)||
					(gridTodo.getSelectionModel().getSelected().data.estado9estadoTodoId==4))&&
					(gridTodo.getSelectionModel().getSelected().data.finalizable=='true')){	
					Ext.getCmp('finalizarTodo').enable();
			}else{
					Ext.getCmp('finalizarTodo').disable();
			}	

			//agregado tarea 11498
			//agregado tarea 11555
			
			if (gridTodo.getSelectionModel().getSelected().data.estado9estadoTodoId==1){	
					Ext.getCmp('notificarTodo').setText('Notificar');
					Ext.getCmp('notificarTodo').enable();
				}else if (gridTodo.getSelectionModel().getSelected().data.estado9estadoTodoId==4){
					Ext.getCmp('notificarTodo').setText('Desnotificar');
					Ext.getCmp('notificarTodo').enable();
				}else{
					Ext.getCmp('notificarTodo').disable();
				}	

			//agregado en tarea:11499
			
			if (gridTodo.getSelectionModel().getSelected().data.estado9estadoTodoId==1){
				Ext.getCmp('anexo').enable();
				Ext.getCmp('cedula').enable();
			}else{
				Ext.getCmp('anexo').disable();
				Ext.getCmp('cedula').disable();
			}

			//agregado en tarea:11555
			if (gridTodo.getSelectionModel().getSelected().data.estado9estadoTodoId==1){
				Ext.getCmp('aprobarTodo').setText('Desaprobar');
				Ext.getCmp('aprobarTodo').enable();
			}else if(gridTodo.getSelectionModel().getSelected().data.estado9estadoTodoId==0){
				Ext.getCmp('aprobarTodo').setText('Aprobar');
				Ext.getCmp('aprobarTodo').enable();
			}else{
				Ext.getCmp('aprobarTodo').disable();
			}


			//agregado en tarea:11793
			if (((gridTodo.getSelectionModel().getSelected().data.estado9estadoTodoId==1)||
			(gridTodo.getSelectionModel().getSelected().data.estado9estadoTodoId==4))&&
			(gridTodo.getSelectionModel().getSelected().data.hayResolucion=='false')){
				Ext.getCmp('proyResolucion').enable();
			}else{
				Ext.getCmp('proyResolucion').disable();
			}

			
			
		}else{
			Ext.getCmp('fpDocumentos').disable();
		}
	};
	
	var gridTodo = new Ext.grid.EditorGridPanel({
		iconCls:'icon-grid',   
		title:'Todos',	    
		height:screen.height-370,
	    listeners: {rowclick: handleActivateTodo},
	  	width:screen.width-5,
	  	stripeRows: true,
	    id:'gridTodo',
	    //renderTo:'gridTodoDiv',
	    store: storeTodo,    
	    cm: cmodelTodo,
	    sm: smTodo,    
	    enableColumnMove:true,
	    enableColumnResize:true,	
	    plugins: [filtersTodo],    
	    trackMouseOver:true,
	    loadMask: true,    
	    tbar:[{
			    text:'Agregar',
			    iconCls:'add',
			    id:'agregarBoton',
			    hidden:(<%=request.getAttribute("ALTA")%>!=null)?false:true,    
			    handler:function (){agregarTodo('new');}
			  },'-',{
				text:'Editar',
			    iconCls:'editar',
			    id:'editarBotonTodo',	        
			    hidden:(<%=request.getAttribute("MODIFICAR")%>!=null)?false:true,    
			    handler:function (){agregarTodo('update');}
	    	  },'-',{
		        text:'Anular',
		        iconCls:'eliminar',
		        id:'eliminarTodo',	            
		        hidden:(<%=request.getAttribute("ANULARTodo")%>!=null)?false:true,
		        handler:eliminarTodo
	    	  },'-',{
		        text:'Aprobar',
		        //iconCls:'eliminar',
		        id:'aprobarTodo',	            
		        hidden:(<%=request.getAttribute("APROBARDESTodo")%>!=null)?false:true,
		        handler:aprobarTodo
	    	  },'-',{
		        text:'Notificar',
		        //iconCls:'eliminar',
		        id:'notificarTodo',	            
		        hidden:(<%=request.getAttribute("NOTIFICARTodo")%>!=null)?false:true,
		        handler:notificarDesTodo
	    	  },'-',{
			    text:'Rebeldía',
			    //iconCls:'eliminar',
			    id:'rebeldiaTodo',	            
			    hidden:((<%=request.getAttribute("NOTIFICARTodo")%>!=null)||(<%=request.getAttribute("APROBARDESTodo")%>!=null))?false:true,
			    handler:rebeldiaTodo
		      },'-',{
		        text:'Finalizar',
		        //iconCls:'eliminar',
		        id:'finalizarTodo',	            
		        hidden:(<%=request.getAttribute("FINALIZARTodo")%>!=null)?false:true,
		        handler:finalizarTodo
	    	  },'-',{
		        text:'Ver',
		        iconCls:'detalle',
		        id:'verTodo',	            
		        // hidden:(<%=request.getAttribute("ELIMINAR")%>!=null)?false:true,
		        handler:function (){agregarTodo('ver');}
    		  },'-',{
		        text:'Instrucción',
		        iconCls:'busqueda',
		        id:'anexo',	            
		        // hidden:(<%=request.getAttribute("ELIMINAR")%>!=null)?false:true,
		        handler:function (){printv("PDF");}
    		  },'-',{
		        text:'Cédula',
		        iconCls:'busqueda',
		        id:'cedula',	            
		        // hidden:(<%=request.getAttribute("ELIMINAR")%>!=null)?false:true,
		        handler:function (){printC("PDF");}
    		  },'-',{
	  		    text: 'Proy. Resolución',		   
	  		    iconCls:'rtf',
	  		    tabIndex:5,
	  		    id:'proyResolucion',
				hidden:(<%=request.getAttribute("PROYECTORESOLUCION")%>!=null)?false:true,
	  		    handler: function(){proyectoResolucion();}
  			  },'-',{
	  		    text: 'pdf',		   
	  		    iconCls:'pdf',
	  		    tabIndex:4,
				hidden:(<%=request.getAttribute("ALTA")%>!=null)?false:true,
	  		    handler: function(){printTodo('PDF');}
  			  }
	    	],
	    bbar: new Ext.PagingToolbar({
	        //pageSize:16,
	        pageSize: parseInt((screen.height-320)/25),
	        store: storeTodo,	       
	        displayInfo: true,
	        displayMsg: 'Mostrando {0} - {1} de {2}',
	        plugins: [filtersTodo,new Ext.ux.ProgressBarPager(),new Ext.ux.SlidingPager()],
	        emptyMsg: "No hay paginas para mostrar",            
	        items:[{
		              pressed: false,
		              enableToggle:true,
		              text: 'Borrar Filtros',
		              cls: 'x-btn-text-icon details',
		              toggleHandler: function(){filtersTodo.clearFilters(); }	              
	          	  }]
	    })
	});

	gridTodo.getSelectionModel().on('rowdeselect', function(sm, rowIdx, r) {   
		Ext.getCmp('gridDictamenTodo').disable();
	});
	
	
	gridTodo.on('afteredit', afterEdit, this ); function afterEdit(val) {     val.record.commit(); };



function printv(obj){

	if((Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.domiciolioNotificacionEmpleador!="")&&
	(Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.localidadNotificacionEmpleador9localidadId!="")){
		document.getElementById('TodoReporteId').value = Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.TodoId;
		if(Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.dac=='true'){
			document.formReporteTodos.action="../generic/printAnexoB.action?type="+obj;
			document.formReporteTodos.target="_blank";
			document.formReporteTodos.submit();
		}else{
			document.formReporteTodos.action="../generic/printAnexo.action?type="+obj;
			document.formReporteTodos.target="_blank";
			document.formReporteTodos.submit();
		}
	}else{
		 msg('Error', 'Para poder imprimir la Instrucción debe completar los campos Domicilio Notificación Empleador y Localidad.', Ext.Msg.ERROR );	
	}	     			
};

function printC(obj){

	if((Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.domiciolioNotificacionEmpleador!="")&&
	(Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.localidadNotificacionEmpleador9localidadId!="")){
	
		document.getElementById('TodoReporteId').value = Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.TodoId;
		if(Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.dac=='true'){
				document.formReporteTodos.action="../generic/printCedulaB.action?type="+obj;
				document.formReporteTodos.target="_blank";
				document.formReporteTodos.submit();
		}else{
			document.formReporteTodos.action="../generic/printCedula.action?type="+obj;
			document.formReporteTodos.target="_blank";
			document.formReporteTodos.submit();
		}
	}else{
		 msg('Error', 'Para poder imprimir la Cédula debe completar los campos Domicilio Notificación Empleador y Localidad.', Ext.Msg.ERROR );	
	}	 
			     			
};

function printTodo(obj){
	
	document.getElementById('TodoReporteId').value = Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.TodoId;
	document.formReporteTodos.action="../generic/printTodos.action?type="+obj;
	document.formReporteTodos.target="_blank";
	document.formReporteTodos.submit();

			     			
};

function printRebeldiaTodo(obj){
	
	document.getElementById('TodoReporteId').value = Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.TodoId;
	document.formReporteTodos.action="../generic/printRebeldiaTodo.action?type="+obj;
	document.formReporteTodos.target="_blank";
	document.formReporteTodos.submit();

			     			
};

function printConclusionRebeldiaTodo(obj){
	
	document.getElementById('TodoReporteId').value = Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.TodoId;
	document.formReporteTodos.action="../generic/printConclusionSumarialRebeldia.action?type="+obj;
	document.formReporteTodos.target="_blank";
	document.formReporteTodos.submit();

			     			
};
	function saveOrUpdateTodo(status){	
		
		var descripcionTodo = new Ext.form.TextField({
			name:'abmObjet.descripcion',
			id:'descripcion',		
			allowBlank:false,
			labelStyle: 'font:normal 10px Verdana;text-align: right;',
			fieldLabel:'Descripción',		
			width:200
			});

		
		var TodoId = new Ext.form.Hidden({
			name:'abmObjet.TodoId',
			id:'TodoId'		
			});

		
		
		if (status=='MODIFICAR'){
			if(Ext.getCmp('gridTodo').getSelectionModel().getCount()==1){
				accion = 'update';
			}else{
				Ext.MessageBox.alert("Atención","Debe seleccionar un registro para editar");
				return;
			} 
		}else{
			accion = 'save';			
		}



		if (accion=='update'){
			Ext.getCmp('navTodo').getForm().loadRecord(
					Ext.getCmp('gridTodo').getSelectionModel().getSelected()
					);	
			}	
		
	}



	function proyectoResolucion(){
		var TodoProResId = new Ext.form.Hidden({
			id:'TodoProResId',
			name:'TodoProResId'
			});


		var nameTipoResolucion = new Ext.data.JsonStore({
			fields: ['tipoResolucionId','descripcion'],    
		    proxy: new Ext.data.HttpProxy({ method: 'POST', url:'../generic/doComboTipoResolucion.action'}),
		    autoLoad:false
		});
		
		var cmbTipoResolucion= new Ext.form.ComboBox({
		    id:'cmbTipoResolucion',
			name:'tipoResolucionId',
			store: nameTipoResolucion,       
			hiddenName: "tipoResolucionId",		 	
			allowBlank:false,
			displayField:'descripcion',
			valueField: 'tipoResolucionId',
			typeAhead: false,     		 	  
			triggerAction: 'all',
			emptyText:'Seleccione...',              
			loadingText: 'cargando...',
			minChars:2, 
			disabled  :false,
			blankText : 'Este campo es requerido.',	
			msgTarget:'side',
			forceSelection :false,
			selectOnFocus:true,
		    labelStyle: 'font:normal 10px Verdana;text-align: right;',
			fieldLabel:'Motivo',	
			listWidth: 600,     	
			width: 600,
			mode: 'remote'	
			});

		var importeMultaRes = new Ext.form.NumberField({
			name:'importeMultaRes',
			id:'importeMultaRes',		
			allowBlank:false,
			labelStyle: 'font:normal 10px Verdana;text-align: right;',
			fieldLabel:'Importe',	
			width:150
			});

		var registraAntecedente = new Ext.form.Checkbox({
			id:'registraAntecedente',
			name:'registraAntecedente',
			fieldLabel:'Registra Antecedentes',
			 labelWidth: 200, 	
			labelStyle: 'font:normal 10px Verdana;text-align: right;',
			checked:false
			});
	
	
	var navProyectoResolucion = new Ext.FormPanel({
		id:'navProyectoResolucion',
	    baseCls: 'x-plain',		
		method:'POST',				
		height: 200,
		 labelWidth: 100, 			          
		 width: 850, 
		 border:false,
		 monitorValid:true,
	     /* listeners:{clientvalidation:function(form, valid)
		 		{  		 										
					if (valid)
						{
							Ext.getCmp('guardarESum').enable();
							}else{
							Ext.getCmp('guardarESum').disable();
						}													    		                            					
				}
			},   */
		 bodyStyle:'background-color:#F5f5f5;padding:10px 10px 10px 10px;',		
		 items: [{bodyStyle:'background-color:#Ffffff;padding:10px 10px 10px 10px;',
	            layout:'form',		            				 		
	            items:
		            [TodoProResId, cmbTipoResolucion, importeMultaRes,registraAntecedente]}]				
	});

	function imprimirProyetoResolucion(){

		document.getElementById('TodoReporteId').value = Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.TodoId;
		document.getElementById('importeReporte').value = Ext.getCmp('importeMultaRes').getValue();
		document.getElementById('antecedentesReporte').value = Ext.getCmp('registraAntecedente').checked;
		if(Ext.getCmp('cmbTipoResolucion').getValue()==1){
				document.formReporteTodos.action="../generic/printProyResLabConv.action?type=RTF";
				document.formReporteTodos.target="_blank";
				document.formReporteTodos.submit();
		}else if (Ext.getCmp('cmbTipoResolucion').getValue()==2){
			document.formReporteTodos.action="../generic/printProyResLabSeg.action?type=RTF";
			document.formReporteTodos.target="_blank";
			document.formReporteTodos.submit();
		}else if (Ext.getCmp('cmbTipoResolucion').getValue()==3){
			document.formReporteTodos.action="../generic/printProyResAbsolver.action?type=RTF";
			document.formReporteTodos.target="_blank";
			document.formReporteTodos.submit();
		}else{
			document.formReporteTodos.action="../generic/printProyResApercibimiento.action?type=RTF";
			document.formReporteTodos.target="_blank";
			document.formReporteTodos.submit();
		}

		
        
	}
	
	var winProyectoResolucion = new Ext.Window({
	      title: 'Proyecto resolución',	     
	      width: 850,
	      closeAction : 'destroy',
	      id:'winProyectoResolucion',
	      height: 200,
	      resizable :false,
	      shadow : true,
	      shadowOffset : 8,
	      modal:true,
	      plain: false,
	      maximizable :false,	
	      closable :false,           
	      items: [navProyectoResolucion],
	      tbar:[{
	          text:'Imprimir',
	          id: 'imprimirProyRes',
	          iconCls:'rtf',
		      handler:function(){ 
	    	  				imprimirProyetoResolucion();
		     				}			     
		     }
	          ,{
		          text:'Cerrar',
		          iconCls:'eliminar',
		          handler:function()
		          {
		          
	        	  winProyectoResolucion.destroy();
			          }    
		        }]   
	 });
	
	winProyectoResolucion.show();
	
	TodoProResId.setValue(Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.TodoId);
	
	}

	

var myReaderDictamenTecnico= new Ext.data.JsonReader({
	totalProperty: 'totalCount',
	root: 'ffis',
	id: 'dictamenTecnicoId',	
	fields:[{name: 'dictamenTecnicoId', mapping: 'dictamenTecnicoId' },
	    	{name: 'fechaElaboracion', mapping: 'fechaElaboracion'},
	    	{name: 'inspector9inspectorId', mapping: 'inspector9inspectorId'},
	    	{name: 'inspector9nombre', mapping: 'inspector9nombre'},
	    	{name: 'expediente', mapping: 'expediente'},
	    	{name: 'resumen', mapping: 'resumen'},
	    	{name: 'numeroExpediente', mapping: 'numeroExpediente'},
	    	{name: 'letraExpediente', mapping: 'letraExpediente'},
	    	{name: 'anioExpediente', mapping: 'anioExpediente'},
	    	{name: 'estado9descripcion', mapping: 'estado9descripcion'},
	    	{name: 'estado9estadoDictamenTecnicoId', mapping: 'estado9estadoDictamenTecnicoId'}
  			]
	});

var myHttpProxyDictamenTecnico = new Ext.data.HttpProxy({
	url: '../generic/grillaByTodoDictamenTecnico.action',
	method:'POST',
	autoLoad:false
	});


var storeDictamenTodo = new Ext.data.Store({
	proxy: myHttpProxyDictamenTecnico,
	reader: myReaderDictamenTecnico,
	remoteSort: true,
	baseParams: {limit:parseInt((screen.height-320)/25)}	
	});
storeDictamenTodoGlobal = storeDictamenTodo;
	
var sm2 = new Ext.grid.CheckboxSelectionModel({singleSelect:true});



 cmodelDictamenTodo = new Ext.grid.ColumnModel([
													sm2,
												 {id: 'dictamenTecnicoId', 
												  header: "Número",	                                    
												  sortable: false,
												  dataIndex: 'dictamenTecnicoId',
												  width : 80
												 },{id: 'fechaElaboracion', 
												  header: "Fecha",	                                    
												  sortable: false,
													 align:'left',
												  dataIndex: 'fechaElaboracion',
												  width : 80
												 },{id: 'numeroExpediente', 
												  header: "Número Exp.",	                                    
												  sortable: false,
												  dataIndex: 'numeroExpediente',
												  align:'center',
												  width : 100
												 },{id: 'letraExpediente', 
												  header: "Letra Exp.",	                                    
												  sortable: false,
												  dataIndex: 'letraExpediente',
												  align:'center',
												  width : 100
												 },{id: 'anioExpediente', 
												  header: "Año Exp.",	                                    
												  sortable: false,
												  dataIndex: 'anioExpediente',
												  align:'center',
												  width : 100
												 },{id: 'inspector9nombre', 
												  header: "Inspector",	                                    
												  sortable: false,
												  align:'center',
												  dataIndex: 'inspector9nombre',
												  width : 150
												 },{id: 'codigoBarras', 
												  header: "Estado",	                                    
												  sortable: false,
												  align:'center',
												  dataIndex: 'estado9descripcion',
												  width : 60
												 },{id: 'resumen', 
												  header: "Resumen",	                                    
												  sortable: false,
												  align:'center',
												  dataIndex: 'resumen',
												  width : 400
												 }                                                             	     	    								                                                 
												]); 
 
 function handleActivateDictamen(){
	 if(gridTodo.getSelectionModel().getCount()>0){
	 	storeDictamenTodo.load({params:{limit:14,'TodoId':Ext.getCmp('gridTodo').getSelectionModel().getSelected().data.TodoId}});
	 }
	};
 
 	var gridDictamenTodo = new Ext.grid.EditorGridPanel({
	iconCls:'icon-grid',   
	title:'Dictamen Técnico',
	autoExpandColumn: 'codigoBarras',  
	listeners: {activate: handleActivateDictamen},	    
	height:screen.height-370,
	width:screen.width-5,
	stripeRows: true,
	id:'gridDictamenTodo',
	store: storeDictamenTodo,  
	cm: cmodelDictamenTodo,
	sm: sm3,
	bbar: new Ext.PagingToolbar({
        //pageSize:16,
        pageSize: parseInt((screen.height-320)/25),
        store: storeDictamenTodo,	       
        displayInfo: true,
        displayMsg: 'Mostrando {0} - {1} de {2}',
        //plugins: [filtersTodo,new Ext.ux.ProgressBarPager(),new Ext.ux.SlidingPager()],
        emptyMsg: "No hay paginas para mostrar"//,            
       /* items:[{
	              pressed: false,
	              enableToggle:true,
	              text: 'Borrar Filtros',
	              cls: 'x-btn-text-icon details',
	              toggleHandler: function(){filtersTodo.clearFilters(); }	              
          	  }]*/
    }),
	tbar:[{
	    text:'Asignar',
	    iconCls:'add',
	    id:'asignarDictamenBoton',
	    handler:function (){
	    	storeDictamenTodo.reload();
	    	asignarDictamen('new');
	    }
	  },'-',{
	        text:'Desasignar',
	        iconCls:'eliminar',
	        id:'desasignarDictamenBoton',
	        handler:function (){
	        	storeDictamenTodo.reload();
	        	desasignarDictamen();
	        }
    	  },'-',
	      	{
	  	        text:'Ver',
	  	        iconCls:'busqueda',
	  	        id:'btnVerDictamen',	            
	  	        handler:function (){verDictamenTecnico();}
	      	}
	]  
	
	});	
 	
 	

	
});
</script>



