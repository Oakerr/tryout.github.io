<script language="jscript" runat="server">
function toobject(json)
{
	eval("var o="+json);return o;
}
function viewobject(obj,name,i){  
    var msg="";
    for(var a in obj){
        for(var x in obj[a]){
           if(name==x&&a==i)
		   {
			   msg=obj[a][x];
		   }
        }
    }
    return msg;
}
</script>