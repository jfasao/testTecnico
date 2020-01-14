package testTecnico.base.dao.hibernate;
 

import testTecnico.common.FiltrosGrilla;
import testTecnico.common.GrillaExt;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import org.hibernate.criterion.DetachedCriteria;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;



public abstract class SpringBaseRootDAO extends HibernateDaoSupport {
 
		
	        public abstract Class getReferenceClass ();
	        
	        protected Object get(Serializable id){
	        	try {
	        		return this.getHibernateTemplate().get(this.getReferenceClass(),id);
				} catch (Exception e) {
					return null;
				}
	        	
	        }
	        
	        
	        
	        protected void saveOrUpdate (Object o){
	        	try {
	        		this.getHibernateTemplate().saveOrUpdate(o);

	        	} catch (Exception e) {
	        		e.getMessage();
			}
	        	
	        }
	        
	        protected Serializable save (Object o) {
	        try {
	        	return this.getHibernateTemplate().save(o);
	        } catch (Exception e) {
        		e.getMessage();
        		return null;
	        }
	        }

	        protected void delete (Object o)throws org.springframework.dao.DataAccessException 
	        {
	        	this.getHibernateTemplate().delete(o);
	        }
	        

	        
	        protected void update(Object o)
	        {
	           this.getHibernateTemplate().update(o);	
	        }
	        
	        protected List findAll()
	        {
	             return this.getHibernateTemplate().loadAll(this.getReferenceClass());	
	        }
	       
	        protected List findByExample(Object o)
	        {
	             return this.getHibernateTemplate().findByExample(o);	
	        }
	        
	        protected List findByCriteria(DetachedCriteria o)
	        {
	             return this.getHibernateTemplate().findByCriteria(o);	
	        }
	        
	        
	        public  java.util.List findAll (String nameClass, String propertyName, String oderName) throws org.springframework.dao.DataAccessException 
	    	{
	    	
	    		String queryString = "from " +nameClass +" order by "+ propertyName + " " + oderName;
	    		
	    		try {       
	    			
	    			return this.getHibernateTemplate().find(queryString);			
	    		
	    		} catch (org.springframework.dao.DataAccessException e) {
	    			return null;
	    		}
	    	}
	     
	        protected Integer countByFiltersAndPaging(List<FiltrosGrilla> filtros, String whereExtra)
	        {	
	        	StringBuffer consultaDinamica = new StringBuffer("");
	        	try {
	        		 
	        		consultaDinamica.append("select distinct count(*) from ").append(this.getReferenceClass().getName()).append(" t ");
					consultaDinamica.append(whereContructor((filtros!=null)?filtros:new ArrayList<FiltrosGrilla>() ,whereExtra));	        	
		            return  new Integer((String) this.getHibernateTemplate().getSessionFactory().getCurrentSession().createQuery(consultaDinamica.toString()).uniqueResult().toString());
				} catch (Exception e) {
					return 0;
				}        	
	        	
	        }
	        
	            
	       
	        
	        
	        protected List findByFiltersAndPaging(String orderFix,GrillaExt grillaExt)
	        {	
	        	StringBuffer consultaDinamica = new StringBuffer("");
	        	try {
	        		 
	        	consultaDinamica.append(" from ").append(this.getReferenceClass().getName()).append(" t ");
				consultaDinamica.append(whereContructor((grillaExt.getFiltrosGrilla()!=null)?grillaExt.getFiltrosGrilla():new ArrayList<FiltrosGrilla>(),grillaExt.getWhereAdd()));
				
				if ( !grillaExt.getOrder().equals("")){
					
					consultaDinamica.append(" order by t.").append(orderFix).append(" ").append("desc");
				}
	        	this.getHibernateTemplate().setCacheQueries(true);
	             return this.getHibernateTemplate().getSessionFactory().getCurrentSession().createQuery(consultaDinamica.toString()).setFirstResult(grillaExt.getStart()).setMaxResults(grillaExt.getLimit()).list();
	        	} catch (Exception e) {
					return null;
				}
	        }
	        
	      
	        
	        public StringBuffer whereContructor(List<FiltrosGrilla> filters, String whereExtra ) {
	    		StringBuffer where = new StringBuffer("");
	    		
	    			if (filters.size() >0){
	    				where.append(" where ");
	    				for (Iterator iterator = filters.iterator(); iterator.hasNext();) {
	    					FiltrosGrilla fil = (FiltrosGrilla) iterator.next();
	    					
	    					if (fil.getType().equals("string")){
	    						where.append(" UPPER(t.").append(fil.getField()).append(") ").append(fil.getComparison()).append(" ").append(fil.getValue());;
	    					}else if  (fil.getType().equals("date"))
	    					{
	    						where.append(" TO_CHAR(t.").append(fil.getField()).append(",'yyyy/mm/dd') ").append(fil.getComparison()).append(" ").append(fil.getValue());;
	    					}
	    					
	    					else {
	    						where.append(" t.").append(fil.getField()).append(" ").append(fil.getComparison()).append(" ").append(fil.getValue().toString());	    					
	    					}
	    					where.append(" and");
	    				}
	    				where = new StringBuffer( where.substring(0, where.length()-3));
	    			}
	    	
	    		if ((whereExtra.trim().length()!=0)&&(!whereExtra.contains("where"))){
	    			if (filters.size()==0){
	    				where.append(" where ");
	    			}else{
	    				where.append(" and ");
	    			}
	    			where.append(whereExtra);
	    		}
	    		if (whereExtra.contains("where")){ return new StringBuffer(whereExtra);} else
	    		{return where;}
	    	}

}

