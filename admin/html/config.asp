<!--#include file="../../lib/base.asp"-->
<!--#include file="../../theme.asp"-->
<!--#include file="../../lib/cmd.asp"-->
<%
	sub htmlshow(byval t0,byval t1,byval t2,byval t3)
		dim temproot:temproot=sdcms.getsplitname(t0)
		sdcms.temp.isgzip=isgzip
		sdcms.temp.iscache=tempcache
		sdcms.temp.cname=t3
		sdcms.temp.cachepath=webroot&"cache/theme/"&theme_root&temproot(0)
		sdcms.temp.templatepath=webroot&"theme/"&theme_root&temproot(0)
		sdcms.temp.templatename=temproot(1)
		sdcms.temp.templateext=temproot(2)
		sdcms.temp.htmlpath=t1
		sdcms.temp.htmlName=t2
		sdcms.temp.load()
		sdcms.temp.createhtml()
	end sub
	
	function googledate(byval t0)
			googledate=year(t0)&"-"&right("0"&month(t0),2)&"-"&right("0"&day(t0),2)&"T"&right("0"&hour(t0),2)&":"&right("0"&minute(t0),2)&":"&right("0"&second(t0),2)&"+08:00"
	end function
%>