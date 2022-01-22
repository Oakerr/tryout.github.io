<!--#include file="config.asp"-->
<%
	sub qq_api()
		dim code:code=sdcms.getrnd(10)
		sdcms.setsession "qq_state",code
		dim url:url="https://graph.qq.com/oauth2.0/authorize?response_type=code"
			url=url&"&client_id="&qq_appid
			url=url&"&scope="&qq_scope
			url=url&"&redirect_uri="&qq_callback
			url=url&"&state="&code
		sdcms.go url
	end sub
	qq_api
%>