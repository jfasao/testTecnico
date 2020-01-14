
package testTecnico.dao.hibernate;



import java.util.ArrayList;
import java.util.List;
import testTecnico.base.dao.hibernate._RootDAO;
import testTecnico.common.GrillaExt;
import testTecnico.dao.DocumentoDao;
import testTecnico.model.Documento;
import testTecnico.model.Todo;





public class DocumentoDaoImp extends _RootDAO implements  DocumentoDao {
	
	public Class getReferenceClass () {
		return Documento.class;
	}
	
	public Documento cast (Object object) {
		return (Documento) object;
	}

	public Documento get(long key)	throws org.springframework.dao.DataAccessException {
		return (Documento) super.get(key);
								
	}

	public void saveOrUpdate(Documento documento) throws org.springframework.dao.DataAccessException {
		super.saveOrUpdate(documento);
	}
	
	public void save(Documento documento) throws org.springframework.dao.DataAccessException {
		try {
			super.save(documento);
		} catch (Exception e) {
			e.getLocalizedMessage();
		}
		
	}

	public void update(Documento documento)	throws org.springframework.dao.DataAccessException {
		super.update(documento);
	}
	
	public void delete(Documento documento) throws org.springframework.dao.DataAccessException {
		super.delete(documento);
	}
	
	public java.util.List<Documento> findAll () throws org.springframework.dao.DataAccessException {
		this.getHibernateTemplate().setCacheQueries(true);
		return super.findAll();
	}
	
	public java.util.List<Documento> findAll (String propertyName, String oderName) throws org.springframework.dao.DataAccessException  {
		this.getHibernateTemplate().setCacheQueries(true);
		return super.findAll(this.getReferenceClass().getName(),propertyName,oderName);
	}
	

	public  void deleteById(long id) throws org.springframework.dao.DataAccessException {
		Documento tarea = get(id);
		delete(tarea);	
	}
	
	
	public  Integer countByFiltersAndPaging (GrillaExt grilla) throws org.springframework.dao.DataAccessException {
		return super.countByFiltersAndPaging(grilla.getFiltrosGrilla(),grilla.getWhereAdd());
	}
	
	
	public  List<Documento> findByFiltersAndPaging (GrillaExt grilla) throws org.springframework.dao.DataAccessException{
		//String property, String order, List<FiltrosGrilla> filtros,int firstResult,int maxResults, 
		try {  	
			return super.findByFiltersAndPaging("documentoId",grilla);			
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
    	String queryString = "from Documento s  where UPPER(s.descripcion) like '%"+query +"%' and s.activo=true order by s.descripcion asc";
    	this.getHibernateTemplate().setCacheQueries(true);			
    	aux =  this.getHibernateTemplate().find(queryString);
    	
    	if (aux.size()==0){
    		resultado.append("[{actividadId:'-1',descripcion:'No hay datos con ese filtro.'}]");;
    	}else {
    		resultado.append("[");	    	
	    	if (aux.size()>0){
	    	for (Todo inicio : aux) {  
	    	//	resultado.append("{actividadId:'"+inicio.getActividadId()+"',");
	    		resultado.append("descripcion:'"+inicio.getDescripcion().replaceAll("'", "&#39;")+"'},");  
	    	}
	    	resultado.delete(resultado.length()-1, resultado.length());
	    	}
	    	resultado.append("]");	
	    }
    	return resultado.toString();
	}	

	
}
