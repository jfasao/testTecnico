package testTecnico.dao;



import testTecnico.common.GrillaExt;
import testTecnico.model.Todo;

import java.util.List;


public interface TodoDao {

	public abstract Class getReferenceClass();
	
	public abstract Todo get(long key)throws org.springframework.dao.DataAccessException;
	
	public abstract void saveOrUpdate(Todo actividad)throws org.springframework.dao.DataAccessException;
	
	public abstract void save(Todo actividad)throws org.springframework.dao.DataAccessException;
		
	public abstract void update(Todo actividad)	throws org.springframework.dao.DataAccessException;
	
	public abstract void delete(Todo actividad)throws org.springframework.dao.DataAccessException;
	
	public abstract java.util.List<Todo> findAll () throws org.springframework.dao.DataAccessException;
	
	public abstract java.util.List<Todo> findAll (String propertyName, String oderName) throws org.springframework.dao.DataAccessException;
	
	public abstract void deleteById(long id)throws org.springframework.dao.DataAccessException;
	
	public  Integer countByFiltersAndPaging (GrillaExt grilla) throws org.springframework.dao.DataAccessException;
	
	public  List<Todo> findByFiltersAndPaging (GrillaExt grilla) throws org.springframework.dao.DataAccessException;
	public abstract String findAllJsonCombo(String query);
	
	public abstract boolean hayDescripcion(String nombre)throws org.springframework.dao.DataAccessException;
	
	public abstract java.util.List<Todo> findByDescAndEstado (String descripcion, String estado) throws org.springframework.dao.DataAccessException;

	}







