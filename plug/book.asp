<!--#include file="../lib/base.asp"-->
<!--#include file="../theme.asp"-->
<%
''' SDCMS 留言
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
		case "islogin":userstaus
		case "add":adddb
		case else
			dim config:config=eval(sdcms.getsys("expand.book"))
			if not(config(0)) then
				sdcms.echo "&#26410;&#24320;&#21551;&#30041;&#35328;"
				sdcms.die
			end if
			dim root:root="book"
			sdcms.show theme_book,""
	end select
	sdcms.db.dbclose
	
	sub userstaus()
		if sdcms.is_login then
			dim userdata:userdata=sdcms.userinfo
			sdcms.echo "<input type=""text"" name=""t0"" id=""nicekname"" maxlength=""20"" class=""ip"" value="""&userdata(13)&""" readonly=""readonly"" /> (<a href="""&webroot&"user/login.asp?act=out&gourl="&webroot&"plug/book.asp"">匿名发表</a>)"
		else
			sdcms.echo "<input type=""text"" name=""t0"" id=""nicekname"" maxlength=""20"" class=""ip"" /> (<a href="""&webroot&"user/login.asp?gourl="&webroot&"plug/book.asp"">登陆发表</a>)"
		end if
	end sub
	
	sub adddb()
		dim t0,t1,t2,t3,t4,t5,t6
		t0=sdcms.enhtml(sdcms.fpost("t0",0))
		t1=sdcms.enhtml(sdcms.fpost("t1",0))
		t2=sdcms.enhtml(sdcms.fpost("t2",0))
		t3=sdcms.getint(sdcms.fpost("t3",0),0)
		t4=sdcms.enhtml(sdcms.fpost("t4",0))
		t5=sdcms.enhtml(sdcms.fpost("t5",0))
		t6=sdcms.enhtml(sdcms.fpost("t6",0))
		dim config:config=eval(sdcms.getsys("expand.book"))
		if not(config(0)) then
			response.Write "未开启留言"
			exit sub
		end if
		dim f,passnum
		if config(1) then
			f=1
			passnum=0
		else
			f=2
			passnum=1
		end if
		if not(sdcms.checkpost) then
			response.Write "禁止外部提交数据"
			exit sub
		end if
		if sdcms.strlen(t0)=0 then
			response.Write "姓名不能为空"
			exit sub
		end if
		if sdcms.strlen(t2)=0 then
			response.Write "电话不能为空"
			exit sub
		end if
		if sdcms.strlen(t1)=0 then
			response.Write "留言内容不能为空"
			exit sub
		end if
		if sdcms.strlen(t1)<5 then
			response.Write "留言内容至少输入5个字符"
			exit sub
		end if
		if sdcms.loadcookie("book_add")<>"" then
			if int(datediff("s",sdcms.loadcookie("book_add"),now()))<=60 then
				response.Write "请勿重复提交"
				exit sub
			end if
		end if
		dim userid,avatar
		userid=0
		avatar=0
		if sdcms.is_login then
			dim userdata:userdata=sdcms.userinfo
			userid=userdata(0)
			avatar=userdata(12)
			if t0<>userdata(13) then
				t0=userdata(13)
			end if
		end if
		dim data
		data=array(array("username",t0,20,1),array("content",t1,255,1),array("email",t5,255,1),array("title",t6,255,1),array("tel",t2,20,1),array("sex",t3,1,1),array("userid",userid,0,0),array("avatar",avatar,0,0),array("createdate",sqltime,0,0),array("islock",passnum,0,0),array("postip",sdcms.getip,0,1))
		sdcms.db.insert "sd_expand_book",data
		dim body:body=""
		dim title:title="您有一条新留言(来自网站)"
		body=body&"昵　称："&t0
		body=body&"<br>电　话："&t2
		dim sex
		select case t3
			case "0":sex="保密"
			case "1":sex="男"
			case "2":sex="女"
		end select
		body=body&"<br>性　别："&sex
		body=body&"<br>日　期："&now()
		body=body&"<br>内　容："&t1
		sdcms.sendmail sdcms.getsys("adminemail"),title,body
		response.Write "提交成功，我们会尽快给您回复，谢谢！"
		sdcms.setcookie "book_add",now()
	end sub
%>