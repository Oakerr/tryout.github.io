﻿<!--#include file="../lib/base.asp"-->
<!--#include file="../theme.asp"-->
<%
''' SDCMS 下载
''' ==================================================================
''' 版权所有 http://www.sdcms.cn
''' ------------------------------------------------------------------
''' 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和使用；
''' 未经授权不允许对程序代码以任何形式任何目的的再发布。
''' ==================================================================
''' 编写: IT平民
''' 修改：IT平民 in 2013.09

	dim id:id=sdcms.getint(sdcms.fget("id",0),0)
	dim order:order=sdcms.getint(sdcms.fget("order",0),-1)
	get_down id,order
	
	sub get_down(byval t0,byval t1)
		if t0=0 or t1<0 then
			sdcms.echo "0无效的下载"
			exit sub
		end if
			dim data,point
			 data=sdcms.db.dbload(1,"point","sd_content","id="&t0&" and islock=1","")
			 if ubound(data)<0 then
				sdcms.echo "0无效的下载"
				exit sub
			 end if
			 point=data(0,0)
			 data=sdcms.db.dbload(1,"downurl","sd_model_down","cid="&t0&"","")
			 if ubound(data)<0 then
				sdcms.echo "0无效的下载"
				exit sub
			 end if
			 downdata=data(0,0)
			 dim downarr,downdata,downurl
			 downarr=split(downdata,",")
			 if t1>ubound(downarr) then
				 sdcms.echo "0无效的下载"
				exit sub
			 end if
			 downurl=downarr(t1)
			 if point=0 then
				 if instr(downurl,"thunder://")>0 then
					 sdcms.echo "<script src=""http://pstatic.xunlei.com/js/webThunderDetect.js""></script>"&vbcrlf
					 sdcms.echo "<script type=""text/javascript"">OnDownloadClick('"&downurl&"','',location.href,'132450',false)</script>"
				 else
					 sdcms.go downurl
				 end if
				 exit sub
			 end if
				if not(sdcms.is_login) then
					sdcms.echo "1请先登录或注册"
					exit sub
				else
					dim userdata:userdata=sdcms.userinfo
					dim userid:userid=userdata(0)
					if userdata(8)=1 then
						if userdata(9)=0 then
						else
							if instr(downurl,"thunder://")>0 then
								 sdcms.echo "<script src=""http://pstatic.xunlei.com/js/webThunderDetect.js""></script>"&vbcrlf
								 sdcms.echo "<script type=""text/javascript"">OnDownloadClick('"&downurl&"','',location.href,'132450',false)</script>"
							 else
								 sdcms.echo "3"&downurl
							 end if
							exit sub
						end if
					end if
					dim upoint:upoint=sdcms.db.dbloadone("point","sd_user","id="&userid&"")
				end if
			dim npoint:npoint=upoint-point
			dim rs,ure
			ure=0
			set rs=server.createobject("adodb.recordset")
			rs.open "select contentid,point,userid,createdate,lastupdate from sd_user_buy where contentid="&t0&" and userid="&userid&"",sdcms.db.conn,1,3
			if rs.eof then
				 if upoint<point then
					sdcms.echo "2您的积分不足，请先充值！"
					exit sub
				end if
				ure=1
				rs.addnew
				rs(0)=t0
				rs(1)=point
				rs(2)=userid
				rs(3)=now()
				rs(4)=now()
			else
				rs.update
				rs(4)=now()
			end if
			rs.update
			rs.close
			set rs=nothing
			if ure=1 then
				sdcms.db.dbupdate "sd_user","id="&userid&"",array(array("point",npoint,10,0))
				sdcms.createuserpoint array(array("point",point,0,0),array("userid",userid,0,0),array("type",2,0,0),array("content","<a href='../show.asp?id="&t0&"' target='_blank'>下载资源，支付："&point&"积分</a>",0,1),array("createdate",now(),0,1))
			end if
			sdcms.echo "3"&downurl
	end sub

	sdcms.db.dbclose
%>