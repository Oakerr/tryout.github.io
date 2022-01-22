<!--#include file="base.asp"-->
<%
''' SDCMS 登录
''' ==================================================================
''' 版权所有 http://www.sdcms.cn
''' ------------------------------------------------------------------
''' 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和使用；
''' 未经授权不允许对程序代码以任何形式任何目的的再发布。
''' ==================================================================
''' 编写: IT平民
''' 修改：IT平民 in 2014.07
	
	'是否启用验证码
	const verify_code=true

	sub check()
		dim t0,t1,t2,t3
		t0=sdcms.enhtml(sdcms.fpost("t0",0))
		t1=sdcms.enhtml(sdcms.fpost("t1",0))
		t2=sdcms.enhtml(sdcms.fpost("t2",0))
		t3=sdcms.loadsession("imgcode")
		if sdcms.strlen(t0)=0 then sdcms.ajaxjson "&#29992;&#25143;&#21517;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		if sdcms.strlen(t1)=0 then sdcms.ajaxjson "&#23494;&#30721;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		if verify_code then
		if sdcms.strlen(t2)=0 then sdcms.ajaxjson "&#39564;&#35777;&#30721;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		if sdcms.strlen(t3)=0 then sdcms.ajaxjson "&#26080;&#27861;&#33719;&#21462;&#31995;&#32479;&#39564;&#35777;&#30721;",0:exit sub
		if t2<>t3 then sdcms.ajaxjson "&#39564;&#35777;&#30721;&#19981;&#27491;&#30830;",0:exit sub
		end if
		if not(sdcms.checkpost) then
			sdcms.ajaxjson "&#31105;&#27490;&#22806;&#37096;&#25552;&#20132;&#25968;&#25454;",0:exit sub
		end if
		dim data
		data=sdcms.db.dbload(1,"adminid,logintimes,islock,groupid,penname,adminname,adminpass","sd_admin","adminname='"&t0&"' and adminpass='"&md5(t1)&"'","")
		if ubound(data)<0 then
			sdcms.ajaxjson "&#29992;&#25143;&#21517;&#25110;&#23494;&#30721;&#38169;&#35823;",0:exit sub
		else
			if data(2,0)=0 then
				sdcms.ajaxjson "&#29992;&#25143;&#34987;&#38145;&#23450;&#65292;&#19981;&#33021;&#30331;&#24405;",0
			else
				dim datanew
				datanew=array(array("logintimes",data(1,0)+1,0,0),array("lastlogindate",sqltime,0,0),array("lastloginip",sdcms.getip,17,1))
				sdcms.db.dbupdate "sd_admin","adminid="&data(0,0)&"",datanew
				sdcms.setsession "adminid",data(0,0)
				sdcms.setsession "adminname",t0
				sdcms.setsession "admingroupid",data(3,0)
				sdcms.setcookie "adminid",data(0,0)
				sdcms.setsession "penname",data(4,0)
				dim key:key=sdcms.getkey()
				sdcms.setcookie "adminid",data(0,0)
				sdcms.setcookie "loginkey",key
				sdcms.setcookie "loginpwd",md5(data(5,0)&data(6,0)&key)
				sdcms.ajaxjson "&#30331;&#24405;&#25104;&#21151;",1
			end if
		end if
		data=""
	end sub
	
	sub out()
		sdcms.setsession "adminid",""
		sdcms.setsession "adminname",""
		sdcms.setsession "penname",""
		sdcms.setsession "admingroupid",""
		sdcms.setcookie "adminid",empty
		sdcms.setcookie "loginkey",empty
		sdcms.setcookie "loginpwd",empty
		sdcms.go "login.asp"
	end sub
	
	dim act:act=lcase(sdcms.fget("act",0))
	select case act
		case "check":check
		case "out":out
		case else
		if sdcms.loadsession("adminid")<>"" then sdcms.go "./"
		dim t:t=sdcms.getint(sdcms.fget("t",0),0)
		dim s:s=sdcms.strlen(sdcms.getsys("qq.login"))
		load theme_login
	end select
	sdcms.db.dbclose
%>