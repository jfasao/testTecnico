<%@ taglib prefix="s" uri="/struts-tags"%>


<script>
encodeURIComponent=escape;
decodeURIComponent=unescape;

</script>



<body>
	<s:form name="cargarMenu" method="POST" theme="simple"
		action="../seguridad/loadMenu">

		<s:hidden id="IdApp" name="IdApp"></s:hidden>
		<s:hidden id="username" name="username"></s:hidden>
		<s:hidden id="password" name="password"></s:hidden>

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
									style="font-family: Arial; font-variant: normal; font-size: 150%; line-height: 28px; font-weight: bold;">Ingreso
									al Sistema</font>

								<div id="divLogin"></div>

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


Ext.onReady(function(){
	
    Ext.QuickTips.init();

    Ext.form.Field.prototype.msgTarget = 'side';
    var bd = Ext.getBody();

	
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
		

		var usuario = new Ext.form.TextField({
			id:'usuario',	
			name:'username',	
			allowBlank:false,	
			listeners:{specialkey:function(field,e){   
				if(e.getKey() == e.ENTER){					 		
					clave.focus();
				}
			}},  					
			labelStyle: 'font:normal 10px Verdana;text-align: right;',
			fieldLabel:'Usuario',		
			width:200
			});
	 	
		var clave = new Ext.form.TextField({
			id:'clave',	
			name:'password',	
			inputType: 'password',				
			allowBlank:false,
			labelStyle: 'font:normal 10px Verdana;text-align: right;',
			fieldLabel:'Clave',	
			listeners:{specialkey:function(field,e){   
				if(e.getKey() == e.ENTER){					 		
					ingresar();
				}
			}},  	
			width:200
			});
	 	

		 function ingresar()
		 {
			 Ext.getCmp('navLogInit').getForm().submit({
		            url: 'login.action', 
		            waitMsg: 'Comprobando Usuario...',                
		            waitTitle : 'Procesando petición', 
		            failure : function(navLogInit, o){   
					if (o.result.msg == 'CambioClave'){
						//document.cargarMenu.action = "../seguridad/resetPassword.action";
		        		//document.cargarMenu.submit();
						Ext.getCmp('panelMain').getUpdater().update( { url: "resetPassword.action",method:'POST',scripts:true, params:{username:usuario.getValue()}});
						//userTemp.setValue(usuario.getValue());
					}	
					else
					{
						msg('Error', o.result.msg, Ext.Msg.ERROR );
					}
		                	
		            }    ,                          
		            success: function(navLogInit, o){ 
 		                document.cargarMenu.action = "../seguridad/loadMenu.action";
		        		document.cargarMenu.submit();
          		              		               			                	                  
		            }                       
		        });
			 }

	/*	 function ingresar()
			{		
				 Ext.getCmp('navLogInit').getForm().submit({
			            url: 'login.action'});
			      document.getElementById("username").value=Ext.getCmp('usuario').getValue();
				  document.getElementById("password").value=Ext.getCmp('clave').getValue();
		        	document.cargarMenu.action = "../seguridad/login.action";
		        	document.cargarMenu.submit();
			}
		*/
		var navLogInit = new Ext.FormPanel({
		    baseCls: 'x-plain',		
		    id:'navLogInit',
			 method:'POST',	
			 monitorValid:true, 
			 frame:true,	
			 fbar: [{
		            text: 'Ingresar',
		            id:'guardarRecLogin',
		            handler:ingresar
		        },
		         {
			            text: 'Salir',
			            id:'exits',			            
						handler:function()
						{
		        	 	document.cargarMenu.action = "../seguridad/logout.action";
			        	document.cargarMenu.submit();
							}			            
			         }],					 
			 border:true,
			 layout:'form',		 	
			
			  height: 150,
			  bodyStyle:'background-color:#eeeeee;padding:20px 10px 10px 10px;',
			  //labelWidth: 1, 			          
			    width: 360,
			 items: [
			            					 
					 		usuario,clave
					 	
			 ]
		    		                
											 				
		});


		navLogInit.render('divLogin');

		
		usuario.focus(false,500);
		
		
});
</script>
