package testTecnico.model;

import java.io.Serializable;


public class Estado implements Serializable {

	
	
	private static final long serialVersionUID = 1L;
	private long id;
	private String descripcion;
	
	
	
	
	
	
	public Estado(String descripcion) {
		super();
		this.descripcion = descripcion;
	}


	//getters and setters
	public long getId() {
		return id;
	}


	public void setId(long id) {
		this.id = id;
	}


	public String getDescripcion() {
		return descripcion;
	}



	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}


	public Estado() {
		super();
		// TODO Auto-generated constructor stub
	}

	
	
	
}
