<!--#include file="base.asp"-->
<%
''' SDCMS 内容
''' ==================================================================
''' 版权所有 http://www.sdcms.cn
''' ------------------------------------------------------------------
''' 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和使用；
''' 未经授权不允许对程序代码以任何形式任何目的的再发布。
''' ==================================================================
''' 编写: IT平民
''' 修改：IT平民 in 2012.12

	sub get_tags()
		dim t0:t0=sdcms.enhtml(sdcms.fpost("t0",0))
		if sdcms.strlen(t0)=0 then sdcms.echo "0&#26631;&#39064;&#19981;&#33021;&#20026;&#31354;":exit sub
		sdcms.echo sdcms.split_tags(t0)
	end sub

	sub adddb()
		dim t0,t1,t2,t3,t4,t5,t6,t7
		dim o0,o1
		dim s0,s1,s2,style
		t0=sdcms.enhtml(sdcms.fpost("t0",0))
		t1=sdcms.enhtml(sdcms.fpost("t1",0))
		t2=sdcms.enhtml(sdcms.fpost("t2",0))
		t3=sdcms.enhtml(sdcms.fpost("t3",0))
		t4=sdcms.getint(sdcms.fpost("t4",0),0)
		t5=sdcms.getint(sdcms.fpost("t5",0),0)
		t6=sdcms.getint(sdcms.fpost("t6",0),0)
		t7=sdcms.enhtml(sdcms.fpost("t7",0))
		s0=sdcms.enhtml(sdcms.fpost("c0",0))
		s1=sdcms.enhtml(sdcms.fpost("c1",0))
		s2=left(sdcms.enhtml(sdcms.fpost("s2",0)),7)
		
		t7=sdcms.iif(isdate(t7),t7,now())
		o1=sdcms.is_pic(t3)
		t3=sdcms.iif(o1=0,"",t3)
		
		t2=replace(t2," ",",")
		t2=replace(t2,"　",",")
		t2=replace(t2,"，",",")
		t2=sdcms.deal_strmid(t2,",")
		if sdcms.strlen(s2)>0 then s2="color:"&s2
		style=s0&s1&s2
		if sdcms.strlen(style)>0 then style="style="""&style&""""
		if sdcms.strlen(t0)=0 then sdcms.ajaxjson "&#26631;&#39064;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		if sdcms.strlen(t1)=0 then sdcms.ajaxjson "&#38142;&#25509;&#22320;&#22336;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		deal_tags "",t2
		data=array(array("title",t0,255,1),array("url",t1,255,1),array("isurl",1,1,0),array("tags",t2,255,1),array("pic",t3,255,1),array("ispic",o1,1,0),array("hits",0,1,0),array("islock",t4,1,0),array("isnice",t5,1,0),array("ontop",t6,1,0),array("iscomment",1,1,0),array("createdate",fuckdate(t7),50,1),array("likeid",0,0,1),array("style",style,0,1),array("lastupDate",fuckdate(t7),50,1),array("classid",classid,0,0),array("comments",0,0,0),array("adminid",adminid,0,0),array("userid",0,0,0),array("point",0,0,0))
		sdcms.db.insert "sd_content",data
		dim cid:cid=sdcms.db.insertid("id","sd_content")
		deal_file cid,1
		sdcms.ajaxjson cid&":保存成功",1
	end sub
	
	sub editdb()
		dim t0,t1,t2,t2_0,t3,t4,t5,t6,t7
		dim o0,o1
		dim s0,s1,s2,style
		dim t3_1
		dim id:id=sdcms.getint(sdcms.fget("id",0),0)
		t0=sdcms.enhtml(sdcms.fpost("t0",0))
		t1=sdcms.enhtml(sdcms.fpost("t1",0))
		t2=sdcms.enhtml(sdcms.fpost("t2",0))
		t2_0=sdcms.enhtml(sdcms.fpost("t2_0",0))
		t3=sdcms.enhtml(sdcms.fpost("t3",0))
		t4=sdcms.getint(sdcms.fpost("t4",0),0)
		t5=sdcms.getint(sdcms.fpost("t5",0),0)
		t6=sdcms.getint(sdcms.fpost("t6",0),0)
		t7=sdcms.enhtml(sdcms.fpost("t7",0))
		s0=sdcms.enhtml(sdcms.fpost("c0",0))
		s1=sdcms.enhtml(sdcms.fpost("c1",0))
		s2=left(sdcms.enhtml(sdcms.fpost("s2",0)),7)
		
		t7=sdcms.iif(isdate(t7),t7,now())
		o1=sdcms.is_pic(t3)
		t3=sdcms.iif(o1=0,"",t3)
		t2=replace(t2," ",",")
		t2=replace(t2,"　",",")
		t2=replace(t2,"，",",")
		t2=sdcms.deal_strmid(t2,",")
		if sdcms.strlen(s2)>0 then s2="color:"&s2
		style=s0&s1&s2
		if sdcms.strlen(style)>0 then style="style="""&style&""""
		
		if sdcms.strlen(t0)=0 then sdcms.ajaxjson "&#26631;&#39064;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		if sdcms.strlen(t1)=0 then sdcms.ajaxjson "&#38142;&#25509;&#22320;&#22336;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		deal_tags t2_0,t2
		data=array(array("title",t0,255,1),array("url",t1,255,1),array("tags",t2,255,1),array("pic",t3,255,1),array("ispic",o1,1,0),array("islock",t4,1,0),array("isnice",t5,1,0),array("ontop",t6,1,0),array("createdate",fuckdate(t7),50,1),array("style",style,0,1),array("lastupDate",sqltime,50,0))
		sdcms.db.dbupdate "sd_content","id="&id&"",data
		sdcms.ajaxjson id&":保存成功",1
	end sub
	
	sub deldb()
		dim id:id=sdcms.getint(sdcms.fget("id",0),0)
		sdcms.db.dbupdate "sd_content","id="&id&" and classid="&classid&"",array(array("islock",-3,2,0))
		sdcms.echo "1"
	end sub
	
	sub delall()
		dim id:id=sdcms.enhtml(sdcms.fget("id",0))
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
			sdcms.db.dbupdate "sd_content","id in("&id&") and classid="&classid&"",array(array("islock",-3,2,0))
			sdcms.echo "1"
		end if
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
				case "islock":filed="islock":result=1
				case "nolock":filed="islock":result=0
				case "isnice":filed="isnice":result=1
				case "nonice":filed="isnice":result=0
				case "istop":filed="ontop":result=1
				case "notop":filed="ontop":result=0
				case "iscomment":filed="iscomment":result=1
				case "nocomment":filed="iscomment":result=0
				case else:sdcms.echo "0&#21442;&#25968;&#38169;&#35823;":exit sub
			end select
			sdcms.db.dbupdate "sd_content","id in("&id&") and classid="&classid&"",array(array(filed,result,2,0))
			sdcms.echo "1"
		end if
	end sub
	
	sub movedb()
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
			sdcms.db.dbupdate "sd_content","id in("&id&") and classid="&classid&"",array(array("classid",go,0,0))
			sdcms.echo "1"
		end if
	end sub
	
	sub movecate()
		dim comecate:comecate=sdcms.getint(sdcms.fget("comecate",0),0)
		dim gocate:gocate=sdcms.getint(sdcms.fget("gocate",0),0)
		sdcms.db.dbupdate "sd_content","classid="&comecate&"",array(array("classid",gocate,0,0))
		sdcms.echo "1"
	end sub
	
	sub redo()
		dim id:id=sdcms.enhtml(sdcms.fget("id",0))
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
			sdcms.db.dbupdate "sd_content","id in("&id&") and classid="&classid&"",array(array("islock",1,2,0))
			sdcms.echo "1"
		end if
	end sub
	
	sub redoall()
		sdcms.db.dbupdate "sd_content","classid="&classid&"",array(array("islock",1,2,0))
		sdcms.echo "1"
	end sub
	
	sub clearall()
		dim idarr
		data=sdcms.db.dbload("","id","sd_content","classid="&classid&" and islock=-3","")
		if ubound(data)>=0 then
			for i=0 to ubound(data,2)
				if i=0 then
					idarr=data(0,i)
				else
					idarr=idarr&","&data(0,i)
				end if
			next
			sdcms.db.dbdel tablename,"cid in("&idarr&")"
		end if
		sdcms.db.dbdel "sd_content","classid="&classid&" and islock=-3"
		sdcms.echo "1"
	end sub
	
	sub delclear()
		dim id:id=sdcms.enhtml(sdcms.fget("id",0))
		data=sdcms.db.dbload(1,"id","sd_content","classid="&classid&" and islock=-3 and id="&id&"","")
		if ubound(data)>=0 then
			sdcms.db.dbdel tablename,"cid="&id&""
			sdcms.db.dbdel "sd_content","classid="&classid&" and islock=-3 and id="&id&""
		end if
		sdcms.echo "1"
	end sub
	
	sub likedb()
		dim id:id=sdcms.enhtml(sdcms.fget("id",0))
		dim classid:classid=sdcms.enhtml(sdcms.fget("classid",0))
		dim t0:t0=sdcms.enhtml(sdcms.fpost("key",0))
		t0=replace(t0,"　"," ")
		dim arr:arr=split(t0," ")
		dim j,sql
		sql=" and ("
		for j=0 to ubound(arr)
			if j>0 then sql=sql&" or "
			sql=sql&" title like '%"&arr(j)&"%'"
		next
		sql=sql&" ) "
		dim t1
		t1=sdcms.db.dbload(15,"id,title","sd_content","islock=1 and id<>"&id&" "&sql&"","ontop desc,id desc")
		if ubound(t1)<0 then
			sdcms.echo "0&#27809;&#26377;&#30456;&#20851;&#20449;&#24687;"
		else
			dim i,t2
			t2="1"
			for i=0 to ubound(t1,2)
				t2=t2&"<li><span class=""del"" title=""删除""></span><input type=""hidden"" name=""like"" value="""&t1(0,i)&""" /><a href="""&webroot&"show.asp?id="&t1(0,i)&""" title="""&t1(1,i)&""" target=""_blank"">"&sdcms.cutstr(t1(1,i),24,1)&"</a></li>"
			next
			sdcms.echo t2
		end if
	end sub
	
	sub treedb()
		dim data:data=sdcms.getclassdb(classid)
		getcategory classid,data(10)
		load theme_content_tree
	end sub

	sub getcategory(byval t0,byval t1)
		dim data:data=sdcms.categorydata
		dim i
		if isarray(data) then
			if ubound(data)>=0 then
				for i=0 to ubound(data,2)
					get_tree=get_tree&""&sdcms.iif(i=0,"",",")&"{"
					get_tree=get_tree&"id:"&data(0,i)&""
					get_tree=get_tree&",pId:"&data(3,i)&""
					get_tree=get_tree&",name:"""&data(1,i)&""""
					if t0=data(0,i) then
						get_tree=get_tree&",checked:true"
					end if
					if data(0,i)<>data(5,i) then
						get_tree=get_tree&",open:true"
					end if
					if data(10,i)<>t1 or data(0,i)=t0 then
						get_tree=get_tree&",chkDisabled:true"
					end if
					get_tree=get_tree&"}"
				next
			end if
		end if
	
	end sub
		
	sub getdate()
		dim t0:t0=sdcms.getint(sdcms.fget("t0",0),0)
		dim t1:t1=sdcms.getint(sdcms.fget("classid",0),0)
		dim sqlwhere:sqlwhere="isurl=0 and islock=1 and classid="&t1&""

		dim datestr,daystr,weekstr,monthstr
		if datatype then
			datestr="date()"
			daystr="'d'"
			weekstr="'w'"
			monthstr="'m'"
		else
			datestr="getdate()"
			daystr="d"
			weekstr="w"
			monthstr="m"
		end if
		select case t0
			case "1"
				sqlwhere=sqlwhere&" and datediff("&daystr&",createdate,"&datestr&")=0"
			case "2"
				sqlwhere=sqlwhere&" and datediff("&daystr&",createdate,"&datestr&")=1"
			case "3"
				sqlwhere=sqlwhere&" and datediff("&weekstr&",createdate,"&datestr&")=0"
			case "4"
				sqlwhere=sqlwhere&" and datediff("&monthstr&",createdate,"&datestr&")=0"
		end select

		dim data:data=sdcms.db.dbload("","id","sd_content",sqlwhere&"","id")

		if ubound(data)<0 then
			exit sub
		else
			dim i,str
			for i=0 to ubound(data,2)
				if i=0 then
					str=data(0,i)
				else
					str=str&","&data(0,i)
				end if
			next
			sdcms.echo str
		end if
	end sub	
	
	islogin
	dim act:act=lcase(sdcms.fget("act",0))
	if act<>"left" and act<>"list" then
		dim classid:classid=sdcms.getint(sdcms.fget("classid",0),0)
		dim catedata,catename,modeid,adminurl,tablename,parentid
		catedata=sdcms.getclassdb(classid)
		if not isarray(catedata) then
			sdcms.echo "&#26639;&#30446;&#19981;&#23384;&#22312;&#25110;&#24050;&#34987;&#21024;&#38500;"
			sdcms.db.dbclose
			sdcms.die
		end if
		catename=catedata(1)
		modeid=catedata(10)
		adminurl=catedata(14)
		tablename=catedata(12)
		parentid=catedata(6)
	end if
	dim sta,nat,order,keyword,data
	sta=sdcms.getint(sdcms.fget("sta",0),0)
	nat=sdcms.getint(sdcms.fget("nat",0),0)
	order=sdcms.getint(sdcms.fget("order",0),0)
	keyword=sdcms.enhtml(sdcms.fget("keyword",1))
	dim sqlwhere,statitle,nattitle,orderby,ordtitle,wherekey
	select case sta
		case "1":sqlwhere=" and sd_content.islock=1":statitle="状态:已发"
		case "2":sqlwhere=" and sd_content.islock=0":statitle="状态:草稿"
		case else:sqlwhere=" and (sd_content.islock=1 or sd_content.islock=0)":statitle="按状态↓"
	end select
	select case nat
		case "1":sqlwhere=" and ispic=1":nattitle="性质:有缩略图"
		case "2":sqlwhere=" and ispic=0":nattitle="性质:无缩略图"
		case "3":sqlwhere=" and isnice=1":nattitle="性质:已推荐"
		case "4":sqlwhere=" and isnice=0":nattitle="性质:未推荐"
		case "5":sqlwhere=" and ontop=1":nattitle="性质:已置顶"
		case "6":sqlwhere=" and ontop=0":nattitle="性质:未置顶"
		case "7":sqlwhere=" and iscomment=1":nattitle="性质:允许评论"
		case "8":sqlwhere=" and iscomment=0":nattitle="性质:禁止评论"
		case "9":sqlwhere=" and isurl=1":nattitle="性质:外部链接"
		case else:nattitle="按性质↓"
	end select
	select case order
		case "1":orderby="hits desc,id desc":ordtitle="状态:访问人气↑"
		case "2":orderby="hits,id":ordtitle="状态:访问人气↓"
		case "3":orderby="createdate desc,id desc":ordtitle="状态:发布日期↑"
		case "4":orderby="createdate,id":ordtitle="状态:发布日期↓"
		case "5":orderby="comments desc,id desc":ordtitle="状态:评论数量↑"
		case "6":orderby="comments,id":ordtitle="状态:评论数量↓"
		case else:orderby="ontop desc,id desc":ordtitle="按排序↓"
	end select
	if sdcms.strlen(keyword)>0 then
		if datatype then
			wherekey=" and instr(lcase(title),lcase('"&keyword&"'))>0 "
		else
			wherekey=" and title like '%"&keyword&"%'"
		end if
	end if
	select case act
		case "list"
			dim cid:cid=sdcms.getint(sdcms.fget("classid",0),0)
			if cid<>0 then
				sqlwhere=sqlwhere&" and classid="&cid&""
			end if
			if admingroupid<>0 then	
				sqlwhere=sqlwhere&" and classid in("&admin_cate_array&")"
			end if
			load theme_content_list
		case "gettags":get_tags
		case "add":checkcateaction(1):load theme_contentadd
		case "adddb":checkcateaction(1):adddb
		case "edit":checkcateaction(2):dim id:id=sdcms.getint(sdcms.fget("id",0),0):load theme_contentedit
		case "editdb":checkcateaction(2):editdb
		case "del":checkcateaction(3):deldb
		case "delall":checkcateaction(3):delall
		case "doset":checkcateaction(5):doset
		case "move":checkcateaction(4):movedb
		case "movecate":checkcateaction(4):movecate
		case "redo":checkcateaction(5):redo
		case "redoall":checkcateaction(5):redoall
		case "clearall":checkcateaction(5):clearall
		case "delclear":checkcateaction(5):delclear
		case "getdate":getdate
		case "likedb":likedb
		case "tree":dim get_tree:treedb
		case else
			checkcatelever(classid)
			load theme_contentlist
	end select
	sdcms.db.dbclose
%>