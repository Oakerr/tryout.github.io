﻿<!--#include file="base.asp"-->
<%
''' SDCMS 积分
''' ==================================================================
''' 版权所有 http://www.sdcms.cn
''' ------------------------------------------------------------------
''' 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和使用；
''' 未经授权不允许对程序代码以任何形式任何目的的再发布。
''' ==================================================================
''' 编写: IT平民
''' 修改：IT平民 in 2014.07

	sub gettip()
		dim q:q=sdcms.fget("q",0)
		if sdcms.strlen(q)>0 then
			dim data,i,str,wherekey
			if datatype then
				wherekey=" instr(lcase(username),lcase('"&q&"'))>0 "
			else
				wherekey=" username like '%"&q&"%'"
			end if
			data=sdcms.db.dbload(10,"username","sd_user",wherekey,"")
			if ubound(data)>=0 then
				for i=0 to ubound(data,2)
					str=str&data(0,i)&chr(10)
				next
				sdcms.echo str
			end if
		end if
	end sub
	
	sub paydb
		dim t0,t1,t2,t3,data,userid,point,npoint,groupid,allowupgrade
		t0=sdcms.enhtml(sdcms.fpost("t0",0))
		t1=sdcms.getint(sdcms.fpost("t1",0),0)
		t2=sdcms.getint(sdcms.fpost("t2",0),0)
		t3=sdcms.enhtml(sdcms.fpost("t3",0))
		if sdcms.strlen(t0)=0 then sdcms.ajaxjson "&#29992;&#25143;&#21517;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		if t1<1 then sdcms.ajaxjson "&#37329;&#39069;&#19981;&#33021;&#23567;&#20110;&#49;",0:exit sub
		select case t2
			case "1","2"
			case else
				sdcms.ajaxjson "&#24615;&#36136;&#19981;&#33021;&#20026;&#31354;":exit sub
		end select
		if sdcms.strlen(t3)=0 then sdcms.ajaxjson "&#20837;&#36134;&#21407;&#22240;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		data=sdcms.db.dbload(1,"id,point,groupid,(select allowupgrade from sd_user_group where id=sd_user.groupid)","sd_user","username='"&t0&"'","")
		if ubound(data)<0 then
			sdcms.echo "&#29992;&#25143;&#21517;&#19981;&#23384;&#22312;&#65292;&#35831;&#37325;&#26032;&#36755;&#20837;",0:exit sub
		else
			userid=data(0,0)
			point=data(1,0)
			groupid=data(2,0)
			allowupgrade=data(3,0)
		end if
		if t2=2 then
			if point<t1 then
				sdcms.ajaxjson "&#29992;&#25143;&#31215;&#20998;&#20313;&#39069;&#19981;&#36275;&#65292;&#26080;&#27861;&#25187;&#38500;",0
				exit sub
			end if
			npoint=point-t1
		else
			npoint=point+t1
		end if
		sdcms.db.insert "sd_user_point",array(array("point",t1,10,0),array("type",t2,1,0),array("userid",userid,0,0),array("content",t3,255,1),array("createdate",sqltime,0,0))
		sdcms.db.dbupdate "sd_user","id="&userid&"",array(array("point",npoint,0,0))
		if t2=1 then
			if allowupgrade=1 then sdcms.userupgrade npoint,groupid,userid
		end if
		sdcms.ajaxjson "执行成功",1
	end sub
	
	sub del()
		dim id:id=sdcms.getint(sdcms.fget("id",0),0)
		if id>0 then
			sdcms.db.dbdel "sd_user_point","id="&id&""
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
			sdcms.db.dbdel "sd_user_point","id in("&id&")"
			sdcms.echo "1"
		end if
	end sub
	
	islogin
	checkpagelever 27
	dim act:act=lcase(sdcms.fget("act",0))
	dim userid:userid=sdcms.getint(sdcms.fget("userid",0),0)
	dim keyword:keyword=sdcms.enhtml(sdcms.fget("keyword",1))
	dim sta:sta=sdcms.getint(sdcms.fget("sta",0),0)
	dim statitle
	select case act
		case "pay":load theme_user_pointpay
		case "tip":gettip
		case "paydb":paydb
		case "del":del
		case "delall":delall
		case else
			dim sqlwhere,wherekey
			if userid>0 then
				sqlwhere="and userid="&userid&""
			end if
			if sdcms.strlen(keyword)>0 then
				if datatype then
					wherekey=" and instr(lcase(content),lcase('"&keyword&"'))>0 "
				else
					wherekey=" and content like '%"&keyword&"%'"
				end if
			end if
			select case sta
				case "1":sqlwhere=" and type=1":statitle="性质:收入"
				case "2":sqlwhere=" and type=2":statitle="性质:支出"
				case else:statitle="按性质↓"
			end select
		load theme_user_point
	end select
	sdcms.db.dbclose
%>