<!--#include file="../lib/base.asp"-->
<!--#include file="../theme.asp"-->
<%
''' SDCMS ajaxlogin
''' ==================================================================
''' 版权所有 http://www.sdcms.cn
''' ------------------------------------------------------------------
''' 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和使用；
''' 未经授权不允许对程序代码以任何形式任何目的的再发布。
''' ==================================================================
''' 编写: IT平民
''' 修改：IT平民 in 2013.02

	dim str
	dim url:url=lcase(sdcms.enhtml(sdcms.fpost("url",0)))
	if instr(url,"login.asp")>0 or instr(url,"reg.asp")>0 then url=""

	sdcms.show theme_ajaxlogin,""
	sdcms.db.dbclose
%>