﻿<!--#include file="base.asp"-->
<%
''' SDCMS 投票
''' ==================================================================
''' 版权所有 http://www.sdcms.cn
''' ------------------------------------------------------------------
''' 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和使用；
''' 未经授权不允许对程序代码以任何形式任何目的的再发布。
''' ==================================================================
''' 编写: IT平民
''' 修改：IT平民 in 2014.07

	sub adddb()
		dim t0,t1,t2,t3,t4,t5,t6,i
		t0=sdcms.enhtml(sdcms.fpost("t0",0))
		t1=sdcms.getint(sdcms.fpost("t1",0),0)
		t4=sdcms.getint(sdcms.fpost("t4",0),0)
		dim t2_1,t3_1
		dim num:num=request.form("t2").count
		for i=1 to num
			if i>1 then
				t2_1=t2_1&","
				t3_1=t3_1&","
			end if
			t2_1=t2_1&replace(sdcms.enhtml(trim(request.form("t2")(i))),",","&#44;")
			t3_1=t3_1&sdcms.enhtml(trim(request.form("t3")(i)))
		next
		t2=t2_1
		t3=t3_1
		t6=eval(replace(t3,",","+"))
		dim arr:arr=split(t3,",")
		for i=0 to ubound(arr)
			if t5="" then
				if t6=0 then
					t5="0%"
				else
					t5=clng(arr(i)/t6*100)&"%"
				end if
			else
				if t6=0 then
					t5=t5&",0%"
				else
					t5=t5&","&clng(arr(i)/t6*100)&"%"
				end if
			end if
		next
		dim data:data=array(array("title",t0,255),array("votetype",t1,0),array("voteitem",t2,0),array("voteresult",t3,0),array("islock",t4,0),array("votepercent",t5,0),array("totalnum",t6,0))
		if sdcms.db.dbnew("sd_expand_vote",data,"title='"&t0&"'")=0 then
			sdcms.ajaxjson "0&#39033;&#30446;&#21517;&#31216;&#24050;&#23384;&#22312;&#65292;&#35831;&#25442;&#20010;&#35797;&#35797;",0
		else
			sdcms.ajaxjson "保存成功",1
		end if
	end sub
	
	sub editdb()
		dim t0,t1,t2,t3,t4,t5,t6,i
		t0=sdcms.enhtml(sdcms.fpost("t0",0))
		t1=sdcms.getint(sdcms.fpost("t1",0),0)
		t4=sdcms.getint(sdcms.fpost("t4",0),0)
		dim t2_1,t3_1
		dim num:num=request.form("t2").count
		for i=1 to num
			if i>1 then
				t2_1=t2_1&","
				t3_1=t3_1&","
			end if
			t2_1=t2_1&replace(sdcms.enhtml(trim(request.form("t2")(i))),",","&#44;")
			t3_1=t3_1&sdcms.enhtml(trim(request.form("t3")(i)))
		next
		t2=t2_1
		t3=t3_1
		t6=eval(replace(t3,",","+"))
		dim arr:arr=split(t3,",")
		for i=0 to ubound(arr)
			if t5="" then
				if t6=0 then
					t5="0%"
				else
					t5=clng(arr(i)/t6*100)&"%"
				end if
			else
				if t6=0 then
					t5=t5&",0%"
				else
					t5=t5&","&clng(arr(i)/t6*100)&"%"
				end if
			end if
		next
		dim data,id
		id=sdcms.getint(sdcms.fget("id",0),0)
		data=array(array("title",t0,255,1),array("votetype",t1,0,0),array("voteitem",t2,0,1),array("voteresult",t3,0,1),array("islock",t4,0,0),array("votepercent",t5,0,1),array("totalnum",t6,0,0))
		if sdcms.db.dbupdate("sd_expand_vote","id="&id&"",data)=1 then
			sdcms.ajaxjson "保存成功",1
		end if
	end sub
	
	sub deldb()
		dim id:id=sdcms.getint(sdcms.fget("id",0),0)
		sdcms.db.dbdel "sd_expand_vote","id="&id
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
			dim filed,result
			select case go
				case "islock":filed="islock":result=0
				case "nolock":filed="islock":result=1
				case else:sdcms.echo "0&#21442;&#25968;&#38169;&#35823;":exit sub
			end select
			sdcms.db.dbupdate "sd_expand_vote","id in("&id&")",array(array(filed,result,2,0))
			sdcms.echo "1"
		end if
	end sub
	
	sub delsome()
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
				else
					sdcms.db.dbdel "sd_expand_vote","id="&idarr(i)&""
				end if
			next
			sdcms.echo "1"
		end if
	end sub
	
	islogin
	checkpagelever 40
	dim act:act=lcase(sdcms.fget("act",0))
	select case act
		case "add":load eval("theme_expand_vote_"&act)
		case "adddb":adddb
		case "edit"
			dim datadb,id
			id=sdcms.getint(sdcms.fget("id",0),0)
			datadb=sdcms.db.dbload("","title,votetype,voteitem,voteresult,islock","sd_expand_vote","id="&id&"","")
			load eval("theme_expand_vote_"&act)
		case "editdb":editdb
		case "del":deldb
		case "doset":doset
		case "delsome":delsome
		case else
			dim sqlwhere,nattitle,nat
			nat=sdcms.getint(sdcms.fget("nat",0),0)
			select case nat
				case "1":sqlwhere=" and islock=0":nattitle="性质:未审"
				case "2":sqlwhere=" and islock=1":nattitle="性质:已审"
				case else:nattitle="按性质↓"
			end select
			load theme_expand_vote
	end select
	sdcms.db.dbclose
%>