<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="s" uri="/struts-tags" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<noscript>
<meta HTTP-EQUIV="REFRESH" content="0; url=../test/pages/error/nojava.jsp">
</noscript>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" >



<title><tiles:getAsString name="title"/></title>
<link rel="shortcut icon" href="../test/images/headertop.ico" type="image/x-icon">
<meta http-equiv="Pragma" content="no-cache"/>
<meta http-equiv="expires" content="-1"/>
<meta http-equiv="Cache-control" content="no-store, no-cache, must-revalidate"/>



<script src="../test/scripts/template.js" type="text/javascript" ></script>

<link rel="stylesheet" href="../test/styles/container_special.css" type="text/css"></link>
<link rel="stylesheet" href="../test/styles/proceso.css" type="text/css"></link>
<link href="../test/styles/template.css"  type="text/css" rel="stylesheet"/>
	
<link rel="stylesheet" type="text/css" href="../test/scripts/extjs3/resources/css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="../test/scripts/extjs3/resource1/css/xtheme-darkgray.css" />
<script type='text/javascript' src='../test/scripts/extjs3/adapter/ext/ext-base.js'></script>
<script type='text/javascript' src='../test/scripts/extjs3/ext-all.js'></script>	
<script type='text/javascript' src='../test/scripts/extjs3/extension/mask.js'></script>

  
<link rel="stylesheet" type="text/css" href="../test/scripts/extjs3/examples/ux/css/Spinner.css" />

<link rel="stylesheet" type="text/css" href="../test/scripts/extjs3/extension/grid/img/style.css" />
<link rel="stylesheet" type="text/css" href="../test/scripts/extjs3/examples/grid/grid-examples.css" />
<link rel="stylesheet" type="text/css" href="../test/scripts/extjs3/examples/form/file-upload.css" />
<script type="text/javascript" src="../test/scripts/extjs3/extension/grid/menu/EditableItem.js"></script>
<script type="text/javascript" src="../test/scripts/extjs3/extension/grid/menu/RangeMenu.js"></script>
<script type="text/javascript" src="../test/scripts/extjs3/extension/grid/menu/ListMenu.js"></script>
<script type="text/javascript" src="../test/scripts/extjs3/extension/grid/GridFilters.js"></script>
<script type="text/javascript" src="../test/scripts/extjs3/extension/grid/fixGrid.js"></script>
<script type="text/javascript" src="../test/scripts/extjs3/extension/grid/filter/Filter.js"></script>
<script type="text/javascript" src="../test/scripts/extjs3/extension/grid/filter/StringFilter.js"></script>
<script type="text/javascript" src="../test/scripts/extjs3/extension/grid/filter/DateFilter.js"></script>
<script type="text/javascript" src="../test/scripts/extjs3/extension/grid/filter/ListFilter.js"></script>
<script type="text/javascript" src="../test/scripts/extjs3/extension/grid/filter/NumericFilter.js"></script>
<script type="text/javascript" src="../test/scripts/extjs3/extension/grid/filter/BooleanFilter.js"></script>
<script type="text/javascript" src="../test/scripts/extjs3/examples/ux/ProgressBarPager.js"></script>
<script type="text/javascript" src="../test/scripts/extjs3/examples/ux/SlidingPager.js"></script>
<script type="text/javascript" src="../test/scripts/extjs3/examples/ux/SliderTip.js"></script>
<script type="text/javascript" src="../test/scripts/extjs3/examples/ux/StatusBar.js"> </script>
<script type="text/javascript" src="../test/scripts/extjs3/examples/ux/Spinner.js"> </script>
<script type="text/javascript" src="../test/scripts/extjs3/examples/ux/SpinnerField.js"> </script>
<script type="text/javascript" src="../test/scripts/extjs3/examples/ux/RowExpander.js"></script>
<script type="text/javascript" src="../test/scripts/extjs3/examples/ux/SearchField.js"></script>
<script type="text/javascript" src="../test/scripts/extjs3/examples/ux/FileUploadField.js"></script>

<link href="../test/scripts/extjs3/extension/multiselector/Multiselect.css" rel="stylesheet" type="text/css"/>
<script type='text/javascript' src='../test/scripts/extjs3/extension/multiselector/Multiselect.js'></script>
<script type='text/javascript' src='../test/scripts/extjs3/extension/multiselector/DDView.js'></script>

<link rel="stylesheet" type="text/css" href="../test/scripts/extjs3/examples/ux/css/Spinner.css" />
<script type="text/javascript" src="../test/scripts/extjs3/examples/ux/Spinner.js"></script>
<script type="text/javascript" src="../test/scripts/extjs3/examples/ux/SpinnerField.js"></script>

<link rel="stylesheet" type="text/css" href="../test/scripts/extjs3/examples/ux/css/passwordmeter.css" />
<script type='text/javascript' src='../test/scripts/extjs3/examples/ux/passwordmeter.js'></script>		

<script type="text/javascript" src="../test/scripts/extjs3/examples/ux/TabCloseMenu.js"></script>



<style type="text/css">


.x-grid-dirty-cell {      background-image:none; }
  		.x-grid3-hd-row td.ux-filtered-column {   
        font-style: italic;  
        font-weight: bold;
    }	
  	.add {
   		background-image:url(../test/scripts/extjs3/resources/images/default/grid/add.png) !important;
   	}
  	.eliminar {
  		background-image:url(../test/scripts/extjs3/resources/images/default/grid/delete.png) !important;
	}
 	.detalle{
 		background-image:url(../test/images/template/view.gif) !important;
 	}
 	.editar{
 		background-image:url(../test/images/template/edit.gif) !important;
 	}
 	.ver{
 		background-image:url(../test/images/icon-pencil-x.gif) !important;
 	}
 	
 	
 	.pdf {
   		background-image:url(../test/images/report/pdf_small.gif) !important;
   	}
 	.x-grid3-row-expanded{
 		background:#EFEFEF;
 	}
 </style>
</head>
<body leftmargin="0" rightmargin="0" topmargin="0" bottommargin="0">

<table style="margin-top:0px;" border="0" align="center" cellpadding="0" cellspacing="0" height="100%" width="100%" >
	<tr >
		<td height="100" valign="middle" >
			<tiles:insertAttribute name="header" flush="true"/>
		</td>
	</tr>	

	<tr>
		<td>
		 	<div id="divMain"  style="height: 100%; width: 100%; vertical-align: top;">
		 	</div>
		</td>

	</tr>
	<tr>
		<td align="center" width="100%" >
			<tiles:insertAttribute name="footer" flush="true"/>
		</td>

	</tr>

</table>

</body>

</html>


<script type="text/javascript">
//screenHeight = screen.height-parseInt(screen.height*0.2955);
Ext.onReady(function(){
	
	cambioPass = new String('<%=request.getAttribute("cambioPass")%>');
	
	if (cambioPass!='Si'){
		
	var scrollerMenu = new Ext.ux.TabCloseMenu({
		maxText  : 25,
		pageSize : 5
	});

	var panelMain = new Ext.Panel({
				title:'',
				id : 'panelMain',
				border:false,	
				renderTo : 'divMain',				
				items  : {
					xtype           : 'tabpanel',
					activeTab       : 0,
					id              : 'myTPanel',
					enableTabScroll : true,
					resizeTabs      : true,		
							
					minTabWidth     : 100,	
					tabWidth:180,
					//					width: screen.width,
				//	height:screen.height-(screen.height)*0.39,
					//height:screen.height-365,
					height:screenHeight,
					bodyStyle:'background:url(../test/images/template/28518.jpg) center center no-repeat ; ',			
					border          : false,
					plugins         : [ scrollerMenu ]
					//items           : []
	}
});
	
}
});

 
</script>

<script type="text/javascript" src="../test/scripts/extjs3/src/locale/ext-lang-es.js"></script>