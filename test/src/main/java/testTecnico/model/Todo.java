package testTecnico.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import testTecnico.model.Documento;



public class Todo implements Serializable {

	private static final long serialVersionUID = 8760167225934563167L;
	private long id;
	private String descripcion;
	private Estado estado;
	private List<Documento>documentos= new ArrayList<Documento>();
	
	
	
	
	
	public Todo(String descripcion) {
		super();
		this.descripcion = descripcion;
	}




	public Todo() {
		super();
		// TODO Auto-generated constructor stub
	}




	public Todo(long id, String descripcion, Estado estado) {
		super();
		this.id = id;
		this.descripcion = descripcion;
		this.estado = estado;
	}




	public Todo(long id, String descripcion, Estado estado, List<Documento> documentos) {
		super();
		this.id = id;
		this.descripcion = descripcion;
		this.estado = estado;
		this.documentos = documentos;
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

	public Estado getEstado() {
		return estado;
	}

	public void setEstado(Estado estado) {
		this.estado = estado;
	}




	public List<Documento> getDocumentos() {
		return documentos;
	}




	public void setDocumentos(List<Documento> documentos) {
		this.documentos = documentos;
	}

	public String documentosToJson(){
		StringBuffer salida=new StringBuffer();
		salida.append("[");
		for (Iterator iterator = this.getDocumentos().iterator(); iterator.hasNext();) {
			Documento doc = (Documento) iterator.next();
			salida.append(doc.documentoToJson());
			if (iterator.hasNext()==true){
				salida.append(",");
			}
		}
		salida.append("]");
		return salida.toString();
		
	}
	
	
}
