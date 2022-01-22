<!--#include file="base.asp"-->
<!--#include file="../skins.asp"-->
<%
''' SDCMS 栏目
''' ==================================================================
''' 版权所有 http://www.sdcms.cn
''' ------------------------------------------------------------------
''' 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和使用；
''' 未经授权不允许对程序代码以任何形式任何目的的再发布。
''' ==================================================================
''' 编写: IT平民
''' 修改：IT平民 in 2014.08

	sub loadsondb()
		dim str:str=""
		dim classid:classid=sdcms.getint(sdcms.fget("classid",0),0)
		dim data:data=sdcms.db.dbload("","cateid,followid,ordnum,catename,modeid,modelname,ismenu,allowpost,sonid","view_category","followid="&classid&"","ordnum,cateid")
		if ubound(data)<0 then
			exit sub
		end if
		dim i
		for i=0 to ubound(data,2)
			dim url:url=sdcms.iiif(data(4,i)=-1,data(4,i)=-2,"page","link","")
			str=str&"<tr id="""&data(0,i)&""" pId="""&data(1,i)&""""
			if instr(data(8,i),",")>0 then
				str=str&" hasChild=""true"""
			end if
			str=str&">"
			str=str&"	<td class=""txt_left""><a href=""../list.asp?classid="&data(0,i)&""" target=""_blank"">"&data(3,i)&"</a></td>"
			str=str&"	<td>"&data(0,i)&"<input type=""hidden"" name=""cid"" value="""&data(0,i)&""" ></td>"
			str=str&"	<td><input type=""text"" name=""ordnum"" id="""&data(0,i)&""" value="""&data(2,i)&""" size=""4"" maxlength=""4"" class=""ordnum"" data-rule=""排序:required;digit""></td>"
			str=str&"	<td>"&sdcms.iiif(data(4,i)=-1,data(4,i)=-2,"<em>单网页</em>","<u>外部链接</u>","内部栏目")&"</td>"
			str=str&"	<td>"&data(5,i)&"</td>"
			str=str&"	<td>"&sdcms.iif(data(6,i)=1,"是","<span>否</span>")&" / "&sdcms.iif(data(7,i)=1,"是","<span>否</span>")&"</td>"
			str=str&"	<td><a href=""?act=add"&url&"&id="&data(0,i)&"&moid="&data(4,i)&""">添加子栏目</a>　"
			if data(4,i)=-1 then
				str=str&"<a href=""sd_model_page.asp?classid="&data(0,i)&""">内容管理</a>"
			elseif data(4,i)=-2 then
				str=str&"　　　　"
			else
				str=str&"<a href=""sd_content.asp?classid="&data(0,i)&""">内容管理</a>"
			end if
			str=str&"　<a href=""?act=move&id="&data(0,i)&""">移动</a>　<a href=""?act=edit"&url&"&id="&data(0,i)&""">编辑</a>　<a href=""javascript:;"" class=""del"" rel="""&data(0,i)&""">删除</a></td>"
			str=str&"</tr>"
		next
		sdcms.echo str
	end sub
	
	sub classlist(byval t0)
		dim i
		for i=0 to ubound(data,2)
			if t0=data(3,i) then
				class_list=class_list&"<tr id=""class_"&data(0,i)&""">"
				class_list=class_list&"      <td><input type=""text"" name=""ordnum"" id="""&data(0,i)&""" value="""&data(7,i)&""" size=""4"" maxlength=""4"" class=""ordnum"" data-rule=""排序:required;digit""></td>"
				class_list=class_list&"      <td>"&data(0,i)&"<input type=""hidden"" name=""cid"" value="""&data(0,i)&""" ></td>"
				class_list=class_list&"      <td class=""txt_left"">　"&string(data(4,i)-1,"　")&sdcms.iif(data(3,i)>0,"<img src=""../theme/admin/images/line.gif"">","")&"<a href=""../list.asp?classid="&data(0,i)&""" target=""_blank"">"&data(1,i)&"</a></td>"
				class_list=class_list&"      <td>"&sdcms.iiif(data(10,i)=-1,data(10,i)=-2,"<b>单网页</b>","<u>外部链接</u>","内部栏目")&"</td>"
				class_list=class_list&"      <td>"&data(11,i)&"</td>"
				class_list=class_list&"      <td>"&sdcms.iif(data(8,i)=1,"是","<span>否</span>")&" / "&sdcms.iif(data(31,i)=1,"是","<span>否</span>")&"</td>"
				class_list=class_list&"      <td><a href=""?act=add"&sdcms.iiif(data(10,i)=-1,data(10,i)=-2,"page","link","")&"&id="&data(0,i)&"&moid="&data(10,i)&""">添加子栏目</a>　"
				select case data(10,i)
					case "-1"
						class_list=class_list&"<a href="" sd_model_page.asp?classid="&data(0,i)&""">内容管理</a>　"
					case "-2"
						class_list=class_list&"　　　　　"
					case else
						'if ""&data(0,i)&""=""&data(5,i)&"" then
							class_list=class_list&"<a href=""sd_content.asp?classid="&data(0,i)&""">内容管理</a>　"
						'else
							'class_list=class_list&"　　　　"
						'end if
				end select
				class_list=class_list&"<a href=""?act=move&id="&data(0,i)&""">移动</a>　<a href=""?act=edit"&sdcms.iiif(data(10,i)=-1,data(10,i)=-2,"page","link","")&"&id="&data(0,i)&""">编辑</a>　<a href=""javascript:;"" class=""del"" rel="""&data(0,i)&""">删除</a></td>"
				class_list=class_list&"</tr>"&vbcrlf
				classlist(data(0,i))
			end if
		next
	end sub
	
	sub orderdb()
		dim t0,t1,t2,t3,i
		t0=sdcms.enhtml(sdcms.fpost("ordnum",0))
		t1=sdcms.enhtml(sdcms.fpost("cid",0))
		t2=split(t0,", ")
		t3=split(t1,", ")
		if ubound(t2)-ubound(t3)<>0 then sdcms.ajaxjson "0&#21442;&#25968;&#38169;&#35823;",0:exit sub
		for i=0 to ubound(t2)
			if sdcms.isnum(t2(i)) then
				sdcms.db.dbupdate "sd_category","cateid="&t3(i)&"",array(array("ordnum",t2(i),10,0,0))
			end if
		next
		sdcms.ajaxjson "保存成功",1
	end sub
	
	sub adddb()
		dim t0,t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,t14
		t0=sdcms.enhtml(sdcms.fpost("t0",0))
		t1=sdcms.enhtml(sdcms.fpost("t1",0))
		t2=sdcms.getint(sdcms.fpost("t2",0),0)
		t3=sdcms.getint(sdcms.fpost("t3",0),0)
		t4=sdcms.getint(sdcms.fpost("t4",0),0)
		t5=sdcms.enhtml(sdcms.fpost("t5",0))
		t6=sdcms.getint(sdcms.fpost("t6",0),20)
		t7=sdcms.getint(sdcms.fpost("t7",0),0)
		t8=sdcms.enhtml(sdcms.fpost("t8",0))
		t9=sdcms.enhtml(sdcms.fpost("t9",0))
		t10=sdcms.enhtml(sdcms.fpost("t10",0))
		t11=sdcms.enhtml(sdcms.fpost("t11",0))
		t12=sdcms.enhtml(sdcms.fpost("t12",0))
		t13=sdcms.enhtml(sdcms.fpost("t13",0))
		t14=sdcms.getint(sdcms.fpost("t14",0),0)
	
		if sdcms.strlen(t0)=0 then sdcms.ajaxjson "&#26639;&#30446;&#21517;&#31216;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		add_class_one array(t0,t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,t14)
		sdcms.ajaxjson "&#20445;&#23384;&#25104;&#21151;",1
	end sub
	
	sub addmoredb()
		dim t0,t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,t14
		t0=sdcms.enhtml(sdcms.fpost("t0",0))
		t2=sdcms.getint(sdcms.fpost("t2",0),0)
		t3=sdcms.getint(sdcms.fpost("t3",0),0)
		t4=sdcms.getint(sdcms.fpost("t4",0),0)
		t5=sdcms.enhtml(sdcms.fpost("t5",0))
		t6=sdcms.getint(sdcms.fpost("t6",0),20)
		t7=sdcms.getint(sdcms.fpost("t7",0),0)
		t8=sdcms.enhtml(sdcms.fpost("t8",0))
		t9=sdcms.enhtml(sdcms.fpost("t9",0))
		t10=sdcms.enhtml(sdcms.fpost("t10",0))
		t11=sdcms.enhtml(sdcms.fpost("t11",0))
		t12=sdcms.enhtml(sdcms.fpost("t12",0))
		t13=sdcms.enhtml(sdcms.fpost("t13",0))
		t14=sdcms.getint(sdcms.fpost("t14",0),0)
	
		if sdcms.strlen(t0)=0 then sdcms.ajaxjson  "&#26639;&#30446;&#21517;&#31216;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		dim i,cname,result
		t0=replace(t0,chr(13),"")
		t1=split(t0,chr(10))
		for i=0 to ubound(t1)
			dim c_0,c_1
			if instr(t1(i),"|")>0 then
				cname=split(t1(i),"|")
				c_0=trim(cname(0))
				c_1=trim(cname(1))
			else
				c_0=trim(t1(i))
				c_1=""
			end if
			if sdcms.strlen(c_0)>0 then
				add_class_one array(c_0,c_1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,t14)
			end if
		next
		sdcms.ajaxjson "&#20445;&#23384;&#25104;&#21151;",1
	end sub
	
	sub add_class_one(byval str)
		dim t0,t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,t14
		if not isarray(str) then exit sub
		t0=str(0)
		t1=str(1)
		t2=str(2)
		t3=str(3)
		t4=str(4)
		t5=str(5)
		t6=str(6)
		t7=str(7)
		t8=str(8)
		t9=str(9)
		t10=str(10)
		t11=str(11)
		t12=str(12)
		t13=str(13)
		t14=str(14)
		if sdcms.strlen(t1)=0 then t1=sdcms.get_pinyin(t0)
		if t1="/" or right(lcase(t1),1)="/" or left(lcase(t1),1)="/" or not(sdcms.checkstr(t1,"file")) then
			sdcms.ajaxjson ""&t1&"&#33521;&#25991;&#30446;&#24405;&#22635;&#20889;&#38169;&#35823;",0
			sdcms.die
		end if
		dim thisid
		dim depth
		data=sdcms.db.dbload(1,"depth","sd_category","cateid="&t2&"","")
		if ubound(data)<0 then
			depth=1
		else
			depth=data(0,0)+1
		end if
		data=array(array("catename",t0,50),array("catedir",t1,255),array("followid",t2,10),array("modeid",t3,10),array("ismenu",t4,1),array("catepic",t5,255),array("pagenum",t6,10),array("ordnum",t7,10),array("cate_list",t8,255),array("cate_show",t9,255),array("seotitle",t10,255),array("catekey",t11,255),array("catedesc",t12,0),array("urlrule",t13,0),array("depth",depth,0),array("allowpost",t14,1))
		
		if sdcms.db.dbnew("sd_category",data,"catename='"&t0&"' and followid="&t2&"")=0 then
			sdcms.ajaxjson ""&t0&"&#26639;&#30446;&#21517;&#31216;&#24050;&#23384;&#22312;&#65292;&#35831;&#25442;&#20010;&#35797;&#35797;&#65281;",0
			sdcms.die
		else
			thisid=sdcms.db.insertid("cateid","sd_category")
			data=array(array("sonid",thisid,0,1),array("parentid",thisid,0,1))
			sdcms.db.dbupdate "sd_category","cateid="&thisid&"",data
			if t2>0 then
				dim datanew,pareid
				datanew=sdcms.db.dbload(1,"parentid","sd_category","cateid="&t2&"","")
				pareid=datanew(0,0)
				data=array(array("parentid",thisid&","&pareid,0,1))
				sdcms.db.dbupdate "sd_category","cateid="&thisid&"",data
				
				datanew=sdcms.db.dbload("","cateid,sonid","sd_category","cateid in("&pareid&")","")
				dim i,newid,newson
				for i=0 to ubound(datanew,2)
					newid=datanew(0,i)
					newson=datanew(1,i)
					data=array(array("sonid",newson&","&thisid,0,1))
					sdcms.db.dbupdate "sd_category","cateid="&newid&"",data
				next
			end if
			deal_file thisid,3
		end if
	end sub
	
	sub addlinkdb()
		dim t0,t1,t2,t3,t4,t5,thisid
		t0=sdcms.enhtml(sdcms.fpost("t0",0))
		t1=sdcms.getint(sdcms.fpost("t1",0),0)
		t2=sdcms.getint(sdcms.fpost("t2",0),0)
		t3=sdcms.enhtml(sdcms.fpost("t3",0))
		t4=sdcms.enhtml(sdcms.fpost("t4",0))
		t5=sdcms.getint(sdcms.fpost("t5",0),0)
		if sdcms.strlen(t0)=0 then sdcms.ajaxjson "&#26639;&#30446;&#21517;&#31216;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		if sdcms.strlen(t4)=0 then sdcms.ajaxjson "&#38142;&#25509;&#22320;&#22336;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		dim depth
		data=sdcms.db.dbload(1,"depth","sd_category","cateid="&t1&"","")
		if ubound(data)<0 then
			depth=1
		else
			depth=data(0,0)+1
		end if
		data=array(array("catename",t0,50),array("followid",t1,10),array("modeid",-2,2),array("ismenu",t2,1),array("catepic",t3,255),array("pagenum",0,1),array("cateurl",t4,255),array("ordnum",t5,10),array("depth",depth,0),array("allowpost",0,0))
		
		if sdcms.db.dbnew("sd_category",data,"catename='"&t0&"' and followid="&t1&"")=0 then
			sdcms.ajaxjson "&#26639;&#30446;&#21517;&#31216;&#24050;&#23384;&#22312;&#65292;&#35831;&#25442;&#20010;&#35797;&#35797;&#65281;",0:exit sub
		else
			thisid=sdcms.db.insertid("cateid","sd_category")
			data=array(array("sonid",thisid,0,1),array("parentid",thisid,0,1))
			sdcms.db.dbupdate "sd_category","cateid="&thisid&"",data
			if t1>0 then
				dim datanew,pareid
				datanew=sdcms.db.dbload(1,"parentid","sd_category","cateid="&t1&"","")
				pareid=datanew(0,0)
				data=array(array("parentid",thisid&","&pareid,0,1))
				sdcms.db.dbupdate "sd_category","cateid="&thisid&"",data
				
				datanew=sdcms.db.dbload("","cateid,sonid","sd_category","cateid in("&pareid&")","")
				dim i,newid,newson
				for i=0 to ubound(datanew,2)
					newid=datanew(0,i)
					newson=datanew(1,i)
					data=array(array("sonid",newson&","&thisid,0,1))
					sdcms.db.dbupdate "sd_category","cateid="&newid&"",data
				next
			end if
			deal_file thisid,3
			sdcms.ajaxjson "&#20445;&#23384;&#25104;&#21151;",1
		end if
	end sub
	
	sub addpagedb()
		dim t0,t1,t2,t3,t4,t5,t6,t7,t8,t9
		t0=sdcms.enhtml(sdcms.fpost("t0",0))
		t1=sdcms.enhtml(sdcms.fpost("t1",0))
		t2=sdcms.getint(sdcms.fpost("t2",0),0)
		t3=sdcms.getint(sdcms.fpost("t3",0),0)
		t4=sdcms.enhtml(sdcms.fpost("t4",0))
		t5=sdcms.getint(sdcms.fpost("t5",0),0)
		t6=sdcms.enhtml(sdcms.fpost("t6",0))
		t7=sdcms.enhtml(sdcms.fpost("t7",0))
		t8=sdcms.enhtml(sdcms.fpost("t8",0))
		t9=sdcms.enhtml(sdcms.fpost("t9",0))
		
		if sdcms.strlen(t0)=0 then sdcms.ajaxjson "&#26639;&#30446;&#21517;&#31216;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		add_page_one array(t0,t1,t2,t3,t4,t5,t6,t7,t8,t9)
		sdcms.ajaxjson "&#20445;&#23384;&#25104;&#21151;",1
	end sub
	
	sub addpagemoredb()
		dim t0,t1,t2,t3,t4,t5,t6,t7,t8,t9
		t0=sdcms.enhtml(sdcms.fpost("t0",0))
		t2=sdcms.getint(sdcms.fpost("t2",0),0)
		t3=sdcms.getint(sdcms.fpost("t3",0),0)
		t4=sdcms.enhtml(sdcms.fpost("t4",0))
		t5=sdcms.getint(sdcms.fpost("t5",0),0)
		t6=sdcms.enhtml(sdcms.fpost("t6",0))
		t7=sdcms.enhtml(sdcms.fpost("t7",0))
		t8=sdcms.enhtml(sdcms.fpost("t8",0))
		t9=sdcms.enhtml(sdcms.fpost("t9",0))
		
		if sdcms.strlen(t0)=0 then sdcms.ajaxjson "&#26639;&#30446;&#21517;&#31216;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		dim i,cname,result
		t0=replace(t0,chr(13),"")
		t1=split(t0,chr(10))
		for i=0 to ubound(t1)
			dim c_0,c_1
			if instr(t1(i),"|")>0 then
				cname=split(t1(i),"|")
				c_0=trim(cname(0))
				c_1=trim(cname(1))
			else
				c_0=trim(t1(i))
				c_1=""
			end if
			if sdcms.strlen(c_0)>0 then
				add_page_one array(c_0,c_1,t2,t3,t4,t5,t6,t7,t8,t9)
			end if
		next
		sdcms.ajaxjson "&#20445;&#23384;&#25104;&#21151;",1
	end sub
	
	sub add_page_one(byval str)
		dim t0,t1,t2,t3,t4,t5,t6,t7,t8,t9,thisid
		t0=str(0)
		t1=str(1)
		t2=str(2)
		t3=str(3)
		t4=str(4)
		t5=str(5)
		t6=str(6)
		t7=str(7)
		t8=str(8)
		t9=str(9)

		if sdcms.strlen(t1)=0 then t1=sdcms.get_pinyin(t0)
		if t1="/" or right(lcase(t1),1)="/" or left(lcase(t1),1)="/" or not(sdcms.checkstr(t1,"file")) then
			sdcms.ajaxjson ""&t1&"&#33521;&#25991;&#30446;&#24405;&#22635;&#20889;&#38169;&#35823;",0
			sdcms.die
		end if

		dim depth
		data=sdcms.db.dbload(1,"depth","sd_category","cateid="&t2&"","")
		if ubound(data)<0 then
			depth=1
		else
			depth=data(0,0)+1
		end if
		
		data=array(array("catename",t0,50),array("catedir",t1,255),array("followid",t2,10),array("modeid",-1,2),array("ismenu",t3,1),array("catepic",t4,255),array("pagenum",0,1),array("cateurl","",255),array("ordnum",t5,10),array("depth",depth,0),array("cate_show",t6,255),array("seotitle",t7,255),array("catekey",t8,255),array("catedesc",t9,0),array("allowpost",0,0))
		
		if sdcms.db.dbnew("sd_category",data,"catename='"&t0&"' and followid="&t2&"")=0 then
			sdcms.ajaxjson "&#26639;&#30446;&#21517;&#31216;&#24050;&#23384;&#22312;&#65292;&#35831;&#25442;&#20010;&#35797;&#35797;&#65281;",0
			sdcms.die
		else
			thisid=sdcms.db.insertid("cateid","sd_category")
			data=array(array("sonid",thisid,0,1),array("parentid",thisid,0,1))
			sdcms.db.dbupdate "sd_category","cateid="&thisid&"",data
			if t2>0 then
				dim datanew,pareid
				datanew=sdcms.db.dbload(1,"parentid","sd_category","cateid="&t2&"","")
				pareid=datanew(0,0)
				data=array(array("parentid",thisid&","&pareid,0,1))
				sdcms.db.dbupdate "sd_category","cateid="&thisid&"",data
				
				datanew=sdcms.db.dbload("","cateid,sonid","sd_category","cateid in("&pareid&")","")
				dim i,newid,newson
				for i=0 to ubound(datanew,2)
					newid=datanew(0,i)
					newson=datanew(1,i)
					data=array(array("sonid",newson&","&thisid,0,1))
					sdcms.db.dbupdate "sd_category","cateid="&newid&"",data
				next
			end if
			deal_file thisid,3
		end if
	end sub
	
	sub editdb()
		dim t0,t1,t2,t2_1,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13
		t0=sdcms.enhtml(sdcms.fpost("t0",0))
		t1=sdcms.enhtml(sdcms.fpost("t1",0))
		t2=sdcms.getint(sdcms.fpost("t2",0),0)
		t2_1=sdcms.getint(sdcms.fpost("t2_1",0),0)
		t3=sdcms.getint(sdcms.fpost("t3",0),0)
		t4=sdcms.enhtml(sdcms.fpost("t4",0))
		t5=sdcms.getint(sdcms.fpost("t5",0),20)
		t6=sdcms.getint(sdcms.fpost("t6",0),0)
		t7=sdcms.enhtml(sdcms.fpost("t7",0))
		t8=sdcms.enhtml(sdcms.fpost("t8",0))
		t9=sdcms.enhtml(sdcms.fpost("t9",0))
		t10=sdcms.enhtml(sdcms.fpost("t10",0))
		t11=sdcms.enhtml(sdcms.fpost("t11",0))
		t12=sdcms.enhtml(sdcms.fpost("t12",0))
		t13=sdcms.getint(sdcms.fpost("t13",0),0)
		if sdcms.strlen(t0)=0 then sdcms.ajaxjson "&#26639;&#30446;&#21517;&#31216;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		if sdcms.strlen(t1)=0 then t1=sdcms.get_pinyin(t0)
		if t1="/" or right(lcase(t1),1)="/" or left(lcase(t1),1)="/" or  not(sdcms.checkstr(t1,"file")) then
			sdcms.ajaxjson "&#33521;&#25991;&#30446;&#24405;&#22635;&#20889;&#38169;&#35823;",0:exit sub
		end if
		dim id:id=sdcms.getint(sdcms.fget("id",0),0)
		if t2_1<>0 then
			t2=sdcms.db.dbloadone("modeid","sd_category","cateid="&id&"")
		end if
		
		data=array(array("catename",t0,50,1),array("catedir",t1,255,1),array("modeid",t2,0,0),array("ismenu",t3,1,0),array("catepic",t4,255,1),array("pagenum",t5,12,0),array("ordnum",t6,12,0),array("cate_list",t7,255,1),array("cate_show",t8,255,1),array("seotitle",t9,255,1),array("catekey",t10,255,1),array("catedesc",t11,0,1),array("urlrule",t12,0,1),array("allowpost",t13,1,0))
		if sdcms.db.dbupdate("sd_category","cateid="&id&"",data)=1 then
			sdcms.ajaxjson "&#20445;&#23384;&#25104;&#21151;",1
		end if
	end sub
	
	sub editlinkdb()
		dim t0,t1,t2,t3,t4
		t0=sdcms.enhtml(sdcms.fpost("t0",0))
		t1=sdcms.getint(sdcms.fpost("t1",0),0)
		t2=sdcms.enhtml(sdcms.fpost("t2",0))
		t3=sdcms.enhtml(sdcms.fpost("t3",0))
		t4=sdcms.getint(sdcms.fpost("t4",0),0)
		if sdcms.strlen(t0)=0 then sdcms.ajaxjson "&#26639;&#30446;&#21517;&#31216;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		dim id:id=sdcms.getint(sdcms.fget("id",0),0)
		data=array(array("catename",t0,50,1),array("ismenu",t1,3,0),array("catepic",t2,255,1),array("cateurl",t3,255,1),array("ordnum",t4,10,0))
		if sdcms.db.dbupdate("sd_category","cateid="&id&"",data)=1 then
			sdcms.ajaxjson "&#20445;&#23384;&#25104;&#21151;",1
		end if
	end sub
	
	sub editpagedb()
		dim t0,t1,t2,t3,t4,t5,t6,t7,t8
		t0=sdcms.enhtml(sdcms.fpost("t0",0))
		t1=sdcms.enhtml(sdcms.fpost("t1",0))
		t2=sdcms.getint(sdcms.fpost("t2",0),0)
		t3=sdcms.enhtml(sdcms.fpost("t3",0))
		t4=sdcms.getint(sdcms.fpost("t4",0),0)
		t5=sdcms.enhtml(sdcms.fpost("t5",0))
		t6=sdcms.enhtml(sdcms.fpost("t6",0))
		t7=sdcms.enhtml(sdcms.fpost("t7",0))
		t8=sdcms.enhtml(sdcms.fpost("t8",0))
		if sdcms.strlen(t0)=0 then sdcms.ajaxjson "&#26639;&#30446;&#21517;&#31216;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		if sdcms.strlen(t1)=0 then t1=sdcms.get_pinyin(t0)
		if t1="/" or right(lcase(t1),1)="/" or left(lcase(t1),1)="/" or  not(sdcms.checkstr(t1,"file")) then
			sdcms.ajaxjson "&#33521;&#25991;&#30446;&#24405;&#22635;&#20889;&#38169;&#35823;",0:exit sub
		end if
		dim id:id=sdcms.getint(sdcms.fget("id",0),0)
		data=array(array("catename",t0,50,1),array("catedir",t1,255,1),array("ismenu",t2,3,0),array("catepic",t3,255,1),array("ordnum",t4,12,0),array("cate_show",t5,0,1),array("seotitle",t6,255,1),array("catekey",t7,255,1),array("catedesc",t8,0,1))
		if sdcms.db.dbupdate("sd_category","cateid="&id&"",data)=1 then
			sdcms.ajaxjson "&#20445;&#23384;&#25104;&#21151;",1
		end if
	end sub
	
	sub deldb()
		dim id:id=sdcms.getint(sdcms.fget("id",0),0)
		data=sdcms.db.dbload(1,"followid,sonid,parentid,modeid,(select tablename from sd_model where sd_model.modelid=sd_category.modeid),catepic","sd_category","cateid="&id&"","")
		
		if ubound(data)>=0 then
			if instr(data(1,0),",")>0 then
				sdcms.echo "0&#19981;&#33021;&#21024;&#38500;&#65292;&#35831;&#20808;&#21024;&#38500;&#23376;&#26639;&#30446;&#65281;":exit sub
			else
				select case data(3,0)
					case -1
						sdcms.db.dbdel "sd_model_page","classid="&id&""
						deal_del_file id,2
						delclassurl id
					case -2:
					case else
						delclassurl id
						dim tablename,dbs,j
						tablename=data(4,0)
						dbs=sdcms.db.dbload("","id","sd_content","classid="&id&"","")
						if ubound(dbs)>=0 then
							for j=0 to ubound(dbs,2)
								sdcms.db.dbdel tablename,"cid="&dbs(0,j)&""
								sdcms.db.dbdel "sd_expand_mood","contentid="&dbs(0,j)&""
								sdcms.db.dbdel "sd_expand_comment","contentid="&dbs(0,j)&""
								sdcms.db.dbdel "sd_user_favorite","contentid="&dbs(0,j)&""
								deal_del_file dbs(0,j),1
							next
						end if
						sdcms.db.dbdel "sd_content","classid="&id&""
				end select
				dim datanew,i
				datanew=sdcms.db.dbload("","cateid,sonid","sd_category","cateid in("&data(2,0)&")","")
				for i=0 to ubound(datanew,2)
					sdcms.db.dbupdate "sd_category","cateid="&datanew(0,i)&"",array(array("sonid",replace(datanew(1,i),","&id,""),0,1))
				next
				deal_del_file id,3
				sdcms.db.dbdel "sd_category","cateid="&id&""
			end if
		end if

		sdcms.echo "1删除成功"
	end sub
	
	sub movedb()
		dim id:id=sdcms.getint(sdcms.fget("id",0),0)
		dim t0:t0=sdcms.getint(sdcms.fpost("t0",0),0)
		data=sdcms.db.dbload(1,"followid,sonid,parentid","sd_category","cateid="&id&"","")
		if ubound(data)<0 then sdcms.ajaxjson "&#21442;&#25968;&#38169;&#35823;",0:exit sub
		dim old_followid,old_allclassid,old_partentid
		old_followid=data(0,0)
		old_allclassid=data(1,0)
		old_partentid=data(2,0)
		
		dim old_followid_num
		old_followid_num=sdcms.db.dbcount("sd_category","followid="&id&"")
		if clng(t0)=clng(old_followid) then sdcms.ajaxjson "&#27809;&#26377;&#31227;&#21160;",0:exit sub
		dim old_allclassid01
		old_allclassid01=replace(","&old_allclassid&",",""&id&"","")
		if instr(","&old_allclassid01&",",","&t0&",")>0 then sdcms.ajaxjson"&#19981;&#33021;&#31227;&#21160;&#21040;&#23376;&#26639;&#30446;&#19979;",0:exit sub
		if clng(t0)=clng(id) then sdcms.ajaxjson "&#19981;&#33021;&#31227;&#21160;&#33258;&#24049;&#19979;&#38754;",0
		if t0=0 then
			dim o_partentid,n_partentid
			dim o_allclassid,n_allclassid
			if old_followid_num=0 then
				data=sdcms.db.dbload("","cateid,parentid","sd_category","cateid in("&old_allclassid&")","cateid desc")
				dim i,j
				if ubound(data)>=0 then
					for i=0 to ubound(data,2)
						dim datanew
						datanew=sdcms.db.dbload("","cateid,sonid","sd_category","cateid in("&old_partentid&") and cateid<>"&data(0,i)&"","cateid")
						for j=0 to ubound(datanew,2)
							n_allclassid=replace(","&datanew(1,j)&",",","&data(0,i)&",",",")
							if left(n_allclassid,1)="," then n_allclassid=right(n_allclassid,sdcms.strlen(n_allclassid)-1)
							if right(n_allclassid,1)="," then n_allclassid=left(n_allclassid,sdcms.strlen(n_allclassid)-1)
							sdcms.db.dbupdate "sd_category","cateid="&datanew(0,j)&"",array(array("sonid",n_allclassid,0,1))
						next
						n_partentid=replace(","&data(0,i)&","&data(1,i)&",",","&old_partentid&",",",")
						if left(n_partentid,1)="," then n_partentid=right(n_partentid,sdcms.strlen(n_partentid)-1)
						if right(n_partentid,1)="," then n_partentid=left(n_partentid,sdcms.strlen(n_partentid)-1)
						sdcms.db.dbupdate "sd_category","cateid="&data(0,i)&"",array(array("parentid",n_partentid,0,1))
					next
				end if
				sdcms.db.dbupdate "sd_category","cateid="&id&"",array(array("followid",0,0,0))
				redepth
				sdcms.ajaxjson "栏目移动成功",1
			else
				data=sdcms.db.dbload("","cateid,sonid","sd_category","cateid in("&old_partentid&") and cateid<>"&id&"","cateid desc")
				for i=0 to ubound(data,2)
					n_allclassid=replace(","&data(1,i)&",",","&old_allclassid&",",",")
					if left(n_allclassid,1)="," then n_allclassid=right(n_allclassid,sdcms.strlen(n_allclassid)-1)
					if right(n_allclassid,1)="," then n_allclassid=left(n_allclassid,sdcms.strlen(n_allclassid)-1)
					sdcms.db.dbupdate "sd_category","cateid="&data(0,i)&"",array(array("sonid",n_allclassid,0,1))
				next
				dim old_old_old_partentid
				old_old_old_partentid=replace(","&old_partentid&",",","&id&",","")
				if left(old_old_old_partentid,1)="," then old_old_old_partentid=right(old_old_old_partentid,sdcms.strlen(old_old_old_partentid)-1)
				if right(old_old_old_partentid,1)="," then old_old_old_partentid=left(old_old_old_partentid,sdcms.strlen(old_old_old_partentid)-1)
				data=sdcms.db.dbload("","cateid,parentid","sd_category","cateid in("&Old_allclassid&")","cateid desc")
				for i=0 to ubound(data,2)
					n_partentid=replace(","&data(1,i)&",",","&old_old_old_partentid&",",",")
					if left(n_partentid,1)="," then n_partentid=right(n_partentid,sdcms.strlen(n_partentid)-1)
					if right(n_partentid,1)="," then n_partentid=left(n_partentid,sdcms.strlen(n_partentid)-1)
					sdcms.db.dbupdate "sd_category","cateid="&data(0,i)&"",array(array("parentid",n_partentid,0,1))
				next
				sdcms.db.dbupdate "sd_category","cateid="&id&"",array(array("followid",0,0,0))
				redepth
				sdcms.ajaxjson "栏目移动成功",1
			end if
		else
			dim pare_followid,datafoll,pare_sonid,pare_pid
			datafoll=sdcms.db.dbload(1,"followid,sonid,parentid","sd_category","cateid="&t0&"","")
			pare_followid=datafoll(0,0)
			pare_sonid=datafoll(1,0)
			pare_pid=datafoll(2,0)
			if old_followid<>pare_followid then
				dim new_allclassid,new_partentid
				data=sdcms.db.dbload(1,"sonid,parentid","sd_category","cateid="&t0&"","")
				if ubound(data)<0 then
					sdcms.echo "0&#26469;&#28304;&#38169;&#35823;":exit sub
				else
					new_allclassid=data(0,0)
					new_partentid=data(1,0)
				end if
				if old_followid=0 then
					data=sdcms.db.dbload("","cateid,sonid","sd_category","cateid in("&new_partentid&")","")
					if ubound(data)>=0 then
						for i=0 to ubound(data,2)
							sdcms.db.dbupdate "sd_category","cateid="&data(0,i)&"",array(array("sonid",data(1,i)&","&old_allclassid,0,1))
						next
					end if
					if old_followid_num=0 then
						sdcms.db.dbupdate "sd_category","cateid="&id&"",array(array("parentid",id&","&new_partentid,0,1))
					else
						dim o_o_o_o_partentid,n_n_n_n_partentid
						data=sdcms.db.dbload("","cateid,parentid","sd_category","cateid in("&Old_allclassid&")","")
						if ubound(data)>=0 then
							for i=0 to ubound(data,2)
								o_o_o_o_partentid=","&data(1,i)&","
								n_n_n_n_partentid=replace(o_o_o_o_partentid,","&old_followid&",",",")
								if left(n_n_n_n_partentid,1)="," then n_n_n_n_partentid=right(n_n_n_n_partentid,sdcms.strlen(n_n_n_n_partentid)-1)
								if right(n_n_n_n_partentid,1)="," then n_n_n_n_partentid=left(n_n_n_n_partentid,sdcms.strlen(n_n_n_n_partentid)-1)
								sdcms.db.dbupdate "sd_category","cateid="&data(0,i)&"",array(array("parentid",n_n_n_n_partentid&","&new_partentid,0,1))
							next
						end if
					end if
				else
					dim o_o_o_partentid,o_o_partentid,n_n_partentid
					o_o_o_partentid=replace(old_partentid,id&",","")
					data=sdcms.db.dbload("","cateid,sonid","sd_category","cateid in("&o_o_o_partentid&")","")
					if ubound(data)>=0 then
						for i=0 to ubound(data,2)
							n_n_partentid=replace(","&data(1,i)&",",","&old_allclassid&",",",")
							if left(n_n_partentid,1)="," then n_n_partentid=right(n_n_partentid,sdcms.strlen(n_n_partentid)-1)
							if right(n_n_partentid,1)="," then n_n_partentid=left(n_n_partentid,sdcms.strlen(n_n_partentid)-1)
							sdcms.db.dbupdate "sd_category","cateid="&data(0,i)&"",array(array("sonid",n_n_partentid,0,1))
						next
					end if
					data=sdcms.db.dbload("","cateid,sonid","sd_category","cateid in("&new_partentid&")","")
					if ubound(data)>=0 then
						for i=0 to ubound(data,2)
							sdcms.db.dbupdate "sd_category","cateid="&data(0,i)&"",array(array("sonid",data(1,i)&","&old_allclassid,0,1))
						next
					end if
					
					if old_followid_num=0 Then
						sdcms.db.dbupdate "sd_category","cateid="&id&"",array(array("parentid",id&","&new_partentid,0,1))
					else
						dim old_old_partentid
						old_old_partentid=replace(","&old_partentid&",",","&id&",","")
						if left(old_old_partentid,1)="," then old_old_partentid=right(old_old_partentid,sdcms.strlen(old_old_partentid)-1)
						if right(old_old_partentid,1)="," then old_old_partentid=left(old_old_partentid,sdcms.strlen(old_old_partentid)-1)
							
						dim o_o_o_o_o_partentid,n_n_n_n_n_partentid
						data=sdcms.db.dbload("","cateid,parentid","sd_category","cateid in("&old_allclassid&")","")
						if ubound(data)>=0 then
							for i=0 to ubound(data,2)
								o_o_o_o_o_partentid=","&data(0,i)&","
								n_n_n_n_n_partentid=replace(o_o_o_o_o_partentid,","&old_old_partentid&",",",")
								if left(n_n_n_n_n_partentid,1)="," then n_n_n_n_n_partentid=right(n_n_n_n_n_partentid,sdcms.strlen(n_n_n_n_n_partentid)-1)
								if right(n_n_n_n_n_partentid,1)="," then n_n_n_n_n_partentid=left(n_n_n_n_n_partentid,sdcms.strlen(n_n_n_n_n_partentid)-1)
								sdcms.db.dbupdate "sd_category","cateid="&data(0,i)&"",array(array("sonid",n_n_n_n_n_partentid&","&new_partentid,0,1))
							next
						end if
					end if
				end if
			else
				data=sdcms.db.dbload("","cateid,parentid","sd_category","cateid in("&old_allclassid&")","")
				if ubound(data)>=0 then
					for i=0 to ubound(data,2)
						o_o_o_o_o_partentid=data(1,i)
						o_o_o_o_o_partentid=replace(o_o_o_o_o_partentid,","&old_followid,"")
						o_o_o_o_o_partentid=o_o_o_o_o_partentid&","&pare_pid
						sdcms.db.dbupdate "sd_category","cateid="&data(0,i)&"",array(array("parentid",o_o_o_o_o_partentid,0,1))
					next
				end if
				
				sdcms.db.dbupdate "sd_category","cateid="&t0&"",array(array("sonid",pare_sonid&","&old_allclassid,0,1))
			end if
			sdcms.db.dbupdate "sd_category","cateid="&id&"",array(array("followid",t0,0,0))
			redepth
			sdcms.ajaxjson "栏目移动成功",1
		end if
	end sub
	
	sub reset()
		data=sdcms.db.dbload("","cateid,followid,depth,sonid,parentid","sd_category","","")
		if ubound(data)>=0 then
			dim i,thisid
			for i=0 to ubound(data,2)
			thisid=data(0,i)
			sdcms.db.dbupdate "sd_category","cateid="&data(0,i)&"",array(array("followid",0,0,0),array("depth",1,0,0),array("sonid",thisid,0,1),array("parentid",thisid,0,1))
			next
		end if
		sdcms.echo "1栏目复位成功"
	end sub
	
	dim get_sonid:get_sonid=""
	sub getsonid(byval t0)
		dim rs
		get_sonid=get_sonid&","&t0
		set rs=sdcms.db.conn.execute("select cateid,followid from sd_category where followid="&t0&"")
		if rs.eof then
			exit sub
		end if
		while not rs.eof
			if instr(get_sonid&",",","&rs(0)&",")<0 then
				get_sonid=get_sonid&","&rs(0)
			end if
			getsonid rs(0)
		rs.movenext
		wend
		rs.close
		set rs=nothing
	end sub
	
	dim get_parid:get_parid=""
	sub getparid(byval t0)
		dim rs
		get_parid=get_parid&","&t0
		set rs=sdcms.db.conn.execute("select followid from sd_category where cateid="&t0&"")
		if rs.eof then
			exit sub
		else
			if rs(0)=0 then
				exit sub
			else		
				getparid rs(0)
			end if
		end if
	end sub
	
	function get_sid(byval t0)
		getsonid(t0)
		get_sid=repair_id(get_sonid)
		get_sonid=""
	end function
	
	function get_pid(byval t0)
		getparid(t0)
		get_pid=repair_id(get_parid)
		get_parid=""
	end function
	
	function repair_id(byval t0)
		if len(t0)<=0 then
			repair_id=t0
		else
			repair_id=right(t0,len(t0)-1)
		end if
	end function
	
	sub repair()
		dim rs,t0,t1,t2
		set rs=server.createobject("adodb.recordset")
		rs.open "select cateid from sd_category",sdcms.db.conn,1,3
		while not rs.eof
			t0=get_sid(rs(0))
			t1=get_pid(rs(0))
			t2=ubound(split(t1,","))+1
			sdcms.db.conn.execute("update sd_category set sonid='"&t0&"',parentid='"&t1&"',depth="&t2&" where cateid="&rs(0)&"")
		rs.movenext
		wend
		rs.close
		set rs=nothing
		sdcms.echo "1修复成功"
	end sub
	
	sub gettemp()
		dim modid,listname
		modid=sdcms.getint(sdcms.fget("modid",0),0)
		listname=sdcms.fget("listname",0)
		if modid=0 then
			sdcms.echo "":exit sub
		end if
		data=sdcms.db.dbload(1,"default_temp,list_temp,show_temp","sd_model","modelid="&modid&"","")
		if ubound(data)<0 then
			sdcms.echo ""
		else
			sdcms.echo "<select onchange=""$('#"&listname&"').val(this.value)""><option>列表模板选择</option><option value="""&data(0,0)&""">频道模板("&data(0,0)&")</option>><option value="""&data(1,0)&""">列表模板("&data(1,0)&")</option></select>"
		end if
	end sub
	
	sub loadtemp()
		dim t0:t0=sdcms.enhtml(sdcms.fget("t0",1))
		dim t1:t1=sdcms.enhtml(sdcms.fget("t1",1))
		dim fso,fsofolder,fsocontent,fsocount,folder,str
		folder=theme_root&"/model/"&t1&""
		str="<ul class=""templist"">"
		str=str&"<li class=""tips""><span>提示：</span>模板选择请谨慎操作</li>"
		set fso=createobject("scripting.filesystemobject")
        set fsofolder=fso.getfolder(server.mappath(""&webroot&"theme/"&folder))
        set fsocontent=fsofolder.files

        dim fsoitem
        for each fsoitem in fsocontent
			if lcase(fsoitem.name)<>"config.asp" and lcase(fsoitem.name)<>"base.asp" and lcase(fsoitem.name)<>"config.xml" then
				str=str&"<li><span>"&getblockname("model/"&t1&"/"&fsoitem.name)&"</span><a href=""javascript:;"" onClick=""getid('"&t0&"','model/"&t1&"/"&fsoitem.name&"')"">"&fsoitem.name&"</a></li>"
			end if
		next
        set fso=nothing
        set fsofolder=nothing
        set fsocontent=nothing
		str=str&"</ul>"
		sdcms.echo str
	end sub
	
	sub redepth()
		dim depth
		data=sdcms.db.dbload("","cateid,parentid","sd_category","","")
		dim i
		if ubound(data)>=0 then
			for i=0 to ubound(data,2)
				depth=ubound(split(data(1,i),","))+1
				sdcms.db.dbupdate "sd_category","cateid="&data(0,i)&"",array(array("depth",depth,0,0))
			next
		end if
	end sub
	
	sub recache()
		dim gonum:gonum=sdcms.getint(sdcms.fget("go",0),0)
		sdcms.delcache "category"
		if gonum=1 then sdcms.echo "1栏目缓存更新成功"
	end sub
	
	sub delclassurl(byval t0)
		if webmode=3 then
			dim classurl:classurl=sdcms.getcateurl(t0)
			sdcms.delfolder classurl
		end if
	end sub
	
	sub pinyin()
		dim t0:t0=sdcms.enhtml(sdcms.fpost("t0",0))
		if sdcms.strlen(t0)=0 then sdcms.echo "0&#26639;&#30446;&#21517;&#31216;&#19981;&#33021;&#20026;&#31354;":exit sub
		sdcms.echo sdcms.get_pinyin(t0)
	end sub
	
	sub english()
		dim t0:t0=sdcms.enhtml(sdcms.fpost("t0",0))
		if sdcms.strlen(t0)=0 then sdcms.echo "0&#26639;&#30446;&#21517;&#31216;&#19981;&#33021;&#20026;&#31354;":exit sub
		sdcms.echo sdcms.get_english(t0)
	end sub
	
	islogin
	checkpagelever 19
	dim act:act=lcase(sdcms.fget("act",0))
	dim data
	select case act
		case "add","addlink","addpage","add_more","addpage_more"
			dim get_category,cid,get_tree,ji
			cid=sdcms.getint(sdcms.fget("id",0),0)
			data=sdcms.categorydata
			if isarray(data) then
				if ubound(data)>=0 then
					for ji=0 to ubound(data,2)
						get_tree=get_tree&""&sdcms.iif(ji=0,"",",")&"{"
						get_tree=get_tree&"id:"&data(0,ji)&""
						get_tree=get_tree&",pId:"&data(3,ji)&""
						get_tree=get_tree&",name:"""&data(1,ji)&""""
						get_tree=get_tree&"}"
					next
				end if
			end if
			dim moid:moid=sdcms.getint(sdcms.fget("moid",0),0)
			dim pname:pname="作为一级栏目"
			if cid>0 then
				pname=sdcms.db.dbloadone("catename","sd_category","cateid="&cid&"")
			end if
			load eval("theme_class"&act)
		case "adddb":adddb:recache
		case "addmoredb":addmoredb:recache
		case "addlinkdb":addlinkdb:recache
		case "addpagedb":addpagedb:recache
		case "addpagemoredb":addpagemoredb:recache
		case "edit","editlink","editpage"
			dim id
			id=sdcms.getint(sdcms.fget("id",0),0)
			data=sdcms.db.dbload("","cateid,catename,catedir,modeid,ismenu,catepic,pagenum,ordnum,cate_list,cate_show,seotitle,catekey,catedesc,cateurl,sonid,urlrule,allowpost","view_category","cateid="&id&"","")
			if data(3,0)>0 then
				dim catenum
				catenum=sdcms.db.dbcount("sd_content","classid in("&data(14,0)&")")
			end if
			load eval("theme_class"&act)
		case "editdb":editdb:recache
		case "editlinkdb":editlinkdb:recache
		case "editpagedb":editpagedb:recache
		case "move"
			id=sdcms.getint(sdcms.fget("id",0),0)
			dim fid,fname
			data=sdcms.db.dbload("","cateid,catename,followid","sd_category","cateid="&id&"","")
			if ubound(data)>=0 then
				fname=data(1,0)
				fid=data(2,0)
				get_category=""
				data=sdcms.categorydata
				if isarray(data) then
					if ubound(data)>=0 then
						get_tree=get_tree&"{id:0,pId:-1,name:""作为一级栏目""}"
						for ji=0 to ubound(data,2)
							get_tree=get_tree&",{"
							get_tree=get_tree&"id:"&data(0,ji)&""
							get_tree=get_tree&",pId:"&sdcms.iif(data(3,ji)=0,"-1",data(3,ji))&""
							get_tree=get_tree&",name:"""&data(1,ji)&""""
							if fid=data(0,ji) then
								get_tree=get_tree&",checked:true"
							end if
							if data(0,ji)<>data(5,ji) then
								get_tree=get_tree&",open:true"
							end if
							get_tree=get_tree&"}"
						next
					end if
				end if
			end if
			load eval("theme_class"&act)
		case "movedb":movedb:recache
		case "del":deldb:recache
		case "order":orderdb:recache
		case "temp":gettemp
		case "reset":reset:recache
		case "repair":repair:recache
		case "cache":recache
		case "loadtemp":loadtemp
		case "pinyin":pinyin
		case "english":english
		case "loadson":loadsondb
		case else:load theme_classlist
	end select
	sdcms.db.dbclose
%>