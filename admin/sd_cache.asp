﻿<!--#include file="base.asp"-->
<%
''' SDCMS 缓存
''' ==================================================================
''' 版权所有 http://www.sdcms.cn
''' ------------------------------------------------------------------
''' 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和使用；
''' 未经授权不允许对程序代码以任何形式任何目的的再发布。
''' ==================================================================
''' 编写: IT平民
''' 修改：IT平民 in 2014.07

	islogin
	dim act:act=lcase(sdcms.fget("act",0))
	select case act
		case "clear"
			sdcms.clearcache
			sdcms.echo "1"
		case "cleartemp"
			sdcms.delfolder "../cache/"
			sdcms.echo "1"
		case else
			load theme_cache
	end select
	sdcms.db.dbclose
%>