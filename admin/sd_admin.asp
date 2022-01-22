<!--#include file="base.asp"-->
<%
''' SDCMS 管理员
''' ==================================================================
''' 版权所有 http://www.sdcms.cn
''' ------------------------------------------------------------------
''' 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和使用；
''' 未经授权不允许对程序代码以任何形式任何目的的再发布。
''' ==================================================================
''' 编写: IT平民
''' 修改：IT平民 in 2014.07

	sub getcategory()
		dim i
		for i=0 to ubound(catedata,2)
			get_category=get_category&",{"
			get_category=get_category&"id:"&catedata(0,i)&","
			get_category=get_category&"pId:"&sdcms.iif(catedata(3,i)=0,"-1",catedata(3,i))&","
			get_category=get_category&"name:"""&catedata(1,i)&""""
			get_category=get_category&",open:true"
			if instr(","&catearray&",",","&catedata(0,i)&",")>0 then
				get_category=get_category&",checked:true"
			end if
			get_category=get_category&"}"
		next
	end sub
	
	sub adddb()
		dim t0,t1,t2,t3,t4
		t0=sdcms.enhtml(sdcms.fpost("t0",0))
		t1=sdcms.enhtml(sdcms.fpost("t1",0))
		t2=sdcms.getint(sdcms.fpost("t2",0),0)
		t3=sdcms.getint(sdcms.fpost("t3",0),0)
		t4=sdcms.enhtml(sdcms.fpost("t4",0))
		if sdcms.strlen(t0)=0 then sdcms.ajaxjson "&#29992;&#25143;&#21517;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		if sdcms.strlen(t1)=0 then sdcms.ajaxjson "&#23494;&#30721;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		dim data
		data=array(array("adminname",t0,20),array("adminpass",md5(t1),16),array("penname",t4,50),array("islock",t2,1),array("logintimes",0,0),array("groupid",t3,0))
		if sdcms.db.dbnew("sd_admin",data,"adminname='"&t0&"'")=0 then
			sdcms.ajaxjson "&#29992;&#25143;&#21517;&#24050;&#23384;&#22312;&#65292;&#35831;&#25442;&#20010;&#35797;&#35797;",0:exit sub
		else
			sdcms.ajaxjson "保存成功",1
		end if
	end sub
	
	sub editdb()
		dim id:id=sdcms.getint(sdcms.fget("id",0),0)
		if id>0 then
			dim t1,t2,t3,t4
			t1=sdcms.enhtml(sdcms.fpost("t1",0))
			t2=sdcms.getint(sdcms.fpost("t2",0),0)
			t3=sdcms.getint(sdcms.fpost("t3",0),0)
			t4=sdcms.enhtml(sdcms.fpost("t4",0))
			dim data
			if sdcms.strlen(t1)=0 then
				data=array(array("penname",t4,50,1),array("islock",t2,1,0),array("groupid",t3,0,0))
			else
				data=array(array("adminpass",md5(t1),18,1),array("penname",t4,50,1),array("islock",t2,1,0),array("groupid",t3,0,0))
			end if
			if sdcms.db.dbupdate("sd_admin","adminid="&id&"",data)=1 then
				if id=adminid then
					dim t5:t5=sdcms.loadcookie("loginkey")
					sdcms.setcookie "loginpwd",md5(adminname&md5(t1)&t5)
				end if
			end if
		end if
		sdcms.ajaxjson "保存成功",1
	end sub
	
	sub passdb()
		dim t0,t1,t2
		t0=sdcms.enhtml(sdcms.fpost("t0",0))
		t1=sdcms.enhtml(sdcms.fpost("t1",0))
		t2=sdcms.enhtml(sdcms.fpost("t2",0))
		if sdcms.strlen(t0)=0 then sdcms.ajaxjson "&#21407;&#23494;&#30721;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		if sdcms.strlen(t1)=0 then sdcms.ajaxjson "&#26032;&#23494;&#30721;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		if sdcms.strlen(t2)=0 then sdcms.ajaxjson "&#30830;&#35748;&#23494;&#30721;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		if t1<>t2 then sdcms.ajaxjson "&#20004;&#27425;&#23494;&#30721;&#36755;&#20837;&#19981;&#19968;&#33268;",0:exit sub
		dim data
		data=sdcms.db.dbload("","","sd_admin","adminid="&adminid&" and adminpass='"&md5(t0)&"'","")
		if ubound(data)<0 then
			sdcms.ajaxjson "&#21407;&#23494;&#30721;&#36755;&#20837;&#38169;&#35823;",0:exit sub
		else
			dim datanew
			datanew=array(array("adminpass",md5(t1),18,1))
			if sdcms.db.dbupdate("sd_admin","adminid="&adminid&"",datanew)=1 then
				dim t3:t3=sdcms.loadcookie("loginkey")
				sdcms.setcookie "loginpwd",md5(adminname&md5(t1)&t3) 
			end if
		end if
		sdcms.ajaxjson "修改成功",1
	end sub
	
	sub del()
		dim id:id=sdcms.getint(sdcms.fget("id",0),0)
		if id>0 then
			if id=adminid then
				sdcms.echo "0&#19981;&#33021;&#21024;&#38500;&#33258;&#24049;":exit sub
			else
				sdcms.db.dbdel "sd_admin","adminid="&id&""
			end if
		end if
		sdcms.echo "1"
	end sub
	
	sub unbind()
		dim id:id=sdcms.getint(sdcms.fget("id",0),0)
		dim data:data=array(array("openid","",0,1))
		sdcms.db.dbupdate "sd_admin","adminid="&id&"",data
		sdcms.echo "1&#35299;&#38500;&#32465;&#23450;&#25104;&#21151;"
	end sub
	
	sub addgroupdb()
		dim t0,t1,t2
		t0=sdcms.enhtml(sdcms.fpost("t0",0))
		t1=sdcms.enhtml(sdcms.fpost("t1",0))
		if sdcms.strlen(t0)=0 then sdcms.ajaxjson "&#29992;&#25143;&#21517;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		dim data
		data=array(array("groupname",t0,20),array("groupdesc",t1,50),array("createdate",now(),0),array("pagelever","",0),array("catelever","",0))
		if sdcms.db.dbnew("sd_admin_group",data,"groupname='"&t0&"'")=0 then
			sdcms.ajaxjson "&#35282;&#33394;&#21517;&#31216;&#24050;&#23384;&#22312;&#65292;&#35831;&#25442;&#20010;&#35797;&#35797;",0:exit sub
		else
			sdcms.ajaxjson "添加成功",1
		end if
	end sub
	
	sub editgroupdb()
		dim id:id=sdcms.getint(sdcms.fget("id",0),0)
		if id>0 then
			dim t0,t1
			t0=sdcms.enhtml(sdcms.fpost("t0",0))
			t1=sdcms.enhtml(sdcms.fpost("t1",0))
			dim data:data=array(array("groupname",t0,20,1),array("groupdesc",t1,50,1))
			sdcms.db.dbupdate "sd_admin_group","id="&id&"",data
		end if
		sdcms.ajaxjson "修改成功",1
	end sub
	
	sub editleverdb()
		dim id:id=sdcms.getint(sdcms.fget("id",0),0)
		if id>0 then
			dim t0
			t0=sdcms.enhtml(sdcms.fpost("t0",0))
			t0=replace(t0," ","")
			dim data:data=array(array("pagelever",t0,0,1))
			sdcms.db.dbupdate "sd_admin_group","id="&id&"",data
		end if
		sdcms.ajaxjson "保存成功",1
	end sub
	
	sub editcatedb()
		dim id:id=sdcms.getint(sdcms.fget("id",0),0)
		if id>0 then
			dim t0,t1
			t0=sdcms.enhtml(sdcms.fpost("t0",0))
			t1=sdcms.enhtml(sdcms.fpost("t1",0))
			dim data:data=array(array("catearray",t0,0,1),array("catelever",t1,0,1))
			sdcms.db.dbupdate "sd_admin_group","id="&id&"",data
		end if
		sdcms.ajaxjson "保存成功",1
	end sub
	
	sub delgroup()
		dim id:id=sdcms.getint(sdcms.fget("id",0),0)
		sdcms.db.dbdel "sd_admin_group","id="&id&""
		sdcms.echo "1"
	end sub
	
	islogin
	dim act:act=lcase(sdcms.fget("act",0))
	select case act
		case "add":checkpagelever 16:load theme_adminadd
		case "adddb":checkpagelever 16:adddb
		case "edit"
			checkpagelever 16
			dim id
			id=sdcms.getint(sdcms.fget("id",0),0):load eval("theme_admin"&act)
		case "editgroup","editlever"
			checkpagelever 17
			id=sdcms.getint(sdcms.fget("id",0),0):load eval("theme_admin"&act)
		case "list"
			checkpagelever 17
			dim d:d=sdcms.strlen(sdcms.getsys("qq.login"))
			id=sdcms.getint(sdcms.fget("id",0),0):load eval("theme_admin"&act)
		case "editcate"
			checkpagelever 17
			id=sdcms.getint(sdcms.fget("id",0),0)
			dim catedata
			catedata=sdcms.db.dbload(1,"catelever","sd_admin_group","id="&id&"","")
			load eval("theme_admin"&act)
		case "loadtree"
			dim get_category,catearr,catearray,catelever
			id=sdcms.getint(sdcms.fget("id",0),0)
			catedata=sdcms.categorydata
			catearr=sdcms.db.dbload(1,"catearray,catelever","sd_admin_group","id="&id&"","")
			if ubound(catearr)>=0 then
				catearray=catearr(0,0)
				catelever=catearr(1,0)
			end if
			if ubound(catedata)>=0 then
				getcategory
			end if
			get_category="var zNodes=[{id:-1,pId:0,name:""全选/取消"",open:true}"&get_category&"]"
			sdcms.echo get_category
			
		case "editdb":checkpagelever 16:editdb
		case "editpass":load theme_adminpass
		case "passdb":passdb
		case "del":checkpagelever 16:del
		case "unbind":unbind
		case "group","addgroup":checkpagelever 17:load eval("theme_admin"&act)
		case "addgroupdb":checkpagelever 17:addgroupdb
		case "editgroupdb":checkpagelever 17:editgroupdb
		case "editleverdb":checkpagelever 17:editleverdb
		case "editcatedb":checkpagelever 17:editcatedb
		case "delgroup":checkpagelever 17:delgroup
		case else:checkpagelever 16:dim s:s=sdcms.strlen(sdcms.getsys("qq.login")):load theme_admin
	end select
	sdcms.db.dbclose
%>