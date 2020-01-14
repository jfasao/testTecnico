package testTecnico.service.dao.hibernate;

import testTecnico.dao.DocumentoDao;
import testTecnico.dao.EstadoDao;
import testTecnico.dao.TodoDao;

import testTecnico.service.dao.ItestTecnicoManager;

public class TestTecnicoManagerImpl implements ItestTecnicoManager {

	

	protected TodoDao todoDao;
	protected EstadoDao estadoDao;
	protected DocumentoDao documentoDao;
	
	
	
	

	public TodoDao getTodoDao() {
		return todoDao;
	}

	
	public void setTodoDao(TodoDao todoDao) {
		this.todoDao = todoDao;
	}


	public EstadoDao getEstadoDao() {
		return estadoDao;
	}


	public void setEstadoDao(EstadoDao estadoDao) {
		this.estadoDao = estadoDao;
	}


	public DocumentoDao getDocumentoDao() {
		return documentoDao;
	}


	public void setDocumentoDao(DocumentoDao documentoDao) {
		this.documentoDao = documentoDao;
	}

	
	
}
