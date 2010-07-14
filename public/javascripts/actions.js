function editNode(id, newVal) {
	if(newVal=='')
	{
		alert("Not a valid value");
	}
	else
	{
		var conf = confirm("Are you surely want to edit the node?");
		if (conf) {
			window.opener.location = window.opener.location;
			window.close();
		}
	}
}
function closeWindow() {
	window.close();
}
function deleteNode(id, viz) {
	window.opener.abc();
	window.close();
}