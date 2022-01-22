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
	dim id:id=sdcms.getint(sdcms.fget("id",0),0)
	dim filed
	filed="classid,title,createdate,lastupdate,hits,style"
	filed=filed&",pic,ispic,tags,url,isurl,keyword,description,"
	filed=filed&"islock,isnice,ontop,iscomment,likeid,comments,point,c.catedir,c.catedir,"
	filed=filed&"author,comefrom,intro,userid"
	
	dim data:data=sdcms.db.dbload(1,filed,"sd_content n left join sd_category c on n.classid=c.cateid","id="&id&" and islock=1","")
	if ubound(data)<0 then
		sdcms.echo "0&#24744;&#35201;&#26597;&#30475;&#30340;&#20869;&#23481;&#19981;&#23384;&#22312;&#65292;&#25110;&#24050;&#34987;&#21024;&#38500;"
		sdcms.db.dbclose
		sdcms.die
	else
		dim classid,title,createdate,lastupdate,hits,style
		dim pic,ispic,tags,url,isurl,seokey,seodesc
		dim islock,isnice,ontop,iscomment,likeid,comments
		dim content,userid,parentname
		dim point,author,comefrom,intro
		dim this_file
		classid=data(0,0)
		title=data(1,0)
		createdate=data(2,0)
		lastupdate=data(3,0)
		hits=data(4,0)
		style=data(5,0)
		pic=data(6,0)
		ispic=data(7,0)
		tags=sdcms.get_tags_arr(data(8,0))
		url=data(9,0)
		isurl=data(10,0)
		seokey=data(11,0)
		seodesc=data(12,0)
		islock=data(13,0)
		isnice=data(14,0)
		ontop=data(15,0)
		iscomment=data(16,0)
		likeid=data(17,0)
		comments=data(18,0)
		point=data(19,0)
		author=data(22,0)
		comefrom=data(23,0)
		intro=data(24,0)
		userid=data(25,0)
		htmlrule=webroot&htmldir&data(20,0)&"/"&url&"_[page].html"
	end if
	data=sdcms.getclassdb(classid)
	if not isarray(data) then
		sdcms.echo "0&#26639;&#30446;&#19981;&#23384;&#22312;&#25110;&#24050;&#34987;&#21024;&#38500;"
		sdcms.db.dbclose
		sdcms.die
	end if
	dim classname:classname=data(1)
	dim followid:followid=data(3)
	dim sonid:sonid=data(5)
	dim parentid:parentid=data(6)
	dim cateurl:cateurl=data(9)
	dim modeid:modeid=data(10)
	dim catepic:catepic=data(15)
	dim topid:topid=sdcms.get_topid(parentid)
	dim pfid:pfid=sdcms.get_fid(followid)
	
	temproot=sdcms.iif(len(data(21))=0,(data(24)),(data(21)))
	
	dim contenturl:contenturl=weburl&webroot&htmldir&data(2)&"/"&url&".html"
	if followid=0 then
		parentname=classname
	else
		parentname=sdcms.getcatename(followid)
	end if
	dim model_tablename:model_tablename=data(12)
	dim rsshow
	set rsshow=sdcms.db.exedb("select top 1 * from "&model_tablename&" where cid="&id&"")
	if rsshow.eof then
		sdcms.echo "0id="&id&",&#33719;&#21462;&#20869;&#23481;&#22833;&#36133;"
		rsshow.close
		set rsshow=nothing
		sdcms.db.dbclose
		sdcms.die
	else
		if model_tablename="sd_model_down" or point=0 then
			content=sdcms.get_content_split(rsshow("content"),htmlrule)
		else
			dim isbuy:isbuy=0
			dim isvip:isvip=false
			content=""
		end if
		dim foldername:foldername=data(2)&"/"
		dim filename:filename=url
		if page>1 then filename=filename&"_"&page
		htmlshow temproot,webroot&htmldir&foldername,filename,""
		rsshow.close
		set rsshow=nothing
	end if
	sdcms.db.dbclose
%>