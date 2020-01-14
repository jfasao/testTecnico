package testTecnico.rest;

import com.opensymphony.xwork2.ModelDriven;

import testTecnico.model.Todo;
import testTecnico.service.dao.ItestTecnicoManager;


import org.apache.struts2.rest.DefaultHttpHeaders;
import org.apache.struts2.rest.HttpHeaders;
import org.apache.struts2.rest.ContentTypeInterceptor;


public class TodoController implements ModelDriven<Object> {

	private long id;
	private String descripcion="";
	private String estado="";
	private long estadoId;
	private Object model;
	private ItestTecnicoManager service;
	public Todo todo=new Todo();
	
	// GET	/api/users
	public HttpHeaders index() {
		model = this.getService().getTodoDao().findAll();
		System.out.println("GET \t /todo");
		return new DefaultHttpHeaders("index").disableCaching();
	}
	
	// GET	/api/users/1
	 public HttpHeaders show() {
			 if (this.getId()!=0){
		 		 model=this.getService().getTodoDao().get(id);
		 	 }else if ((!this.getDescripcion().equals(""))||(!this.getEstado().equals(""))) {
			 		 model=this.getService().getTodoDao().findByDescAndEstado(this.getDescripcion(), this.getEstado());
			 } 
		 	
		   
		    System.out.println("GET \t /todo/{id}");
		    return new DefaultHttpHeaders("show");
	 }
	 
	// POST	/api/users
	public HttpHeaders create() {
			ContentTypeInterceptor cont;
			
			Todo todo=new Todo();
			todo.setDescripcion(this.getDescripcion());
			todo.setEstado(this.getService().getEstadoDao().get(this.getEstadoId()));
			
			this.getService().getTodoDao().save(todo);
			model=todo;
			System.out.println("POST \t /todo" + todo.getDescripcion());
			return new DefaultHttpHeaders("create");
		}
		
		// PUT	/api/users
		public HttpHeaders update() {
			try {
				Todo todo=this.getService().getTodoDao().get(this.getId());
				if (!this.getDescripcion().equals("")) {
					todo.setDescripcion(this.getDescripcion());
				}
				if (this.getEstadoId()!=0){
					todo.setEstado(this.getService().getEstadoDao().get(this.getEstadoId()));
				}
				this.getService().getTodoDao().update(todo);
			}catch (Exception e) {
				System.out.println("put \t /error");
			}
			model =todo; 
			System.out.println("PUT \t /todo/{id}");
			
		
			return new DefaultHttpHeaders("update");
		}
		
		// DELETE	/api/users/1
		public HttpHeaders destroy() {
			this.getService().getTodoDao().deleteById(this.getId());
			
			System.out.println("DELETE \t /todo/{id}");
			return new DefaultHttpHeaders("destroy");
		}
		
		// GET	/api/users/1/edit
		public HttpHeaders edit() {
			try {
			Todo todo=this.getService().getTodoDao().get(this.getId());
			if (!this.getDescripcion().equals("")) {
				todo.setDescripcion(this.getDescripcion());
			}
			if (this.getEstadoId()!=0){
				todo.setEstado(this.getService().getEstadoDao().get(this.getEstadoId()));
			}
			this.getService().getTodoDao().update(todo);
			}catch (Exception e) {
				System.out.println("put \t /error");
			}
			model =todo; 
			System.out.println("PUT \t /todo/{id}");
			return new DefaultHttpHeaders("edit");
		}
	
	public TodoController() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public Object getModel() {
		// TODO Auto-generated method stub
		return model;
	}

	public long getId() {
		return id;
	}

		
	public void setId(long id) {
		model=this.getService().getTodoDao().get(id);
		this.id = id;
	}

	public ItestTecnicoManager getService() {
		return service;
	}

	public void setService(ItestTecnicoManager service) {
		this.service = service;
	}

	public void setModel(Object model) {
		this.model = model;
	}

	public TodoController(ItestTecnicoManager service) {
		super();
		this.service = service;
	}

	public Todo getTodo() {
		return todo;
	}

	public void setTodo(Todo todo) {
		this.todo = todo;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}

	public long getEstadoId() {
		return estadoId;
	}

	public void setEstadoId(long estadoId) {
		this.estadoId = estadoId;
	}

	
}
