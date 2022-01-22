<!--#include file="base.asp"-->
<!--#include file="../lib/class/sdcms.upload.asp"-->
<!--#include file="../lib/class/sdcms.draw.asp"-->
<%
''' SDCMS 上传
''' ==================================================================
''' 版权所有 http://www.sdcms.cn
''' ------------------------------------------------------------------
''' 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和使用；
''' 未经授权不允许对程序代码以任何形式任何目的的再发布。
''' ==================================================================
''' 编写: IT平民
''' 修改：IT平民 in 2014.07

	sub getjson(byval t0,byval t1,byval t2,byval t3)
		if t0=0 Then
			sdcms.echo "{""url"":"""",""original"":"""",""title"":"""",""state"":"""&t3&"""}"
		else
			sdcms.echo "{""url"":"""&t1&""",""original"":"""&t2&""",""title"":"""&t2&""",""state"":"""&t3&"""}"
		end if
	end sub
	
	function get_uploaderr(byval t0)
		dim t1:t1=""
		select case t0
			case -1:t1="没有文件上传"
			case 1:t1="文件过大，上传失败"
			case 2:t1="不允许被上传的文件"
			case 3:t1="文件过大，且不允许被上传"
			case 4:t1="文件保存失败"
			case 5:t1="禁止上传此类文件"
		end select
		get_uploaderr=t1
	end function

	sub adddb(byval t0,byval t1,byval t2,byval t3,byval t4,byval t5,byval t6,byval t7,byval t8,byval t9)
		sdcms.db.insert "sd_attachment",array(array("classid",t9,0,0),array("cid",t8,0,0),array("filepath",t0,255,1),array("filename",t1,255,1),array("filesize",sdcms.getnum(t2),255,1),array("oldname",t3,255,1),array("fileext",t4,50,1),array("ispic",sdcms.is_pic("."&t4),1,0),array("createip",sdcms.getip,255,1),array("createdate",t5,255,0),array("adminid",t6,0,0),array("userid",t7,0,0),array("fullname",t0&t1,0,1))
		if sdcms.is_pic(t1)=1 then
			dim draw
			set draw=new sdcms_draw
				draw.add t0&t1
			set draw=nothing
		end if
	end sub
	
	sub editordb()
		if adminid="" then
			getjson 0,"","","登录失败"
			exit sub
		end if
		dim classid,cid
		classid=sdcms.getint(sdcms.fget("classid",0),0)
		cid=sdcms.getint(sdcms.fget("cid",0),0)
		dim upload
		set upload=new sdcms_upload
			select case act
				case "video"
					upload.filetype="flv|mp4|swf|mp3"
				case "file"
					upload.filetype="gif|jpg|png|bmp|flv|mp4|swf|mp3|rar|zip|tar|gz|7z|bz2|cab|iso|apk|doc|docx|xls|xlsx|ppt|pptx|pdf|txt|md|xml"
				case else
					upload.filetype="gif|jpg|png|bmp"
			end select
			upload.savepath=sdcms.uploaddir("")
			upload.charset="utf-8"
			upload.maxsize=sdcms.getsys("upmaxsize")
			upload.autosave=0
			upload.open()
			dim i,filepath,filenew,filename,filesize,oldname,fileext,errstr
			for i=1 to ubound(upload.fileitem)
				filepath=upload.savepath
				filenew=upload.form(upload.fileitem(i))
				filename=lcase(filepath&filenew)
				filesize=upload.form(upload.fileitem(i)&"_size")/1024
				fileext=upload.form(upload.fileitem(i)&"_ext")
				oldname=upload.form(upload.fileitem(i)&"_name")
				errstr=get_uploaderr(upload.form(upload.fileitem(i)&"_Err"))
				if len(errstr)>0 then
					getjson 0,"","",errstr
				else
					getjson 1,filename,oldname,"SUCCESS"
					adddb filepath,filenew,filesize,oldname,fileext,sqltime,adminid,0,cid,classid
				end if
			next
		set upload=nothing
	end sub
	
	sub swfdb()
		if isuplogin=0 then
			sdcms.echo "0,登录失败，请退出重新登陆_swf"
			exit sub
		end if
		dim upload,filetype,uptype,classid,cid
		filetype=sdcms.fget("filetype",0)
		classid=sdcms.getint(sdcms.fget("classid",0),0)
		cid=sdcms.getint(sdcms.fget("cid",0),0)
		select case filetype
			case "2":uptype="rar|zip|tar|gz|7z|bz2|cab|iso|apk|doc|docx|xls|xlsx|ppt|pptx|pdf|txt|md|xml"
			case "3":uptype="flv|mp4|swf"
			case "4":uptype="gif|jpg|png|bmp|flv|mp4|swf|mp3|rar|zip|tar|gz|7z|bz2|cab|iso|apk|doc|docx|xls|xlsx|ppt|pptx|pdf|txt|md|xml"
			case "5":uptype="swf"
			case else:uptype="gif|jpg|png|bmp"
		end select
		set upload=new sdcms_upload
			upload.filetype=uptype
			upload.savepath=sdcms.uploaddir("")
			upload.charset="utf-8"
			upload.maxsize=sdcms.getsys("upmaxsize")
			upload.autosave=0
			upload.open()
			dim i,filepath,filenew,filename,filesize,oldname,fileext,errstr
			dim admin_id:admin_id=sdcms.getint(sdcms.fget("admin_id",0),0)
			for i=1 to ubound(upload.fileitem)
				filepath=upload.savepath
				filenew=upload.form(upload.fileitem(i))
				filename=filepath&filenew
				filesize=upload.form(upload.fileitem(i)&"_size")/1024
				fileext=upload.form(upload.fileitem(i)&"_ext")
				oldname=upload.form(upload.fileitem(i)&"_name")
				errstr=get_uploaderr(upload.form(upload.fileitem(i)&"_Err"))
				if sdcms.strlen(errstr)>0 then
					sdcms.echo "{""error"":"""&errstr&"""}"
				else
					adddb filepath,filenew,filesize,oldname,fileext,sqltime,admin_id,0,cid,classid
					sdcms.echo "{""fileurl"":"""&filename&"""}"
				end if
			next
		set upload=nothing
	end sub

	sub configdb()
		if adminid="" then
			exit sub
		end if
		Response.AddHeader "Content-Type", "text/plain"
		dim html:html=""
		html=html&"{"&vbcrlf
		html=html&"    ""imageActionName"": ""image"","&vbcrlf
		html=html&"    ""imageFieldName"": ""upfile"","&vbcrlf
		html=html&"    ""imageMaxSize"": "&sdcms.getsys("upmaxsize")*1000&","&vbcrlf
		html=html&"    ""imageAllowFiles"": ["".png"", "".jpg"", "".gif"", "".bmp""],"&vbcrlf
		html=html&"    ""imageCompressEnable"": true,"&vbcrlf
		html=html&"    ""imageCompressBorder"": 600,"&vbcrlf
		html=html&"    ""imageInsertAlign"": ""none"","&vbcrlf
		html=html&"    ""imageUrlPrefix"": """","&vbcrlf
		html=html&"    ""imagePathFormat"": """","&vbcrlf

		html=html&"    ""videoActionName"": ""video"","&vbcrlf
		html=html&"    ""videoFieldName"": ""upfile"","&vbcrlf
		html=html&"    ""videoPathFormat"": """","&vbcrlf
		html=html&"    ""videoUrlPrefix"": """","&vbcrlf
		html=html&"    ""videoMaxSize"": "&sdcms.getsys("upmaxsize")*1000&","&vbcrlf
		html=html&"    ""videoAllowFiles"": ["".flv"", "".swf"", "".mp4"","".mp3""],"&vbcrlf
		html=html&"    ""fileActionName"": ""file"","&vbcrlf
		html=html&"    ""fileFieldName"": ""upfile"","&vbcrlf
		html=html&"    ""filePathFormat"": """","&vbcrlf
		html=html&"    ""fileUrlPrefix"": """","&vbcrlf
		html=html&"    ""fileMaxSize"": "&sdcms.getsys("upmaxsize")*1000&","&vbcrlf
		html=html&"    ""fileAllowFiles"": ["&vbcrlf
		html=html&"        "".png"", "".jpg"", "".gif"", "".bmp"","&vbcrlf
		html=html&"        "".flv"", "".swf"", "".mp3"", "".mp4"","&vbcrlf
		html=html&"        "".rar"", "".zip"", "".tar"", "".gz"", "".7z"", "".bz2"", "".cab"", "".iso"","&vbcrlf
		html=html&"        "".doc"", "".docx"", "".xls"", "".xlsx"", "".ppt"", "".pptx"", "".pdf"", "".txt"", "".md"", "".xml"""&vbcrlf
		html=html&"    ]"&vbcrlf
		html=html&"}"
		sdcms.echo html
	end sub
	
	on error resume next
	dim act:act=sdcms.fget("action",0)
	select case act
		case "swf":swfdb
		case "config":configdb
		case else:editordb
	end select
%>