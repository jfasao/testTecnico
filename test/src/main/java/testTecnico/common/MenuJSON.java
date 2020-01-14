package testTecnico.common;

import java.util.List;

	public class MenuJSON {
	    private String id;
	    private String text;
	    private boolean leaf;
	    private String cls;
	    private String href;
	    private List<MenuJSON> children;
		
	    
		public MenuJSON(String id, String text, boolean leaf, String cls,
				String href, List<MenuJSON> children) {
			super();
			this.id = id;
			this.text = text;
			this.leaf = leaf;
			this.cls = cls;
			this.href = href;
			this.children = children;
		}
		public String getId() {
			return id;
		}
		public void setId(String id) {
			this.id = id;
		}
		public String getText() {
			return text;
		}
		public void setText(String text) {
			this.text = text;
		}
		public boolean isLeaf() {
			return leaf;
		}
		public void setLeaf(boolean leaf) {
			this.leaf = leaf;
		}
		public String getCls() {
			return cls;
		}
		public void setCls(String cls) {
			this.cls = cls;
		}
		public List<MenuJSON> getChildren() {
			return children;
		}
		public void setChildren(List<MenuJSON> children) {
			this.children = children;
		}
		public String getHref() {
			return href;
		}
		public void setHref(String href) {
			this.href = href;
		}
	}

