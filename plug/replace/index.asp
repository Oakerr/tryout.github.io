﻿<!--#include file="../../lib/base.asp"-->
<!--#include file="../../theme/admin/config.asp"-->
<!--#include file="../../lib/cmd.asp"-->
<%
''' SDCMS 内容替换插件
''' ==================================================================
''' 版权所有 http://www.sdcms.cn
''' ------------------------------------------------------------------
''' 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和使用；
''' 未经授权不允许对程序代码以任何形式任何目的的再发布。
''' ==================================================================
''' 插件编写: IT平民
''' 修改：IT平民 in 2014.07

	is_plug_install "sdcms.plug.replace"
	
	is_plug_login
	
	dim plug_theme
	plug_theme="module/plug_replace/list.html"
	
	sub loaddb()
		dim t0:t0=sdcms.enhtml(sdcms.fget("t0",0))
		dim str01,str02,str03
		str01="<select name=""t1"" class=""ip"">"&vbcrlf&"<option value="""">请选择</option>"&vbcrlf
		str03="</select>"
		dim rsf
		set rsf=sdcms.db.conn.openschema(4)
		do until rsf.eof or rsf("table_name")=t0
		rsf.movenext
		loop
		do until rsf.eof or rsf("table_name")<>t0
			str02=str02&"<option value="""&rsf("column_Name")&""">"&rsf("column_Name")&"</option>"&vbcrlf
		rsf.movenext
		loop
		rsf.close
		set rsf=nothing
		sdcms.echo str01&str02&str03
	end sub
	
	sub dodb()
		dim t0,t1,t2,t3,t4
		t0=sdcms.enhtml(sdcms.fpost("t0",0))
		t1=sdcms.enhtml(sdcms.fpost("t1",0))
		t2=sdcms.getint(sdcms.fpost("t2",0),0)
		t3=sdcms.enhtml(sdcms.fpost("t3",0))
		t4=sdcms.enhtml(sdcms.fpost("t4",0))
		
		dim rs,i
		dim topstr:topstr=""
		if t2<>0 then
			topstr="top "&t2
		end if
		on error resume next
		set rs=server.createobject("adodb.recordset")
		rs.open "select "&topstr&" "&t1&" from "&t0&"",sdcms.db.conn,1,3
		if rs.eof then
			sdcms.echo "没有信息可替换"
			exit sub
		end if
		i=0
		do while not rs.eof
			if instr(rs(0),t3)>0 then
				rs(0)=replace(rs(0),t3,t4)
				i=i+1
				if t2<>0 then
					if i>=t2 then
						sdcms.echo "替换完毕，总计替换了<span>"&i&"</span>条<br>"
						sdcms.echo "<script>window.scroll(0,99999)</script><br>"
						response.flush()
						exit sub
					end if
				end if
				sdcms.echo "正在替换第<span>"&i&"</span>条<br>"
				sdcms.echo "<script>window.scroll(0,99999)</script><br>"
				response.flush()
				rs.update
			end if
		rs.movenext
		loop
		rs.close
		set rs=nothing
		sdcms.echo "替换完毕，总计替换了<span>"&i&"</span>条<br>"
		sdcms.echo "<script>window.scroll(0,99999)</script><br>"
		response.flush()
		if err then
			sdcms.echo "发生错误，错误内容为：<span>"&err.description&"</span><br>"
			sdcms.echo "<script>window.scroll(0,99999)</script><br>"
		end if
	end sub

	dim act:act=lcase(sdcms.fget("act",0))
	select case act
		case "load":loaddb
		case "do":dodb
		case else:load plug_theme
	end select
	sdcms.db.dbclose
%>