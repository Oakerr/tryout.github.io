﻿<!--#include file="../lib/base.asp"-->
<!--#include file="../theme.asp"-->
<%
''' SDCMS 内容归档
''' ==================================================================
''' 版权所有 http://www.sdcms.cn
''' ------------------------------------------------------------------
''' 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和使用；
''' 未经授权不允许对程序代码以任何形式任何目的的再发布。
''' ==================================================================
''' 编写: IT平民
''' 修改：IT平民 in 2014.07

	dim sql_where:sql_where=""
	dim logdate:logdate=sdcms.fget("logdate",0)
	dim keylen:keylen=sdcms.strlen(logdate)
	if keylen<=0  then
		sdcms.echo "&#21442;&#25968;&#38169;&#35823;"
		sdcms.die
	end if
	if not isdate(logdate) then
		sdcms.echo "&#21442;&#25968;&#38169;&#35823;"
		sdcms.die
	end if
	dim y,m
	y=year(logdate)
	m=month(logdate)
	dim datename
	datename=y&"年"&right("0"&m,2)&"月"
	sql_where=" and year(createdate)='"&y&"' and month(createdate)='"&m&"'"
	sdcms.show theme_date,""
%>