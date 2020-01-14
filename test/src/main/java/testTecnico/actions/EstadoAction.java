package testTecnico.actions;




import testTecnico.common.ConstantsActions;
import testTecnico.common.GrillaExt;
import testTecnico.common.Methods;
import testTecnico.dao.EstadoDao;
import testTecnico.model.Estado;
import testTecnico.web.generic.common.GenericServletRequestAction;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;


public class EstadoAction  extends GenericServletRequestAction   {
	

		private static final long serialVersionUID = 6437417800877500074L;
		private EstadoDao service;
		
		private Estado abmObjet = new Estado();
		private long id;
		




		public long getId() {
			return id;
		}


		public void setId(long id) {
			this.id = id;
		}


		public Estado getAbmObjet() {
			return abmObjet;
		}


		public void setAbmObjet(Estado abmObjet) {
			this.abmObjet = abmObjet;
		}


		public EstadoAction(EstadoDao service) {
	        setService (service);
	    }

	    
		public EstadoDao getService() {
			return service;
		}


		public void setService(EstadoDao service) {
			this.service = service;
		}


		public String execute() {
			
		try {	
			
    
    		String d = request.getSession().getAttribute("logged").toString();		        
		} catch (Exception e) {
			e.getMessage();
		}finally
		{
			response.setContentType("text/html;charset=ISO-8859-1");
			return SUCCESS;	
			}
		}
	        
	       
	    public void save() throws IOException {	 
	    	String msg="";
	    	try {
	    		if(!this.getService().hayDescripcion(abmObjet.getDescripcion())){
	    			Estado ta = new Estado();
	    			
	    			ta.setDescripcion(abmObjet.getDescripcion());
	    			
		    		getService().save(ta);
					msg="{msg:' Estado guardado con éxito.',success:true}";
	    		}else{
	    			msg="{msg:'No se pudo completar la operación, ya existe un Estado con esa descripción.',success:false}";
	    		}
			} catch (Exception e) {
				msg="{msg:'No se pudo completar la operación.',success:false}";
			}
	    		response.setContentType("text/html;charset=ISO-8859-1");
				PrintWriter writer=response.getWriter();
				writer.print(msg);
	    }
	    
	    public void update() throws IOException {	    
	    	String msg="";
	    	try {
	    		Estado tipEst= this.getService().get(abmObjet.getId());
	    		
	    		tipEst.setDescripcion(abmObjet.getDescripcion());
	    		
	    		getService().update(tipEst);
				msg="{msg:'Estado guardado con éxito.',success:true}";
			} catch (Exception e) {
				msg="{msg:'No se pudo completar la operación.',success:false}";
			}
	    		response.setContentType("text/html;charset=ISO-8859-1");
				PrintWriter writer=response.getWriter();
				writer.print(msg);
				}   
	    
	    public void remove() throws IOException {	    
	    	String msg="";
	    	try {
				getService().deleteById(getId());
				msg="{msg:'Estado eliminado con éxito.',success:true}";
			} catch (Exception e) {
				msg="{msg:'No se pudo completar la operación.',success:false}";
			}
	    		response.setContentType("text/html;charset=ISO-8859-1");
				PrintWriter writer=response.getWriter();
				writer.print(msg);
				} 
	    
	    public void grilla()throws IOException
		{
			String resultado = "";
		
		try {
			GrillaExt grillaExt = Methods.getMethods().getGrillaExt(request);			
			
						
			String  whereAdd = "  " ;
			grillaExt.setWhereAdd(whereAdd);
			
		
			
			Integer countReg = getService().countByFiltersAndPaging(grillaExt);		
			List<Estado> tempList = getService().findByFiltersAndPaging( grillaExt);
			
			StringBuffer estados = new StringBuffer("[");
			
			for (Iterator iterator = tempList.iterator(); iterator.hasNext();) {
				Estado est = (Estado) iterator.next();
											
					
				estados.append("{id:'"+ est.getId()+ "',");
				estados.append("descripcion:'"+ est.getDescripcion().replaceAll("'", "&#39;")+"'},");
			
			}
				if (tempList.size()>0){
					estados.deleteCharAt(estados.length()-1);
				}
				estados.append("]");
				resultado ="{totalCount:'"+countReg+"',estados:"+estados.toString()+"}";
			} catch (Exception e) {
				String p="";
			}				
	    	 response.setContentType("text/html;charset=ISO-8859-1");
	    	 PrintWriter writer=response.getWriter();
	    	 writer.print(resultado);	
	    }


		
	    
}
