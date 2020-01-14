package testTecnico.common;

public class FiltrosGrilla {
	private String field="";
	private Object value= new Object();
	private String type="";
	private String comparison="";
	
	
	//Constructor
	
	public FiltrosGrilla(String field, Object value, String type,String comparison) {
		super();
		this.field = field;
		this.value = value;
		this.type = type;
		this.comparison = comparison;
	}


	public FiltrosGrilla() {
		super();
		
	}

	//getters and setters

	public String getField() {
		return field;
	}


	public void setField(String field) {
		this.field = field;
	}


	public Object getValue() {
		return value;
	}


	public void setValue(Object value) {
		this.value = value;
	}


	public String getType() {
		return type;
	}


	public void setType(String type) {
		this.type = type;
	}


	public String getComparison() {
		return comparison;
	}


	public void setComparison(String comparison) {
		this.comparison = comparison;
	}
	
	
	
	
	
}
