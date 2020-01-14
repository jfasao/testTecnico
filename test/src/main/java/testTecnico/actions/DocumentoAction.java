package testTecnico.actions;




import testTecnico.common.GrillaExt;
import testTecnico.common.Methods;
import testTecnico.model.Documento;
import testTecnico.model.Todo;
import testTecnico.service.dao.ItestTecnicoManager;
import testTecnico.web.generic.common.GenericServletRequestAction;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletOutputStream;




public class DocumentoAction  extends GenericServletRequestAction   {
	

		private static final long serialVersionUID = 6437417800877500074L;
		private ItestTecnicoManager service;
		
		private Documento abmObjet = new Documento();
		private long id;
		


	

		public String execute() {
			
		try {	
			/*Methods.getMethods().getFunctionsByProfile(getRequest(), 
							  ConstantsActions.AMB_DOCUMENTO,	    											 
							  request.getSession().getAttribute("logged").toString(),
							  ConstantsActions.SISTEMA);
    */
    		String d = request.getSession().getAttribute("logged").toString();		        
		} catch (Exception e) {
			e.getMessage();
		}finally
		{
			response.setContentType("text/html;charset=ISO-8859-1");
			return SUCCESS;	
			}
		}
	
	    public void remove() throws IOException {	    
	    	String msg="";
	    	try {
				this.getService().getDocumentoDao().deleteById(getId());
				msg="{msg:'Documento eliminado con éxito.',success:true}";
			} catch (Exception e) {
				msg="{msg:'No se pudo completar la operación.',success:false}";
			}
	    		response.setContentType("text/html;charset=ISO-8859-1");
				PrintWriter writer=response.getWriter();
				writer.print(msg);
				} 
	    
	    public void grillaByTodo()throws IOException
		{
			String resultado = "";
		
		try {
			GrillaExt grillaExt = Methods.getMethods().getGrillaExt(request);			
			
						
			/*String  whereAdd = "  " ;
			whereAdd+= "where t.todo.id = "+request.getParameter("todoId")+"";
			grillaExt.setWhereAdd(whereAdd);
			*/	
			Todo todo = this.getService().getTodoDao().get(new Long(request.getParameter("todoId")));
			
			Integer countReg = todo.getDocumentos().size();//this.getService().countByFiltersAndPaging(grillaExt);		
			List<Documento> tempList = todo.getDocumentos();//this.getService().findByFiltersAndPaging( grillaExt);
			
			StringBuffer documentos = new StringBuffer("[");
			
			for (Iterator iterator = tempList.iterator(); iterator.hasNext();) {
				Documento doc = (Documento) iterator.next();
				documentos.append(doc.documentoToJson());
				documentos.append(",");
				
			}
				if (tempList.size()>0){
					documentos.deleteCharAt(documentos.length()-1);
				}
				documentos.append("]");
				resultado ="{totalCount:'"+countReg+"',docs:"+documentos.toString()+"}";
			} catch (Exception e) {
				String p="";
			}				
	    	 response.setContentType("text/html;charset=ISO-8859-1");
	    	 PrintWriter writer=response.getWriter();
	    	 writer.print(resultado);	
	    }
	  	    
	    public void downLoad() throws IOException{
			
	    	String msg="";
		 	   Documento doc = this.getService().getDocumentoDao().get(new Long(request.getParameter("idArchivo")));
		 	   	
		 		response.setContentType(doc.getContentType());
		 		response.setHeader("Content-disposition",
		               "attachment; filename=" + doc.getNombreDoc().replace(" ", "_"));
		 		
		 		try{
		 		ServletOutputStream ouputStream;
		 				
		 		InputStream blobStream = doc.getDocumento().getBinaryStream();

		 		ouputStream = response.getOutputStream();
		 		// buffer holding bytes to be transferred
		 		byte[] buffer = new byte[10 * 1024];
		 		int nbytes = 0;
		 		// Read from the Blob data input stream, and write to the
		 		// file output stream
		 		while ((nbytes = blobStream.read(buffer)) != -1) { // Read from
		 															// Blob stream
		 			ouputStream.write(buffer, 0, nbytes); // Write to file stream
		 		}
		 		ouputStream.flush();
		 		 msg = "{msg:'Archivo descargado con Éxito.',success:true}";
		 		
		         ouputStream.close();
		         
		 		}catch (Exception e) {
		 			// TODO: handle exception
		 			
		 		}finally{
		 		 
		 			PrintWriter writer=response.getWriter();
					writer.print(msg);
		         
		 	   }
		    }

		public long getId() {
			return id;
		}


		public void setId(long id) {
			this.id = id;
		}


		public Documento getAbmObjet() {
			return abmObjet;
		}


		public void setAbmObjet(Documento abmObjet) {
			this.abmObjet = abmObjet;
		}


		public DocumentoAction(ItestTecnicoManager service) {
	        setService (service);
	    }

		public ItestTecnicoManager getService() {
			return service;
		}

		public void setService(ItestTecnicoManager service) {
			this.service = service;
		}

	    
	
}
