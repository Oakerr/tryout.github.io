<!--#include file="lib/base.asp"-->
<!--#include file="theme.asp"-->
<%
''' SDCMS 内容页
''' ==================================================================
''' 版权所有 http://www.sdcms.cn
''' ------------------------------------------------------------------
''' 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和使用；
''' 未经授权不允许对程序代码以任何形式任何目的的再发布。
''' ==================================================================
''' 编写: IT平民
''' 修改：IT平民 in 2014.08

dim temproot:temproot=""
dim id:id=sdcms.getint(sdcms.fget("id",0),0)
dim root:root=sdcms.enhtml(sdcms.fget("root",0))
dim self_where:self_where="id="&id&""
if id=0 and root<>"" then
	if sdcms.checkstr(root,"filename") then
		self_where="url='"&root&"'"
	end if
end if
dim filed
filed="classid,title,createdate,lastupdate,hits,style"
filed=filed&",pic,ispic,tags,url,isurl,keyword,description,"
filed=filed&"islock,isnice,ontop,iscomment,likeid,comments,point,c.catedir,"
filed=filed&"author,comefrom,intro,userid,id"
dim data:data=sdcms.db.dbload(1,filed,"sd_content n left join sd_category c on n.classid=c.cateid",""&self_where&" and islock=1","")
if ubound(data)<0 then
	dim errormsg:errormsg="&#24744;&#35201;&#26597;&#30475;&#30340;&#20869;&#23481;&#19981;&#23384;&#22312;&#65292;&#25110;&#24050;&#34987;&#21024;&#38500;"
	sdcms.show theme_404,""
	sdcms.db.dbclose
	sdcms.die
else
	dim classid,title,createdate,lastupdate,hits,style,catedir
	dim pic,ispic,tags,url,isurl,seokey,seodesc
	dim islock,isnice,ontop,iscomment,likeid,comments
	dim htmlname,content,parentname
	dim point,author,comefrom,intro,userid
	id=data(25,0)
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
	catedir=data(20,0)
	author=data(21,0)
	comefrom=data(22,0)
	intro=data(23,0)
	userid=data(24,0)
	htmlname=webroot&htmldir&data(20,0)&"/"&url&".html"
	htmlrule="?id="&id&""
	if webmode=2 then htmlrule=webroot&catedir&"/"&url&"_[page].html"
end if

data=sdcms.getclassdb(classid)
if not isarray(data) then
	sdcms.echo "&#26639;&#30446;&#19981;&#23384;&#22312;&#25110;&#24050;&#34987;&#21024;&#38500;"
	sdcms.db.dbclose
	sdcms.die
end if
dim classname:classname=data(1)
dim followid:followid=data(3)
dim sonid:sonid=data(5)
dim parentid:parentid=data(6)
dim cateurl:cateurl=data(9)
dim modeid:modeid=data(10)
dim model_tablename:model_tablename=data(12)
dim catepic:catepic=data(15)
dim topid:topid=sdcms.get_topid(parentid)
dim pfid:pfid=sdcms.get_fid(followid)

temproot=sdcms.iif(len(data(21))=0,(data(24)),(data(21)))
if ismobile and len(data(21))>0 then
	if not(sdcms.isfile(webroot&"theme/"&theme_root&"/"&data(21)&"")) then
		temproot=data(24)
	end if
end if
dim contenturl:contenturl=thisurl
if followid=0 then
	parentname=classname
else
	parentname=sdcms.getcatename(followid)
end if
if webmode=2 then
	contenturl=weburl&webroot&catedir&"/"&url
	contenturl=replace(contenturl,"%26","&")
	if page>1 then
		contenturl=contenturl&"_"&page
	end if
	contenturl=contenturl&".html"
end if
dim rsshow
set rsshow=sdcms.db.exedb("select top 1 * from "&model_tablename&" where cid="&id&"")
if rsshow.eof then
	errormsg="&#33719;&#21462;&#20869;&#23481;&#22833;&#36133;"
	sdcms.show theme_404,""
	rsshow.close
	set rsshow=nothing
	sdcms.db.dbclose
	sdcms.die
else
	if webmode=3 then
		sdcms.go htmlname
		sdcms.db.dbclose
		sdcms.die
	else
		if model_tablename="sd_model_down" or point=0 then
			content=sdcms.get_content_split(rsshow("content"),htmlrule)
		else
			dim isbuy:isbuy=0
			dim isvip:isvip=sdcms.is_vip
			if sdcms.is_login then
				if isvip then
					content=sdcms.get_content_split(rsshow("content"),htmlrule)
				else
					isbuy=sdcms.is_buy(id)
					if isbuy=0 then
						content=""
					else
						content=sdcms.get_content_split(rsshow("content"),htmlrule)
					end if
				end if
			else
				content=""
			end if
		end if
		sdcms.show temproot,""
	end if
	rsshow.close
	set rsshow=nothing
end if
sdcms.db.dbclose
%>