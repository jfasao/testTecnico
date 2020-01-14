package testTecnico.common;
// default package


public class LoginIntentos  implements java.io.Serializable {

  
	private static final long serialVersionUID = -7414559581299077851L;
	/**
	 * 
	 */		
	 private String user = "";
     private Integer Intentos = 0;
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public Integer getIntentos() {
		return Intentos;
	}
	public void setIntentos(Integer intentos) {
		Intentos = intentos;
	}
	public LoginIntentos() {
		super();
		// TODO Auto-generated constructor stub
	}
	public LoginIntentos(String user, Integer intentos) {
		super();
		this.user = user;
		Intentos = intentos;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((user == null) ? 0 : user.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		final LoginIntentos other = (LoginIntentos) obj;
		if (user == null) {
			if (other.user != null)
				return false;
		} else if (!user.equals(other.user))
			return false;
		return true;
	}
     
     
    
}