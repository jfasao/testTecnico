package testTecnico.common;




import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;





public class Methods {

	  private static Methods _instance;


	    private static Methods getInstance()
		{
			if (_instance == null)
			{
				_instance = new Methods();
			}
			return _instance;
		}

	public void getFunctionsByProfile( Map request,String nameAcction, String user, long idApp) throws Exception
	{		String l ="";
		try {
			l = getFunctionByProfileAndAction( nameAcction,  user,  idApp);
			String[] lista = l.split("\\|");
			for (String elemento : lista) {
				request.put (elemento.split(",")[0],elemento.split(",")[1]);
			}		

		} catch (Exception e) {
				throw(e);
		}
	}

	
	public  static String strpad(String stringValue,Integer maxLength,String fillChar,String orientation){
        String ch = stringValue;
        Integer top = maxLength-ch.length();
        for (int i=0;i<top;i++){
                ch = (orientation=="LEFT")?fillChar + ch:ch + fillChar;        
                }
        return ch;
        }
	
	public static GrillaExt getGrillaExt(HttpServletRequest request) {		
		GrillaExt grillaext = new GrillaExt();
		List<FiltrosGrilla> filtros = new ArrayList<FiltrosGrilla>();
		filtros = getFiltros( request);
		
		grillaext.setFiltrosGrilla(( (filtros==null?new ArrayList<FiltrosGrilla>():filtros)));
		grillaext.setDir((request.getParameter("dir")==null?"desc":request.getParameter("dir")));
		grillaext.setOrder((request.getParameter("sort")==null?"":request.getParameter("sort").toString().replaceAll("9", ".")));
		grillaext.setStart(new Integer((request.getParameter("start")==null?"0":request.getParameter("start"))));
		grillaext.setLimit(new Integer((request.getParameter("limit")==null?"15":request.getParameter("limit"))));		
		return grillaext;
	}
	
	
	public static List<FiltrosGrilla> getFiltros(HttpServletRequest request) {
		List<FiltrosGrilla> filtros = new ArrayList<FiltrosGrilla>();
		String tempValue = "";
		String[] values = new String[0];
		for (int i = 0; i < 11; i++) {
			String tempField = request.getParameter("filter["+i+"][field]");
			//String tempValue = request.getParameter("filter["+i+"][data][value]");
			if (request.getParameterMap().get("filter["+i+"][data][value]")!=null){
			values = ((String[])request.getParameterMap().get("filter["+i+"][data][value]"));
			}
			for (int j = 0; j < values.length; j++) {
				tempValue = values[j];
			if(tempField!=null){
				FiltrosGrilla filtro = new FiltrosGrilla();
				filtro.setField(tempField.toString().replaceAll("9", "."));
				filtro.setType(request.getParameter("filter["+i+"][data][type]"));
				filtro.setValue(tempValue);
				filtro.setComparison(request.getParameter("filter["+i+"][data][comparison]"));
				filtros.add(filtro);
			}else{
				break;
			}
			}
		}
		return filtros;
	}
	public void getFunctionsByProfile( HttpServletRequest request,String nameAcction, String user, long idApp) throws Exception
	{		String l ="";
		try {
			l = getFunctionByProfileAndAction( nameAcction,  user,  idApp);
			String[] lista = l.split("\\|");
			for (String elemento : lista) {
				request.setAttribute  (elemento.split(",")[0],elemento.split(",")[1]);
			}	
					

		} catch (Exception e) {
				throw(e);
		}
	}

	public static synchronized Methods getMethods()
	{
		return Methods.getInstance();
	}
	
	public String getFunctionByProfileAndAction(String nameAcction, String user, long idApp) throws RemoteException
	{
	//	IWsSeguridadPortType service = new IWsSeguridadPortTypeProxy();
		
		return null;//service.getFunctionByProfileAndAction(nameAcction, user, idApp);
	}
	
	public static String nombreMes(int m){
		String[] values = {"Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"};
		try{
			return values[m-1];
		}
		catch (Exception e) {
			// TODO: handle exception
			return "No Data";
		}
	}
	
	 private static void agregarElementosNuevos(List listaOriginal, List listaNueva, String clase){
	    	for (Iterator iterator = listaNueva.iterator(); iterator.hasNext();) {
				Object item = (Object) iterator.next();
				if (!elementoEnLista(item, listaOriginal, clase)){
					listaOriginal.add(item);
				}
				
			}
	    }
	 
	 public static boolean elementoEnLista(Object elem, List lista, String clase){
	    	boolean esta = false;
	    	try {
	    //		clase = clase.replace("class ", "");
	    		Class<?> theClass = Class.forName(clase);
		        Object elemReal = theClass.cast(elem);
	    	for (Iterator iterator = lista.iterator(); iterator.hasNext();) {
				Object item = (Object) iterator.next();
		        Object obj = theClass.cast(item);
				if (obj.equals(elemReal)){
					esta = true;
					break;
				}
				
			}
	    	} catch (Exception e) {
				// TODO: handle exception
	    		e.getMessage();
			}
	    	return esta;
	    }
	    
	    private static void eliminarElementosViejos(List listaOriginal, List listaNueva, String clase){
	    	List laux = new ArrayList();
	    	for (Iterator iterator = listaOriginal.iterator(); iterator.hasNext();) {
				Object item = (Object) iterator.next();
				if (!elementoEnLista(item, listaNueva,clase)){
					laux.add(item);
				}
			}
	    	listaOriginal.removeAll(laux);
	    }
	    
	    public static void actualizarLista(List listaOriginal, List listaNueva, String clase){
	    	agregarElementosNuevos(listaOriginal,listaNueva, clase);
	    	eliminarElementosViejos(listaOriginal, listaNueva, clase);
	    }
	    
	  
	    
	
	
}
