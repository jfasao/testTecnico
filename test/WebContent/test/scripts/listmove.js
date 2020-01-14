
function add2list(sourceID,targetID){
  source=document.all(sourceID);
  target=document.all(targetID);
  numberOfItems=source.options.length;
  insertPt=target.options.length; // insert at end
  for (i=0;i<numberOfItems;i++){
    if(source.options[i].selected==true && picked[i]!=true){

    var addIndex = source.selectedIndex;
   if(addIndex < 0)
      return;
   target.appendChild( 
      source.options.item(addIndex));
    msg=source.options[i].text;
    //target.options[insertPt]=new Option(msg);
    //picked[i]=true;insertPt=target.options.length;
    }
  }
  setSize(document.all(sourceID),document.all(targetID));
}

function insert(theSel, newOpt)
{

  if (theSel.length == 0) {

    theSel.options[0] = newOpt;
    
  } else  {
  
      theSel.options[theSel.length] = newOpt;
      
    }
  }





function removeandinsert(fuente,destino)
{
  var selIndex = fuente.selectedIndex;
  if (selIndex != -1) {
    for(i=fuente.length-1; i>=0; i--)
    {
      if(fuente.options[i].selected)
      {
      	var newOpt = new Option();
        newOpt=fuente.options[i];
        fuente.options[i] = null;
        insert(destino,newOpt);    
      }
    }
    if (fuente.length > 0) {
      fuente.selectedIndex = selIndex == 0 ? 0 : selIndex - 1;
    }
    
    
  }
  SelectSort(destino);
}

function removeSelectedRows(SS1){
	for (i=SS1.options.length-1; i>=0; i--)
    {
        if (SS1.options[i].selected == true)
        {	
           SS1.options[i]=null;
        }
    }
}

function SelectMoveRows(SS1,SS2)
{
    var SelID='';
    var SelText='';
    // Move rows from SS1 to SS2 from bottom to top
    for (i=0; i<=SS1.options.length -1; i++)
    {

        if (SS1.options[i].selected == true)
        {	
          if (exists(SS1.options[i].value,SS2)==false){ 
            SelID=SS1.options[i].value;
            SelText=SS1.options[i].text;
            var newRow = new Option(SelText,SelID);
            SS2.options[SS2.length]=newRow;
            SS1.options[i]=null;
       }
        }
    }
    SelectSort(SS2);
}

	function exists(item,list)
	{
	var result=false;
		if (list.options.length>=0){
		for (j=list.options.length-1; j>=0; j--) {	
	    	if (list.options[j].value==item)	{
	    		result=true;
		    	break;
		    }
	    }
	    }
	return result;    
	}

function SelectSort(SelList)
{
    var ID='';
    var Text='';
    for (x=0; x < SelList.length - 1; x++)
    {
        for (y=x + 1; y < SelList.length; y++)
        {
            if (SelList[x].text > SelList[y].text)
            {
                // Swap rows
                ID=SelList[x].value;
                Text=SelList[x].text;
                SelList[x].value=SelList[y].value;
                SelList[x].text=SelList[y].text;
                SelList[y].value=ID;
                SelList[y].text=Text;
            }
        }
    }
}

function selectAll(list){

	lista=document.all(list);

	if (lista.options.length>0){
	for (i=0; i<lista.options.length; i++){
		lista.options[i].selected=true;
		
	}
	}
	
}



