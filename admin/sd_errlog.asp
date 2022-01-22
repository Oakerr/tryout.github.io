<!--#include file="base.asp"-->
<%
''' SDCMS 消息
''' ==================================================================
''' 版权所有 http://www.sdcms.cn
''' ------------------------------------------------------------------
''' 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和使用；
''' 未经授权不允许对程序代码以任何形式任何目的的再发布。
''' ==================================================================
''' 编写: IT平民
''' 修改：IT平民 in 2013.04
	
	sub del()
		dim id:id=sdcms.getint(sdcms.fget("id",0),0)
		if id>0 then
			sdcms.db.dbdel "sd_errlog","id="&id&""
		end if
		sdcms.echo "1"
	end sub
	
	sub delall()
		dim id:id=sdcms.enhtml(sdcms.fget("id",0))
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
			sdcms.db.dbdel "sd_errlog","id in("&id&")"
			sdcms.echo "1"
		end if
	end sub
	
	sub delno()
		sdcms.db.dbdel "sd_errlog","isread=0"
		sdcms.echo "1"
	end sub
	
	islogin
	dim act:act=lcase(sdcms.fget("act",0))
	dim keyword:keyword=sdcms.enhtml(sdcms.fget("keyword",1))
	select case act
		case "del":del
		case "delall":delall
		case "delno":delno
		case "show"
			dim id:id=sdcms.getint(sdcms.fget("id",0),0)
			dim data:data=sdcms.db.dbload(1,"createdate,content,isread","sd_errlog","id="&id&"","")
			if ubound(data)>=0 then
				if data(2,0)=0 then
					sdcms.db.dbupdate "sd_errlog","id="&id&"",array(array("isread",1,0,0))
				end if
				load theme_errlog_show
			end if
		case else
			dim wherekey
			if sdcms.strlen(keyword)>0 then
				if datatype then
					wherekey=" and instr(lcase(content),lcase('"&keyword&"'))>0 "
				else
					wherekey=" and content like '%"&keyword&"%'"
				end if
			end if
		load theme_errlog
	end select
	sdcms.db.dbclose
%>