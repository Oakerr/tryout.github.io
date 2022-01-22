﻿<!--#include file="base.asp"-->
<%
''' SDCMS 内链
''' ==================================================================
''' 版权所有 http://www.sdcms.cn
''' ------------------------------------------------------------------
''' 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和使用；
''' 未经授权不允许对程序代码以任何形式任何目的的再发布。
''' ==================================================================
''' 编写: IT平民
''' 修改：IT平民 in 2014.07

	sub adddb()
		dim t0,t1,t2,t3,t4,t5,t6
		t0=sdcms.enhtml(sdcms.fpost("t0",0))
		t1=sdcms.enhtml(sdcms.fpost("t1",0))
		t2=sdcms.enhtml(sdcms.fpost("t2",0))
		t3=sdcms.getint(sdcms.fpost("t3",0),0)
		t4=sdcms.getint(sdcms.fpost("t4",0),0)
		t5=sdcms.getint(sdcms.fpost("t5",0),0)
		t6=sdcms.getint(sdcms.fpost("t6",0),0)
		if sdcms.strlen(t0)=0 then sdcms.ajaxjson "&#38142;&#25509;&#21517;&#31216;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		if sdcms.strlen(t2)=0 then sdcms.ajaxjson "&#38142;&#25509;&#32593;&#22336;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		dim data:data=array(array("title",t0,50),array("intro",t1,255),array("siteurl",t2,255),array("replacenum",t3,255),array("ordnum",t4,10),array("linktype",t5,10),array("islock",t6,10))
		if sdcms.db.dbnew("sd_expand_sitelink",data,"title='"&t0&"'")=0 then
			sdcms.ajaxjson "&#38142;&#25509;&#21517;&#31216;&#24050;&#23384;&#22312;&#65292;&#35831;&#25442;&#20010;&#35797;&#35797;",0
		else
			sdcms.ajaxjson "保存成功",1
		end if
	end sub
	
	sub editdb()
		dim t0,t1,t2,t3,t4,t5,t6
		t0=sdcms.enhtml(sdcms.fpost("t0",0))
		t1=sdcms.enhtml(sdcms.fpost("t1",0))
		t2=sdcms.enhtml(sdcms.fpost("t2",0))
		t3=sdcms.getint(sdcms.fpost("t3",0),0)
		t4=sdcms.getint(sdcms.fpost("t4",0),0)
		t5=sdcms.getint(sdcms.fpost("t5",0),0)
		t6=sdcms.getint(sdcms.fpost("t6",0),0)
		if sdcms.strlen(t0)=0 then sdcms.ajaxjson "&#38142;&#25509;&#21517;&#31216;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		if sdcms.strlen(t2)=0 then sdcms.ajaxjson "&#38142;&#25509;&#32593;&#22336;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		dim data,id
		id=sdcms.getint(sdcms.fget("id",0),0)
		data=array(array("title",t0,50,1),array("intro",t1,255,1),array("siteurl",t2,255,1),array("replacenum",t3,255,0),array("ordnum",t4,10,0),array("linktype",t5,10,0),array("islock",t6,10,0))
		if sdcms.db.dbupdate("sd_expand_sitelink","id="&id&"",data)=1 then
			sdcms.ajaxjson "保存成功",1
		end if
	end sub
	
	sub deldb()
		dim id:id=sdcms.getint(sdcms.fget("id",0),0)
		sdcms.db.dbdel "sd_expand_sitelink","id="&id
		sdcms.echo "1"
	end sub
	
	sub doset()
		dim id:id=sdcms.enhtml(sdcms.fget("id",0))
		dim go:go=sdcms.enhtml(sdcms.fget("go",0))
		dim idarr:idarr=split(id,",")
		if ubound(idarr)<0 then
			sdcms.echo "0&#33267;&#23569;&#36873;&#25321;&#19968;&#26465;&#20449;&#24687;"
		else
			dim i
			for i=0 to ubound(idarr)
				if not isnumeric(idarr(i)) then
					sdcms.echo "0&#21442;&#25968;&#65306;"&idarr(i)&"&#19981;&#27491;&#30830;&#65292;&#35831;&#30830;&#35748;&#21518;&#20877;&#25805;&#20316;"
					exit sub
				end if
			next
			dim filed,result
			select case go
				case "islock":filed="islock":result=0
				case "nolock":filed="islock":result=1
				case else:sdcms.echo "0&#21442;&#25968;&#38169;&#35823;":exit sub
			end select
			sdcms.db.dbupdate "sd_expand_sitelink","id in("&id&")",array(array(filed,result,2,0))
			sdcms.echo "1"
		end if
	end sub
	
	sub delsome()
		dim id:id=sdcms.enhtml(sdcms.fget("id",0))
		dim idarr:idarr=split(id,",")
		if ubound(idarr)<0 then
			sdcms.echo "0&#33267;&#23569;&#36873;&#25321;&#19968;&#26465;&#20449;&#24687;"
		else
			dim i
			for i=0 to ubound(idarr)
				if not isnumeric(idarr(i)) then
					sdcms.echo "0&#21442;&#25968;&#65306;"&idarr(i)&"&#19981;&#27491;&#30830;&#65292;&#35831;&#30830;&#35748;&#21518;&#20877;&#25805;&#20316;"
					exit sub
				else
					sdcms.db.dbdel "sd_expand_sitelink","id="&idarr(i)&""
				end if
			next
			sdcms.echo "1"
		end if
	end sub
	
	sub recache()
		sdcms.delcache "sitelink"
	end sub
	
	islogin
	checkpagelever 39
	dim act:act=lcase(sdcms.fget("act",0))
	dim sqlwhere,nattitle,nat
	nat=sdcms.getint(sdcms.fget("nat",0),0)
	select case act
		case "add":load eval("theme_expand_sitelink_"&act)
		case "adddb":adddb:recache
		case "edit"
			dim datadb,id
			id=sdcms.getint(sdcms.fget("id",0),0)
			datadb=sdcms.db.dbload("","title,intro,siteurl,replacenum,ordnum,linktype,islock","sd_expand_sitelink","id="&id&"","")
			load eval("theme_expand_sitelink_"&act)
		case "editdb":editdb:recache
		case "del":deldb:recache
		case "doset":doset:recache
		case "delsome":delsome:recache
		case else
			select case nat
				case "1":sqlwhere=" and islock=0":nattitle="性质:未审"
				case "2":sqlwhere=" and islock=1":nattitle="性质:已审"
				case else:nattitle="按性质↓"
			end select
			load theme_expand_sitelink
	end select
	sdcms.db.dbclose
%>