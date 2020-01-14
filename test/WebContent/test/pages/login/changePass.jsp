<%@ taglib prefix="s" uri="/struts-tags"%>


<script>
function verGrilla(){
	Ext.getCmp('panelMain').getUpdater().update( { url: "resetPassword.action",method:'POST',scripts:true});

}
encodeURIComponent=escape;
decodeURIComponent=unescape;

</script>

username
