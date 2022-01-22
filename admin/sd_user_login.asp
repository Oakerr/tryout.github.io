﻿<!--#include file="base.asp"-->
<%
''' SDCMS 快捷登录
''' ==================================================================
''' 版权所有 http://www.sdcms.cn
''' ------------------------------------------------------------------
''' 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和使用；
''' 未经授权不允许对程序代码以任何形式任何目的的再发布。
''' ==================================================================
''' 编写: IT平民
''' 修改：IT平民 in 2014.07

	sub installdb()
		dim config:config=sdcms.enhtml(sdcms.fget("config",0))
		if sdcms.strlen(config)<=0 then
			sdcms.echo "0参数错误"
			exit sub
		end if
		dim data:data=array(array("setname","sdcms.api.login",0),array("setkey",""&config&"",0),array("setvalue","array("""","""","""")",0))
		if sdcms.db.dbnew("sd_config",data,"setname='sdcms.api.login' and setkey='"&config&"'")=0 then
			sdcms.echo "0应用已存在，请勿重复安装"
			exit sub
		else
			sdcms.echo "1应用安装成功，请配置相关参数！"
			sdcms.delcache "sdcmsdata"
		end if
	end sub
	
	sub uninstalldb()
		dim config:config=sdcms.enhtml(sdcms.fget("config",0))
		if sdcms.strlen(config)<=0 then
			sdcms.echo "0参数错误"
			exit sub
		end if
		sdcms.db.dbdel "sd_config","setname='sdcms.api.login' and setkey='"&config&"'"
		sdcms.echo "1应用卸载成功"
		sdcms.delcache "sdcmsdata"
	end sub
	
	sub setdb()
		dim t0,t1,id,apiname
		t0=sdcms.enhtml(sdcms.fpost("t0",0))
		t1=sdcms.enhtml(sdcms.fpost("t1",0))
		id=sdcms.enhtml(sdcms.fget("id",0))
		apiname=sdcms.enhtml(sdcms.fget("apiname",0))
		if sdcms.strlen(t0)=0 or sdcms.strlen(t1)=0 then sdcms.ajaxjson "&#21442;&#25968;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		sdcms.db.dbupdate "sd_config","setname='sdcms.api.login' and setkey='"&id&"'",array(array("setvalue","array("""&apiname&""","""&t0&""","""&t1&""")",0,1))
		sdcms.delcache "sdcmsdata"
		sdcms.ajaxjson "保存成功",1
	end sub
	
	islogin
	checkpagelever 47
	dim act:act=lcase(sdcms.fget("act",0))
	select case act
		case "install":installdb
		case "uninstall":uninstalldb
		case "set"
			dim id:id=sdcms.fget("id",0)
			dim apiname:apiname=sdcms.fget("apiname",0)
			dim apidb:apidb=eval(sdcms.getsys(id))
			load theme_user_login_set
		case "setdb":setdb
		case else:load theme_user_login
	end select
	
	sdcms.db.dbclose
%>