package testTecnico.common;

import java.util.List;

public class GrillaExt {
	private Integer limit=13;
	private Integer start=0;
	private String order="";
	private String dir="DESC";
	private String whereAdd = "";
	
	
	
	public String getWhereAdd() {
		return whereAdd;
	}
	public void setWhereAdd(String whereAdd) {
		this.whereAdd = whereAdd;
	}
	private List<FiltrosGrilla> filtrosGrilla;
	
	
	public Integer getLimit() {
		return limit;
	}
	public void setLimit(Integer limit) {
		this.limit = limit;
	}
	public Integer getStart() {
		return start;
	}
	public void setStart(Integer start) {
		this.start = start;
	}
	public String getOrder() {
		return order;
	}
	public void setOrder(String order) {
		this.order = order;
	}
	public String getDir() {
		return dir;
	}
	public void setDir(String dir) {
		this.dir = dir;
	}
	public List<FiltrosGrilla> getFiltrosGrilla() {
		return filtrosGrilla;
	}
	public void setFiltrosGrilla(List<FiltrosGrilla> filtrosGrilla) {
		this.filtrosGrilla = filtrosGrilla;
	}
	public GrillaExt(String dir, List<FiltrosGrilla> filtrosGrilla,
			Integer limit, String order, Integer start) {
		super();
		this.dir = dir;
		this.filtrosGrilla = filtrosGrilla;
		this.limit = limit;
		this.order = order;
		this.start = start;
	}
	public GrillaExt() {
		super();
		// TODO Auto-generated constructor stub
	}
	

	
	
	
}
