﻿<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
''' SDCMS
''' ==================================================================
''' 版权所有 http://www.sdcms.cn
''' ------------------------------------------------------------------
''' 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和使用；
''' 未经授权不允许对程序代码以任何形式任何目的的再发布。
''' ==================================================================
''' 编写: IT平民
''' 修改：IT平民 in 2014.07

	option explicit
	session.codepage=65001
	response.charset="utf-8"
	server.scripttimeout=999999
	dim in_sdcms:in_sdcms=true
	dim dbquery:dbquery=0
	dim startime:startime=timer()
	'microsoft.xmlhttp
	'Msxml2.XMLHTTP
	'MSXML2.SERVERXMLHTTP.3.0
	dim xmlhttp:xmlhttp="Msxml2.ServerXMLHTTP"
	dim ismobile:ismobile=false
	dim htmlrule
%>
<!--#include file="../config.asp"-->
<!--#include file="../version.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="class/sdcms.db.asp"-->
<!--#include file="class/sdcms.fun.asp"-->
<!--#include file="class/sdcms.ip.asp"-->
<!--#include file="class/sdcms.page.asp"-->
<!--#include file="class/sdcms.temp.asp"-->
<!--#include file="class/sdcms.jscript.asp"-->
<%
	dim sqltime:sqltime="now()"
	if not(datatype) then sqltime="GetDate()"
	sdcms.sitedb:sdcms.catedb:sdcms.auto_update
	dim page:page=sdcms.getint(sdcms.fget("page",0),1)
	dim webmode:webmode=sdcms.getsys("webmode")
	dim isgzip:isgzip=sdcms.getsys("isgzip")
	dim iscache:iscache=sdcms.getsys("iscache")
	dim tempcache:tempcache=sdcms.getsys("tempcache")
	dim cachedate:cachedate=sdcms.getsys("cachedate")
	dim thisurl:thisurl=sdcms.getthisurl
	dim htmldir:htmldir=sdcms.getsys("htmldir")
	dim commentconfig:commentconfig=eval(sdcms.getsys("expand.comment"))
	dim syscomment:syscomment=commentconfig(0)
	dim moodconfig:moodconfig=sdcms.getsys("expand.mood")
	ismobile=sdcms.get_ismobile
	dim blacklist:blacklist="javascript|Document|onerror|onload|onmouseover"
	dim murl:murl=sdcms.getsys("sys_murl")
	if murl<>"" and ismobile and weburl<>murl then
		dim nexturl:nexturl=replace(thisurl,weburl,murl)
		Response.Redirect(nexturl)
	end if
%>