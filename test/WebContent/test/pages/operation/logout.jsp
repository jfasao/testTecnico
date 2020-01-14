
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
	return true;
}

function verGrilla()
{ 	
	 return true;
}

 
		
	
</script>



<body>
	<table width="100%" align="center" cellpadding="2" cellspacing="0">
		<tr>
			<td>
				<div id="logoutDiv"></div>

			</td>
		</tr>
	</table>
</body>





<script type="text/javascript">

/*var btnSalir = new Ext.Button({		
	 text:'Aceptar',
	 labelStyle: 'color:#FFF; font:normal 14px Verdana;text-align: right;',
	 width: 80,
	 handler:function()
	 {
			document.logonForm.action="../seguridad/logout.action";
			document.logonForm.submit();
	 }
});

	var mensaje = new Ext.form.Label({
		style:'font:normal 10px Verdana;text-align: right;',
		text:'Su sesión a caducado. Oprima aceptar para autentificarse nuevamente.'
	});


var winTimeout = new Ext.Window({
    title: '',	     
    width: 200,
    closeAction : 'destroy',
    id:'winTimeout',
    resizable :false,
    shadow : true,
    buttonAlign:'center',
    shadowOffset : 8,
    modal:true,
    plain: true,
    maximizable :false,	
    closable :false,           
    items: [mensaje],
    bbar:[
          {
        	  text:'Aceptar',
        	  handler:function()
        		 {
        				document.logonForm.action="../seguridad/logout.action";
        				document.logonForm.submit();
        		 }
          }
          ]
});	
	
winTimeout.show();*/

Ext.Msg.alert('Expiró la sesión', 'Su sesión a expirado. Autentifíquese nuevamente para continuar trabajando.', function(){
	document.logonForm.action="../seguridad/logout.action";
	document.logonForm.submit();
});
</script>

