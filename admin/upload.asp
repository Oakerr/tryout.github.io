<!--#include file="base.asp"-->
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

	islogin
	dim filetype:filetype=sdcms.getint(sdcms.fget("filetype",0),1)
	dim compress:compress=sdcms.getint(sdcms.fget("compress",0),1)
	dim limit:limit=sdcms.getint(sdcms.fget("limit",0),1)
	dim up_max_width:up_max_width=300
	dim up_max_height:up_max_height=300
	if limit>10 then limit=1
	dim uptype,cid,classid
	cid=sdcms.getint(sdcms.fget("cid",0),0)
	classid=sdcms.getint(sdcms.fget("classid",0),0)
	select case filetype
		case "2":uptype="doc|docx|xls|xlsx|ppt|pptx|rar|zip|7z|pdf|txt|apk"
		case "3":uptype="mp4|flv|swf"
		case "4":uptype="gif|jpg|png|doc|docx|xls|xlsx|ppt|pptx|rar|zip|7z|pdf|txt|flv|mp4|apk"
		case "5":uptype="swf"
		case else:uptype="gif|jpg|png"
	end select
	uptype=replace(uptype,"|",",")
	load theme_upload
%>