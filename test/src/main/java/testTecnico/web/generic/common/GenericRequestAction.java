/*
 * $Id: GenericRequestAction.java,v 1.1 2009/11/10 11:45:48 falcalde Exp $
 *
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

package testTecnico.web.generic.common;


import com.opensymphony.xwork2.ActionSupport;

import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.apache.struts2.interceptor.SessionAware;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * <code>Set welcome message.</code>
 */
	
public class GenericRequestAction extends ActionSupport implements SessionAware,RequestAware {
	
	 private Map session;
	 protected Map request;
	 
	
	 
	 public void setSession(Map session) {
		    this.session = session;
		  }
		  
	public Map getSession() {
		    return session;
		  }

	
	
	public void setRequest(Map request) {
		this.request= request;
		
	}
	
	public Map getRequest() {
		return this.request;
		
	}
	

}
