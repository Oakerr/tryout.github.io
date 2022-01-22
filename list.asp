<!--#include file="lib/base.asp"-->
<!--#include file="theme.asp"-->
<%
''' SDCMS 栏目页
''' ==================================================================
''' 版权所有 http://www.sdcms.cn
''' ------------------------------------------------------------------
''' 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和使用；
''' 未经授权不允许对程序代码以任何形式任何目的的再发布。
''' ==================================================================
''' 编写: IT平民
''' 修改：IT平民 in 2014.08

dim temproot:temproot=""
dim classid:classid=sdcms.getint(sdcms.fget("classid",0),0)
dim root:root=sdcms.enhtml(sdcms.fget("root",0))
if classid=0 and root<>"" and not isnull(root) then
	if sdcms.checkstr(root,"file") then
		classid=sdcms.getcateid(root)
	else
		classid=0
	end if	
end if
dim data:data=sdcms.getclassdb(classid)
if not isarray(data) then
	dim errormsg:errormsg="&#26639;&#30446;&#19981;&#23384;&#22312;&#25110;&#24050;&#34987;&#21024;&#38500;"
	sdcms.show theme_404,""
	sdcms.die
end if
dim sonid,parentid,followid,catedir,modeid,cateurl
dim classname,catepic,seotitle,seokey,seodesc,pagenum
dim parentname,topid,pfid
classname=data(1)
catedir=data(2)&"/"
followid=data(3)
sonid=data(5)
parentid=data(6)
cateurl=data(9)
modeid=data(10)
catepic=data(15)
seotitle=data(16)
seokey=data(17)
seodesc=data(18)
pagenum=data(19)
topid=sdcms.get_topid(parentid)
pfid=sdcms.get_fid(followid)
htmlrule="?classid="&classid&""
if followid=0 then
	parentname=classname
else
	parentname=sdcms.getcatename(followid)
end if
select case modeid
	case "-1"
		temproot=sdcms.iif(len(data(21))=0,(theme_page),(data(21)))
		if ismobile and len(data(21))>0 then
			if not(sdcms.isfile(webroot&"theme/"&theme_root&"/"&data(21)&"")) then
				temproot=theme_page
			end if
		end if
	case "-2"
		sdcms.go data(9)
	case else
		temproot=sdcms.iif(len(data(20))=0,(data(23)),(data(20)))
		if ismobile and len(data(20))>0 then
			if not(sdcms.isfile(webroot&"theme/"&theme_root&"/"&data(20)&"")) then
				temproot=data(23)
			end if
		end if
end select
if webmode=2 then htmlrule=webroot&catedir&"[page]/"
if webmode=3 then
	sdcms.go webroot&htmldir&catedir
	sdcms.db.dbclose
	sdcms.die
else
	sdcms.show temproot,classid
end if
sdcms.db.dbclose
%>