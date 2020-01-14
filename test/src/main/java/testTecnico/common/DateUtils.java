package testTecnico.common;


import java.lang.reflect.InvocationTargetException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;



public abstract class DateUtils {
	
	public static Date addDaysToDate(Date fecha, Integer days){
		Calendar c1 = Calendar.getInstance(); 
		c1.setTime(fecha); 
		c1.add(Calendar.DATE,days);
		return c1.getTime();
	}
	
	
	
	/**
	 * Cantidad de dias que entre 2 fechas en TimeMillis.
	 * @param long fecha1 
	 * @param long fecha2 
	 * @return
	 */
	public static Long getDaysBetweenDates(long date1, long date2, String className) throws IllegalArgumentException, IllegalAccessException, InvocationTargetException, SecurityException, NoSuchMethodException, InstantiationException, ClassNotFoundException
	{	
		/*
		Class _class = Class.forName("java.sql.Timestamp");
		Class[] types = new Class[] { long.class };
		
		Class[] params= new Class[0];
		
		Object[] arg= new Object[0];
		Constructor cons = _class.getConstructor(types);
		Object[] args1 = new Object[] { p_time };
		
		
		Method po=_class.getMethod("getTime", null);
		Object pop=po.invoke( cons.newInstance(args1), null);
		
		long days=0;*/
		long days = (date2 - date1) / (1000 * 60 * 60 * 24);
		return days;
	}
	
	public static long getDaysBetweenDates(Date date1, Date date2) 
	{	
		
		long days = (date2.getTime() - date1.getTime()) / (1000 * 60 * 60 * 24);
		return days;
	}
	
	/**
	 * Compara 2 fechas dado un formato especificado.
	 * @param String fecha1 
	 * @param String fecha2 
	 * @param String formato
	 * @return
	 */
	public static String compareDates(String date1, String date2, String format){
		
		String result="";
		if (convertToNumber(date1, format).compareTo(convertToNumber(date2, format))>0){
			result = Constants.MAYOR;
		}
		else if (convertToNumber(date1, format).compareTo(convertToNumber(date2, format))<0){
			result = Constants.MENOR;
		}
		else
		{result = Constants.IGUAL;}
		return result;
		
	}
	
	
	/**
	 * Convierte a numero una fecha dado un formato especificado.
	 * @param String fecha 
	 * @param String formato 
	 * @return
	 */
	public static BigDecimal convertToNumber(String fecha, String format){
		BigDecimal number=new BigDecimal(0);
		char[] formatArray = format.toCharArray();
		char[] dateArray = fecha.toCharArray();
		String anno="";
		String mes="";
		String dia="";
		String hora="";
		String minuto="";

		try {
			
		for (int i = 0; i < formatArray.length; i++) {
			if (formatArray[i]==Constants.CARACTER_ANNO){
				anno+=String.valueOf(dateArray[i]);
			}
			else if (formatArray[i]==Constants.CARACTER_MES){
				mes+=String.valueOf(dateArray[i]);
			}
			else if (formatArray[i]==Constants.CARACTER_DIA){
				dia+=String.valueOf(dateArray[i]);
			}
			else if (formatArray[i]==Constants.CARACTER_HORA){
				hora+=String.valueOf(dateArray[i]);
			}
			else if (formatArray[i]==Constants.CARACTER_MINUTO){
				minuto+=String.valueOf(dateArray[i]);
			}
		}
		} catch (Exception e) {
			// TODO: handle exception
		}
		finally{

		String result = anno+mes+dia+hora+minuto;
		return new BigDecimal(result);
	}
		}
	
	/**
	 * Compara una fecha, con un formato especifico, con 
	 * la fecha actual
	 * @param String fecha 
	 * @param String formato 
	 * @return
	 */	
	public static String compareToCurrent(String fecha, String format){
		Calendar calendar = new GregorianCalendar();
		String day = (new Integer(calendar.get(GregorianCalendar.DAY_OF_MONTH))).toString();
		if (day.length()==1){day = "0"+day.toString();}
		String month = (new Integer(calendar.get(GregorianCalendar.MONTH)+1)).toString();
		if (month.length()==1){month = "0"+month.toString();}
		Integer year = new Integer(calendar.get(GregorianCalendar.YEAR));
		String result=compareDates(fecha, new String(year.toString()+"/"+month.toString()+"/"+day.toString()), format);
		return result;
		
	}
	
	/**
	 * Convierte fechas de un formato a otro.
	 * @param String fecha 
	 * @param String formato_origen 
	 * @param String formato_destino  
	 * @return
	 */
	public static String changeFormat(String date, String format, String formatDest){
		char[] fecha = date.toCharArray();
		char[] formato = format.toCharArray();
		String anno="";
		String mes="";
		String dia="";
		
		for (int i = 0; i < fecha.length; i++) {
			if (formato[i]==Constants.CARACTER_ANNO){
				anno+=String.valueOf(fecha[i]);
			}
			else if (formato[i]==Constants.CARACTER_MES){
				mes+=String.valueOf(fecha[i]);
			}
			else if (formato[i]==Constants.CARACTER_DIA){
				dia+=String.valueOf(fecha[i]);
			}

		}
		
		char[] list = formatDest.toCharArray();
		String splitChar="";
		for (int i = 0; i < list.length; i++) {
			if ((list[i]!=Constants.CARACTER_ANNO)&&(list[i]!=Constants.CARACTER_MES)&&(list[i]!=Constants.CARACTER_DIA)){
				splitChar = String.valueOf(list[i]);
				break;
			}
		}
		
		String[] fec = {}; 
		fec = formatDest.split("\\"+splitChar);
		Integer counter = 0;
		char[] lresult= new char[new Integer(anno.length()+dia.length()+mes.length()+2)];
		
		char[] lanno = anno.toCharArray();
		char[] lmes = mes.toCharArray();
		char[] ldia = dia.toCharArray();
		String res="";
		
		if (fec[0].contains(String.valueOf(Constants.CARACTER_ANNO))){
			res = String.copyValueOf(lanno);
			counter=res.length()-1;
		}	else
			if (fec[0].contains(String.valueOf(Constants.CARACTER_MES))){
					res=String.copyValueOf(lmes);
					counter=res.length()-1;
				}	
			else
			{
				    res=String.copyValueOf(ldia);
					counter=res.length()-1;
			}
		
		res+=splitChar;
		counter++;
		
		if (fec[1].contains(String.valueOf(Constants.CARACTER_ANNO))){
			res+= String.copyValueOf(lanno);
			counter=res.length()-1;
		}	else
			if (fec[1].contains(String.valueOf(Constants.CARACTER_MES))){
					res+=String.copyValueOf(lmes);
					counter=res.length()-1;
				}	
			else
			{
				    res+=String.copyValueOf(ldia);
					counter=res.length()-1;
			}
		
		res+=splitChar;
		counter++;
		
		if (fec[2].contains(String.valueOf(Constants.CARACTER_ANNO))){
			res+= String.copyValueOf(lanno);
			counter=res.length()-1;
		}	else
			if (fec[2].contains(String.valueOf(Constants.CARACTER_MES))){
					res+=String.copyValueOf(lmes);
					counter=res.length()-1;
				}	
			else
			{
				    res+=String.copyValueOf(ldia);
					counter+=res.length()-1;
			}
		

			
		
		
		return res;
		
	}
	
	 /**
	  * Fecha actual en un formato espec�fico
	  * @param format
	  * @return
	  */	
	public static String today(String format){
		Calendar calendar = new GregorianCalendar();
		String day = (new Integer(calendar.get(GregorianCalendar.DAY_OF_MONTH))).toString();
		if (day.length()==1){day = "0"+day.toString();}
		String month = (new Integer(calendar.get(GregorianCalendar.MONTH)+1)).toString();
		if (month.length()==1){month = "0"+month.toString();}
		Integer year = new Integer(calendar.get(GregorianCalendar.YEAR));
		String result=changeFormat(new String(year.toString()+"/"+month.toString()+"/"+day.toString()),"yyyy/MM/dd", format);
		return result;
		
	}
	
	/**
	 * Fecha actual con hora en un formato especifico
	 * @param format
	 * @return
	 */
	public static String todayWithTime(String format){
		Calendar calendar = new GregorianCalendar();
		String day = (new Integer(calendar.get(GregorianCalendar.DAY_OF_MONTH))).toString();
		if (day.length()==1){day = "0"+day.toString();}
		String month = (new Integer(calendar.get(GregorianCalendar.MONTH)+1)).toString();
		if (month.length()==1){month = "0"+month.toString();}
		Integer year = new Integer(calendar.get(GregorianCalendar.YEAR));
		String result=changeFormat(new String(year.toString()+"/"+month.toString()+"/"+day.toString()),"yyyy/mm/dd", format);
		String min = new Integer(calendar.get(GregorianCalendar.MINUTE)).toString();
		if (min.length()==1){min="0"+min;}
		result +=" "+ (new Integer(calendar.get(GregorianCalendar.HOUR_OF_DAY)).toString())+":"+ (new Integer(calendar.get(GregorianCalendar.MINUTE)).toString()); 
		return result;
		
	}
	
	
	/**
	 * Convierte una fecha de tipo Date a String con el formato deseado.
	 * @param Date date : Fecha a convertir.
	 * @param String outputFormat : Formato de salida.
	 * @param boolean timePresent : Generar fecha con hora.
	 * @return
	 */
	public static String changeDateFormat(Date date,   String outputFormat, boolean timePresent){
		String fechaString="";
		if (date!=null){
			Timestamp t = changeFormateDate(date);
			  Calendar cal = Calendar.getInstance();
			  cal.setTime(t);
		        Integer day = cal.get(Calendar.DATE);
		        Integer month = cal.get(Calendar.MONTH) + 1;
		        Integer year = cal.get(Calendar.YEAR);
			String fecha = t.toString().split(" ")[0];
			String dia = day.toString().length()==1?"0"+day.toString():day.toString();
			String mes = month.toString().length()==1?"0"+month.toString():month.toString();
			fechaString=dia+"/"+mes+"/"+year;
			fechaString=changeFormat(fechaString, "dd/MM/yyyy", outputFormat);
			
			if (timePresent){
				fechaString = fechaString + " " + t.toString().split(" ")[1].split("\\.")[0];
			}
		}
		return fechaString;
	}
	
		
	public static String changeDateToString(Date date){
		String[] meses={"Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"};
		String fechaString="";
		if (date!=null){
			Timestamp t = changeFormateDate(date);
			  Calendar cal = Calendar.getInstance();
			  cal.setTime(t);
		        Integer day = cal.get(Calendar.DATE);
		        Integer month = cal.get(Calendar.MONTH);
		        Integer year = cal.get(Calendar.YEAR);
			
			String dia = day.toString().length()==1?"0"+day.toString():day.toString();
			String mes = meses[month];
			fechaString=dia+" de "+mes+" de "+year;
			
		}
		return fechaString;
	}
	
	public static Timestamp changeFormateDate(Date dia)
	{
		return new Timestamp(dia.getTime());
	}
	
	public static Integer getDay(Date date){
		 Calendar cal = Calendar.getInstance();
		 cal.setTime(date);
		return cal.get(Calendar.DAY_OF_WEEK);
	}
	
	public static Integer getDia(Date date){
		 Calendar cal = Calendar.getInstance();
		 cal.setTime(date);
		return cal.get(Calendar.DAY_OF_MONTH);
	}
	
	public static Integer getMonth(Date date){
		 Calendar cal = Calendar.getInstance();
		 cal.setTime(date);
		return cal.get(Calendar.MONTH) + 1;
	}
	
	public static Integer getYear(Date date){
		 Calendar cal = Calendar.getInstance();
		 cal.setTime(date);
		return cal.get(Calendar.YEAR) ;
	}
	
	/**
	 * dd/MM/yyyy
	 */
	public static Date convertToDate(String str, String mask) throws ParseException{
		SimpleDateFormat format = new SimpleDateFormat(mask);
		 return format.parse(str);

	}
	
	public static Date convertToDateWithTime(String str, String mask) throws ParseException{
		String[] arr = str.split(" ");
		Date d=new Date();
		SimpleDateFormat format = new SimpleDateFormat(mask);
		if (arr.length<2){
		d=format.parse(str);}
		else
		{
			try {
				d=format.parse(str);
			} catch (Exception e) {
				// TODO: handle exception
				e.getMessage();
			}
		}
		 return d;

	}
	
}
	
