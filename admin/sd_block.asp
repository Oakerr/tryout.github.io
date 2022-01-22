<!--#include file="base.asp"-->
<!--#include file="../skins.asp"-->
<%
''' SDCMS 区块
''' ==================================================================
''' 版权所有 http://www.sdcms.cn
''' ------------------------------------------------------------------
''' 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和使用；
''' 未经授权不允许对程序代码以任何形式任何目的的再发布。
''' ==================================================================
''' 编写: IT平民
''' 修改：IT平民 in 2013.09

	sub adddb()
		dim t0:t0=sdcms.enhtml(sdcms.fpost("t0",0))
		dim t1:t1=sdcms.enhtml(sdcms.fpost("t1",0))
		dim t2:t2=sdcms.fpost("t2",1)
		if not(sdcms.checkstr(t0,"en")) then
			sdcms.ajaxjson "区块名称只能是英文字母",0:exit sub
		end if
		if t1="" then
			sdcms.ajaxjson "区块说明不能为空",0:exit sub
		end if
		if t2="" then
			sdcms.ajaxjson "区块内容不能为空",0:exit sub
		end if
		if sdcms.isfile("../theme/"&theme_root&"/block/"&t0&".asp") then
			sdcms.ajaxjson "区块已存在",0:exit sub
		end if
		dim is_end:is_end="<%"
		is_end=is_end&"if not in_sdcms then response.write(""template load fail""):response.end() end if"
		is_end=is_end&"%"
		is_end=is_end&">"
		t2=replace(t2,is_end,"")
		t2=is_end&t2
		sdcms.newfile "../theme/"&theme_root&"/block/",t0&".asp",t2,""
		dim str:str="<%"
		str=str&"dim block_arr:block_arr=array("
		dim j
		for j=0 to ubound(block_arr)
			if j>0 then str=str&","
			dim t3:t3=block_arr(j)
			str=str&"array("""&t3(0)&""","""&t3(1)&""")"
		next
		str=str&","
		str=str&"array(""block/"&t0&".asp"","""&t1&""")"
		str=str&")%"
		str=str&">"
		str=replace(str,"(,","(")
		sdcms.newfile "../theme/"&theme_root&"/","base.asp",str,""
		sdcms.ajaxjson "保存成功",1
	end sub
	
	sub editdb()
		dim filename:filename=sdcms.fget("filename",0)
		dim t0:t0=sdcms.enhtml(sdcms.fpost("t0",0))
		dim t1:t1=sdcms.fpost("t1",1)
		if not(sdcms.checkstr(filename,"en")) then
			sdcms.ajaxjson "区块名称只能是英文字母",0:exit sub
		end if
		if not(sdcms.isfile("../theme/"&theme_root&"/block/"&filename&".asp")) then
			sdcms.ajaxjson "区块不存在",0:exit sub
		end if
		if t0="" then
			sdcms.ajaxjson "区块说明不能为空",0:exit sub
		end if
		
		dim is_end:is_end="<%"
		is_end=is_end&"if not in_sdcms then response.write(""template load fail""):response.end() end if"
		is_end=is_end&"%"
		is_end=is_end&">"
		if instr(t1,is_end)<=0 then
			t1=is_end&t1
		end if

		sdcms.newfile "../theme/"&theme_root&"/block/",filename&".asp",t1,""
		
		dim str:str="<%"
		str=str&"dim block_arr:block_arr=array("
		dim j,i
		i=0
		for j=0 to ubound(block_arr)
			if j>0 then str=str&","
			dim t2:t2=block_arr(j)
			if t2(0)="block/"&filename&".asp" then
				i=1
				str=str&"array("""&t2(0)&""","""&t0&""")"
			else
				str=str&"array("""&t2(0)&""","""&t2(1)&""")"
			end if
		next
		if i=0 then
			str=str&","
			str=str&"array(""block/"&filename&".asp"","""&t0&""")"
		end if
		str=str&")%"
		str=str&">"
		str=replace(str,"(,","(")
		sdcms.newfile "../theme/"&theme_root&"/","base.asp",str,""
		
		sdcms.ajaxjson "保存成功",1
	end sub
	
	sub deldb()
		dim id:id=sdcms.fget("id",0)
		if not(sdcms.isfile("../theme/"&theme_root&"/block/"&id&".asp")) then
			sdcms.echo "0区块名称错误"
			exit sub
		else
			sdcms.delfile "../theme/"&theme_root&"/block/"&id&".asp"
		end if
		dim str:str="<%"
		str=str&"dim block_arr:block_arr=array("
		dim j
		for j=0 to ubound(block_arr)
			dim t2:t2=block_arr(j)
			if t2(0)<>"block/"&id&".asp" then
				str=str&",array("""&t2(0)&""","""&t2(1)&""")"
			end if
		next
		str=str&")%"
		str=str&">"
		str=replace(str,"(,","(")
		str=replace(str,",)",")")
		sdcms.newfile "../theme/"&theme_root&"/","base.asp",str,""
		sdcms.echo "1"
	end sub

	islogin
	checkpagelever 32
	dim act:act=lcase(sdcms.fget("act",0))
	select case act
		case "add":load theme_block_add
		case "adddb":adddb
		case "edit"
			dim filename:filename=sdcms.fget("filename",0)
			if not(sdcms.checkstr(filename,"en")) then
				sdcms.echo "filename is wrong"
				sdcms.die
			end if
			if not(sdcms.isfile("../theme/"&theme_root&"/block/"&filename&".asp")) then
				sdcms.echo "filename is wrong"
				sdcms.die
			end if
			dim block_txt:block_txt=getblockname("block/"&filename&".asp")
			dim temp_content:temp_content=sdcms.loadfile("../theme/"&theme_root&"/block/"&filename&".asp")
			dim r_mid:r_mid="<%"
			r_mid=r_mid&"if not in_sdcms then response.write(""template load fail""):response.end() end if"
			r_mid=r_mid&"%"
			r_mid=r_mid&">"
			temp_content=replace(temp_content,r_mid,"")
			load theme_block_edit
		case "editdb":editdb
		case "call":filename=sdcms.fget("filename",0):load theme_block_call
		case "del":deldb
		case else
			if not(sdcms.isfolder("../theme/"&theme_root&"/block/")) then
				sdcms.newfolder "../theme/"&theme_root&"/block/"
			end if
			load theme_block
	end select
	sdcms.db.dbclose
%>