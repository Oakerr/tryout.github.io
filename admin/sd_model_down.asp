﻿<!--#include file="base.asp"-->
<%
''' SDCMS 下载
''' ==================================================================
''' 版权所有 http://www.sdcms.cn
''' ------------------------------------------------------------------
''' 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和使用；
''' 未经授权不允许对程序代码以任何形式任何目的的再发布。
''' ==================================================================
''' 编写: IT平民
''' 修改：IT平民 in 2014.07

	sub adddb()
		dim t0,t1,t2,t3,t4,t5,t6,t7,t8,t9
		dim t10,t11,t12,t13,t14,t15,t16,t32
		dim o0,o1,o2,o3
		dim s0,s1,s2,style,up,frist
		dim t17,t18,t19,t20,t21,t22,t23,t24,t25,t26,t27,t28,t29,t30,t31
		t0=sdcms.enhtml(sdcms.fpost("t0",0))
		t1=sdcms.enhtml(sdcms.fpost("t1",0))
		t2=sdcms.fpost("t2",1)
		't3=sdcms.enhtml(sdcms.fpost("t3",0))
		t4=sdcms.enhtml(sdcms.fpost("t4",0))
		t5=sdcms.enhtml(sdcms.fpost("t5",0))
		t6=sdcms.enhtml(sdcms.fpost("t6",0))
		t7=sdcms.enhtml(sdcms.fpost("t7",0))
		t8=sdcms.enhtml(sdcms.fpost("t8",0))
		t9=sdcms.getint(sdcms.fpost("t9",0),0)
		t10=sdcms.getint(sdcms.fpost("t10",0),0)
		t11=sdcms.getint(sdcms.fpost("t11",0),0)
		t12=sdcms.getint(sdcms.fpost("t12",0),0)
		t13=sdcms.getint(sdcms.fpost("t13",0),0)
		t14=sdcms.enhtml(sdcms.fpost("t14",0))
		t15=sdcms.enhtml(sdcms.fpost("like",0))
		t16=sdcms.getint(sdcms.fpost("t16",0),0)
		
		t17=sdcms.enhtml(sdcms.fpost("t17",0))
		t18=sdcms.enhtml(sdcms.fpost("t18",0))
		t19=sdcms.enhtml(sdcms.fpost("t19",0))
		t20=sdcms.enhtml(sdcms.fpost("t20",0))
		t21=sdcms.enhtml(sdcms.fpost("t21",0))
		t22=sdcms.enhtml(sdcms.fpost("t22",0))
		t23=sdcms.enhtml(sdcms.fpost("t23",0))
		t24=sdcms.enhtml(sdcms.fpost("t24",0))
		t25=sdcms.enhtml(sdcms.fpost("t25",0))
		t26=sdcms.enhtml(sdcms.fpost("t26",0))
		t27=sdcms.enhtml(sdcms.fpost("t27",0))
		t28=sdcms.enhtml(sdcms.fpost("t28",0))
		t29=sdcms.enhtml(sdcms.fpost("t29",0))
		t30=sdcms.enhtml(sdcms.fpost("t30",0))
		t31=sdcms.getint(sdcms.fpost("t31",0),0)
		
		t32=sdcms.enhtml(sdcms.fpost("t32",0))
		
		s0=sdcms.enhtml(sdcms.fpost("c0",0))
		s1=sdcms.enhtml(sdcms.fpost("c1",0))
		s2=left(sdcms.enhtml(sdcms.fpost("s2",0)),7)
		up=sdcms.getint(sdcms.fpost("up",0),0)
		frist=sdcms.getint(sdcms.fpost("frist",0),0)
	
		t14=sdcms.iif(isdate(t14),t14,now())
		if sdcms.strlen(t15)=0 then t15="0"
		t15=replace(t15," ","")
		
		t23=replace(t23,", ","/")
		t24=replace(t24,", ","/")
		t25=replace(t25,", ","/")
		
		t29=replace(t29," ","")
		t30=replace(t30," ","")
		
		o0=""
		o1=sdcms.is_pic(t6)
		t6=sdcms.iif(o1=0,"",t6)
		o2=t14
		o3=classid
		t1=replace(t1," ",",")
		t1=replace(t1,"　",",")
		t1=replace(t1,"，",",")
		t1=sdcms.deal_strmid(t1,",")
		if sdcms.strlen(s2)>0 then s2="color:"&s2
		style=s0&s1&s2
		if sdcms.strlen(style)>0 then style="style="""&style&""""
		
		if sdcms.strlen(t0)=0 then sdcms.ajaxjson "&#26631;&#39064;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		if sdcms.strlen(t2)=0 then sdcms.ajaxjson "&#20869;&#23481;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		if sdcms.strlen(t32)>0 then
			if not(sdcms.checkstr(t32,"urlname")) then
				sdcms.ajaxjson "文件名称错误，不能包含特殊字符",0:exit sub
			end if
			if sdcms.db.dbcount("sd_content","url='"&t32&"'")>0 then
				sdcms.ajaxjson "文件名称已存在，请更换！",0:exit sub
			end if
		end if
		if up=1 then
			t2=sdcms.deal_outfile(t2,array(0,1,adminid))
		end if
		if frist=1 and o1=0 then
			t6=sdcms.get_frist_pic(t2)
			if t6="" then o1=0 else o1=1
		end if
		t3=sdcms.get_intro(t2)
		dim fstr:fstr=deal_model_field(modeid)
		
		deal_tags "",t1
		data=array(array("title",t0,255,1),array("tags",t1,255,1),array("keyword",t4,255,1),array("description",t5,255,1),array("pic",t6,255,1),array("hits",t9,10,0),array("islock",t10,1,0),array("isnice",t11,1,0),array("ontop",t12,1,0),array("iscomment",t13,1,0),array("createdate",fuckdate(t14),50,1),array("likeid",t15,0,1),array("style",style,0,1),array("ispic",o1,1,0),array("lastupdate",fuckdate(o2),50,1),array("classid",o3,0,0),array("isurl",0,1,0),array("comments",0,0,0),array("adminid",adminid,0,0),array("userid",0,0,0),array("author",t7,50,1),array("comefrom",t8,50,1),array("intro",t3,0,1),array("point",t16,10,0),array("url",t32,255,1))
		sdcms.db.insert "sd_content",data
		dim cid:cid=sdcms.db.insertid("id","sd_content")
		
		fstr="array(array(""cid"",cid,0,0),array(""content"",t2,0,1),array(""version"",t17,50,1),array(""softsize"",t18,50,1),array(""sizeunit"",t19,10,1),array(""language"",t20,10,1),array(""license"",t21,10,1),array(""property"",t22,10,1),array(""os"",t23,50,1),array(""devlanguage"",t24,50,1),array(""database"",t25,50,1),array(""developers"",t26,50,1),array(""developerurl"",t27,255,1),array(""demourl"",t28,255,1),array(""downway"",t29,0,1),array(""downurl"",t30,0,1),array(""stars"",t31,0,0)"&fstr&")"
		
		sdcms.db.insert "sd_model_down",eval(fstr)
		if sdcms.strlen(t32)=0 then sdcms.deal_content_url cid,o3
		deal_file cid,1
		sdcms.ajaxjson cid&":保存成功",1
	end sub
	
	sub editdb()
		dim t0,t1,t2,t3,t4,t5,t6,t7,t8,t9
		dim t10,t11,t12,t13,t14,t15,t16,t1_0,t32
		dim o0,o1,o2
		dim s0,s1,s2,style,up,frist
		dim t17,t18,t19,t20,t21,t22,t23,t24,t25,t26,t27,t28,t29,t30,t31
		dim id:id=sdcms.getint(sdcms.fget("id",0),0)
	
		t0=sdcms.enhtml(sdcms.fpost("t0",0))
		t1=sdcms.enhtml(sdcms.fpost("t1",0))
		t2=sdcms.fpost("t2",1)
		't3=sdcms.enhtml(sdcms.fpost("t3",0))
		t4=sdcms.enhtml(sdcms.fpost("t4",0))
		t5=sdcms.enhtml(sdcms.fpost("t5",0))
		t6=sdcms.enhtml(sdcms.fpost("t6",0))
		t7=sdcms.enhtml(sdcms.fpost("t7",0))
		t8=sdcms.enhtml(sdcms.fpost("t8",0))
		t9=sdcms.getint(sdcms.fpost("t9",0),0)
		t10=sdcms.getint(sdcms.fpost("t10",0),0)
		t11=sdcms.getint(sdcms.fpost("t11",0),0)
		t12=sdcms.getint(sdcms.fpost("t12",0),0)
		t13=sdcms.getint(sdcms.fpost("t13",0),0)
		t14=sdcms.enhtml(sdcms.fpost("t14",0))
		t15=sdcms.enhtml(sdcms.fpost("like",0))
		t16=sdcms.getint(sdcms.fpost("t16",0),0)
		t1_0=sdcms.enhtml(sdcms.fpost("t1_0",0))

		t17=sdcms.enhtml(sdcms.fpost("t17",0))
		t18=sdcms.enhtml(sdcms.fpost("t18",0))
		t19=sdcms.enhtml(sdcms.fpost("t19",0))
		t20=sdcms.enhtml(sdcms.fpost("t20",0))
		t21=sdcms.enhtml(sdcms.fpost("t21",0))
		t22=sdcms.enhtml(sdcms.fpost("t22",0))
		t23=sdcms.enhtml(sdcms.fpost("t23",0))
		t24=sdcms.enhtml(sdcms.fpost("t24",0))
		t25=sdcms.enhtml(sdcms.fpost("t25",0))
		t26=sdcms.enhtml(sdcms.fpost("t26",0))
		t27=sdcms.enhtml(sdcms.fpost("t27",0))
		t28=sdcms.enhtml(sdcms.fpost("t28",0))
		t29=sdcms.enhtml(sdcms.fpost("t29",0))
		t30=sdcms.enhtml(sdcms.fpost("t30",0))
		t31=sdcms.getint(sdcms.fpost("t31",0),0)
		
		t32=sdcms.enhtml(sdcms.fpost("t32",0))
		
		s0=sdcms.enhtml(sdcms.fpost("c0",0))
		s1=sdcms.enhtml(sdcms.fpost("c1",0))
		s2=left(sdcms.enhtml(sdcms.fpost("s2",0)),7)
		up=sdcms.getint(sdcms.fpost("up",0),0)
		frist=sdcms.getint(sdcms.fpost("frist",0),0)
	
		t14=sdcms.iif(isdate(t14),t14,now())
		if sdcms.strlen(t15)=0 then t15="0"
		t15=replace(t15," ","")
		t23=replace(t23,", ","/")
		t24=replace(t24,", ","/")
		t25=replace(t25,", ","/")
		t29=replace(t29," ","")
		t30=replace(t30," ","")
		
		o0=""
		o1=sdcms.is_pic(t6)
		t6=sdcms.iif(o1=0,"",t6)
		o2=now()
		t1=replace(t1," ",",")
		t1=replace(t1,"　",",")
		t1=replace(t1,"，",",")
		t1=sdcms.deal_strmid(t1,",")
		if sdcms.strlen(s2)>0 then s2="color:"&s2
		style=s0&s1&s2
		if sdcms.strlen(style)>0 then style="style="""&style&""""
		
		if sdcms.strlen(t0)=0 then sdcms.ajaxjson "&#26631;&#39064;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		if sdcms.strlen(t2)=0 then sdcms.ajaxjson "&#20869;&#23481;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		if sdcms.strlen(t32)>0 then
			if not(sdcms.checkstr(t32,"urlname")) then
				sdcms.ajaxjson "文件名称错误，不能包含特殊字符",0:exit sub
			end if
			if sdcms.db.dbcount("sd_content","url='"&t32&"' and id<>"&id&"")>0 then
				sdcms.ajaxjson "文件名称已存在，请更换！",0:exit sub
			end if
		end if
		
		if up=1 then
			t2=sdcms.deal_outfile(t2,array(id,1,adminid))
		end if
		if frist=1 and o1=0 then
			t6=sdcms.get_frist_pic(t2)
			if t6="" then o1=0 else o1=1
		end if
		t3=sdcms.get_intro(t2)
		
		dim fstr:fstr=deal_model_field(modeid)
		
		dim old_lock:old_lock=sdcms.db.dbloadone("islock","sd_content","id="&id&"")
		deal_tags t1_0,t1
		data=array(array("title",t0,255,1),array("tags",t1,255,1),array("keyword",t4,255,1),array("description",t5,255,1),array("pic",t6,255,1),array("hits",t9,10,0),array("islock",t10,3,0),array("isnice",t11,1,0),array("ontop",t12,1,0),array("iscomment",t13,1,0),array("createdate",fuckdate(t14),50,1),array("likeid",t15,0,1),array("style",style,0,1),array("ispic",o1,1,0),array("lastupdate",fuckdate(o2),50,1),array("author",t7,50,1),array("comefrom",t8,50,1),array("intro",t3,0,1),array("point",t16,10,0),array("url",t32,255,1))
		sdcms.db.dbupdate "sd_content","id="&id&" and classid="&classid&"",data
		fstr="array(array(""content"",t2,0,1),array(""version"",t17,50,1),array(""softsize"",t18,50,1),array(""sizeunit"",t19,10,1),array(""language"",t20,10,1),array(""license"",t21,10,1),array(""property"",t22,10,1),array(""os"",t23,50,1),array(""devlanguage"",t24,50,1),array(""database"",t25,50,1),array(""developers"",t26,50,1),array(""developerurl"",t27,255,1),array(""demourl"",t28,255,1),array(""downway"",t29,0,1),array(""downurl"",t30,0,1),array(""stars"",t31,0,0)"&fstr&")"
		sdcms.db.dbupdate "sd_model_down","cid="&id&"",eval(fstr)
		if t10=1 and old_lock<0 then sdcms.deal_user_publish_point id,""
		sdcms.ajaxjson id&":保存成功",1
	end sub
	
	islogin
	dim act:act=lcase(sdcms.fget("act",0))
	dim classid:classid=sdcms.getint(sdcms.fget("classid",0),0)
	dim sta:sta=sdcms.getint(sdcms.fget("sta",0),0)
	dim nat:nat=sdcms.getint(sdcms.fget("nat",0),0)
	dim order:order=sdcms.getint(sdcms.fget("order",0),0)
	dim where:where=sdcms.getint(sdcms.fget("where",0),0)
	dim keyword:keyword=sdcms.enhtml(sdcms.fget("keyword",1))
	dim data
	dim catedata,catename,modeid,parentid
	catedata=sdcms.getclassdb(classid)
	if not isarray(catedata) then
		sdcms.echo "&#26639;&#30446;&#19981;&#23384;&#22312;&#25110;&#24050;&#34987;&#21024;&#38500;"
		sdcms.db.dbclose
		sdcms.die
	end if
	catename=catedata(1)
	modeid=catedata(10)
	parentid=catedata(6)
	dim field_data:field_data=sdcms.get_model_field(modeid)
	dim editor_int:editor_int=""
	dim editor_get:editor_get=""
	if isarray(field_data) then
		dim ei
		for ei=0 to ubound(field_data,2)
			if field_data(2,ei)=6 then
				editor_int=editor_int&"UE.getEditor('"&field_data(0,ei)&"',editorOption);"
				editor_get=editor_get&"UE.getEditor('"&field_data(0,ei)&"').sync();"
				editor_get=editor_get&"$(""#"&field_data(0,ei)&""").val(UE.getEditor('"&field_data(0,ei)&"').getContent());"
			end if
		next
	end if
	dim theme_content_add:theme_content_add=catedata(26)
	dim theme_content_edit:theme_content_edit=catedata(27)
	dim theme_content_publish:theme_content_publish=catedata(28)
	select case act
		case "add":checkcateaction(1):load theme_content_add
		case "adddb":checkcateaction(1):adddb
		case "edit","publish"
			checkcateaction(2)
			dim id:id=sdcms.getint(sdcms.fget("id",0),0)
			dim filed,likeid
			filed="title,keyword,description,pic,hits,islock,isnice,ontop,iscomment,createdate,likeid,style,tags,author,comefrom,point,url"'0-16
			data=sdcms.db.dbload(1,filed,"sd_content","classid="&classid&" and id="&id&"","")
			likeid=data(10,0)
			dim rsshow
			set rsshow=sdcms.db.exedb("select top 1 * from sd_model_down where cid="&id&"")
			if rsshow.eof then
				sdcms.echo "参数错误":sdcms.die
			end if
			load eval ("theme_content_"&act)
		case "editdb":checkcateaction(2):editdb
	end select
	sdcms.db.dbclose
%>