﻿<!--#include file="../lib/base.asp"-->
<!--#include file="../theme.asp"-->
<%
''' SDCMS 心情
''' ==================================================================
''' 版权所有 http://www.sdcms.cn
''' ------------------------------------------------------------------
''' 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和使用；
''' 未经授权不允许对程序代码以任何形式任何目的的再发布。
''' ==================================================================
''' 编写: IT平民
''' 修改：IT平民 in 2014.07

	sub upmood()
		dim cid:cid=sdcms.getint(sdcms.fpost("cid",0),0)
		dim mtype:mtype=sdcms.getint(sdcms.fpost("mtype",0),0)
		if not(moodconfig) then
			sdcms.echo "error"
			exit sub
		end if
		if not(sdcms.checkpost) then
			sdcms.echo "error"
			exit sub
		end if
		if sdcms.loadcookie("mood_add_"&cid)<>"" then
			sdcms.echo "error"
			exit sub
		end if
		if cid=0 then
			loadmood 0
			exit sub
		else
			if mtype>8 or mtype<=0 then
				loadmood 0
				exit sub
			end if
			dim rs
			set rs=server.createobject("adodb.recordset")
			rs.open "select contentid,moodnum,moodtype from sd_expand_mood where contentid="&cid&" and moodtype="&mtype&"",sdcms.db.conn,1,3
			if rs.eof then
				rs.addnew
				rs(0)=cid
				rs(1)=1
				rs(2)=mtype
			else
				rs.update
				rs(1)=rs(1)+1
			end if
			rs.update
			rs.close
			set rs=nothing
			sdcms.setcookie "mood_"&cid,""
			loadmood cid
			sdcms.setcookie "mood_add_"&cid,now()
		end if
	end sub
	
	sub loadmood(byval t0)
		dim cid
		if t0="" then
			cid=sdcms.getint(sdcms.fpost("cid",0),0)
		else
			cid=t0
		end if
		dim result
		if not(moodconfig) then
			sdcms.echo "error"
			exit sub
		end if
		if not(sdcms.checkpost) then
			sdcms.echo "error"
			exit sub
		end if
		if sdcms.loadcookie("mood_"&cid)="" then
			if cid=0 then
				result="0#0%:0#0%:0#0%:0#0%:0#0%:0#0%:0#0%:0#0%"
			else
				dim mooddata,moodtotal
				dim t1,t2,t3,t4,t5,t6,t7,t8
				dim k1,k2,k3,k4,k5,k6,k7,k8
				mooddata=sdcms.db.dbload("","moodtype,moodnum","sd_expand_mood","contentid="&cid&"","moodid desc")
				if ubound(mooddata)<0 then
					t1=0:t2=0:t3=0:t4=0:t5=0:t6=0:t7=0:t8=0
				else
					dim im
					t1=0:t2=0:t3=0:t4=0:t5=0:t6=0:t7=0:t8=0
					for im=0 to ubound(mooddata,2)
						select case mooddata(0,im)
							case "1":t1=mooddata(1,im)
							case "2":t2=mooddata(1,im)
							case "3":t3=mooddata(1,im)
							case "4":t4=mooddata(1,im)
							case "5":t5=mooddata(1,im)
							case "6":t6=mooddata(1,im)
							case "7":t7=mooddata(1,im)
							case "8":t8=mooddata(1,im)
						end select
					next
				end if
				moodtotal=t1+t2+t3+t4+t5+t6+t7+t8
				if moodtotal=0 then
					k1=0:k2=0:k3=0:k4=0:k5=0:k6=0:k7=0:k8=0
				else
					k1=sdcms.getnum(t1/moodtotal)*100
					k2=sdcms.getnum(t2/moodtotal)*100
					k3=sdcms.getnum(t3/moodtotal)*100
					k4=sdcms.getnum(t4/moodtotal)*100
					k5=sdcms.getnum(t5/moodtotal)*100
					k6=sdcms.getnum(t6/moodtotal)*100
					k7=sdcms.getnum(t7/moodtotal)*100
					k8=sdcms.getnum(t8/moodtotal)*100
				end if
				result=t1&"#"&k1&":"&t2&"#"&k2&":"&t3&"#"&k3&":"&t4&"#"&k4&":"&t5&"#"&k5&":"&t6&"#"&k6&":"&t7&"#"&k7&":"&t8&"#"&k8
			end if
			sdcms.setcookie "mood_"&cid,result
		else
			result=sdcms.loadcookie("mood_"&cid)
		end if
		sdcms.echo result
	end sub
	
	dim act:act=sdcms.fget("act",0)
	select case act
		case "up":upmood
		case "load":loadmood ""
		case else
			'sdcms.show theme_mood,""
	end select
	sdcms.db.dbclose
%>