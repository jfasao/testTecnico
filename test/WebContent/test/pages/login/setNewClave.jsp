<%@ taglib prefix="s" uri="/struts-tags"%>



<script>
/*
encodeURIComponent=escape;
decodeURIComponent=unescape;
*/
var longClave = "";
</script>




<body>
	<s:form name="formGeneric" method="post" id="formGeneric"
		theme="simple">

		<s:hidden id="longMinima" name="longMinima"></s:hidden>

	</s:form>


	<table border="0" align="center" width="100%" height="100%">
		<tr>
			<td align="center" valign="middle">
				<div style="width: 400px; text-align: left;">
					<div class="x-box-tl">
						<div class="x-box-tr">
							<div class="x-box-tc"></div>
						</div>
					</div>
					<div class="x-box-ml">
						<div class="x-box-mr">
							<div class="x-box-mc">
								<font color="#868d9d"
									style="font-family: Arial; font-variant: normal; font-size: 150%; line-height: 28px; font-weight: bold;">Cambio
									de Clave</font>

								<div id="divCambioClave"></div>

							</div>
						</div>
					</div>
					<div class="x-box-bl">
						<div class="x-box-br">
							<div class="x-box-bc"></div>
						</div>
					</div>
				</div>
			</td>
		</tr>
	</table>


</body>






<script type="text/javascript">
Ext.apply(Ext.form.VTypes, { 
    password : function(val, field) {
        if (field.initialPassField) {
            var pwd = Ext.getCmp(field.initialPassField);
            return (val == pwd.getValue());
        }
        return true;
    },

    passwordText : 'La clave de confirmación no coinciden'
});

Ext.onReady(function(){
	
    Ext.QuickTips.init();

    Ext.form.Field.prototype.msgTarget = 'side';

	
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
		


	
			
	



		var claveActual = new Ext.form.TextField({
			id:'claveActual',	
			name:'oldPassword',	
			allowBlank:false,
			inputType: 'password',				
			labelStyle: 'font:normal 10px Verdana;text-align: right;',
			fieldLabel:'Clave Actual',		
			width:198
			});
	 	
		var newClave = new Ext.ux.PasswordMeter({
			id:'newClave',	
			name:'newPassword',	
			inputType: 'password',				
			allowBlank:false,
			labelStyle: 'font:normal 10px Verdana;text-align: right;',
			fieldLabel:'Nueva Clave',		
			width:198
			});

		var claveVerificacion = new Ext.form.TextField({
			id:'claveVerificacion',
			allowBlank:false,
			vtype: 'password',
			inputType: 'password',
			initialPassField: 'newClave' ,
			labelStyle: 'font:normal 10px Verdana;text-align: right;',
			fieldLabel:'Confirmar Clave',		
			width:198
			});
	 	

		  var longMinima =  document.getElementById("longMinima").value;
		  if ( longMinima != "")
		  {
			  newClave.minLength = longMinima;
		  }
		
		var navCambioClave = new Ext.FormPanel({
		    baseCls: 'x-plain',		
		    id:'navCambioClave',
			 method:'POST',	
			 monitorValid:true,
			 frame:true,	
			 fbar: [{
		            text: 'Cancelar',
		            id:'btnCancelar',
		            handler:function()
				      {
				 document.formGeneric.action = "../seguridad/logout.action";
	                document.formGeneric.submit();
			      }}, {
		            text: 'Cambiar Clave',
		            id:'guardarRecCambio',
		            handler:function()
				      { 
			    	  navCambioClave.getForm().submit({
				            url: '../seguridad/changePass.action', 
				            waitMsg: 'Grabando...',
				            params:{usuario:'<%=request.getAttribute("username")%>',oldPass:claveActual.getValue(),newPass:newClave.getValue()},                
				            waitTitle : 'Procesando petición', 
				            failure : function(fps, o){   
				                msg('Error', o.result.msg, Ext.Msg.ERROR );	
				            }    ,                          
				            success: function(fps, o){
				               // msg('Información', o.result.msg ,Ext.Msg.INFO); 
				                
				                Ext.MessageBox.confirm('Cambio de Clave', o.result.msg+'.Oprima Si para ingresar nuevamente a la aplicaci&#243;n.' ,logout );
				               //Ext.MessageBox.alert('Cambio de Clave', o.result.msg+'Ingrese nuevamente a la aplicación.',  o.result.msg, logout);
				              		               			                	                  
				            }                       
				        });
				     }
		        }
		        ],
					 
			 border:true,
			 layout:'form',		 	
			 listeners:{clientvalidation:function(form, valid)
								 		{  		 										
	 										if (valid)
		 										{
													Ext.getCmp('guardarRecCambio').enable();
		 											}else{
													Ext.getCmp('guardarRecCambio').disable();
												}													    		                            					
										}
						}, 
			  height: 170,
			  bodyStyle:'background-color:#eeeeee;padding:20px 10px 10px 10px;',
			  //labelWidth: 1, 			          
			    width: 340,
			 items: [					 
					 claveActual,newClave,claveVerificacion
					 ]
		    		                
											 				
		});


		function logout(btn)
		{
			if(btn=='yes'){
				  document.formGeneric.action = "../seguridad/logout.action";
	                document.formGeneric.submit();	
			}else
				{
				document.formGeneric.action = "../seguridad/logout.action";
                document.formGeneric.submit();	
				}	
		}

		
	
		navCambioClave.render('divCambioClave');

		claveActual.focus(false,500);
});



</script>
