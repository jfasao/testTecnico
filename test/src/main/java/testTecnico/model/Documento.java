package testTecnico.model;

import java.io.Serializable;
import java.sql.Blob;

import org.codehaus.jackson.annotate.JsonIgnore;
import org.codehaus.jackson.annotate.JsonIgnoreProperties;


public class Documento  implements Serializable
{
	
	private static final long serialVersionUID = -8440203440451834633L;
	private long   documentoId;
	private String nombreDoc;
	private String contentType;
	private String comentario;
	private Blob   documento ;
	private String ruta;
	@JsonIgnore
	//private Todo todo;
	
	
	
	public String getContentType() {
		return contentType;
	}
	public void setContentType(String contentType) {
		this.contentType = contentType;
	}
	public String getComentario() {
		return comentario;
	}
	public void setComentario(String comentario) {
		this.comentario = comentario;
	}
	public long getDocumentoId() {
		return documentoId;
	}
	public void setDocumentoId(long documentoId) {
		this.documentoId = documentoId;
	}
	public String getNombreDoc() {
		return nombreDoc;
	}
	public void setNombreDoc(String nombreDoc) {
		this.nombreDoc = nombreDoc;
	}
	public Blob getDocumento() {
		return documento;
	}
	public void setDocumento(Blob documento) {
		this.documento = documento;
	}

	
	
	
	//constructors
	/*
	
	@JsonIgnore
	public Todo getTodo() {
		return todo;
	}
	@JsonIgnore
	public void setTodo(Todo todo) {
		this.todo = todo;
	}*/
	public String getRuta() {
		return ruta;
	}
	public void setRuta(String ruta) {
		this.ruta = ruta;
	}
	public Documento() {
		super();
	}
	
	
	
	public Documento(long documentoId) {
		super();
		this.documentoId = documentoId;
	}
	/*public Documento(long documentoId, String nombreDoc, String contentType,
			String comentario, Blob documento, Todo todo) {
		super();
		this.documentoId = documentoId;
		this.nombreDoc = nombreDoc;
		this.contentType = contentType;
		this.comentario = comentario;
		this.documento = documento;
		this.todo = todo;
	}
	
	public Documento(String comentario, String contentType, Blob documento,
			long documentoId, String nombreDoc, String ruta, Todo todo) {
		super();
		this.comentario = comentario;
		this.contentType = contentType;
		this.documento = documento; 
		this.documentoId = documentoId;
		this.nombreDoc = nombreDoc;
		this.ruta = ruta;
		this.todo = todo;
	}*/
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + (int) (documentoId ^ (documentoId >>> 32));
		return result;
	}
	public Documento(long documentoId, String nombreDoc, String contentType, String comentario, Blob documento,
			String ruta) {
		super();
		this.documentoId = documentoId;
		this.nombreDoc = nombreDoc;
		this.contentType = contentType;
		this.comentario = comentario;
		this.documento = documento;
		this.ruta = ruta;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		final Documento other = (Documento) obj;
		if (documentoId != other.documentoId)
			return false;
		return true;
	}
	
	public String documentoToJson(){
		StringBuffer salida = new StringBuffer();
		salida.append("{");
		salida.append("documentoId:'"+this.getDocumentoId()+"',");
		salida.append("nombreDoc:'"+this.getNombreDoc()+"',");
		salida.append("contentType:'"+this.getContentType()+"',");
		salida.append("comentario:'"+this.getComentario()+"',");
		salida.append("ruta:'"+this.getRuta()+"'}");
		
		return salida.toString();
		
	}
	
	
}
