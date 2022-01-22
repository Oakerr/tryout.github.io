<!--#include file="config.asp"-->
<%
	if not(checkloginstaus) then
		sdcms.echo "0登录失败"
		sdcms.die
	end if
	if webmode<3 then
		sdcms.echo "0系统未开启静态模式"
		sdcms.die
	end if
	thisurl=""
	dim temproot:temproot=""
	dim classid:classid=sdcms.getint(sdcms.fget("classid",0),0)
	dim data:data=sdcms.getclassdb(classid)
	if not isarray(data) then
		sdcms.echo "0classid="&classid&"&#26639;&#30446;&#19981;&#23384;&#22312;&#25110;&#24050;&#34987;&#21024;&#38500;"
	else	
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
		
		select case data(10)
			case "-1":temproot=sdcms.iif(len(data(21))=0,(theme_page),(data(21)))
			case "-2":sdcms.go data(9)
			case else:temproot=sdcms.iif(len(data(20))=0,(data(23)),(data(20)))
		end select
		dim foldername:foldername=data(2)&"/"
		dim filename:filename="index"
		htmlrule=webroot&htmldir&catedir&"index_[page].html"
		if followid=0 then
			parentname=classname
		else
			parentname=sdcms.getcatename(followid)
		end if
		if page>1 then filename=filename&"_"&page
		htmlshow temproot,webroot&htmldir&foldername,filename,classid
	end if
	sdcms.db.dbclose
%>