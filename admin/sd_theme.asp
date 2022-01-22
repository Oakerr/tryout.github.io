<!--#include file="base.asp"-->
<!--#include file="../skins.asp"-->
<%
''' SDCMS 模板
''' ==================================================================
''' 版权所有 http://www.sdcms.cn
''' ------------------------------------------------------------------
''' 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和使用；
''' 未经授权不允许对程序代码以任何形式任何目的的再发布。
''' ==================================================================
''' 编写: IT平民
''' 修改：IT平民 in 2014.07

	sub editdb()
		dim filename:filename=sdcms.fget("filename",0)
		if not(sdcms.checkstr(filename,"filename")) then
			sdcms.echo "0filename is wrong"
			exit sub
		end if
		if not(sdcms.isfile("../theme/"&filename)) then
			sdcms.echo "0filename is wrong"
			exit sub
		end if
		dim isasp:isasp=0
		if lcase(right(filename,4))=".asp" then isasp=1
		dim t0:t0=sdcms.enhtml(sdcms.fpost("t0",0))
		dim t1:t1=sdcms.fpost("t1",1)
		dim arr:arr=split(filename,"/")
		dim t2:t2=replace("../theme/"&filename,arr(ubound(arr)),"")
		if isasp=1 then
			dim is_end:is_end="<%"
			is_end=is_end&"if not in_sdcms then response.write(""template load fail""):response.end() end if"
			is_end=is_end&"%"
			is_end=is_end&">"
			if instr(t0,is_end)<=0 then
				t1=is_end&t1
			end if
		end if
		sdcms.newfile t2,arr(ubound(arr)),t1,""
		
		dim fname:fname=replace(filename,theme_root&"/","")
		dim str:str="<%"
		str=str&"dim block_arr:block_arr=array("
		dim j,i
		i=0
		for j=0 to ubound(block_arr)
			if j>0 then str=str&","
			dim t3:t3=block_arr(j)
			if t3(0)=fname then
				i=1
				str=str&"array("""&t3(0)&""","""&t0&""")"
			else
				str=str&"array("""&t3(0)&""","""&t3(1)&""")"
			end if
		next
		if i=0 then
			str=str&","
			str=str&"array("""&fname&""","""&t0&""")"
		end if
		str=str&")%"
		str=str&">"
		str=replace(str,"(,","(")
		sdcms.newfile "../theme/"&theme_root&"/","base.asp",str,""
		
		sdcms.ajaxjson "保存成功",1
	end sub
	
	dim picsrc,edittype
	sub check_file(byval t0)
		select case lcase(t0)
		case "htm","tml"
			picsrc="html"
			edittype=true
		case "asp","css",".js"
			picsrc="txt"
			edittype=true
		case "rar","swf","pdf","psd","ppt","xls"
			picsrc=t0
		case "bmp","jpg","gif","png":
			picsrc="bmp"
		case else
			picsrc="txt"
		end select
	end sub
	
	islogin
	checkpagelever 30
	dim act:act=lcase(sdcms.fget("act",0))
	select case act
		case "aply"
			dim rootdir:rootdir=sdcms.fpost("t0",0)
			if not(sdcms.isfolder("../theme/"&rootdir&"/")) then
				sdcms.echo "0&#24212;&#29992;&#22833;&#36133;&#65292;&#27169;&#26495;&#19981;&#23384;&#22312;"
			else
				if not(sdcms.isfile("../theme/"&rootdir&"/base.asp")) then
					dim html:html="<%"
					html=html&"dim block_arr:block_arr=array("
					html=html&")%"
					html=html&">"
					sdcms.newfile "../theme/"&rootdir&"/","base.asp",html,""
				end if
				'保存模板配置
				dim config
				config=config&"<%"&vbcrlf
				config=config&"dim theme_root"&vbcrlf
				config=config&"	theme_root="""&rootdir&""""&vbcrlf
				config=config&"%"
				config=config&">"&vbcrlf
				config=config&"<!--#include file=""theme/"&rootdir&"/base.asp""-->"
				sdcms.newfile "../","skins.asp",config,""
				config=""
				config=config&"<!--#include file=""skins.asp""-->"&vbcrlf
				config=config&"<!--#include file=""theme/"&rootdir&"/config.asp""-->"
				sdcms.newfile "../","theme.asp",config,""
				sdcms.echo "1"
			end if
		case "list"
			dim folder:folder=sdcms.fget("folder",0)
			if not(sdcms.checkstr(folder,"file")) then
				sdcms.echo "folder is wrong"
				sdcms.die
			end if
			if not(sdcms.isfolder("../theme/"&folder)) then
				sdcms.echo "folder is wrong"
				sdcms.die
			end if
			dim arr:arr=split(folder,"/")
			dim position,i,str
			for i=0 to ubound(arr)
				if i=0 then
					str=arr(i)
				else
					str=str&"/"&arr(i)
				end if
				position=position&" > <a href=""?act=list&folder="&str&""">"&arr(i)&"</a>"
			next
			load theme_theme_folder
		case "edit"
			dim filename:filename=sdcms.fget("filename",0)
			filename=replace(filename,"..","")
			if not(sdcms.checkstr(filename,"filename")) then
				sdcms.echo "filename is wrong"
				sdcms.die
			end if
			if not(sdcms.isfile("../theme/"&filename)) then
				sdcms.echo "filename is wrong"
				sdcms.die
			end if
			arr=split(filename,"/")
			folder=arr(0)
			for i=0 to ubound(arr)-1
				if i=0 then
					str=arr(i)
				else
					str=str&"/"&arr(i)
				end if
				position=position&" > <a href=""?act=list&folder="&str&""">"&arr(i)&"</a>"
			next
			dim iscss:iscss=0
			dim troot:troot=replace(filename,"/"&arr(ubound(arr)),"")
			if lcase(right(filename,4))=".css" then iscss=1
			dim temp_content:temp_content=sdcms.loadfile("../theme/"&filename)
			dim r_mid:r_mid="<%"
			r_mid=r_mid&"if not in_sdcms then response.write(""template load fail""):response.end() end if"
			r_mid=r_mid&"%"
			r_mid=r_mid&">"
			temp_content=replace(temp_content,r_mid,"")
			dim block_txt:block_txt=getblockname(replace(filename,theme_root&"/",""))
			load theme_theme_edit
		case "editdb":editdb
		case else
			load theme_theme
	end select
	
	sdcms.db.dbclose
%>