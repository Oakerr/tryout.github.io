<!--#include file="../lib/base.asp"-->
<!--#include file="../theme.asp"-->
<%
''' SDCMS 广告
''' ==================================================================
''' 版权所有 http://www.sdcms.cn
''' ------------------------------------------------------------------
''' 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和使用；
''' 未经授权不允许对程序代码以任何形式任何目的的再发布。
''' ==================================================================
''' 编写: IT平民
''' 修改：IT平民 in 2014.07

	dim id:id=sdcms.getint(sdcms.fget("id",0),0)
	dim code
	if id=0 then
		code="&#26080;&#25928;&#30340;&#35843;&#29992;"
	else
		if sdcms.checkcache("plug_ad_"&id,0) then
			code=sdcms.loadcache("plug_ad_"&id,0)
		else
			code=loadad(id)
			sdcms.setcache "plug_ad_"&id,code,0
		end if
	end if
	sdcms.echo deal_code(code)
	sdcms.db.dbclose
	
	function loadad(byval t0)
		dim datadb,thisdata
		datadb=sdcms.db.dbload("","begindate,overdate,code,note","sd_expand_ad","id="&id&"","")
		if ubound(datadb)<0 then
			loadad="&#26080;&#25928;&#30340;&#35843;&#29992;"
		else
			thisdata=date()
			if thisdata>=datadb(0,0) and thisdata<=datadb(1,0) then
				loadad=datadb(2,0)
			else
				loadad=datadb(3,0)
			end if
		end if
	end function
	
	function deal_code(byval t0)
		t0=replace(t0,"""","\""")
		dim arr:arr=split(t0,vbcrlf)
		dim j,h
		for j=0 to ubound(arr)
			if arr(j)<>"" then
				h=h&"document.writeln("""&arr(j)&""");"
				if j<>ubound(arr) then h=h&vbcrlf
			end if
		next
		deal_code=h
	end function 
%>