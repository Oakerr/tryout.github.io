﻿<!--#include file="base.asp"-->
<%
''' SDCMS Tags
''' ==================================================================
''' 版权所有 http://www.sdcms.cn
''' ------------------------------------------------------------------
''' 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和使用；
''' 未经授权不允许对程序代码以任何形式任何目的的再发布。
''' ==================================================================
''' 编写: IT平民
''' 修改：IT平民 in 2014.07

	sub adddb()
		dim t0,t1,t2
		dim s0,s1,s2,style
		t0=sdcms.enhtml(sdcms.fpost("t0",0))
		t1=sdcms.getint(sdcms.fpost("t1",0),0)
		t2=sdcms.getint(sdcms.fpost("t2",0),0)
		s0=sdcms.enhtml(sdcms.fpost("c0",0))
		s1=sdcms.enhtml(sdcms.fpost("c1",0))
		s2=left(sdcms.enhtml(sdcms.fpost("s2",0)),7)
		if sdcms.strlen(s2)>0 then s2="color:"&s2
		style=s0&s1&s2
		if sdcms.strlen(style)>0 then style="style="""&style&""""
		if sdcms.strlen(t0)=0 then sdcms.ajaxjson "&#20851;&#38190;&#23383;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		dim data:data=array(array("title",t0,52),array("hits",t1,10),array("style",style,0))
		if sdcms.db.dbnew("sd_expand_tags",data,"title='"&t0&"'")=0 then
			sdcms.ajaxjson "&#21517;&#31216;&#24050;&#23384;&#22312;&#65292;&#35831;&#25442;&#20010;&#35797;&#35797;",0
		else
			sdcms.ajaxjson "保存成功",1
		end if
	end sub
	
	sub editdb()
		dim t0,t1,t2
		dim s0,s1,s2,style
		t0=sdcms.enhtml(sdcms.fpost("t0",0))
		t1=sdcms.getint(sdcms.fpost("t1",0),0)
		t2=sdcms.getint(sdcms.fpost("t2",0),0)
		s0=sdcms.enhtml(sdcms.fpost("c0",0))
		s1=sdcms.enhtml(sdcms.fpost("c1",0))
		s2=left(sdcms.enhtml(sdcms.fpost("s2",0)),7)
		if sdcms.strlen(s2)>0 then s2="color:"&s2
		style=s0&s1&s2
		if sdcms.strlen(style)>0 then style="style="""&style&""""
		if sdcms.strlen(t0)=0 then sdcms.ajaxjson "&#20851;&#38190;&#23383;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		dim data,id
		id=sdcms.getint(sdcms.fget("id",0),0)
		data=array(array("title",t0,50,1),array("hits",t1,10,0),array("style",style,0,1))
		if sdcms.db.dbupdate("sd_expand_tags","id="&id&"",data)=1 then
			sdcms.ajaxjson "保存成功",1
		end if
	end sub
	
	sub deldb()
		dim id:id=sdcms.getint(sdcms.fget("id",0),0)
		sdcms.db.dbdel "sd_expand_tags","id="&id
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
			sdcms.db.dbupdate "sd_expand_tags","id in("&id&")",array(array(filed,result,2,0))
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
					sdcms.db.dbdel "sd_expand_tags","id="&idarr(i)&""
				end if
			next
			sdcms.echo "1"
		end if
	end sub
	
	islogin
	checkpagelever 38
	dim act:act=lcase(sdcms.fget("act",0))
	dim ordtitle,ord,orderwhere
	ord=sdcms.getint(sdcms.fget("ord",0),0)
	select case act
		case "add":load eval("theme_expand_tags_"&act)
		case "adddb":adddb
		case "edit"
			dim datadb,id
			id=sdcms.getint(sdcms.fget("id",0),0)
			datadb=sdcms.db.dbload("","title,hits,style","sd_expand_tags","id="&id&"","")
			load eval("theme_expand_tags_"&act)
		case "editdb":editdb
		case "del":deldb
		case "doset":doset
		case "delsome":delsome
		case else
			select case ord
				case "1":orderwhere="hits desc,id desc":ordtitle="排序:人气降序"
				case else:orderwhere="id desc":ordtitle="排序方式↓"
			end select
			load theme_expand_tags
	end select
	
	sdcms.db.dbclose
%>