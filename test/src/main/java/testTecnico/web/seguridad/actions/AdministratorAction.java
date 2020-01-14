package testTecnico.web.seguridad.actions;


import testTecnico.common.LoginIntentos;

import testTecnico.service.dao.ItestTecnicoManager;
import testTecnico.web.generic.common.GenericServletRequestAction;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import org.apache.struts2.ServletActionContext;






/**
 *
 * carga el header para el loggeo he inicializa el menu cuando se loggea
 *
 */

public class AdministratorAction   extends GenericServletRequestAction{
	private ItestTecnicoManager service;	
  	private String username; 
  	private String password;  	  
  	private String oldPassword;
  	private String newPassword;
  	private String longMinima="";
  	private String menu="";
  
	
	private  List<String> errores =new ArrayList();

	
	
	
	
	public String getMenu() {
		return menu;
	}


	public void setMenu(String menu) {
		this.menu = menu;
	}



	public ItestTecnicoManager getService() {
		return service;
	}

	public void setService(ItestTecnicoManager service) {
		this.service = service;
	}

	public AdministratorAction(ItestTecnicoManager service) {
		super();
		this.service = service;
	}


	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	
	public String getLongMinima() {
		return longMinima;
	}

	public void setLongMinima(String longMinima) {
		this.longMinima = longMinima;
	}
	
	public String getusername() {
		return username;
	}

	public void setusername(String userId) {
		this.username = userId;
	}

	
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getOldPassword() {
		return oldPassword;
	}

	public void setOldPassword(String oldPassword) {
		this.oldPassword = oldPassword;
	}

	public String getNewPassword() {
		return newPassword;
	}

	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}
	
	
	

	public String execute() {	
		return "success";
	}		
	
 

	
	
	public String loadMenu(){
		String salida="success";
		try {
			request.getSession().removeAttribute("repositoryMenu");					
			request.getSession().setAttribute("repositoryMenu", request.getSession().getAttribute("menu"));
			//menu se usa para pasar de una accion a otra es de usuo temporal
			request.getSession().removeAttribute("menu");
			
		} catch (Exception e) {
			e.getMessage();
		}finally{			 
			return salida;
		}
	}
	
	
		
	public String logout(){
		String error =(String)request.getSession().getAttribute("error");
		if(error!=null){
			addActionError(error );
		} 
		this.cleanSession();
		 return "success";
	}
		
		
		
	
	
	
	private void cleanSession(){
		
		Enumeration e = request.getSession().getAttributeNames();
	    while (e.hasMoreElements()) {
	            String name = (String)e.nextElement();
	            if (!name.equals("loginIntentos")&&!name.equals("VersionApp")&&!name.equals("desatest2")){
	            request.getSession().removeAttribute(name);}
	    }	  
	}
	

	
	public void logon(){		
		String valida = "ok";
	//	service.getActaDao().prepare();
		try {
		
			
			//IWsSeguridadPortType menuManager = new IWsSeguridadPortTypeProxy();
		/*	this.setMenu( menuManager.menusbyUserAndProfile(getusername().toUpperCase(), 
													   ConstantsActions.SISTEMA,
													   EncriptarSHA1BASE64.encriptar(getPassword()),
													   fallidos()));	*/
			
			if( getusername().toUpperCase().equals("FALCALDE")&&getPassword().equals("1234")) {
				this.setMenu("TesTecnico1,Tareas,,../generic/TodoActionexecute.action||TesTecnico2,Estados,,../generic/EstadoActionexecute.action||");
			}else {
				this.setMenu("1");
			}
			
			if (getMenu().length()>2)
			{
			request.getSession().setAttribute("menu",getMenu());
			request.getSession().setAttribute("logged",getusername().toUpperCase());
			request.getSession().removeAttribute("loginIntentos");
			//Usuario usuario=this.getService().getUsuarioDao().getById(this.getusername());
			request.getSession().setAttribute("LoggedName","Facundo Alcalde");
			
			}
			else if (getMenu().equals("1"))
			{			
				valida = "Fallo el proceso de validación.";
				
			}else if (getMenu().equals("2"))
			{	maxFallidos();	
				valida = "Usuario y/o clave invalidos.";
				
			}else if (getMenu().equals("3"))
			{
				valida = "Usuario no tiene perfil definido.";
			}
			else if (getMenu().equals("4"))
			{
				valida = "Deshabilitado";
				
			}else if (getMenu().equals("5"))
			{
				valida = "Usuario inactivo. Fecha actual fuera del rango de validez.";
				
			}else if (getMenu().equals("6"))
			{
				valida = "Perfil inactivo. Fecha actual fuera del rango de validez.";
				
			}else if (getMenu().equals("7"))
			{
				valida = "CambioClave";
			}
			
			
			 
		}catch (Exception e) {
			valida = "Fallo el proceso de validacón.";
			this.cleanSession();			
		}finally{
			valida = valida.equals("ok")?"{'msg':'', 'success':true}":"{'msg':'"+valida+"','success':false}";
			loadapp(valida);
		}
			
	}
	
	
	private void loadapp(String valida) {
		
		 PrintWriter out = null;
		 String outLine="";
		try {
			out = response.getWriter();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 
        out.print(valida);
                
	}
		
	private void maxFallidos()
	{
		 if ((LoginIntentos)request.getSession().getAttribute("loginIntentos") != null)
		 {
			 LoginIntentos loginIntentos =   ((LoginIntentos)request.getSession().getAttribute("loginIntentos"));
				if (this.getusername().toUpperCase().equals(loginIntentos.getUser()))
				{
					loginIntentos.setIntentos(loginIntentos.getIntentos()+1);
					
				}
				else
				{
					loginIntentos.setUser(this.getusername().toUpperCase());
					loginIntentos.setIntentos(0);					
				}
		 }
		 else
		 {
			 LoginIntentos loginIntentos = new LoginIntentos(this.getusername().toUpperCase(),0);			
			 request.getSession().setAttribute("loginIntentos",loginIntentos);
		 }		
	}
	
	
	private String fallidos()
	{
		 if ((LoginIntentos)request.getSession().getAttribute("loginIntentos") != null)
		 {
			 LoginIntentos loginIntentos =   ((LoginIntentos)request.getSession().getAttribute("loginIntentos"));
			 return loginIntentos.getIntentos().toString();
		 }else
		 {
			 return "0";
		 }
		
		
	}
	
	
	public String reset(){
		if (request.getParameter("username")!=null){
		request.setAttribute("username", request.getParameter("username").toUpperCase());}
		else
		{
			request.setAttribute("username", ((String) request.getSession().getAttribute("logged")).toUpperCase());
		}
		this.setOldPassword("");
		this.setNewPassword("");
		return "success";
	}
	
public void changePass() throws IOException{
		
		String resultado="";
		setusername(request.getParameter("usuario"));
		setOldPassword(request.getParameter("oldPass"));
		setNewPassword(request.getParameter("newPass"));
		String mensaje = "";
		try{
			/*IWsSeguridadPortType menuManager = new IWsSeguridadPortTypeProxy();
			resultado=  menuManager.cambioClave(
									getusername().toUpperCase(), 
									EncriptarSHA1BASE64.encriptar(getOldPassword()), 
									EncriptarSHA1BASE64.encriptar(getNewPassword()),
									new Integer(getNewPassword().length()).toString());
			*/
			if (resultado.equals("1"))
			{	
				
	    		errores.add("Usuario y/o clave incorrectos.");
	    		mensaje = "{msg:'Usuario y/o clave incorrectos.',success:false}";
			}else if  (resultado.equals("2"))
			{
				
	    		errores.add("Operación Realizada con Exito");	
	    		mensaje = "{msg:'Operación Realizada con Exito',success:true}";
			}
			else if  (resultado.equals("3"))
			{	
				mensaje = "{msg:'La longitud de la nueva clave debe ser mas larga.',success:false}";
			}
			else if  (resultado.equals("4"))
			{
				mensaje = "{msg:'No se puede repetir las clave/s anteriores.',success:false}";
			}
			
	
			}catch (Exception e) {
				mensaje = "{msg:'Fallo el proceso de cambio de clave.',success:false}";
		}
			response.setContentType("text/html;charset=ISO-8859-1");
			PrintWriter writer=response.getWriter();
			writer.print(mensaje);
	}
	
	public String changePassword(){
		
		String resultado="";
		setusername(request.getParameter("usuario"));
		setOldPassword(request.getParameter("oldPass"));
		setNewPassword(request.getParameter("newPass"));
		try{
			/*IWsSeguridadPortType menuManager = new IWsSeguridadPortTypeProxy();
			resultado=  menuManager.cambioClave(
									getusername().toUpperCase(), 
									EncriptarSHA1BASE64.encriptar(getOldPassword()), 
									EncriptarSHA1BASE64.encriptar(getNewPassword()),
									new Integer(getNewPassword().length()).toString());
			*/
			if (resultado.equals("1"))
			{	
				
	    		errores.add("Usuario y/o clave incorrectos.");		   
				addActionError( getText("msg.mensaje.cambio.clave",errores));	
				return "failed";
			}else if  (resultado.equals("2"))
			{
				
	    		errores.add("Operación Realizada con Exito");		   
				addActionError( getText("msg.mensaje.cambio.clave",errores));	
				return "success";
			}
			else if  (resultado.equals("3"))
			{				
	    		errores.add("La longitud de la nueva clave debe ser mas larga.");		   
				addActionError( getText("msg.mensaje.cambio.clave",errores));	
				return "failed";
			}
			else if  (resultado.equals("4"))
			{
	    		errores.add("No se puede repetir las clave/s anteriores.");		   
				addActionError( getText("msg.mensaje.cambio.clave",errores));	
				return "failed";
			}
			
			return	"failed";
			
			}catch (Exception e) {
				errores.add("Fallo el proceso de cambio de clave.");	
				addActionError( getText("msg.mensaje.cambio.clave",errores));	
				return "failed";
		}
	}
	
	
public String initlogin() {
		
		request.getSession().setAttribute("VersionApp",ServletActionContext.getServletContext().getInitParameter("VERSION"));
		
		response.setContentType("text/html;charset=ISO-8859-1");
		return SUCCESS;
	}
	
	
	public String setVersion() {
		Enumeration lista = request.getSession().getAttributeNames();
		while (lista.hasMoreElements()){
			request.getSession().removeAttribute(lista.nextElement().toString());
		}
		request.getSession().setAttribute("VersionApp",ServletActionContext.getServletContext().getInitParameter("VERSION"));
		
		
			 
	
		 
		return SUCCESS;
	}


	
	
	
public String initloginPortal() {
		
		request.getSession().setAttribute("VersionApp",ServletActionContext.getServletContext().getInitParameter("VERSION"));
		
		response.setContentType("text/html;charset=ISO-8859-1");
		return SUCCESS;
	}
	
	
}


