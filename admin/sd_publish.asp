﻿<!--#include file="base.asp"-->
<%
''' SDCMS 投稿
''' ==================================================================
''' 版权所有 http://www.sdcms.cn
''' ------------------------------------------------------------------
''' 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和使用；
''' 未经授权不允许对程序代码以任何形式任何目的的再发布。
''' ==================================================================
''' 编写: IT平民
''' 修改：IT平民 in 2014.07

	sub deldb()
		dim id:id=sdcms.enhtml(sdcms.fget("id",0))
		dim data
		data=sdcms.db.dbload(1,"id,(select tablename from view_category where cateid=sd_content.classid) as tablename","sd_content","id="&id&" and (islock=-1 or islock=-2)","")
		if ubound(data)>=0 then
			sdcms.db.dbdel data(1,0),"cid="&id&""
			sdcms.db.dbdel "sd_content","id="&id&" and (islock=-1 or islock=-2)"
		end if
		sdcms.echo "1"
	end sub
	
	sub passdb(byval t0)
		dim t1
		select case t0
			case "1":t1=1
			case else:t1=-2
		end select
		dim id:id=sdcms.enhtml(sdcms.fget("id",0))
		sdcms.db.dbupdate "sd_content","id="&id&" and islock=-1",array(array("islock",t1,2,0))
		if t1=1 then sdcms.deal_user_publish_point id,""
		sdcms.echo "1"
	end sub
	
	sub doset()
		dim id:id=sdcms.enhtml(sdcms.fget("id",0))
		dim go:go=sdcms.enhtml(sdcms.fget("go",0))
		dim idarr:idarr=split(id,",")
		if ubound(idarr)<0 then
			sdcms.echo "0&#33267;&#23569;&#36873;&#25321;&#19968;&#26465;&#20449;&#24687;"
		else
			dim i
			for i=0 to ubound(idarr)
				if not isnumeric(idarr(i)) then
					sdcms.echo "0&#21442;&#25968;&#65306;"&idarr(i)&"&#19981;&#27491;&#30830;&#65292;&#35831;&#30830;&#35748;&#21518;&#20877;&#25805;&#20316;"
					exit sub
				end if
			next
			dim result
			select case go
				case "islock":result=1
				case "nolock":result=-2
				case else:sdcms.echo "0&#21442;&#25968;&#38169;&#35823;":exit sub
			end select
			sdcms.db.dbupdate "sd_content","id in("&id&") and (islock=-1 or islock=-2)",array(array("islock",result,2,0))
			if result=1 then
				for i=1 to ubound(idarr)
					sdcms.deal_user_publish_point arr(i),""
				next
			end if
			sdcms.echo "1"
		end if
	end sub
	
	sub delsome()
		dim id:id=sdcms.enhtml(sdcms.fget("id",0))
		dim idarr:idarr=split(id,",")
		dim data
		if ubound(idarr)<0 then
			sdcms.echo "0&#33267;&#23569;&#36873;&#25321;&#19968;&#26465;&#20449;&#24687;"
		else
			dim i
			for i=0 to ubound(idarr)
				if not isnumeric(idarr(i)) then
					sdcms.echo "0&#21442;&#25968;&#65306;"&idarr(i)&"&#19981;&#27491;&#30830;&#65292;&#35831;&#30830;&#35748;&#21518;&#20877;&#25805;&#20316;"
					exit sub
				else
					data=sdcms.db.dbload(1,"id,(select tablename from view_category where cateid=sd_content.classid) as tablename","sd_content","id="&idarr(i)&" and (islock=-1 or islock=-2)","")
					if ubound(data)>=0 then
						sdcms.db.dbdel data(1,0),"cid="&idarr(i)&""
						sdcms.db.dbdel "sd_content","id="&idarr(i)&" and (islock=-1 or islock=-2)"
					end if
				end if
			next
			sdcms.echo "1"
		end if
	end sub
	
	sub clearall()
		dim data
		data=sdcms.db.dbload(1,"id,(select tablename from view_category where cateid=sd_content.classid) as tablename","sd_content","islock=-1 or islock=-2","")
		if ubound(data)>=0 then
			sdcms.db.dbdel data(1,0),"cid="&data(0,0)&""
			sdcms.db.dbdel "sd_content","islock=-1 or islock=-2"
		end if
		sdcms.echo "1"
	end sub
	
	islogin
	checkpagelever 20
	dim act:act=lcase(sdcms.fget("act",0))
	dim sta,order,keyword
	sta=sdcms.getint(sdcms.fget("sta",0),0)
	order=sdcms.getint(sdcms.fget("order",0),0)
	keyword=sdcms.enhtml(sdcms.fget("keyword",1))
	select case act
		case "del":deldb
		case "pass":passdb(1)
		case "nopass":passdb(0)
		case "doset":doset
		case "delsome":delsome
		case "clearall":clearall
		case else
			dim sqlwhere,statitle,orderby,ordtitle,wherekey
			select case sta
				case "1":sqlwhere="sd_content.islock=-1":statitle="状态:待审"
				case "2":sqlwhere="sd_content.islock=-2":statitle="状态:退稿"
				case else:sqlwhere="(sd_content.islock=-1 or sd_content.islock=-2)":statitle="按状态↓"
			end select
			select case order
				case "1":orderby="createdate desc,id desc":ordtitle="状态:发布日期↑"
				case "2":orderby="createdate,id":ordtitle="状态:发布日期↓"
				case else:orderby="ontop desc,id desc":ordtitle="按排序↓"
			end select
			if sdcms.strlen(keyword)>0 then
				if datatype then
					wherekey=" and instr(lcase(title),lcase('"&keyword&"'))>0 "
				else
					wherekey=" and title like '%"&keyword&"%'"
				end if
			end if
			load theme_contentpublish
	end select
	sdcms.db.dbclose
%>