<!--#include file="base.asp"-->
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
		dim t0,t1,t2,t3,t4
		t0=sdcms.enhtml(sdcms.fpost("t0",0))
		t1=sdcms.enhtml(sdcms.fpost("t1",0))
		t2=sdcms.getint(sdcms.fpost("t2",0),0)
		t3=sdcms.getint(sdcms.fpost("t3",0),0)
		t4=sdcms.getint(sdcms.fpost("t4",0),0)
		if sdcms.strlen(t0)=0 then sdcms.ajaxjson "表单名称不能为空",0:exit sub
		if sdcms.strlen(t1)=0 then sdcms.ajaxjson "数据表名不能为空",0:exit sub
		t1="sd_form_"&t1
		dim data:data=array(array("title",t0,52),array("tablename",t1,25),array("ispost",t2,0),array("iscode",t3,0),array("islock",t4,0))
		if sdcms.db.dbnew("sd_form",data,"tablename='"&t1&"'")=0 then
			sdcms.ajaxjson "数据表名已存在，请更换",0:exit sub
		else
			sdcms.db.exedb "CREATE TABLE ["&t1&"] ([ID] int IDENTITY (1, 1) PRIMARY KEY NOT NULL ,[userip] nvarchar (50) NULL,[createdate] datetime NULL )"
			sdcms.ajaxjson "保存成功",1
		end if
	end sub
	
	sub editdb()
		dim t0,t1,t2,t3,t4
		t0=sdcms.enhtml(sdcms.fpost("t0",0))
		t2=sdcms.getint(sdcms.fpost("t2",0),0)
		t3=sdcms.getint(sdcms.fpost("t3",0),0)
		t4=sdcms.getint(sdcms.fpost("t4",0),0)
		if sdcms.strlen(t0)=0 then sdcms.ajaxjson "表单名称不能为空",0:exit sub
		dim id:id=sdcms.getint(sdcms.fget("id",0),0)
		dim data:data=array(array("title",t0,50,1),array("ispost",t2,0,0),array("iscode",t3,0,0),array("islock",t4,0,0))
		if sdcms.db.dbupdate("sd_form","id="&id&"",data)=1 then
			sdcms.ajaxjson "保存成功",1
		end if
	end sub
	
	sub deldb()
		dim id:id=sdcms.getint(sdcms.fget("id",0),0)
		dim tablename:tablename=sdcms.db.dbload(1,"tablename","sd_form","id="&id&"","")(0,0)
		sdcms.db.exedb "DROP TABLE ["&tablename&"]"
		sdcms.db.dbdel "sd_form_field","formid="&id
		sdcms.db.dbdel "sd_form","id="&id
		sdcms.echo "1" 
	end sub
	
	sub did()
		dim id:id=sdcms.getint(sdcms.fget("id",0),0)
		dim sid:sid=sdcms.getint(sdcms.fget("sid",0),0)
		dim data:data=sdcms.db.dbload(1,"tablename","sd_form","id="&id&"","")
		if ubound(data)>=0 then
			sdcms.db.dbdel data(0,0),"id="&sid
		end if
		sdcms.echo "1"
	end sub

	islogin
	checkpagelever 49
	dim act:act=lcase(sdcms.fget("act",0))
	select case act
		case "add":load theme_form_add
		case "adddb":adddb
		case "edit","list"
			dim datadb,id
			id=sdcms.getint(sdcms.fget("id",0),0)
			datadb=sdcms.db.dbload("","title,tablename,ispost,iscode,islock","sd_form","id="&id&"","")
			if act="list" then
				dim fdata:fdata=sdcms.db.dbload("","falias,fname","sd_form_field","islock=1 and isshow=1 and formid="&id&"","ordnum,id")
			end if
			load eval("theme_form_"&act)
		case "editdb":editdb
		case "show"
			id=sdcms.getint(sdcms.fget("id",0),0)
			dim sid:sid=sdcms.getint(sdcms.fget("sid",0),0)
			dim data:data=sdcms.db.dbload(1,"tablename","sd_form","id="&id&"","")
			dim rsshow
			if ubound(data)>=0 then
				set rsshow=sdcms.db.exedb("select top 1 * from "&data(0,0)&" where id="&sid&"")
				if rsshow.eof then
					sdcms.echo "参数错误":sdcms.die
				end if
				dim form_data:form_data=sdcms.get_form_field(id)
				load theme_form_show
			end if
		case "del":deldb
		case "did":did
		case else:load theme_form
	end select
		
	sdcms.db.dbclose
%>