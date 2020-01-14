/* funcion del Menu del contenedor*/
function IEHoverPseudo() {

        var navItems = document.getElementById("primary-nav1").getElementsByTagName("li");


        for (var i=0; i<navItems.length; i++) {

            if(navItems[i].className == "menubar") {
            if (navItems[i].parentNode.className=="menuList")
            	{
            	
            	var lword = navItems[i].getElementsByTagName("a")[0].innerHTML.length;
            	if (lword > 11){lword*=6.8;}else {lword*=9;}

            	navItems[i].style.width=lword+"px";


            	};
                navItems[i].onmouseover=function() { this.className += " over"; }
                navItems[i].onmouseout=function() { this.className = "menubar"; }
            }

            else
            {
            if(navItems[i].getElementsByTagName("a")[0].innerHTML=="SALIR"){
            	navItems[i].style.width="50px";}
            }
        }
}


 function handleEnter(event,field){
if (event.keyCode==13){
var i;
    for (i = 0; i < field.form.elements.length; i++)
      if (field.tabIndex == eval(field.form.elements[i].tabIndex)-1)
        break;
    if (field.form.elements[i]!=null)    {
    field.form.elements[i].focus();
    }
}
else
{return false;}
}  

function verifyFields(list,img1,img2,idBasket, form){
var image=img1;
var full='n';
for (i=0;i<list.length;i++)
{
	if (document.getElementById(form).elements[list[i]].value!=''){full='s';break;};
}
  if (full == 's')
	{image=img1;}
	else
	{image=img2;}
	document.getElementById(idBasket).src=image;
}

/* INICIO Focus******/
function PonerFoco(campo){
	/* CAMPO es el nombre del input, por ejmplo */
	if (document.all(campo))
	 {
		 if(document.all(campo).type!="text"){
			document.all(campo).focus();
		 }
		 else{
	        document.all(campo).focus();
	        document.all(campo).select();
		 }
	 
     }
}
/* FINAL Focus******/
/* INICIO ****** Permite ingresar solo numeros al input*/
/* agregando en el evento onkeypress="return numbersonly(event)"*/

/* Tab elemento siguente con MaxLength******/
function doNext(el)
{
if (currentBrowser()=='Firefox'){
if (el.value.length < el.getAttribute('maxlength')-1) return;
}else
{if (el.value.length < el.getAttribute('maxlength')) return;
}

var f = el.form;
var els = f.elements;
var x, nextEl;
for (var i=0, len=els.length; i<len; i++){
x = els[i];
if (el == x && (nextEl = els[i+1])){
if (nextEl.focus) nextEl.focus();
}
}
}
/* Funcion para hacer andar los Checkbox Struts 2******/
function setHiddenCheck(parentCheckBox, hiddenValue)
{
	if (document.getElementById(parentCheckBox).checked){
	document.getElementById(hiddenValue).value = true;}
else
{	
	document.getElementById(hiddenValue).value = false;
}
}


function numbersonly(e){

	var unicode=e.charCode? e.charCode : e.keyCode

	if (currentBrowser()=='Firefox'){
	if ((unicode!=8)&&(unicode!=9)&&(unicode!=46) && !((unicode>36)&&(unicode<41)) )
		{ //if the key isn't the backspace key (which we should allow)

			if (unicode<48||unicode>57 ) //if not a number
					return false //disable key press
		}
	}
	else
	{
	if ((unicode!=8)&&(unicode!=9)){ //if the key isn't the backspace key (which we should allow)
	if (unicode<48||unicode>57) //if not a number
	return false //disable key press
	}
	}
}
function numbersonlyandcoma(e){

	var unicode=e.charCode? e.charCode : e.keyCode

	if (currentBrowser()=='Firefox'){
	if ((unicode!=8)&&(unicode!=9)&&(unicode!=46) && !((unicode>36)&&(unicode<41)) )
		{ //if the key isn't the backspace key (which we should allow)
			if ((unicode !=44) && (unicode<48||unicode>57 )) //if not a number
					return false //disable key press
		}
	}
	else
	{
	if ((unicode !=44) && (unicode!=8)&&(unicode!=9)){ //if the key isn't the backspace key (which we should allow)
	if (unicode<48||unicode>57) //if not a number
	return false //disable key press
	}
	}
}

function numbersonlyandpunto(e){

	var unicode=e.charCode? e.charCode : e.keyCode
	
	if (currentBrowser()=='Firefox'){
	if ((unicode!=8)&&(unicode!=9)&&(e.keyCode!=46) && !((e.keyCode>36)&&(keyCode<41)) )
		{ //if the key isn't the backspace key (which we should allow)
			if ((unicode !=46) && (unicode<48||unicode>57 )) //if not a number
					return false //disable key press
		}
	}
	else
	{
	if ((unicode !=46) && (unicode!=8)&&(unicode!=9)){ //if the key isn't the backspace key (which we should allow)
	if (unicode<48||unicode>57) //if not a number
	return false //disable key press
	}
	}
}

/* FINAL ****** Permite ingresar solo numeros al input*/
function lettersOnly(evt) {
    evt = (evt) ? evt : event;
    var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode :
        ((evt.which) ? evt.which : 0));
    if (charCode>47 && charCode<58) {
        return false;
    }
    return true;
}
function doSubmit(arg,accion)
{
arg.action=accion;
arg.submit();
}

/* INICIO **** Removes leading whitespaces*/
function LTrim( value ) {
	var re = /\s*((\S+\s*)*)/;
	return value.replace(re, "$1");
}
/* FINAL ****** */

/* INICIO **** Removes ending whitespaces*/
function RTrim( value ) {
	var re = /((\s*\S+)*)\s*/;
	return value.replace(re, "$1");
}
/* FINAL ****** */




function limpiarText(tmp){
for (var i=0;i<tmp.length;i++) {
	if (document.all(tmp[i])){
	document.all(tmp[i]).value="";
	}
}
}

function submitEnter(arg,e,accion,div,boton)
{
	var keycode;
	if (window.event)
		keycode = window.event.keyCode;
	else if (e)
		keycode = e.which;
	else
		return true;

	if (keycode == 13)
	   {
	   preDoSubmit(arg,accion,div,boton);
	   return false;
	   }
	else
	   return true;
}
/* INICIO OCULTA DIV del filtro */
function ShowHidefilter(objDiv, objImg){
        if (document.getElementById(objDiv).style.display == 'none')
			{
				document.getElementById(objDiv).style.display = 'block';
				document.getElementById(objImg).src = '../altec/images/filter/boton_expan.gif';
				document.getElementById(objImg).title = 'Ocultar';
			}
		else
			{
				document.getElementById(objDiv).style.display = 'none';
				document.getElementById(objImg).src = '../altec/images/filter/boton_close.gif';
				document.getElementById(objImg).title = 'Mostrar';
			}
}
/* FINAL OCULTA DIV del filtro */
  /* Devuelve el browser activo por el usuario*/
function currentBrowser() {
var agt=navigator.userAgent.toLowerCase();
if (agt.indexOf("opera") != -1) return 'Opera';
if (agt.indexOf("staroffice") != -1) return 'Star Office';
if (agt.indexOf("webtv") != -1) return 'WebTV';
if (agt.indexOf("beonex") != -1) return 'Beonex';
if (agt.indexOf("chimera") != -1) return 'Chimera';
if (agt.indexOf("netpositive") != -1) return 'NetPositive';
if (agt.indexOf("phoenix") != -1) return 'Phoenix';
if (agt.indexOf("firefox") != -1) return 'Firefox';
if (agt.indexOf("safari") != -1) return 'Safari';
if (agt.indexOf("skipstone") != -1) return 'SkipStone';
if (agt.indexOf("msie 7") != -1) return 'IE7';
if (agt.indexOf("msie") != -1) return 'Internet Explorer';
if (agt.indexOf("netscape") != -1) return 'Netscape';
if (agt.indexOf("mozilla/5.0") != -1) return 'Mozilla';
if (agt.indexOf('\/') != -1) {
if (agt.substr(0,agt.indexOf('\/')) != 'mozilla') {
return navigator.userAgent.substr(0,agt.indexOf('\/'));}
else return 'Netscape';} else if (agt.indexOf(' ') != -1)
return navigator.userAgent.substr(0,agt.indexOf(' '));
else return navigator.userAgent;
}

function preDoSubmitSearch(arg,accion,div,boton)
{
			doSubmitProBar(arg,accion,div,boton);
}

function doSubmitProBar(arg,accion,div,boton){
			if (div != '')
			{
				stateProgressBar(div,boton);
			}
			doSubmit(arg,accion);

}

function stateProgressBar(div,boton){

var objDiv = document.all(div);
if (objDiv.style.visibility=="hidden")
	{
		objDiv.style.visibility='visible';
		if (boton!= ''){
		boton.disabled = 'true';}
	}
}

function validationClick(){
	if (submitCounter=="0"){
			return true;
	}
	else{
		return false;
	}
}

function doSubmitNav(form,action,div,boton){
	submitCounter="1";
	stateProgressBar(div,boton);
	doSubmit(form,action);
}


function testSubmits(){
submitCounter+=1;
if (submitCounter>1){return false;}
}




function verifyRequired(fields,fieldNames,form){
var correct='s';
var emptyFields = new Array();
var counter=0;
for (i=0;i<fields.length;i++){
if (RTrim(LTrim(document.getElementById(form).elements[fields[i]].value)) == '')
{
	emptyFields[counter]= fieldNames[i];
	counter++;
	correct='n';
	document.getElementById(form).elements[fields[i]].value='';
}
}
if (correct=='s') {return true;}
else
{
 	if (emptyFields.length>1){
 	var msgBuffer='Los campos '+emptyFields[0];
	for (i=1;i<emptyFields.length;i++)
	{  if (i!=emptyFields.length-1)
			{msgBuffer=msgBuffer+' ,'+emptyFields[i];}
	   else
	   		{msgBuffer=msgBuffer+' o '+emptyFields[i]+' no pueden estar vacíos.';}
	}
	}
	else
	{
	var msgBuffer='El campo '+emptyFields[0]+' no puede estar vacío.';
	}
	alert(msgBuffer);
	return false;
	}

}


function testNulls(formulario, accion, arreglo, msg,btn){
	var condition = verifyRequired(arreglo, msg);
	if (condition){
	preDoSubmit(formulario, accion,btn);
	}
}

function validarDigito( digito , mask )
{
  if(mask == '.') return true;
  if(mask == '9' && digito >='0' && digito <'9' ) return true;
  if(mask == digito ) return true;
  return false;
}

function validarNumero( elemento , mask , lowval, highval ,  msgError)
{
  if( isNaN( elemento.value ) ||
      ( lowval != null && Number(elemento.value) < lowval) ||
      ( highval != null && Number(elemento.value) > highval ) ||
      ( mask != null && !validarMask( elemento.value , mask , false )))
  {
    alert( msgError);
    elemento.focus();
    return false;  
  }
  return true;
}

function validarMask( lstr , mask , startAtBegin )
{
  if( lstr.length > mask.length ) return false;
  
  if( startAtBegin ){
    j=0;
    while( j<lstr.length){
      if( !validarDigito( lstr.charAt(j),mask.charAt(j) ) ){
        return false;
      }
      j++;
    }
    // Recorrer la long luego de terminado el string y verificar que no tenga elementos obligatorios
    while( j<mask.length ){
      if( !validarDigito( '0',mask.charAt(j))){
        return false;
      }
      j++;
    }
  }
  else{
    j=1
    while( (lstr.length-j)>=0){
      if( !validarDigito( lstr.charAt(lstr.length-j),mask.charAt(mask.length-j))){
        return false;
      }
      j++;
    }
    /*
     * Recorrer la long luego de terminado el string y verificar que no tenga elementos obligatorios
     */
    while( (mask.length-j)>=0 ){
      if( !validarDigito( '0',mask.charAt(mask.length-j))){
        return false;
      }
      j++;
    }  
  }
  return true;
}

function preDoSubmit(arg,accion,boton)
{
	document.all(boton).disabled = 'true';
	doSubmit(arg,accion);
}

function viewProgress(div,divwidth,divheigh)
{
   w = screen.availWidth;
   h = screen.availHeight;
   var leftPos = (w-divwidth)/2, topPos = (h-divheigh)/2;
   var objDiv = document.all(div);
   objDiv.style.width=divwidth;
   objDiv.style.heigh=divheigh;
   objDiv.style.visibility='visible';
   objDiv.style.left=leftPos;
   objDiv.style.top=topPos;
}

/*setear campos generico*/
function setValues(l,splitChar,datePresent, HourPresent ){
	for (i=0;i<l.length;i++){
			
		data = l[i].split(splitChar);		
		document.getElementById(data[0]).value=data[1];	
		
	}
	if (datePresent){		
		data=l[l.length-1].split(splitChar);
		dayHour=l[l.length-1].split(" ");
		days=dayHour[0].split(splitChar)[1].split("-");
		
		subDayHour="";
		
		if ((dayHour[1]!=null)&&(HourPresent)) {subDayHour= " "+dayHour[1].substr(0,dayHour[1].length-2);}
		document.getElementById(dayHour[0].split(splitChar)[0]).value=days[2]+'/'+days[1]+'/'+days[0]+subDayHour;
		data=l[l.length-2].split(splitChar);
		dayHour=l[l.length-2].split(" ");
		days=dayHour[0].split(splitChar)[1].split("-");
		if ((dayHour[1]!=null)&&(HourPresent)) {subDayHour= " "+dayHour[1].substr(0,dayHour[1].length-2);}
		document.getElementById(dayHour[0].split(splitChar)[0]).value=days[2]+'/'+days[1]+'/'+days[0]+subDayHour;
		
	}
}	
	

function retrieveSecondOptions(idSourceBoxes,idTargetBoxes,action,paramNames,splitList,splitRegister,splitValues){


	
 	  url=action+"?";
	  for (i=0;i<paramNames.length;i++){
	  firstBox=document.getElementById(idSourceBoxes[i]);
	  url+=paramNames[i]+"="+firstBox.options[firstBox.selectedIndex].value+"&";
	  }
	  url=url.substring(0,url.length-1);
	  url+="&ms="+new Date().getTime();
    //Do the Ajax call
    if (window.XMLHttpRequest){ // Non-IE browsers
      req = new XMLHttpRequest();
      //A call-back function is define so the browser knows which function to call after the server gives a reponse back
      req.onreadystatechange = function(){populateSecondBoxes(idTargetBoxes,splitList,splitRegister,splitValues)};
      try {
      	req.open("GET", url, true); //was get
      } catch (e) {
         alert("Cannot connect to server");
      }
      req.send(null);
    } else if (window.ActiveXObject) { // IE
      req = new ActiveXObject("Microsoft.XMLHTTP");
         if (req) {
        req.onreadystatechange = function(){populateSecondBoxes(idTargetBoxes,splitList,splitRegister,splitValues)};
        req.open("GET", url, true);
        req.send();
      }
    }
  }

  //Callback function
  function populateSecondBoxes(idTargetBoxes,splitList,splitRegister,splitValues){
//alert(req.readyState);
//alert(req.status);*/
    if (req.readyState == 4) { // Complete
      if (req.status == 200) { // OK response
         textToSplit = req.responseText
         if(textToSplit == '803'){
			alert("No select option available on the server")
		  }
          //Split the document
/*		  returnGroupElements=textToSplit.split("?");
	      returnElements0=returnGroupElements[0].split(splitRegister);
	      returnElements1=returnGroupElements[1].split(splitRegister);*/

          //Process each of the elements
          for (k=0;k<idTargetBoxes.length;k++){
		document.getElementById(idTargetBoxes[k]).options.length = 0;
		}
		destinos=textToSplit.split(splitList);
		for (j=0;j<destinos.length;j++){
		if (destinos[j]!=""){
		registros = destinos[j].split(splitRegister);
         for ( var i=0; i<registros.length; i++ ){
             valueLabelPair = registros[i].split(splitValues);
             document.getElementById(idTargetBoxes[j]).options[i] = new Option(valueLabelPair[0], valueLabelPair[1]);
          }
		}
		}
	}
      } else {
           // alert("Bad response by the server");
        }
        
    }

function verifyNumber(idText){
	textField=idText;

		symbol="";
		value= textField.value.split('.');
		number=value[0].split('');
		decimals=value[1];
		if (decimals==null){decimals="00";}
		if (decimals.length==0){decimals="00";}
		if (decimals.length==1){decimals="0"+decimals;}
		counter = 0;
		shadowValue="";
		if (number[0]=="-"){charLimit=1;}else{charLimit=0;}
		for(i=number.length-1;i>=charLimit;i--)
		{
			counter++;
			shadowValue=number[i]+shadowValue;
			if ((counter==3)&&(i>=charLimit+1)){shadowValue=","+shadowValue;counter=0;}
		}
		if (shadowValue.length==0){shadowValue='0';}
		if (charLimit==1){symbol="-";}
		textField.value=symbol+"$"+shadowValue+"."+decimals;
	}
	
	function formatToCurrency(valor){
		symbol="";
		value= valor.split('.');
		number=value[0].split('');
		decimals=value[1];
		if (decimals==null){decimals="00";}
		if (decimals.length==0){decimals="00";}
		if (decimals.length==1){decimals="0"+decimals;}
		counter = 0;
		shadowValue="";
		if (number[0]=="-"){charLimit=1;}else{charLimit=0;}
		for(i=number.length-1;i>=charLimit;i--)
		{
			counter++;
			shadowValue=number[i]+shadowValue;
			if ((counter==3)&&(i>=charLimit+1)){shadowValue=","+shadowValue;counter=0;}
		}
		if (shadowValue.length==0){shadowValue='0';}
		if (charLimit==1){symbol="-";}
		xvalue="$"+symbol+shadowValue+"."+decimals;
		return xvalue;
	}
	
	
	
function getNoneFormat(number,miles,decimales)
	{	
		
		number=number.split("$").join("");
		number=number.replace("$","").split(miles).join("");
		splitted=number.split("");
		if (splitted[0]=="-")
		{
		s=splitted[0];
		number=number.replace("-","");}
		else
		{s="";}
		units=number.split(decimales)[0];
		dec = number.split(decimales)[1];
		if (dec==null)
		{dec="00";}
		else if (dec.length==1)
		{dec+="0";}
		return s+units+"."+dec;
	}

function verifyExtensions(form,extensiones){

var fileText = form.file.value;
var correct='n';

for (i=0;i<extensiones.length;i++){
if ((fileText.substr(fileText.length-3,fileText.length).toLowerCase()==extensiones[i]))
{
	if (fileText!=''){ correct='s';}
}
}
if (correct=='n'){
  if (fileText!=''){
	var msgBuffer='Debe seleccionar archivos '+extensiones[0];
	for (i=1;i<extensiones.length;i++)
	{  if (i!=extensiones.length-1)
			{msgBuffer=msgBuffer+' ,.'+extensiones[i];}
	   else
	   		{msgBuffer=msgBuffer+' o .'+extensiones[i]+' solamente.';}
	}
	alert(msgBuffer);
	form.file.value='';
}
}
}


function testAll(a){
	   var c = 0;
	   for (i=0;i<a.length;i++){

	   if (a[i].isValid()){c++;} else {break;}
	   }
	   return c==a.length;    }

function setAllFields(a,b){
	   for (i=0;i<a.length;i++){
	       a[i].addListener('valid',function(){if (testAll(a)){b.enable();} else {b.disable();}});
	      a[i].addListener('invalid',function(){b.disable();});
	       }
	} 