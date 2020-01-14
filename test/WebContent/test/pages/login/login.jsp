<%@ taglib prefix="s" uri="/struts-tags"%>





<html>



<s:form id="pepes" theme="simple" action="loadMenu.action" method="post">

	<table id="TablaLogin" width="100%" height="80%" cellpadding="0"
		cellspacing="0">
		<tr>
			<td height="60" valign="middle" width="100%"
				background="../altec/images/login-header.jpg" colspan="2"
				align="center">
				<h1 align="center"
					style="font: Verdana; font-weight: bolder; color: #F5F5F5;">Ingreso
					al Sistema</h1>
			</td>
		</tr>

		<tr>
			<td align="center" valign="top">
				<table align="right" border="0" style="vertical-align: top;"
					width="100%" height="130">
					<tr>
						<td class="texto2-link" align="right" width="27%"><label>Usuario:</label>
						</td>
						<td align="left"><s:textfield id="usernameX"
								cssClass="login_username" tabindex="1"
								onkeypress="handleEnter(event,this);" value="" /></td>
					</tr>

					<tr>
						<td class="texto2-link" align="right"><label>Clave:</label></td>
						<td align="left"><s:password id="passwordX"
								cssClass="login_pass" value=""
								onkeypress="handleEnter(event,this);" tabindex="2" /></td>

					</tr>
					<tr>
						<td align="center" colspan="2">
							<div id="botones">
								<table width="100%">
									<tr>
										<td align="right"><input type="button" name="btnlog"
											id="btnlog" value="Entrar" class="imputbuttom"
											onclick="javascript:ValidarClick();" tabindex="3" /></td>
										<td align="left"><a href="#" class="lbAction"
											style="text-decoration: none;" rel="deactivate"><input
												type="button" onclick="Cancelar();" class="imputbuttom"
												value="Cancelar" tabindex="4" /></a></td>
									</tr>
								</table>
							</div>
						</td>
					</tr>
				</table>
			</td>
		</tr>

	</table>
</s:form>
<script>
PonerFoco('usernameX');
</script>
</html>