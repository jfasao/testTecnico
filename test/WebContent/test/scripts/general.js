/*Inplementa un método al Array para verificar si un elemento se encuentra contenido*/
Array.prototype.inArray = function(search_term) {
  var i = this.length;
  if (i > 0) {
	 do {
		if (this[i] === search_term) {
		   return true;
		}
	 } while (i--);
  }
  return false;
}


/*this is a general purpose function that keeps you from having to type 'document.getElementById'.. saves time and typing. I use it's like EVERYWHERE*/
function el(inID) {
  return(document.getElementById(inID));
}

/*Crea un elemento (inElementID) del tipo inElementType, 
y se lo agrega al padre (inParentID). 
Luego lo retorna para poder setear su innerHTML, style u otros atributos.  
*/
function addElement(inElementType, inElementID, inParentID) {
  newEl = document.createElement(inElementType);
  newEl.setAttribute('id', inElementID);
  el(inParentID).appendChild(newEl);
  return(newEl);
}

/*Elimina un elemento de la pagina (inID)*/
function removeElement(inID) {
  oldEl = el(inID);
  parentEl = oldEl.parentNode;
  return(parentEl.removeChild(oldEl));
}