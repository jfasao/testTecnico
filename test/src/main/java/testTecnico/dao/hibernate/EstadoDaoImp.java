package testTecnico.dao.hibernate;

import java.util.ArrayList;
import java.util.List;
import testTecnico.base.dao.hibernate._RootDAO;

import testTecnico.common.GrillaExt;
import testTecnico.dao.EstadoDao;
import testTecnico.model.Estado;






public class EstadoDaoImp extends _RootDAO implements  EstadoDao {
	
	public Class getReferenceClass () {
		return Estado.class;
	}
	
	public Estado cast (Object object) {
		return (Estado) object;
	}

	public Estado get(long key)	throws org.springframework.dao.DataAccessException {
		return (Estado) super.get(key);
								
	}

	public void saveOrUpdate(Estado actividad) throws org.springframework.dao.DataAccessException {
		super.saveOrUpdate(actividad);
	}
	
	public void save(Estado actividad) throws org.springframework.dao.DataAccessException {
		super.save(actividad);
	}

	public void update(Estado actividad)	throws org.springframework.dao.DataAccessException {
		super.update(actividad);
	}
	
	public void delete(Estado actividad) throws org.springframework.dao.DataAccessException {
		super.delete(actividad);
	}
	
	public java.util.List<Estado> findAll () throws org.springframework.dao.DataAccessException {
		this.getHibernateTemplate().setCacheQueries(true);
		return super.findAll();
	}
	
	public java.util.List<Estado> findAll (String propertyName, String oderName) throws org.springframework.dao.DataAccessException  {
		this.getHibernateTemplate().setCacheQueries(true);
		return super.findAll(this.getReferenceClass().getName(),propertyName,oderName);
	}
	
	public  void deleteById(long id) throws org.springframework.dao.DataAccessException {
		Estado actividad = get(id);
		delete(actividad);	
	}
	
	public  Integer countByFiltersAndPaging (GrillaExt grilla) throws org.springframework.dao.DataAccessException {
		return super.countByFiltersAndPaging(grilla.getFiltrosGrilla(),grilla.getWhereAdd());
	}
	
	
	public  List<Estado> findByFiltersAndPaging (GrillaExt grilla) throws org.springframework.dao.DataAccessException{
		//String property, String order, List<FiltrosGrilla> filtros,int firstResult,int maxResults, 
		try {  	
			return super.findByFiltersAndPaging("id",grilla);			
		} catch (org.springframework.dao.DataAccessException e) {
			return  null;
		}
	}
	
	public String findAllJsonCombo(String query){
		if (query==null){
			query = "";
		}
		query = query.toString().trim().toUpperCase();
		StringBuffer resultado = new StringBuffer("");
    	List<Estado> aux = new ArrayList<Estado>();
    	String queryString = "from Estado e  where UPPER(e.descripcion) like '%"+query +"%' order by e.descripcion asc";
    	this.getHibernateTemplate().setCacheQueries(true);			
    	aux =  this.getHibernateTemplate().find(queryString);
    	
    	if (aux.size()==0){
    		resultado.append("[{id:'-1',descripcion:'No hay datos con ese filtro.'}]");;
    	}else {
    		resultado.append("[");	    	
	    	if (aux.size()>0){
	    	for (Estado inicio : aux) {  
	    		resultado.append("{id:'"+inicio.getId()+"',");
	    		resultado.append("descripcion:'"+inicio.getDescripcion().replaceAll("'", "&#39;")+"'},");  
	    	}
	    	resultado.delete(resultado.length()-1, resultado.length());
	    	}
	    	resultado.append("]");	
	    }
    	return resultado.toString();
	}	
	
	public boolean hayDescripcion(String nombre)throws org.springframework.dao.DataAccessException{
		String queryString = "from Estado s  where UPPER(s.descripcion) = '"+nombre.toUpperCase() +"' ";
    try {
    	this.getHibernateTemplate().setCacheQueries(true);			
    	return  this.getHibernateTemplate().find(queryString).size()>0;
    } catch (Exception e) {
		return false;
	}		
	}
}
