package testTecnico.actions;





import testTecnico.common.GrillaExt;
import testTecnico.common.Methods;
import testTecnico.model.Documento;
import testTecnico.model.Estado;
import testTecnico.model.Todo;
import testTecnico.service.dao.ItestTecnicoManager;
import testTecnico.web.generic.common.GenericServletRequestAction;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.util.Iterator;
import java.util.List;

import org.apache.struts2.dispatcher.multipart.MultiPartRequestWrapper;
import org.hibernate.Hibernate;




public class TodoAction  extends GenericServletRequestAction   {
	

		private static final long serialVersionUID = 6437417800877500074L;
		private ItestTecnicoManager service;
		
		private Todo abmObjet = new Todo();
		private long id;
		private long estadoId=0;
		
		//Manejo de archivos adjuntos
				private File[] upload;
				private String documentos="";
				private String[] uploadContentType; 
			    private String[] uploadFileName; 
			    private long idArchivo;


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
	    			this.setEstadoId(new Long(request.getParameter("estadoId")));
	    			Estado estado=this.getService().getEstadoDao().get(this.getEstadoId());
		    		Todo todo = new Todo();
		    		todo.setDescripcion(this.getAbmObjet().getDescripcion());
		    		todo.setEstado(estado);
					this.getService().getTodoDao().save(todo);
					msg="{msg:'Todo guardada con éxito.',success:true}";
	    		
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
	    		this.setEstadoId(new Long(request.getParameter("estadoId")));
	    		Estado estado=this.getService().getEstadoDao().get(this.getEstadoId());
	    		Todo todo = this.getService().getTodoDao().get(this.getAbmObjet().getId());
	    		todo.setDescripcion(this.getAbmObjet().getDescripcion());
	    		todo.setEstado(estado);
				this.getService().getTodoDao().update(todo);
				msg="{msg:'Todo guardada con éxito.',success:true}";
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
				this.getService().getTodoDao().deleteById(getId());
				msg="{msg:'Todo eliminada con éxito.',success:true}";
			} catch (Exception e) {
				if (e.getLocalizedMessage().contains("org.hibernate.exception.ConstraintViolationException")) {
					msg="{msg:'No se pudo completar la operación, el TODO tiene archivos asociados.',success:false}";
				}else {
					msg="{msg:'No se pudo completar la operación.',success:false}";
				}
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
			
		
			
			Integer countReg = getService().getTodoDao().countByFiltersAndPaging(grillaExt);		
			List<Todo> tempList = getService().getTodoDao().findByFiltersAndPaging( grillaExt);
			
			StringBuffer tareas = new StringBuffer("[");
			
			for (Iterator iterator = tempList.iterator(); iterator.hasNext();) {
				Todo todo = (Todo) iterator.next();
											
					
				tareas.append("{id:'"+ todo.getId()+ "',");
				tareas.append("descripcion:'"+ todo.getDescripcion().replaceAll("'", "&#39;")+"',");
				tareas.append("estado9descripcion:'"+(todo.getEstado()!=null? todo.getEstado().getDescripcion().replaceAll("'", "&#39;"):"")+"',");
				tareas.append("estado9id:'"+(todo.getEstado()!=null? todo.getEstado().getId():"")+ "'},");
			}
				if (tempList.size()>0){
					tareas.deleteCharAt(tareas.length()-1);
				}
				tareas.append("]");
				resultado ="{totalCount:'"+countReg+"',todos:"+tareas.toString()+"}";
			} catch (Exception e) {
				String p="";
			}				
	    	 response.setContentType("text/html;charset=ISO-8859-1");
	    	 PrintWriter writer=response.getWriter();
	    	 writer.print(resultado);	
	    }
	    

		
	    /**
	     * Funcionalidad de subida de documentos asociados al todo
	     * @return
	     */
	    public void upload() throws IOException, ParseException {	 
	    	String msg="";
	    	File file;
	    	String text = "";
	    	
			MultiPartRequestWrapper mrequest = (MultiPartRequestWrapper) request;
	    	file = mrequest.getFiles("documentosFile")[0]; 
	       
	       	try {
	        	long id = new Long(request.getParameter("id"));
				Todo todo=this.getService().getTodoDao().get(id);
	       
	    			//Sube los archivos seleccionados en la solapa documentos
	    			if (file!=null){
		    				  				   
		    				   FileInputStream out = new FileInputStream(file) ;
		    						
		    				   Documento doc = new Documento();
		    				   doc.setNombreDoc(mrequest.getFileNames("documentosFile")[0] );//this.getUploadFileName()[0]);
		    				   doc.setDocumento(Hibernate.createBlob(out));
		    				   doc.setContentType(mrequest.getContentType());//this.getUploadContentType()[0]);
		    				   doc.setComentario("prueba de insercion");
		    				  // doc.setTodo(todo);
		    				   doc.setRuta(mrequest.getContextPath());
		    				   this.getService().getDocumentoDao().save(doc);
		    				   
		    				   todo.getDocumentos().add(doc);
		    				   this.getService().getTodoDao().update(todo);
		    				   
		    			    			
	    				}
	    				
	    			
	    			
	        	msg = "{msg:'Archivo guardado con Éxito.',success:true,documentos:"+todo.documentosToJson()+"}";
	        
		 } catch (FileNotFoundException e) {
		        e.printStackTrace();
		        msg = "{msg:'Error al subir el Archivo. "+e.getLocalizedMessage()+"',success:false}";
		} catch (IOException e) {
		        e.printStackTrace();
		        msg = "{msg:'Error al subir el Archivo. "+e.getLocalizedMessage()+"',success:false}";
		}catch (Exception e) {
			 e.printStackTrace();
			 msg = "{msg:'Error al subir el Archivo. "+e.getLocalizedMessage()+"',success:false}";
		}
		  finally {
		       
	    		response.setContentType("text/html;charset=ISO-8859-1");
				PrintWriter writer=response.getWriter();
				writer.print(msg);
	    }
	    
	    }   
	    
	    
	    public void doComboEstado() throws IOException{
	    	StringBuffer resultado = new StringBuffer("");	 
	    	
	    	try {	      		
	    		 resultado	= new StringBuffer(getService().getEstadoDao().findAllJsonCombo(request.getParameter("query").toString() ));    		
			} catch (Exception e) {				
				e.getMessage();
			}finally{	
				  response.setContentType("text/html;charset=ISO-8859-1");
			 	   PrintWriter writer=response.getWriter();
			 	   writer.print(resultado.toString());
			}
	    }  
	    
	        
	    public File[] getUpload() {
			return upload;
		}

		public void setUpload(File[] upload) {
			this.upload = upload;
		}

		public String getDocumentos() {
			return documentos;
		}

		public void setDocumentos(String documentos) {
			this.documentos = documentos;
		}

		public String[] getUploadContentType() {
			return uploadContentType;
		}

		public void setUploadContentType(String[] uploadContentType) {
			this.uploadContentType = uploadContentType;
		}

		public String[] getUploadFileName() {
			return uploadFileName;
		}

		public void setUploadFileName(String[] uploadFileName) {
			this.uploadFileName = uploadFileName;
		}

		public long getIdArchivo() {
			return idArchivo;
		}

		public void setIdArchivo(long idArchivo) {
			this.idArchivo = idArchivo;
		}

		/**
	     * Fin Funcionalidad de subida de documentos asociados al sumario
	     * @return
	     */
	    
	    

		public long getId() {
			return id;
		}


		public void setId(long id) {
			this.id = id;
		}


		public Todo getAbmObjet() {
			return abmObjet;
		}


		public void setAbmObjet(Todo abmObjet) {
			this.abmObjet = abmObjet;
		}


		public TodoAction(ItestTecnicoManager service) {
	        setService (service);
	    }

	    
		public ItestTecnicoManager getService() {
			return service;
		}


		public void setService(ItestTecnicoManager service) {
			this.service = service;
		}


		public long getEstadoId() {
			return estadoId;
		}


		public void setEstadoId(long estadoId) {
			this.estadoId = estadoId;
		}

		
	  	    
	    
}
