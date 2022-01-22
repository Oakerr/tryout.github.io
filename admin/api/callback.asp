<!--#include file="config.asp"-->
<%	
	sub callback()
		dim states:states=sdcms.enhtml(sdcms.fget("state",0))
		dim code:code=sdcms.enhtml(sdcms.fget("code",0))
		dim t0:t0=sdcms.enhtml(sdcms.loadsession("qq_state"))
		if t0="" then
			sdcms.go "../login.asp?t=1"
			exit sub
		end if
		if sdcms.strlen(states)=0 or sdcms.strlen(code)=0 then
			sdcms.go "../login.asp?t=1"
			exit sub
		end if
		if states<>t0 then
			sdcms.go "../login.asp?t=1"
			exit sub
		else
			dim url:url="https://graph.qq.com/oauth2.0/token?grant_type=authorization_code"
				url=url&"&client_id="&qq_appid
				url=url&"&client_secret="&qq_appkey
				url=url&"&redirect_uri="&qq_callback
				url=url&"&code="&code
			dim str:str=sdcms.gethttp(url,"")
			if instr(str,"callback")>0 then
				str=replace(str,"callback( ","")
				str=replace(str," )","")
				dim json
				set json=toobject(str)
					sdcms.echo "错误编号："&sdcms.enhtml(json.error)&"<br>"
					sdcms.echo "错误原因："&sdcms.enhtml(json.error_description)&"<br>"
				set json=nothing
				exit sub
			end if
			if left(str,13)="access_token=" then
				dim access_token:access_token=mid(str,14,instr(str,"&")-14)
				sdcms.setsession "access_token",sdcms.enhtml(access_token)
			else
				sdcms.echo "未知错误"
				exit sub
			end if
		end if
	end sub
	
	sub get_openid()
		dim url:url="https://graph.qq.com/oauth2.0/me?access_token="&sdcms.loadsession("access_token")
		dim str:str=sdcms.gethttp(url,"")
		dim gourl:gourl=sdcms.loadsession("api_backurl")
		if instr(str,"callback")>0 then
			str=replace(str,"callback( ","")
			str=replace(str," )","")
			dim json
			set json=toobject(str)
			dim openid:openid=sdcms.enhtml(json.openid)
			set json=nothing
			dim data
			dim adminid:adminid=sdcms.loadsession("adminid")
			if sdcms.strlen(adminid)>0 then
				data=sdcms.db.dbload(1,"openid","sd_admin","adminid="&adminid&"","")
				if ubound(data)>=0 then
					if sdcms.strlen(data(0,0))=0 then
						sdcms.db.dbupdate "sd_admin","adminid="&adminid&"",array(array("openid",openid,255,1))
					end if
				end if
				sdcms.backurl "\u7ed1\u5b9a\u6210\u529f","../"
				exit sub
			end if
			data=sdcms.db.dbload(1,"adminid,adminname,adminpass,logintimes,islock,groupid","sd_admin","openid='"&openid&"'","")
			if ubound(data)<0 then
				sdcms.go "../login.asp?t=1"
				exit sub
			else
				if data(4,0)=0 then
					sdcms.echo "&#29992;&#25143;&#34987;&#38145;&#23450;&#65292;&#19981;&#33021;&#30331;&#24405;"
				else
					dim datanew
					datanew=array(array("logintimes",data(3,0)+1,0,0),array("lastlogindate",sqltime,0,0),array("lastloginip",sdcms.getip,17,1))
					sdcms.db.dbupdate "sd_admin","adminid="&data(0,0)&"",datanew
					sdcms.setsession "adminid",data(0,0)
					sdcms.setsession "adminname",data(1,0)
					sdcms.setsession "admingroupid",data(5,0)
					sdcms.setcookie "adminid",data(0,0)
					dim key:key=sdcms.getkey()
					sdcms.setcookie "adminid",data(0,0)
					sdcms.setcookie "loginkey",key
					sdcms.setcookie "loginpwd",md5(data(1,0)&data(2,0)&key)
				end if
				sdcms.setsession "qq_state",""
				sdcms.setsession "access_token",""
				sdcms.go "../"
			end if
		else
			sdcms.echo "无法获取数据，登录失败"
			exit sub
		end if
	end sub

	callback()
	get_openid()
%>