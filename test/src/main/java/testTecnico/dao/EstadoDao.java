package testTecnico.dao;



import testTecnico.common.GrillaExt;
import testTecnico.model.Estado;

import java.util.List;


public interface EstadoDao {

	public abstract Class getReferenceClass();
	
	public abstract Estado get(long key)throws org.springframework.dao.DataAccessException;
	
	public abstract void saveOrUpdate(Estado actividad)throws org.springframework.dao.DataAccessException;
	
	public abstract void save(Estado actividad)throws org.springframework.dao.DataAccessException;
		
	public abstract void update(Estado actividad)	throws org.springframework.dao.DataAccessException;
	
	public abstract void delete(Estado actividad)throws org.springframework.dao.DataAccessException;
	
	public abstract java.util.List<Estado> findAll () throws org.springframework.dao.DataAccessException;
	
	public abstract java.util.List<Estado> findAll (String propertyName, String oderName) throws org.springframework.dao.DataAccessException;
	
	public abstract void deleteById(long id)throws org.springframework.dao.DataAccessException;
	
	public  Integer countByFiltersAndPaging (GrillaExt grilla) throws org.springframework.dao.DataAccessException;
	
	public  List<Estado> findByFiltersAndPaging (GrillaExt grilla) throws org.springframework.dao.DataAccessException;
	public abstract String findAllJsonCombo(String query);
	
	public abstract boolean hayDescripcion(String nombre)throws org.springframework.dao.DataAccessException;

	}







