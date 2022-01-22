<!--#include file="base.asp"-->
<%
''' SDCMS 组图
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
		dim t10,t11,t12,t13,t14,t15,t16,t17,t18,t19
		dim o0,o1,o2,o3
		dim s0,s1,s2,style,up,frist
		t0=sdcms.enhtml(sdcms.fpost("t0",0))
		t1=sdcms.enhtml(sdcms.fpost("t1",0))
		t2=sdcms.enhtml(sdcms.fpost("t2",0))
		t3=sdcms.fpost("t3",1)
		t4=sdcms.enhtml(sdcms.fpost("t4",0))
		t5=sdcms.enhtml(sdcms.fpost("t5",0))
		t6=sdcms.enhtml(sdcms.fpost("t6",0))
		t7=sdcms.getint(sdcms.fpost("t7",0),0)
		t8=sdcms.getint(sdcms.fpost("t8",0),0)
		t9=sdcms.getint(sdcms.fpost("t9",0),0)
		t10=sdcms.getint(sdcms.fpost("t10",0),0)
		t11=sdcms.getint(sdcms.fpost("t11",0),0)
		t12=sdcms.enhtml(sdcms.fpost("t12",0))
		t13=sdcms.enhtml(sdcms.fpost("like",0))
		t14=sdcms.enhtml(sdcms.fpost("t14",0))
		t15=sdcms.enhtml(sdcms.fpost("t15",0))
		
		t17=sdcms.getint(sdcms.fpost("t17",0),0)
		t18=sdcms.enhtml(sdcms.fpost("t18",0))

		s0=sdcms.enhtml(sdcms.fpost("c0",0))
		s1=sdcms.enhtml(sdcms.fpost("c1",0))
		s2=left(sdcms.enhtml(sdcms.fpost("s2",0)),7)
		up=sdcms.getint(sdcms.fpost("up",0),0)
		frist=sdcms.getint(sdcms.fpost("frist",0),0)
		
		t2=replace(t2," ","")
		t2=replace(t2,",",""",""")
		t2="array("""&t2&""")"
		
		dim num:num=request.form("t19").count
		dim arr:arr="array("
		dim i
		for i=1 to num
			t19=sdcms.enhtml(trim(request.form("t19")(i)))
			t19=replace(t19,chr(13),"")
			t19=replace(t19,chr(10),"")
			if i>1 then
				arr=arr&","
			end if
			arr=arr&""""&t19&""""
		next
		arr=arr&")"
		t19=arr

		t12=sdcms.iif(isdate(t12),t12,now())
		if sdcms.strlen(t13)=0 then t13="0"
		t13=replace(t13," ","")
		
		o0=""
		o1=sdcms.is_pic(t6)
		t6=sdcms.iif(o1=0,"",t6)
		o2=t12
		o3=classid
		t1=replace(t1," ",",")
		t1=replace(t1,"　",",")
		t1=replace(t1,"，",",")
		t1=sdcms.deal_strmid(t1,",")
		
		if sdcms.strlen(s2)>0 then s2="color:"&s2
		style=s0&s1&s2
		if sdcms.strlen(style)>0 then style="style="""&style&""""
		
		if sdcms.strlen(t0)=0 then sdcms.ajaxjson "&#26631;&#39064;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		if sdcms.strlen(t18)>0 then
			if not(sdcms.checkstr(t18,"urlname")) then
				sdcms.ajaxjson "文件名称错误，不能包含特殊字符",0:exit sub
			end if
			if sdcms.db.dbcount("sd_content","url='"&t18&"'")>0 then
				sdcms.ajaxjson "文件名称已存在，请更换！",0:exit sub
			end if
		end if
		if up=1 then
			t3=sdcms.deal_outfile(t3,array(0,1,adminid))
		end if
		if frist=1 and o1=0 then
			t6=sdcms.get_frist_pic(t3)
			if t6="" then o1=0 else o1=1
		end if
		t16=sdcms.get_intro(t3)
		dim fstr:fstr=deal_model_field(modeid)
		
		deal_tags "",t1
		data=array(array("title",t0,255,1),array("tags",t1,255,1),array("keyword",t4,255,1),array("description",t5,255,1),array("pic",t6,255,1),array("hits",t7,10,0),array("islock",t8,1,0),array("isnice",t9,1,0),array("ontop",t10,1,0),array("iscomment",t11,1,0),array("createdate",fuckdate(t12),50,1),array("likeid",t13,0,1),array("style",style,0,1),array("ispic",o1,1,0),array("lastupdate",fuckdate(o2),50,1),array("classid",o3,0,0),array("isurl",0,1,0),array("comments",0,0,0),array("adminid",adminid,0,0),array("userid",0,0,0),array("author",t14,50,1),array("comefrom",t15,50,1),array("intro",t16,0,1),array("point",t17,10,0),array("url",t18,255,1))
		sdcms.db.insert "sd_content",data
		dim cid:cid=sdcms.db.insertid("id","sd_content")		
		fstr="array(array(""cid"",cid,0,0),array(""piclist"",t2,0,1),array(""content"",t3,0,1),array(""introlist"",t19,0,1)"&fstr&")"
		sdcms.db.insert "sd_model_pic",eval(fstr)
		if sdcms.strlen(t18)=0 then sdcms.deal_content_url cid,o3
		deal_file cid,1
		sdcms.ajaxjson cid&":保存成功",1
	end sub
	
	sub editdb()
		dim t0,t1,t2,t3,t4,t5,t6,t7,t8,t9
		dim t10,t11,t12,t13,t1_0,t14,t15,t16,t17,t18,t19
		dim o0,o1,o2
		dim s0,s1,s2,style,up,frist
		dim id:id=sdcms.getint(sdcms.fget("id",0),0)
	
		t0=sdcms.enhtml(sdcms.fpost("t0",0))
		t1=sdcms.enhtml(sdcms.fpost("t1",0))
		t2=sdcms.enhtml(sdcms.fpost("t2",0))
		t3=sdcms.fpost("t3",1)
		t4=sdcms.enhtml(sdcms.fpost("t4",0))
		t5=sdcms.enhtml(sdcms.fpost("t5",0))
		t6=sdcms.enhtml(sdcms.fpost("t6",0))
		t7=sdcms.getint(sdcms.fpost("t7",0),0)
		t8=sdcms.getint(sdcms.fpost("t8",0),0)
		t9=sdcms.getint(sdcms.fpost("t9",0),0)
		t10=sdcms.getint(sdcms.fpost("t10",0),0)
		t11=sdcms.getint(sdcms.fpost("t11",0),0)
		t12=sdcms.enhtml(sdcms.fpost("t12",0))
		t13=sdcms.enhtml(sdcms.fpost("like",0))
		t14=sdcms.enhtml(sdcms.fpost("t14",0))
		t15=sdcms.enhtml(sdcms.fpost("t15",0))
		t17=sdcms.getint(sdcms.fpost("t17",0),0)
		t18=sdcms.enhtml(sdcms.fpost("t18",0))
		s0=sdcms.enhtml(sdcms.fpost("c0",0))
		s1=sdcms.enhtml(sdcms.fpost("c1",0))
		s2=left(sdcms.enhtml(sdcms.fpost("s2",0)),7)
		up=sdcms.getint(sdcms.fpost("up",0),0)
		frist=sdcms.getint(sdcms.fpost("frist",0),0)
		
		t1_0=sdcms.enhtml(sdcms.fpost("t1_0",0))
		t2=replace(t2," ","")
		t2=replace(t2,",",""",""")
		t2="array("""&t2&""")"
		
		dim num:num=request.form("t19").count
		dim arr:arr="array("
		dim i
		for i=1 to num
			t19=sdcms.enhtml(trim(request.form("t19")(i)))
			t19=replace(t19,chr(13),"")
			t19=replace(t19,chr(10),"")
			if i>1 then
				arr=arr&","
			end if
			arr=arr&""""&t19&""""
		next
		arr=arr&")"
		t19=arr
		
		t12=sdcms.iif(isdate(t12),t12,now())
		if sdcms.strlen(t13)=0 then t13="0"
		t13=replace(t13," ","")
		
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
		if sdcms.strlen(t18)>0 then
			if not(sdcms.checkstr(t18,"urlname")) then
				sdcms.ajaxjson "文件名称错误，不能包含特殊字符",0:exit sub
			end if
			if sdcms.db.dbcount("sd_content","url='"&t18&"' and id<>"&id&"")>0 then
				sdcms.ajaxjson "文件名称已存在，请更换！",0:exit sub
			end if
		end if
		if up=1 then
			t3=sdcms.deal_outfile(t3,array(id,1,adminid))
		end if
		if frist=1 and o1=0 then
			t6=sdcms.get_frist_pic(t3)
			if t6="" then o1=0 else o1=1
		end if
		t16=sdcms.get_intro(t3)
		
		dim fstr:fstr=deal_model_field(modeid)
		
		dim old_lock:old_lock=sdcms.db.dbloadone("islock","sd_content","id="&id&"")
		deal_tags t1_0,t1
		data=array(array("title",t0,255,1),array("tags",t1,255,1),array("keyword",t4,255,1),array("description",t5,255,1),array("pic",t6,255,1),array("hits",t7,10,0),array("islock",t8,3,0),array("isnice",t9,1,0),array("ontop",t10,1,0),array("iscomment",t11,1,0),array("createdate",fuckdate(t12),50,1),array("likeid",t13,0,1),array("style",style,0,1),array("ispic",o1,1,0),array("lastupdate",fuckdate(o2),50,1),array("author",t14,50,1),array("comefrom",t15,50,1),array("intro",t16,0,1),array("point",t17,10,0),array("url",t18,255,1))
		sdcms.db.dbupdate "sd_content","id="&id&" and classid="&classid&"",data		
		fstr="array(array(""piclist"",t2,0,1),array(""content"",t3,0,1),array(""introlist"",t19,0,1)"&fstr&")"
		sdcms.db.dbupdate "sd_model_pic","cid="&id&"",eval(fstr)
		if t8=1 and old_lock<0 then sdcms.deal_user_publish_point id,""
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
			dim rsshow,piclist,introlist,introarr
			set rsshow=sdcms.db.exedb("select top 1 * from sd_model_pic where cid="&id&"")
			if rsshow.eof then
				sdcms.echo "参数错误":sdcms.die
			end if
			piclist=eval(rsshow("piclist"))
			introlist=eval(rsshow("introlist"))

			load eval ("theme_content_"&act)
		case "editdb":checkcateaction(2):editdb
	end select
	sdcms.db.dbclose
%>