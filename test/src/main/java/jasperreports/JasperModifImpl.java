package jasperreports;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.views.jasperreports.JasperReportsResult;
import org.apache.struts2.views.jasperreports.ValueStackShadowMap;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.util.ValueStack;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JRParameter;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.export.JRCsvExporter;
import net.sf.jasperreports.engine.export.JRCsvExporterParameter;
import net.sf.jasperreports.engine.export.JRHtmlExporter;
import net.sf.jasperreports.engine.export.JRHtmlExporterParameter;
import net.sf.jasperreports.engine.export.JRRtfExporter;
import net.sf.jasperreports.engine.export.JRXlsExporter;
import net.sf.jasperreports.engine.export.JRXmlExporter;
import net.sf.jasperreports.engine.util.JRLoader;





/**
 * @author falcalde
 * 
 * modificacion de Struts2-plugin-jasperreports para manejo dianmico de parametros, formatos
 *
 */
public class JasperModifImpl extends JasperReportsResult {
	
	private String customParameters;
	private String type;
	private final static Logger LOG = Logger.getLogger(JasperReportsResult.class);

	
	public void setType(String type) {
		this.type = type;
	}


	public void setCustomParameters(String customParameters) {
        this.customParameters = customParameters;
    }

	
	/**
	 * @author falcalde
	 * modificacion del doExecute para el manejo de parametros para los reportes.
	 *
	 */
	
	 protected void doExecute(String finalLocation, ActionInvocation invocation) throws Exception {
	        
		 	
		  /**
	      * agregado para manejo dinamico de los formatos de los reportes
	      */
		 	ValueStack stack = invocation.getStack();
	        type  = conditionalParse(type, invocation);
		 	
	        if (type!=null){
		 	 format =(String) stack.findValue(type);
		 	}	
		 		 
		 	if (super.format == null) {
	            super.format = FORMAT_PDF;
	        }

	        if (dataSource == null) {
	            String message = "No dataSource specified...";
	            LOG.error(message);
	            throw new RuntimeException(message);
	        }

	        if (LOG.isDebugEnabled()) {
	            LOG.debug("Creating JasperReport for dataSource = " + dataSource + ", format = " + this.format);
	        }

	        HttpServletRequest request = (HttpServletRequest) invocation.getInvocationContext().get(ServletActionContext.HTTP_REQUEST);
	        HttpServletResponse response = (HttpServletResponse) invocation.getInvocationContext().get(ServletActionContext.HTTP_RESPONSE);

	       /**
	        * Se modifica como se crean los datasources, ya que ValueStackDataSource tiene problemas cuando se le pasan valores nulos y
	        * no permite manejar bien la info.
	        */
	       
	        List<Object> dataSourceValue = (List<Object>) stack.findValue(dataSource);
	        JRDataSource jd;
	        if ((dataSourceValue!=null)&&(!dataSourceValue.isEmpty())){
	        	jd= new JRBeanCollectionDataSource(dataSourceValue);
	        }else{
	        	jd= new JREmptyDataSource();
	        }
	        //construct the data source for the report
	        //ValueStackDataSource stackDataSource = new ValueStackDataSource(stack, dataSource);

	        format = conditionalParse(format, invocation);
	        dataSource = conditionalParse(dataSource, invocation);
	        
	      
	       
	        if (contentDisposition != null) {
	            contentDisposition = conditionalParse(contentDisposition, invocation);
	        }

	        if (documentName != null) {
	            documentName = conditionalParse(documentName, invocation);
	        }

	       
	        if ((format=="") ||(format==null)) {
	            format = FORMAT_PDF;
	        }

	        if (!"contype".equals(request.getHeader("User-Agent"))) {
	            // Determine the directory that the report file is in and set the reportDirectory parameter
	            // For WW 2.1.7:
	            //  ServletContext servletContext = ((ServletConfig) invocation.getInvocationContext().get(ServletActionContext.SERVLET_CONFIG)).getServletContext();
	            ServletContext servletContext = (ServletContext) invocation.getInvocationContext().get(ServletActionContext.SERVLET_CONTEXT);
	            String systemId = servletContext.getRealPath(finalLocation);
	            Map parameters = new ValueStackShadowMap(stack);
	           
	            /**
	             * Se Traen los parametros del stack y se pasan al reporte
	             */
	            
	            Map mapParameters = (Map) stack.findValue(customParameters);
                if (mapParameters != null) {
                        parameters.putAll(mapParameters);
                }
               // parameters.put("data", jd);
                //prueba
                
	            File directory = new File(systemId.substring(0, systemId.lastIndexOf(File.separator)));
	            parameters.put("reportDirectory", directory);
	            parameters.put(JRParameter.REPORT_LOCALE, invocation.getInvocationContext().getLocale());

	            byte[] output;
	            JasperPrint jasperPrint;

	            // Fill the report and produce a print object
	            try {
	                JasperReport jasperReport = (JasperReport) JRLoader.loadObject(systemId);
	                
	                
	                /**
	                 * Se modifica para tomar jrdatasource generado por nosotros y no el stackdatasource
	                 */
	                	            
	                jasperPrint =
	                        JasperFillManager.fillReport(jasperReport,
	                                parameters,
	                                jd);
	              
	                
	            } catch (JRException e) {
	                LOG.error("Error building report for uri " + systemId, e);
	                throw new ServletException(e.getMessage(), e);
	            }

	            // Export the print object to the desired output format
	            try {
	                if (contentDisposition != null || documentName != null) {
	                    final StringBuffer tmp = new StringBuffer();
	                    tmp.append((contentDisposition == null) ? "inline" : contentDisposition);

	                    if (documentName != null) {
	                        tmp.append("; filename=");
	                        tmp.append(documentName);
	                        tmp.append(".");
	                        tmp.append(format.toLowerCase());
	                    }

	                    response.setHeader("Content-disposition", tmp.toString());
	                }

	                if (format.equals(FORMAT_PDF)) {
	                    response.setContentType("application/pdf");

	                    // response.setHeader("Content-disposition", "inline; filename=report.pdf");
	                    output = JasperExportManager.exportReportToPdf(jasperPrint);
	                } else {
	                    JRExporter exporter;

	                    if (format.equals(FORMAT_CSV)) {
	                        response.setContentType("text/plain");
	                        exporter = new JRCsvExporter();
	                    } else if (format.equals(FORMAT_HTML)) {
	                        response.setContentType("text/html");

	                        // IMAGES_MAPS seems to be only supported as "backward compatible" from JasperReports 1.1.0

	                        Map imagesMap = new HashMap();

	                        request.getSession(true).setAttribute("IMAGES_MAP", imagesMap);
	                        exporter = new JRHtmlExporter();
	                        exporter.setParameter(JRHtmlExporterParameter.IMAGES_MAP, imagesMap);
	                        exporter.setParameter(JRHtmlExporterParameter.IMAGES_URI, request.getContextPath() + imageServletUrl);
	                        // Needed to support chart images:
	                        exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
	                        request.getSession().setAttribute("net.sf.jasperreports.j2ee.jasper_print", jasperPrint);

	                    } else if (format.equals(FORMAT_XLS)) {
	                        response.setContentType("application/vnd.ms-excel");
	                        exporter = new JRXlsExporter();
	                    } else if (format.equals(FORMAT_XML)) {
	                        response.setContentType("text/xml");
	                        exporter = new JRXmlExporter();
	                    } else if (format.equals(FORMAT_RTF)) {
	                        response.setContentType("application/rtf");
	                        exporter = new JRRtfExporter();
	                    } else {
	                        throw new ServletException("Unknown report format: " + format);
	                    }

	                    output = exportReportToBytes(jasperPrint, exporter);
	                }
	            } catch (JRException e) {
	                String message = "Error producing " + format + " report for uri " + systemId;
	                LOG.error(message, e);
	                throw new ServletException(e.getMessage(), e);
	            }

	            response.setContentLength(output.length);

	            ServletOutputStream ouputStream;

	            try {
	                ouputStream = response.getOutputStream();
	                ouputStream.write(output);
	                ouputStream.flush();
	                ouputStream.close();
	            } catch (IOException e) {
	                LOG.error("Error writing report output", e);
	                throw new ServletException(e.getMessage(), e);
	            }
	        } else {
	            // Code to handle "contype" request from IE
	            try {
	                ServletOutputStream outputStream;
	                response.setContentType("application/pdf");
	                response.setContentLength(0);
	                outputStream = response.getOutputStream();
	                outputStream.close();
	            } catch (IOException e) {
	                LOG.error("Error writing report output", e);
	                throw new ServletException(e.getMessage(), e);
	            }
	        }
	    }
	 /**
	     * Run a Jasper report to CSV format and put the results in a byte array
	     *
	     * @param jasperPrint The Print object to render as CSV
	     * @param exporter    The exporter to use to export the report
	     * @return A CSV formatted report
	     * @throws net.sf.jasperreports.engine.JRException
	     *          If there is a problem running the report
	     */
	    private byte[] exportReportToBytes(JasperPrint jasperPrint, JRExporter exporter) throws JRException {
	        byte[] output;
	        ByteArrayOutputStream baos = new ByteArrayOutputStream();

	        exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
	        exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, baos);
	        if (delimiter != null) {
	            exporter.setParameter(JRCsvExporterParameter.FIELD_DELIMITER, delimiter);
	        }

	        exporter.exportReport();

	        output = baos.toByteArray();

	        return output;
	    }
}
