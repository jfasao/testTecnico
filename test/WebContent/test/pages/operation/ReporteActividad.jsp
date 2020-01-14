<%@ taglib prefix="s" uri="/struts-tags"%>

<style type="text/css">
.pdf {
	background-image: url(../altec/images/report/pdf_small.gif) !important;
}

.xls {
	background-image: url(../altec/images/report/xls_small.gif) !important;
}

.rtf {
	background-image: url(../altec/images/report/doc_small.gif) !important;
}
</style>
<script type="text/javascript">	

function verGrilla(){

	return true;
}
</script>

<body>
	<s:form name="formReporteActividad" method="post"
		id="formReporteActividad" theme="simple">
		<s:hidden id="fechaIniActividad" name="fechaIniActividad" />
		<s:hidden id="fechaFinActividad" name="fechaFinActividad" />
		<s:hidden id="operativoIdActividad" name="operativoIdActividad" />
		<s:hidden id="tipoInspeccionActividad" name="tipoInspeccionActividad" />

		<div id="reporteActividadDiv">
	</s:form>
</body>



<script type="text/javascript">


Ext.onReady(function(){
	
Ext.apply(Ext.form.VTypes, {
		daterange: function(val, field){
			var date = field.parseDate(val);
			if (!date) {
				return;
			}
			if (field.startDateField && (!this.dateRangeMax || (date.getTime() != this.dateRangeMax.getTime()))) {
				var start = Ext.getCmp(field.startDateField);
				start.setMaxValue(date);
				start.validate();
				this.dateRangeMax = date;
			}
			else 
				if (field.endDateField && (!this.dateRangeMin || (date.getTime() != this.dateRangeMin.getTime()))) {
					var end = Ext.getCmp(field.endDateField);
					end.setMinValue(date);
					end.validate();
					this.dateRangeMin = date;
				}
			
			return true;
		}
	});
	
	
	var diniActividad = new Ext.form.DateField({
		id: 'finiActividad',
		name: 'finiActividad',
		fieldLabel :'Fecha de Inicio',
		format: 'd/m/Y',
		altFormats: 'd/m/Y',
		maxValue:new Date(),
		labelStyle: 'font: 90% Verdana;font-weight:bold;color:#535151;',
		vtype: 'daterange',
		endDateField: 'ffinActividad',
		
	});
	
	var dfinActividad = new Ext.form.DateField({
		id: 'ffinActividad',
		name: 'ffinActividad',
		fieldLabel :'Fecha de Fin',
		maxValue:new Date(),
		labelStyle: 'font: 90% Verdana;font-weight:bold;color:#535151;',
		format: 'd/m/Y',
		altFormats: 'd/m/Y',
		vtype: 'daterange',
		startDateField: 'finiActividad',
		
	});

/*var nameOperativoActividad = new Ext.data.JsonStore({
 		fields: ['operativoId','descripcion'],    
 	    proxy: new Ext.data.HttpProxy({ method: 'POST', url:'../generic/doOperativoReporte.action'}),
 	    autoLoad:false
 	});
	
var cmbOperativoActividad= new Ext.form.ComboBox({
 	id:'cmbOperativoActividad',
 	name:'operativoIdActividad',
 	store: nameOperativoActividad,       
 	//hiddenName: "operativoIdActividad",		 	
 	allowBlank:true,
 	displayField:'descripcion',
 	valueField: 'operativoId',
 	typeAhead: false,     		 	  
 	triggerAction: 'all',
 	emptyText:'Seleccione...',              
 	loadingText: 'cargando...',
 	minChars:2, 
 	selectOnFocus:true,
 	labelWidth:30,
 	labelStyle: 'font: 90% Verdana;font-weight:bold;color:#535151;',
	fieldLabel:'Operativo',	
 	listWidth: 300,     	
 	width: 300,
 	mode: 'remote'	
 	});*/
 	
 	var nameActividadActividad = new Ext.data.JsonStore({
		fields: ['actividadId','descripcion'],    
	    proxy: new Ext.data.HttpProxy({ method: 'POST', url:'../generic/doComboActividad.action'}),
	    autoLoad:false
	});

	var cmbActividadActividad= new Ext.form.ComboBox({
	id:'cmbActividadActividad',
	name:'cmbActividadActividad',
	store: nameActividadActividad,       
	//hiddenName: "localidadIdInspeccionesResul",		 	
	displayField:'descripcion',
	valueField: 'actividadId',
	allowBlank :true,
	msgTarget:'side',
	typeAhead: false,     		 	  
	triggerAction: 'all',
	emptyText:'Seleccione...',              
	loadingText: 'cargando...',
	minChars:2, 
	selectOnFocus:true,
	labelWidth:30,
	labelStyle: 'font: 90% Verdana;font-weight:bold;color:#535151;',
	fieldLabel:'Actividad',	
	listWidth: 300,     	
	width: 300,
	mode: 'remote'	
	});
	
	var nameTipoInspeccionActividad = new Ext.data.JsonStore({
 		fields: ['tipoInspeccionId','descripcion'],    
 	    proxy: new Ext.data.HttpProxy({ method: 'POST', url:'../generic/doComboTipoInspeccion.action'}),
 	    autoLoad:false
 	});
	
	var cmbTipoInspeccionActividad= new Ext.form.ComboBox({
 	    id:'cmbTipoInspeccionActividad',
	 	name:'cmbTipoInspeccionActividad',
	 	store: nameTipoInspeccionActividad,       
	 	//hiddenName: "tipoInspeccion",		 	
	 	allowBlank:true,
	 	displayField:'descripcion',
	 	valueField: 'tipoInspeccionId',
	 	typeAhead: false,     		 	  
	 	triggerAction: 'all',
	 	emptyText:'Seleccione...',              
	 	loadingText: 'cargando...',
	 	minChars:2, 
		blankText : 'Este campo es requerido.',	
		msgTarget:'side',
		//validator:function(){if((this.getValue()=='')||(this.getValue()==-1)){return false}else{return true}},
		forceSelection :true,
	 	//forceSelection : false,
	 	selectOnFocus:true,
	 	labelStyle: 'font: 90% Verdana;font-weight:bold;color:#535151;',
		fieldLabel:'Tipo Inspección',	
	 	listWidth: 300,     	
	 	width: 300,
	 	mode: 'remote'	
	 	});
	
var navReporteActividad = new Ext.FormPanel({
			id:'navReporteActividad',
		    baseCls: 'x-plain',		
			method:'POST',	
			autoWidth:true,
			autoHeight:true,			
			applyTo:'reporteActividadDiv',
			border:false,
			monitorValid:true,
		    bodyStyle:'background-color:#F5f5f5;padding:10px 10px 10px 10px;',		
			 items: [{bodyStyle:'background-color:#F5f5f5;padding:10px 10px 10px 10px;',
		            layout:'column',		            				 		
		            items:[{	
                  columnWidth:.5,
				  border:false,
				  layout: 'form',
				  	
               	  bodyStyle:'background-color:#F5f5f5;padding:10px 10px 10px 10px;',
                  items: [diniActividad,cmbActividadActividad]
              }, {
			  	columnWidth: .5,
			  	border: false,
				layout: 'form',
			  	bodyStyle: 'background-color:#F5f5f5;padding:10px 10px 10px 10px;',
			  	items: [dfinActividad,cmbTipoInspeccionActividad]
			  }]
			  }],
						
			
			 tbar: [
      		{
      		    text: 'pdf',		   
      		    iconCls:'pdf',
      		    tabIndex:4,
      		    handler: function()
      		    {
      			printv('PDF');
      			    }
      		}]				
		});	 




function printv(obj){
	document.getElementById('operativoIdActividad').value = Ext.getCmp('cmbActividadActividad').getValue();
	document.getElementById('tipoInspeccionActividad').value = Ext.getCmp('cmbTipoInspeccionActividad').getValue();
	document.getElementById('fechaIniActividad').value = Ext.getCmp('finiActividad').getRawValue();
	document.getElementById('fechaFinActividad').value = Ext.getCmp('ffinActividad').getRawValue();
	document.formReporteActividad.action="../generic/printActividad.action?type="+obj;
	document.formReporteActividad.target="_blank";
	document.formReporteActividad.submit();

			     			
};
	
	
	
});




</script>
