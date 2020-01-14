package testTecnico.dao;

import java.util.List;

import testTecnico.common.GrillaExt;
import testTecnico.model.Documento;




public interface DocumentoDao {

	
	public abstract Class getReferenceClass();
	
	public abstract Documento get(long key)throws org.springframework.dao.DataAccessException;
	
	public abstract void saveOrUpdate(Documento documento)throws org.springframework.dao.DataAccessException;
	
	public abstract void save(Documento documento)throws org.springframework.dao.DataAccessException;
		
	public abstract void update(Documento documento)	throws org.springframework.dao.DataAccessException;
	
	public abstract void delete(Documento documento)throws org.springframework.dao.DataAccessException;
	
	public abstract java.util.List<Documento> findAll () throws org.springframework.dao.DataAccessException;
	
	public abstract java.util.List<Documento> findAll (String propertyName, String oderName) throws org.springframework.dao.DataAccessException;
	
	public abstract void deleteById(long id)throws org.springframework.dao.DataAccessException;
	
	public abstract Integer countByFiltersAndPaging (GrillaExt grilla) throws org.springframework.dao.DataAccessException;
	
	public abstract List<Documento> findByFiltersAndPaging (GrillaExt grilla) throws org.springframework.dao.DataAccessException;
	
	public abstract String findAllJsonCombo(String query);
	
	
	
	}







