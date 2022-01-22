<!--#include file="../lib/base.asp"-->
<!--#include file="../theme.asp"-->
<%
''' SDCMS 表单
''' ==================================================================
''' 版权所有 http://www.sdcms.cn
''' ------------------------------------------------------------------
''' 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和使用；
''' 未经授权不允许对程序代码以任何形式任何目的的再发布。
''' ==================================================================
''' 编写: IT平民
''' 修改：IT平民 in 2014.08

	sub adddb()
		dim data:data=sdcms.db.dbload(1,"tablename,ispost,iscode","sd_form","islock=1 and id="&id&"","id")
		if ubound(data)<0 then
			sdcms.ajaxjson "参数错误",0
			exit sub
		end if
		dim code:code=sdcms.enhtml(sdcms.fpost("code",0))
		dim userip:userip=sdcms.getip
		if data(1,0)=1 then
			if not(sdcms.checkpost) then
				sdcms.ajaxjson "&#31105;&#27490;&#22806;&#37096;&#25552;&#20132;&#25968;&#25454;",0
				exit sub
			end if
		end if
		if sdcms.loadcookie("form_"&id)<>"" then
			if int(datediff("s",sdcms.loadcookie("form_"&id),now()))<=60 then
				sdcms.ajaxjson "&#35831;&#21247;&#37325;&#22797;&#25552;&#20132;",0
				exit sub
			end if
		end if
		if data(2,0)=1 then
			if sdcms.strlen(code)=0 then
				sdcms.ajaxjson "验证码不能为空",0
				exit sub
			end if
			if sdcms.loadsession("imgcode")="" then
				sdcms.ajaxjson "无法获取系统验证码",0
				exit sub
			end if
			if sdcms.loadsession("imgcode")<>code then
				sdcms.ajaxjson "验证码错误",0
				exit sub
			end if
		end if

		dim fstr:fstr=deal_form_field(id)
		fstr="array(array(""userip"",userip,50,1),array(""createdate"",sqltime,0,0)"&fstr&")"
		sdcms.db.insert data(0,0),eval(fstr)
		sdcms.setcookie "form_"&id,now()
		sdcms.ajaxjson "提交成功",1
	end sub
		
	function get_self_field(byval t0,byval t1,byval t2,byval t3,byval t4,byval t5,byval t6,byval t7,byval t8,byval t9,byval t10)
		dim str:str=""
		if t6=1 then
			dim rule
			rule="data-rule="""&t1&":required;"
			select case t7
				case "2":rule=rule&"digits;"
				case "3":rule=rule&"dot;"
				case "4":rule=rule&"tel;"
				case "5":rule=rule&"mobile;"
				case "6":rule=rule&"email;"
				case "7":rule=rule&"date;"
				case "8":rule=rule&"postcode;"
				case "9":rule=rule&"qq;"
				case "10":rule=rule&"url;"
			end select
			rule=rule&""""
		end if
		dim i,arr,m
		arr=split(t5,vbcrlf)
		select case t2
		case "1"
			select case t3
				case "2":t4=10
				case "3":t4=50
				case "4":t4=255
				case "5":t4=10
			end select
			str=str&"<input type=""text"" name="""&t0&""" id="""&t0&""" value="""&t8&""" class="""&t9&""" maxlength="""&t4&""" "&rule&" />"
		case "3"
			str=str&"<select name="""&t0&""" id="""&t0&""" class="""&t9&""" "&rule&">"&vbcrlf
			str=str&"<option value="""">请选择"&t1&"</option>"&vbcrlf
			for i=0 to ubound(arr)
				if len(arr(i))>0 then
					if instr(arr(i),"|")>0 then
						m=split(arr(i),"|")
						str=str&"<option value="""&m(1)&""" "
						if m(1)=t8 then
							str=str&" selected"
						end if
						str=str&">"&m(0)&"</option>"&vbcrlf
					end if
				end if
			next
			str=str&"</select>"
		case "4","5"
			dim types:types=sdcms.iif(t2=4,"radio","checkbox")
			rule=replace(rule,"required;","checked")
			dim j:j=0
			for i=0 to ubound(arr)
				if len(arr(i))>0 then
					if instr(arr(i),"|")>0 then
						m=split(arr(i),"|")
						str=str&"<input type="""&types&""" name="""&t0&""" id="""&t0&"_"&i&""" value="""&m(1)&""" "
						if j=0 then
							str=str&" "&rule&" "
						end if
						if t2=4 then
							if m(1)=t8 then
								str=str&" checked"
							end if
						else
							if instr(", "&t8&", ",", "&m(1)&", ")>0 then
								str=str&" checked"
							end if
						end if
						str=str&">"&m(0)&""&vbcrlf
						j=j+1
					end if
				end if
			next
		case "2"
			str=str&"<textarea name="""&t0&""" id="""&t0&""" class="""&t10&""" "&rule&">"&t8&"</textarea>"
		end select
		get_self_field=str
	end function
	
	function deal_form_field(byval t0)
		dim a:a=sdcms.get_form_field(t0)
		if not isarray(a) then
			deal_form_field="":exit function
		end if
		dim fi,fstr,istrim,length,fname,fmode,iscn,formstr,rules
		for fi=0 to ubound(a,2)
			fstr=fstr&","
			fname=a(0,fi)
			istrim=a(10,fi)
			length=a(5,fi)
			fmode=a(3,fi)
			iscn=1
			rules=""
			select case a(2,fi)
				case "1"
					select case fmode
						case "2","5":length=10:iscn=0
						case "3":length=50
					end select
					formstr="sdcms.enhtml(sdcms.fpost("""&fname&""","&istrim&"))"
				case "2":length=0
					formstr="sdcms.enhtml(sdcms.fpost("""&fname&""","&istrim&"))"
				case "3","4","5":length=255
					formstr="sdcms.enhtml(sdcms.fpost("""&fname&""","&istrim&"))"
			end select
			fstr=fstr&"array("""&fname&""","&formstr&","&length&","&iscn&")"
			formstr=eval(formstr)
			if a(8,fi)=1 then
				if sdcms.strlen(formstr)=0 then sdcms.ajaxjson a(1,fi)&"不能为空",0:sdcms.die
				select case a(9,fi)
					case "2":rules="int"
					case "3":rules="price"
					case "4":rules="tel"
					case "5":rules="mobile"
					case "6":rules="email"
					case "7":rules="date"
					case "8":rules="zipcode"
					case "9":rules="qq"
					case "10":rules="url"
				end select
				if rules<>"" then
					if not(sdcms.checkstr(formstr,rules)) then
						sdcms.ajaxjson a(1,fi)&"格式错误",0:sdcms.die
					end if
				end if
			end if
		next
		deal_form_field=fstr
	end function
	
	dim act:act=sdcms.fget("act",0)
	dim id:id=sdcms.getint(sdcms.fget("id",0),0)
	select case act
		case "db":adddb
		case else
			dim rsshow
			set rsshow=sdcms.db.exedb("select top 1 title,iscode from sd_form where id="&id&" and islock=1")
			if rsshow.eof then
				dim errormsg:errormsg="表单不存在"
				sdcms.show theme_404,""
				rsshow.close
				set rsshow=nothing
				sdcms.db.dbclose
				sdcms.die
			end if
			dim form_data:form_data=sdcms.get_form_field(id)
			sdcms.show theme_form,""
	end select
	sdcms.db.dbclose
%>