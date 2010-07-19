function selectAction(action,str)
{

	if(action=='add')
	{
		document.action = 'add';
		document.newPath = str;
		document.getElementById("add").style.background = 'red';
		document.getElementById("edit").style.background = 'white';
		document.getElementById("remove").style.background = 'white';
		document.getElementById("centre").style.background = 'white';
	}
	else if(action =='edit')
	{
		document.action = 'edit';
//		alert('edit call');
	//	alert(window.opener.callMe());
		//window.opener.this.Hypertree.performAction();
		document.getElementById("edit").style.background = 'red';
		document.getElementById("add").style.background = 'white';
		document.getElementById("remove").style.background = 'white';
		document.getElementById("centre").style.background = 'white';
	
	}
	else if(action == 'remove')
	{
		document.action = 'remove';
		document.getElementById("remove").style.background = 'red';
		document.getElementById("edit").style.background = 'white';
		document.getElementById("add").style.background = 'white';
		document.getElementById("centre").style.background = 'white';
		
	}
	else if(action == 'centre')
	{
		document.action = 'centre';	
		document.getElementById("centre").style.background = 'red';
		document.getElementById("edit").style.background = 'white';
		document.getElementById("remove").style.background = 'white';
		document.getElementById("add").style.background = 'white';
	}
}