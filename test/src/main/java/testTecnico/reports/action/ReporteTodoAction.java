package testTecnico.reports.action;



import testTecnico.service.dao.ItestTecnicoManager;
import testTecnico.web.generic.common.GenericServletRequestAction;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.apache.struts2.ServletActionContext;




public class ReporteTodoAction extends GenericServletRequestAction {


	private static final long serialVersionUID = -6017023719343815784L;
	
	private List<String> lista=new ArrayList<String>();
	private ItestTecnicoManager service;
	private List myList;
	private Map jasperParams;
	private String value;
	private List<String> errores =new ArrayList();
	private Boolean descripcion = false;
	
	
	
	public String execute(){
		try {
			
			this.setMyList(new ArrayList());
		} catch (Exception e) {
			String msg =e.getCause().getLocalizedMessage();
			this.errores.add(msg);				
			addActionError( getText("msg.error.reportetareas.execute",this.errores));
		}finally{
			this.errores.clear();
			return SUCCESS;
		}
	}
	
	

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public String print(){
    	try {
    		
    		this.setValue(request. getParameter("type"));
			this.setMyList(this.getService().getTodoDao().findAll());
			
			jasperParams = new HashMap();
			
			jasperParams.put("APPLICATION_NAME", "Test Tecnico");
			jasperParams.put("STATE_NAME", "Listado de tareas" );
			jasperParams.put("PATH_IMAGE",ServletActionContext.getServletContext().getRealPath("/")+"test/images/report/");
			
			
			
    	} catch (Exception e) {
    		String msg =e.getCause().getLocalizedMessage();
			this.errores.add(msg);				
			addActionError( getText("msg.error.reportetareas.print",this.errores));
		}finally{
			this.errores.clear();
			return SUCCESS;
		}
    }
	
	
	
	
	
	//getters and setters
	
	public ItestTecnicoManager getService() {
		return service;
	}

	public void setService(ItestTecnicoManager service) {
		this.service = service;
	}
	
	public void setValue(String value) {
		this.value = value;
	}
	public String getValue() {
		return value;
	}
	public List getMyList() {
		return myList;
	}
	public void setMyList(List myList) {
		this.myList = myList;
	}
	public Map getJasperParams() {
		return jasperParams;
	}
	public void setJasperParams(Map jasperParams) {
		this.jasperParams = jasperParams;
	}
	public Boolean getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(Boolean descripcion) {
		this.descripcion = descripcion;
	}
	public List<String> getLista() {
		return lista;
	}
	public void setLista(List<String> lista) {
		this.lista = lista;
	}

	
	
	//constructor

	



	public ReporteTodoAction(ItestTecnicoManager service) {
		super();
		this.service = service;
	}



	public ReporteTodoAction() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	

	
	
	

}
