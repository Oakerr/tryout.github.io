﻿<!--#include file="base.asp"-->
<%
''' SDCMS 模型
''' ==================================================================
''' 版权所有 http://www.sdcms.cn
''' ------------------------------------------------------------------
''' 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和使用；
''' 未经授权不允许对程序代码以任何形式任何目的的再发布。
''' ==================================================================
''' 编写: IT平民
''' 修改：IT平民 in 2014.07

	sub adddb()
		dim t0,t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11
		t0=sdcms.enhtml(sdcms.fpost("t0",0))
		t1=sdcms.enhtml(sdcms.fpost("t1",0))
		t2=sdcms.enhtml(sdcms.fpost("t2",0))
		t3=sdcms.enhtml(sdcms.fpost("t3",0))
		t4=sdcms.enhtml(sdcms.fpost("t4",0))
		t5=sdcms.enhtml(sdcms.fpost("t5",0))
		t6=sdcms.enhtml(sdcms.fpost("t6",0))
		t7=sdcms.enhtml(sdcms.fpost("t7",0))
		t8=sdcms.enhtml(sdcms.fpost("t8",0))
		t9=sdcms.enhtml(sdcms.fpost("t9",0))
		t10=sdcms.enhtml(sdcms.fpost("t10",0))
		t11=sdcms.enhtml(sdcms.fpost("t11",0))
		if sdcms.strlen(t0)=0 then sdcms.ajaxjson "&#27169;&#22411;&#21517;&#31216;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		if sdcms.strlen(t1)=0 then sdcms.ajaxjson "&#25968;&#25454;&#34920;&#21517;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		if sdcms.strlen(t3)=0 then sdcms.ajaxjson "&#31649;&#29702;&#36335;&#24452;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		if sdcms.strlen(t4)=0 then sdcms.ajaxjson "&#39057;&#36947;&#27169;&#26495;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		if sdcms.strlen(t5)=0 then sdcms.ajaxjson "&#21015;&#34920;&#27169;&#26495;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		if sdcms.strlen(t6)=0 then sdcms.ajaxjson "&#20869;&#23481;&#27169;&#26495;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		if sdcms.strlen(t7)=0 then sdcms.ajaxjson "&#21518;&#21488;&#20869;&#23481;&#28155;&#21152;&#27169;&#26495;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		if sdcms.strlen(t8)=0 then sdcms.ajaxjson "&#21518;&#21488;&#20869;&#23481;&#20462;&#25913;&#27169;&#26495;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		if sdcms.strlen(t9)=0 then sdcms.ajaxjson "&#21518;&#21488;&#25237;&#31295;&#31649;&#29702;&#27169;&#26495;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		if sdcms.strlen(t10)=0 then sdcms.ajaxjson "&#21069;&#21488;&#25237;&#31295;&#27169;&#26495;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		if sdcms.strlen(t11)=0 then sdcms.ajaxjson "&#21069;&#21488;&#25237;&#31295;&#25991;&#20214;&#36335;&#24452;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		t1="sd_model_"&t1
		dim data
		data=array(array("modelname",t0,22),array("tablename",t1,22),array("modeldesc",t2,255),array("adminurl",t3,255),array("default_temp",t4,255),array("list_temp",t5,255),array("show_temp",t6,255),array("islock",1,0),array("admin_add_temp",t7,255),array("admin_edit_temp",t8,255),array("admin_publish_temp",t9,255),array("pre_publish_temp",t10,255),array("pre_publish_url",t11,255))
		if lcase(left(t1,20))="sd_model_field" or lcase(left(t1,20))="sd_model_page"  then
			sdcms.ajaxjson "数据表名为系统保留，请更换",0
			exit sub
		end if
		if sdcms.db.dbnew("sd_model",data,"tablename='"&t1&"'")=0 then
			sdcms.ajaxjson "&#25968;&#25454;&#34920;&#21517;&#24050;&#23384;&#22312;&#65292;&#35831;&#25442;&#20010;&#35797;&#35797;",0:exit sub
		else
			t1=left(t1,20)
			dim sql:sql="CREATE TABLE ["&t1&"] (["&replace(t1,"sd_","")&"id] int IDENTITY (1, 1) PRIMARY KEY NOT NULL,[cid] int NULL,[content] ntext NULL)"
			sdcms.db.exedb(sql)
			sdcms.ajaxjson "保存成功",1
		end if
	end sub
	
	sub editdb()
		dim t0,t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11
		t0=sdcms.enhtml(sdcms.fpost("t0",0))
		t2=sdcms.enhtml(sdcms.fpost("t2",0))
		t3=sdcms.enhtml(sdcms.fpost("t3",0))
		t4=sdcms.enhtml(sdcms.fpost("t4",0))
		t5=sdcms.enhtml(sdcms.fpost("t5",0))
		t6=sdcms.enhtml(sdcms.fpost("t6",0))
		t7=sdcms.enhtml(sdcms.fpost("t7",0))
		t8=sdcms.enhtml(sdcms.fpost("t8",0))
		t9=sdcms.enhtml(sdcms.fpost("t9",0))
		t10=sdcms.enhtml(sdcms.fpost("t10",0))
		t11=sdcms.enhtml(sdcms.fpost("t11",0))
		if sdcms.strlen(t0)=0 then sdcms.ajaxjson "&#27169;&#22411;&#21517;&#31216;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		if sdcms.strlen(t3)=0 then sdcms.ajaxjson "&#31649;&#29702;&#36335;&#24452;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		if sdcms.strlen(t4)=0 then sdcms.ajaxjson "&#39057;&#36947;&#27169;&#26495;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		if sdcms.strlen(t5)=0 then sdcms.ajaxjson "&#21015;&#34920;&#27169;&#26495;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		if sdcms.strlen(t6)=0 then sdcms.ajaxjson "&#20869;&#23481;&#27169;&#26495;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		if sdcms.strlen(t7)=0 then sdcms.ajaxjson "&#21518;&#21488;&#20869;&#23481;&#28155;&#21152;&#27169;&#26495;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		if sdcms.strlen(t8)=0 then sdcms.ajaxjson "&#21518;&#21488;&#20869;&#23481;&#20462;&#25913;&#27169;&#26495;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		if sdcms.strlen(t9)=0 then sdcms.ajaxjson "&#21518;&#21488;&#25237;&#31295;&#31649;&#29702;&#27169;&#26495;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		if sdcms.strlen(t10)=0 then sdcms.ajaxjson "&#21069;&#21488;&#25237;&#31295;&#27169;&#26495;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		if sdcms.strlen(t11)=0 then sdcms.ajaxjson "&#21069;&#21488;&#25237;&#31295;&#25991;&#20214;&#36335;&#24452;&#19981;&#33021;&#20026;&#31354;",0:exit sub
	
		dim data,id
		id=sdcms.getint(sdcms.fget("id",0),0)
		data=array(array("modelname",t0,20,1),array("modeldesc",t2,255,1),array("adminurl",t3,255,1),array("default_temp",t4,255,1),array("list_temp",t5,255,1),array("show_temp",t6,255,1),array("islock",1,0,0),array("admin_add_temp",t7,255,1),array("admin_edit_temp",t8,255,1),array("admin_publish_temp",t9,255,1),array("pre_publish_temp",t10,255,1),array("pre_publish_url",t11,255,1))
		if sdcms.db.dbupdate("sd_model","modelid="&id&"",data)=1 then
			sdcms.ajaxjson "保存成功",1
		end if
	end sub
	
	sub deldb()
		dim id:id=sdcms.getint(sdcms.fget("id",0),0)
		dim tablename,cnum
		tablename=sdcms.db.dbload(1,"tablename","sd_model","modelid="&id&" and modelid>4","")(0,0)
		if tablename="" then
			sdcms.echo "0&#21442;&#25968;&#38169;&#35823;&#65292;&#21024;&#38500;&#22833;&#36133;"
			exit sub
		else
			cnum=sdcms.db.dbcount(tablename,"")
			if cnum>0 then
				sdcms.echo "0&#24403;&#21069;&#27169;&#22411;&#20013;&#26377;&#20869;&#23481;&#19981;&#33021;&#21024;&#38500;"
				exit sub
			end if
			sdcms.db.dbdel "sd_model_field","modelid="&id
			sdcms.db.exedb("drop table "&tablename&"")
		end if
		sdcms.db.dbdel "sd_model","modelid="&id
		sdcms.echo "1"
	end sub
	
	sub doset()
		dim id:id=sdcms.enhtml(sdcms.fget("id",0))
		dim go:go=sdcms.enhtml(sdcms.fget("go",0))
		dim idarr:idarr=split(id,",")
		if ubound(idarr)<0 then
			sdcms.echo "0&#33267;&#23569;&#36873;&#25321;&#19968;&#26465;&#20449;&#24687;"
		else
			dim i
			for i=0 to ubound(idarr)
				if not isnumeric(idarr(i)) then
					sdcms.echo "0&#21442;&#25968;&#65306;"&idarr(i)&"&#19981;&#27491;&#30830;&#65292;&#35831;&#30830;&#35748;&#21518;&#20877;&#25805;&#20316;"
					exit sub
				end if
			next
			dim filed,result
			select case go
				case "islock":filed="islock":result=0
				case "nolock":filed="islock":result=1
				case else:sdcms.echo "0&#21442;&#25968;&#38169;&#35823;":exit sub
			end select
			sdcms.db.dbupdate "sd_model","modelid in("&id&")",array(array(filed,result,2,0))
			sdcms.echo "1"
		end if
	end sub

	sub recache()
		sdcms.delcache "category"
	end sub
	
	islogin
	checkpagelever 18
	dim act:act=lcase(sdcms.fget("act",0))
	select case act
		case "add":load eval("theme_model"&act)
		case "adddb":adddb:recache
		case "edit"
			dim datadb,id
			id=sdcms.getint(sdcms.fget("id",0),0)
			datadb=sdcms.db.dbload("","modelname,tablename,modeldesc,adminurl,default_temp,list_temp,show_temp,admin_add_temp,admin_edit_temp,admin_publish_temp,pre_publish_temp,pre_publish_url","sd_model","modelid="&id&"","")
			load eval("theme_model"&act)
		case "editdb":editdb:recache
		case "del":deldb:recache
		case "doset":doset:recache
		case else:load theme_modellist
	end select
		
	sdcms.db.dbclose
%>