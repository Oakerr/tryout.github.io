﻿<!--#include file="lib/base.asp"-->
<!--#include file="theme.asp"-->
<%
''' SDCMS 首页
''' ==================================================================
''' 版权所有 http://www.sdcms.cn
''' ------------------------------------------------------------------
''' 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和使用；
''' 未经授权不允许对程序代码以任何形式任何目的的再发布。
''' ==================================================================
''' 编写: IT平民
''' 修改：IT平民 in 2014.07

	if webmode=3 then
		sdcms.trans "index.html"
	else
		dim root:root="index"
		htmlrule=webroot&root&"/[page]/"
		sdcms.show theme_index,""
	end if
	sdcms.db.dbclose
%>