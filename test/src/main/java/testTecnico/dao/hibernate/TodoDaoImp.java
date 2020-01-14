package testTecnico.dao.hibernate;

import java.util.ArrayList;
import java.util.List;
import testTecnico.base.dao.hibernate._RootDAO;
import testTecnico.common.FiltrosGrilla;
import testTecnico.common.GrillaExt;
import testTecnico.dao.TodoDao;
import testTecnico.model.Todo;






public class TodoDaoImp extends _RootDAO implements  TodoDao {
	
	public Class getReferenceClass () {
		return Todo.class;
	}
	
	public Todo cast (Object object) {
		return (Todo) object;
	}

	public Todo get(long key)	throws org.springframework.dao.DataAccessException {
		return (Todo) super.get(key);
								
	}

	public void saveOrUpdate(Todo todo) throws org.springframework.dao.DataAccessException {
		super.saveOrUpdate(todo);
	}
	
	public void save(Todo todo) throws org.springframework.dao.DataAccessException {
		super.save(todo);
	}

	public void update(Todo todo)	throws org.springframework.dao.DataAccessException {
		super.update(todo);
	}
	
	public void delete(Todo todo) throws org.springframework.dao.DataAccessException {
		super.delete(todo);
	}
	
	public java.util.List<Todo> findAll () throws org.springframework.dao.DataAccessException {
		this.getHibernateTemplate().setCacheQueries(true);
		return super.findAll();
	}
	
	public java.util.List<Todo> findAll (String propertyName, String oderName) throws org.springframework.dao.DataAccessException  {
		this.getHibernateTemplate().setCacheQueries(true);
		return super.findAll(this.getReferenceClass().getName(),propertyName,oderName);
	}
	
	public  void deleteById(long id) throws org.springframework.dao.DataAccessException {
		Todo todo = get(id);
		delete(todo);	
	}
	
	public  Integer countByFiltersAndPaging (GrillaExt grilla) throws org.springframework.dao.DataAccessException {
		return super.countByFiltersAndPaging(grilla.getFiltrosGrilla(),grilla.getWhereAdd());
	}
	
	
	public  List<Todo> findByFiltersAndPaging (GrillaExt grilla) throws org.springframework.dao.DataAccessException{
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
    	List<Todo> aux = new ArrayList<Todo>();
    	String queryString = "from Todo s  where UPPER(s.descripcion) like '%"+query +"%' and s.activo=true order by s.descripcion asc";
    	this.getHibernateTemplate().setCacheQueries(true);			
    	aux =  this.getHibernateTemplate().find(queryString);
    	
    	if (aux.size()==0){
    		resultado.append("[{todoId:'-1',descripcion:'No hay datos con ese filtro.'}]");;
    	}else {
    		resultado.append("[");	    	
	    	if (aux.size()>0){
	    	for (Todo inicio : aux) {  
	    	//	resultado.append("{todoId:'"+inicio.gettodoId()+"',");
	    		resultado.append("descripcion:'"+inicio.getDescripcion().replaceAll("'", "&#39;")+"'},");  
	    	}
	    	resultado.delete(resultado.length()-1, resultado.length());
	    	}
	    	resultado.append("]");	
	    }
    	return resultado.toString();
	}	
	
	public boolean hayDescripcion(String nombre)throws org.springframework.dao.DataAccessException{
		String queryString = "from Todo s  where UPPER(s.descripcion) = '"+nombre.toUpperCase() +"' ";
    try {
    	this.getHibernateTemplate().setCacheQueries(true);			
    	return  this.getHibernateTemplate().find(queryString).size()>0;
    } catch (Exception e) {
		return false;
	}		
	}
	
	public java.util.List<Todo> findByDescAndEstado (String descripcion, String estado) throws org.springframework.dao.DataAccessException {
		
		String queryString = "from Todo to  where UPPER(to.descripcion) like '%"+descripcion.toUpperCase() +"%' and UPPER(to.estado.descripcion) like '%"+estado.toUpperCase() +"%' ";
		
		 try {
		    	this.getHibernateTemplate().setCacheQueries(true);			
		    	return  this.getHibernateTemplate().find(queryString);
		    } catch (Exception e) {
				return null;
			}		
	}
}
