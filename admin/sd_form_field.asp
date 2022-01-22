<!--#include file="base.asp"-->
<%
''' SDCMS 模型
''' ==================================================================
''' 版权所有 http://www.sdcms.cn
''' ------------------------------------------------------------------
''' 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和使用；
''' 未经授权不允许对程序代码以任何形式任何目的的再发布。
''' ==================================================================
''' 编写: IT平民
''' 修改：IT平民 in 2014.08

	sub adddb()
		dim t0,t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13
		t0=sdcms.enhtml(sdcms.fpost("t0",0))
		t1=sdcms.enhtml(sdcms.fpost("t1",0))
		t2=sdcms.getint(sdcms.fpost("t2",0),0)
		t3=sdcms.getint(sdcms.fpost("t3",0),0)
		t4=sdcms.getint(sdcms.fpost("t4",0),0)
		t5=sdcms.getint(sdcms.fpost("t5",0),0)
		t6=sdcms.enhtml(sdcms.fpost("t6",0))
		t7=sdcms.enhtml(sdcms.fpost("t7",0))
		t8=sdcms.getint(sdcms.fpost("t8",0),0)
		t9=sdcms.getint(sdcms.fpost("t9",0),0)
		t10=sdcms.getint(sdcms.fpost("t10",0),0)
		t11=sdcms.getint(sdcms.fpost("t11",0),0)
		t12=sdcms.getint(sdcms.fpost("t12",0),0)
		t13=sdcms.getint(sdcms.fpost("t13",0),0)
		if sdcms.strlen(t0)=0 then sdcms.ajaxjson "字段名称不能为空",0:exit sub
		if sdcms.strlen(t1)=0 then sdcms.ajaxjson "字段别名不能为空",0:exit sub
		if sdcms.strlen(t2)=0 then sdcms.ajaxjson "字段类型不能为空",0:exit sub
		t0="fm_"&t0
		if t8=0 then t9=0
		'字段类型
		dim dtype
		select case t2
			case "1"
				select case t3
					case "1","4":dtype="文本"
					case "2":dtype="数字"
					case "3":dtype="日期"
					case "5":dtype="货币"
				end select
			case "2"
				dtype="备注"
			case "6"
				dtype="备注"
				t8=0
			case "3","4","5"
				dtype="文本"
				t5=255
			case else
				select case t4
					case "1":dtype="文本"
					'case "2":dtype="数字"
				end select
		end select
		t0=left(t0,20)
		dim sqlstr
		select case dtype
			case "文本":sqlstr=""&t0&" nvarchar("&t5&") null"
			case "数字":sqlstr=""&t0&" int null"
			case "货币":sqlstr=""&t0&" money null"
			case "日期":sqlstr=""&t0&" datetime null"
			case "备注":sqlstr=""&t0&" ntext null"	
		end select
		dim mdata:mdata=sdcms.db.dbload(1,"tablename","sd_form","id="&formid&"","id")
		if ubound(mdata)<0 then
			sdcms.ajaxjson "模型数据错误"&modelid&"",0:exit sub
		end if
		dim tablename:tablename=mdata(0,0)
		sqlstr="alter table "&tablename&" add "&sqlstr
		dim data
		data=array(array("fname",t0,0),array("falias",t1,9),array("fclass",t2,0),array("fmode",t3,0),array("fdatatype",t4,0),array("flength",t5,5),array("fdefault",t6,255),array("foptions",t7,0),array("fismust",t8,0),array("frules",t9,0),array("fistrim",t10,0),array("ordnum",t11,0),array("islock",t12,0),array("isshow",t13,0),array("formid",formid,0))
		if sdcms.db.dbnew("sd_form_field",data,"fname='"&t0&"' and formid="&formid&"")=0 then
			sdcms.ajaxjson "字段名称已存在，请换个试试",0:exit sub
		else
			sdcms.db.exedb(sqlstr)
			sdcms.ajaxjson "保存成功",1
		end if
	end sub
	
	sub editdb()
		dim t1,t6,t7,t8,t9,t10,t11,t12,t13
		t1=sdcms.enhtml(sdcms.fpost("t1",0))
		t6=sdcms.enhtml(sdcms.fpost("t6",0))
		t7=sdcms.enhtml(sdcms.fpost("t7",0))
		t8=sdcms.getint(sdcms.fpost("t8",0),0)
		t9=sdcms.getint(sdcms.fpost("t9",0),0)
		t10=sdcms.getint(sdcms.fpost("t10",0),0)
		t11=sdcms.getint(sdcms.fpost("t11",0),0)
		t12=sdcms.getint(sdcms.fpost("t12",0),0)
		t13=sdcms.getint(sdcms.fpost("t13",0),0)
		if sdcms.strlen(t1)=0 then sdcms.ajaxjson "字段别名不能为空",0:exit sub
		if t8=0 then t9=0
		dim data,id
		id=sdcms.getint(sdcms.fget("id",0),0)
		data=array(array("falias",t1,7,1),array("fdefault",t6,255,1),array("foptions",t7,0,1),array("fismust",t8,0,0),array("frules",t9,0,0),array("fistrim",t10,0,0),array("ordnum",t11,0,0),array("islock",t12,0,0),array("isshow",t13,0,0))
		if sdcms.db.dbupdate("sd_form_field","id="&id&"",data)=1 then
			sdcms.ajaxjson "保存成功",1
		end if
	end sub
	
	sub orderdb()
		dim t0,t1,t2,t3,i
		t0=sdcms.enhtml(sdcms.fpost("ordnum",0))
		t1=sdcms.enhtml(sdcms.fpost("id",0))
		t2=split(t0,", ")
		t3=split(t1,", ")
		if ubound(t2)-ubound(t3)<>0 then sdcms.ajaxjson "0&#21442;&#25968;&#38169;&#35823;",0:exit sub
		for i=0 to ubound(t2)
			if sdcms.isnum(t2(i)) then
				sdcms.db.dbupdate "sd_form_field","id="&t3(i)&"",array(array("ordnum",t2(i),10,0,0))
			end if
		next
		sdcms.ajaxjson "保存成功",1
	end sub
	
	sub deldb()
		dim id:id=sdcms.getint(sdcms.fget("id",0),0)
		dim data:data=sdcms.db.dbload(1,"formid,fname","sd_form_field","id="&id&"","")
		if ubound(data)<0 then
			exit sub
		end if
		dim mdata:mdata=sdcms.db.dbload(1,"tablename","sd_form","id="&data(0,0)&"","id")
		if ubound(mdata)<0 then
			exit sub
		end if
		sdcms.db.dbdel "sd_form_field","id="&id
		dim sqlstr:sqlstr="alter table "&mdata(0,0)&" drop "&data(1,0)
		sdcms.db.exedb(sqlstr)
		sdcms.echo "1"
	end sub
	
	sub delcache()
		sdcms.delcache "form_field"&formid
	end sub
	
	function get_type(byval t0)
		select case t0
			case "1":get_type="单行文本框"
			case "2":get_type="多行文本框"
			case "3":get_type="下拉列表"
			case "4":get_type="单选按钮"
			case "5":get_type="复选框"
		end select
	end function
	
	function get_data(byval t0)
		select case t0
			case "1":get_data="文本"
			case "2":get_data="数字"
			case "3":get_data="货币"
			case "4":get_data="日期"
			case "5":get_data="备注"
		end select
	end function
	
	islogin
	checkpagelever 49
	dim act:act=lcase(sdcms.fget("act",0))
	dim formid:formid=sdcms.getint(sdcms.fget("formid",0),0)
	select case act
		case "add":load theme_form_field_add
		case "adddb":adddb:delcache
		case "edit"
			dim datadb,id
			id=sdcms.getint(sdcms.fget("id",0),0)
			datadb=sdcms.db.dbload("","fname,falias,fclass,fmode,fdatatype,flength,fdefault,foptions,fismust,frules,fistrim,ordnum,islock,isshow","sd_form_field","id="&id&"","")
			load theme_form_field_edit
		case "editdb":editdb:delcache
		case "order":orderdb:delcache
		case "del":deldb:delcache
		case else:load theme_form_field
	end select
		
	sdcms.db.dbclose
%>