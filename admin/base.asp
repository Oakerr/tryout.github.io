<!--#include file="../lib/base.asp"-->
<!--#include file="../theme/admin/config.asp"-->
<!--#include file="../lib/cmd.asp"-->
<!--#include file="../lib/class/sdcms.pinyin.asp"-->
<%
''' SDCMS base
''' ==================================================================
''' 版权所有 http://www.sdcms.cn
''' ------------------------------------------------------------------
''' 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和使用；
''' 未经授权不允许对程序代码以任何形式任何目的的再发布。
''' ==================================================================
''' 编写: IT平民
''' 修改：IT平民 in 2014.07

function fuckdate(byval t0)
	t0=replace(t0,"上午 ","")
	t0=replace(t0,"下午 ","")
	t0=replace(t0,"星期一","")
	t0=replace(t0,"星期二","")
	t0=replace(t0,"星期三","")
	t0=replace(t0,"星期四","")
	t0=replace(t0,"星期五","")
	t0=replace(t0,"星期六","")
	t0=replace(t0,"星期日","")
	fuckdate=t0
end function

function get_adminfolder
	dim a,b,c
	a=request.servervariables("script_name")
	b=split(a,"/")
	c=ubound(b)
	get_adminfolder=replace(a,b(c),"")
end function

sub deal_tags(byval t0,byval t1)
	if sdcms.strlen(t0)>0 then
		dim t2,i
		t2=split(t0,",")
		for i=0 to ubound(t2)
			if sdcms.strlen(trim(t2(i)))>0 then
			dim rs
				set rs=server.createobject("adodb.recordset")
				rs.open "select hits from sd_expand_tags where title='"&trim(t2(i))&"'",sdcms.db.conn,1,3
				if not rs.eof then
				dim hits:hits=rs(0)
					if hits>0 then hits=hits-1 else hits=0
					rs.update
					rs(0)=hits
					rs.update
				end if
				rs.close
				set rs=nothing
			end if
		next
	end if
	if sdcms.strlen(t1)>0 then
		t2=split(t1,",")
		for i=0 to ubound(t2)
			if sdcms.strlen(trim(t2(i)))>0 then
				set rs=server.createobject("adodb.recordset")
				rs.open "select title,hits from sd_expand_tags where title='"&trim(t2(i))&"'",sdcms.db.conn,1,3
				if rs.eof then
					rs.addnew
					rs(0)=t2(i)
					rs(1)=1
				else
					rs.update
					rs(1)=rs(1)+1
				end if
				rs.update
				rs.close
				set rs=nothing
			end if
		next
	end if
end sub

sub deal_file(byval t0,byval t1)
	sdcms.db.dbupdate "sd_attachment","adminid="&adminid&" and cid<=0 and classid="&t1&"",array(array("cid",t0,0,0))
end sub

sub deal_del_file(byval t0,byval t1)
	sdcms.db.dbupdate "sd_attachment","cid="&t0&" and classid="&t1&"",array(array("cid",-1,0,0))
end sub

function getblockname(byval t0)
	dim j
	for j=0 to ubound(block_arr)
		dim t1:t1=block_arr(j)
		if t1(0)=""&t0&"" then
			getblockname=t1(1)
			exit function
		end if
	next
end function

function get_self_field(byval t0,byval t1,byval t2,byval t3,byval t4,byval t5,byval t6,byval t7,byval t8,byval t9,byval t10,byval t11,byval t12)
	dim str:str=""
	t8=sdcms.iif(isnull(t8),"",t8)
	if t12=0 then t8=sdcms.iif(t8="",t11,t8)
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
			case "3":t4=50:t8=replace(t8,"/","-")
			case "4":t4=255
			case "5":t4=10
			if t8<>"" then t8=formatnumber(t8,-1,-1)
		end select
		str=str&"<input type=""text"" name="""&t0&""" id="""&t0&""" size=""50"" value="""&t8&""" maxlength="""&t4&""" class=""ip"" "&rule&" />"
		if t3=4 then
			str=str&"<input type=""button"" value=""上传"" config="""&t0&":"&t9&":"&t10&":1"" class=""bnt bnt_save"" />"
		end if
	case "3"
		str=str&"<select name="""&t0&""" id="""&t0&""" class=""ip"" "&rule&">"&vbcrlf
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
	case "2","6"
		str=str&"<textarea name="""&t0&""" id="""&t0&""" "
		if t2=2 then
			str=str&"class=""tt"" cols=""51"" rows=""4"" "&rule&""
		else
			str=str&"style=""width:98%;"""
		end if
		str=str&">"&t8&"</textarea>"
	end select
	'str=str&"<span for="""&t0&""" class=""msg-box"">"
	get_self_field=str
end function

function deal_model_field(byval t0)
	dim a:a=sdcms.get_model_field(t0)
	if not isarray(a) then
		deal_model_field="":exit function
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
			case "6":length=0
				formstr="sdcms.fpost("""&fname&""","&istrim&")"
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
	deal_model_field=fstr
end function
%>