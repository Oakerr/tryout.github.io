﻿<!--#include file="../lib/base.asp"-->
<!--#include file="../theme.asp"-->
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

	dim act:act=sdcms.fget("act",0)
	select case act
		case "vote"
			if not(sdcms.checkpost) then
				sdcms.ajaxjson "&#31105;&#27490;&#38750;&#27861;&#25552;&#20132;&#25968;&#25454;",0
				sdcms.die
			end if
			dim t0,t1,t2
			t0=sdcms.getint(sdcms.fpost("id",0),0)
			t1=sdcms.fpost("t1",1)
			t1=replace(t1," ","")
			if t0=0 then
				sdcms.ajaxjson "&#21442;&#25968;&#38169;&#35823;",0
				sdcms.die
			end if
			if sdcms.strlen(t1)=0 then
				sdcms.ajaxjson "&#35831;&#36873;&#25321;&#25237;&#31080;&#39033;&#30446;",0
				sdcms.die
			end if
			if sdcms.loadcookie("voteitem"&t0)<>"" then
				sdcms.ajaxjson "&#35831;&#21247;&#37325;&#22797;&#25237;&#31080;",0
				sdcms.die
			end if
			t2=sdcms.db.dbload(1,"islock,voteresult,totalnum","sd_expand_vote","id="&t0&"","")
			if ubound(t2)<0 then
				sdcms.ajaxjson "&#21442;&#25968;&#38169;&#35823;",0
			else
				if t2(0,0)=0 then
					sdcms.ajaxjson "&#25237;&#31080;&#24050;&#38145;&#23450;&#65292;&#19981;&#33021;&#25237;&#31080;",0
				else
					dim vi,t1_arr,vote_result,vote_result_arr,total_num,new_result,new_percent
					t1_arr=split(t1,",")
					vote_result=t2(1,0)
					vote_result_arr=split(vote_result,",")
					total_num=t2(2,0)+ubound(t1_arr)+1
					new_result=""
					new_percent=""
					for vi=0 to ubound(vote_result_arr)
						if instr(","&t1&",",","&vi&",") then
							new_result=new_result&","&vote_result_arr(vi)+1
							new_percent=new_percent&","&clng(((vote_result_arr(vi)+1)/total_num)*100)&"%"
						else
							new_result=new_result&","&vote_result_arr(vi)
							new_percent=new_percent&","&clng(((vote_result_arr(vi))/total_num)*100)&"%"
						end if
					next
					if left(new_result,1)="," then
						new_result=right(new_result,len(new_result)-1)
					end if
					if left(new_percent,1)="," then
						new_percent=right(new_percent,len(new_percent)-1)
					end if
					sdcms.db.dbupdate "sd_expand_vote","id="&t0&"",array(array("voteresult",new_result,0,1),array("votepercent",new_percent,0,1),array("totalnum",total_num,0,0))
					sdcms.ajaxjson "&#25237;&#31080;&#25104;&#21151;",1
					sdcms.setcookie "voteitem"&t0,t0
				end if
			end if
		case else
			dim id:id=sdcms.getint(sdcms.fget("id",0),0)
			sdcms.show theme_vote,""
	end select
	sdcms.db.dbclose
%>