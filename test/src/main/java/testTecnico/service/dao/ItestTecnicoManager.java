package testTecnico.service.dao;

import testTecnico.dao.DocumentoDao;
import testTecnico.dao.EstadoDao;
import testTecnico.dao.TodoDao;


public interface ItestTecnicoManager {

	public abstract TodoDao getTodoDao();
	public abstract void setTodoDao(TodoDao todoDao);

	public abstract EstadoDao getEstadoDao() ;
	public abstract void setEstadoDao(EstadoDao estadoDao) ;


	public abstract DocumentoDao getDocumentoDao() ;
	public abstract void setDocumentoDao(DocumentoDao documentoDao) ;
}
