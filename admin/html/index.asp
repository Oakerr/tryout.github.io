<!--#include file="config.asp"-->
<%
	if not(checkloginstaus) then
		sdcms.echo "0登录失败"
		sdcms.die
	end if
	if webmode<3 then
		sdcms.echo "0系统未开启静态模式"
		sdcms.die
	end if
	thisurl=""
	dim filename:filename="index"
	if page>1 then filename=filename&"_"&page
	htmlshow theme_index,webroot,filename,""
	sdcms.db.dbclose
%>