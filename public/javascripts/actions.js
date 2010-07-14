function selectAction(action,str)
{

	if(action=='add')
	{
		document.action = 'add';
		document.newPath = str;
	}
	else if(action =='edit')
	{
		document.action = 'edit';
//		alert('edit call');
	//	alert(window.opener.callMe());
		//window.opener.this.Hypertree.performAction();
	
	}
	else if(action == 'remove')
	{
		document.action = 'remove';
		
	}
	else if(action == 'centre')
	{
		document.action = 'centre';	
	}
}