<%@ taglib prefix="s" uri="/struts-tags" %>




<script type="text/javascript">


	
</script>
<script type="text/javascript">


screenHeight = screen.height-300;
screenWidth = screen.width;
recordCount = parseInt((screen.height-370)/27);
	var appluser ="";
	var cambioPass ="";

	function getAspectRatio(width, height) {
	    var ratio = width / height;
	    return ( Math.abs( ratio - 4 / 3 ) < Math.abs( ratio - 16 / 9 ) ) ? '4:3' : '16:9';
	}

	
</script>


<html:html>
<head>


</head>
<body id="headerbody">
<s:form  theme="simple" action="login" namespace="/seguridad"  var="logonForm" name="logonForm" >
	<s:hidden var="username" name="username"></s:hidden>
	<s:hidden var="password" name="password"></s:hidden>
	            
	<table align="center"  border="0" style="background:url(../test/images/template/top.jpg) repeat-x;" cellpadding="0" cellspacing="0" height="100" width="100%" >
		<tr>
			<td  valign="top" align="left" colspan="2" style="padding-left: 5px;">
				<img id="logo"   src="../test/images/template/285182.jpg"  border="0"/>			
			</td>
			<td width="70%" valign="top" style="padding-top: 6px;padding-left:10px;"  >
			 	<font color="#000000" style="font-family:Asap; font-variant: normal; font-size: 190%; line-height: 28px;font-weight:bold; ">Test Técnico</font>
				<br>
				<font color="#000000" style="font-family:Asap; font-variant: normal; font-size: 160%; line-height: 28px;font-weight:bold;">TODOS</font>
				<br>
				<!-- <font color="#e9e6ee" style="font-family:Asap; font-variant: normal; font-size: 120%; line-height: 28px;font-weight:bold; ">de Inspecciones y Multas</font> -->
			</td>	
			<td  align="right" width="22%" >
					<s:if test="%{#session.logged!=null}">
						<table  cellpadding="0" cellspacing="1" border="0" width="70%">
							<tr>				
								<td align="right"  valign="middle" width="30%">								
									<label >Usuario:</label>	
								</td>
								<td align="right"  valign="middle" width="70%" >								
									<label ><b> ${session.LoggedName}</b></label>	
								</td>
							</tr>
		
							<tr>
								<td align="right" valign="bottom" colspan="2" >								
									<dir id="divButon"></dir>
								</td>
							</tr>	
						</table>
					</s:if>
					<s:else>
						<table  cellpadding="0" height="80%" cellspacing="5" border="0" width="100%">
						<tr>
							<td align="right">						
							<dir id="divButonInitSesion"></dir>
							</td>
						</tr>
						<tr>
						<td align="right" valign="middle">
							<font size="2" style="font:Verdana;font-weight: bolder;color:#333333;">&nbsp;</font>
						</td>
						</tr>
						</table>
					</s:else>
			</td>		
			
		</tr>
		<tr>
			<td colspan="4" align="left" >
				<div id="toolbar"></div>
			</td>
		</tr>
	</table>	 
</s:form>	
<script type="text/javascript">
Ext.onReady(function()
{	
	cambioPass = new String('<%=request.getAttribute("cambioPass")%>');
	appluser =	'<%=request.getSession().getAttribute("logged")%>';
if (((appluser!='')&&(appluser!='null'))||(cambioPass == 'Si')){

var msgHeader = function(title, msg, tipoMsg){
    Ext.Msg.show({
        title: title,
        msg: msg,
        minWidth: 200,
        closable:false,
        modal: true,            
        icon: tipoMsg,
        buttons: Ext.Msg.OK
    });
    

    var userTemp = new Ext.form.Hidden({
		id:'userTemp',	
		name:'usetTemp'});
};
	

	var btnSalir = new Ext.Button({		
		 renderTo:'divButon',
		 text:'Salir',
		 labelStyle: 'font:normal 10px Verdana;text-align: right;',
		 width: 80,
		 handler:function()
		 {
				document.logonForm.action="../seguridad/logout.action";
				document.logonForm.target="_self";
				document.logonForm.submit();
		 }
	});	


    var tb = new Ext.Toolbar();
    tb.render('toolbar');
    lista='<%=session.getAttribute("repositoryMenu")%>';	
	vapp='<%=request.getSession().getAttribute("VersionApp") %>';
	arreglo=lista.split('||');
    for (i=0;i<arreglo.length-1;i++){
		subarr=arreglo[i].split(',');	
		if (subarr[2]=='')
			{	
			if (subarr[3]!='')			
			{
				 tb.add({
				        text:subarr[1],
				       // iconCls: 'bmenu',
				        ref:subarr[3],
				        handler: function()
						{	
							 if (Ext.getCmp('myTPanel'). findById('frm'+this.id)!=null){
									Ext.getCmp('myTPanel'). findById('frm'+this.id).show();
								}else{
								 Ext.getCmp('myTPanel').add({
								        title: this.text ,
								        //iconCls: 'tabs',
								        id:'frm'+this.id,								      	        
								        border:false, 
								        align:'center',
								        height:screenHeight,//screen.height-315,
								        autoLoad:{url:this.ref,method:'get',scripts:true, callback:function(e){
								        	verGrilla();
								        	}},
								        closable:true
								     }).show();	
						 
								}
						
															
						}				       
				    
				    } );
			}else{
				if (subarr[1].indexOf('Manual')>=0){
					tb.add({
						xtype:'tbfill'
					});
				}
				 tb.add({
				        text:subarr[1],
				        menu: new Ext.menu.Menu({
				        	id: subarr[0],
				        	itemId: subarr[0] 		        													
								     
				            })
				    } );
			}
		}else
		{
			
			if (Ext.getCmp(subarr[2])!=null)
			{
				
					if (subarr[3]!='')			
					{
						
						Ext.getCmp(subarr[2]).add(
								{			
								id: subarr[0],	 
								itemId: subarr[0],     
								text: subarr[1],
								ref:subarr[3],												
								handler: function()
								{										
									if (Ext.getCmp('myTPanel'). findById('frm'+this.id)!=null){
										Ext.getCmp('myTPanel'). findById('frm'+this.id).show();
									}else
										if (this.ref.indexOf('descargar')>=0){
											document.logonForm.action=this.ref;
											document.logonForm.target="_blank";
											document.logonForm.submit();
										}
										else
											{
									 Ext.getCmp('myTPanel').add({
									        title: this.text ,
									    //    iconCls: 'tabs',
									        id:'frm'+this.id,
									        border:false,  
									        align:'center',
									        height:screenHeight,//screen.height-315,
									        autoLoad:{url:this.ref,method:'get',scripts:true,callback : function (){verGrilla();}},
									        closable:true
									     }).show();	  
									}
									// Ext.getCmp('panelMain').getUpdater().update( { url: "../generic/cargarMenuInit.action",method:'POST',scripts:true,callback:function(){verGrilla();}});
								
								}						
							 }
							);
							
						}else

						{	 Ext.getCmp(subarr[2]).add(
									{			
									   
									text: subarr[1],
									// iconCls: 'bmenu',	
									 menu: new Ext.menu.Menu({
										id: subarr[0],	 
										itemId: subarr[0]
									 })				
								 }
								);
							}	
							
				}
			
			
		}
    }
   
 

    tb.doLayout();
}  else{
	var btnInitSesion = new Ext.Button({		
	 renderTo:'divButonInitSesion',
	 text:'Iniciar Sesión',
	 labelStyle: 'font:normal 10px Verdana;text-align: right;',
	 width: 80,
	 handler:function()
	 {
		 Ext.getCmp('panelMain').getUpdater().update( { url: "../seguridad/initlogin.action",method:'GET',scripts:true});
	 }
});	}
		
});


Ext.BLANK_IMAGE_URL = "../test/scripts/extjs3/resources/images/default/s.gif";
	
</script>		
</body>
</html:html>