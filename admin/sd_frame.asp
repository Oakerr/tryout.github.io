<!--#include file="base.asp"-->
<%
	sub menudb()
		dim id:id=sdcms.getint(sdcms.fget("id",0),0)
		data=sdcms.db.dbload("","title,url","sd_admin_menu","id="&id&" and islock=1","ordnum,id")
		if ubound(data)<0 then
			exit sub
		end if
		dim title:title=data(0,0)
		dim url:url=data(1,0)
		dim arr:arr=split(url,"?")
		url=arr(0)
		if id=3 and title="内容" then
			dim get_pass
			data=sdcms.categorydata
			if isarray(data) then
				gettree 0,""
			end if
			get_pass="{id:-2,pId:-1,name:""综合管理"",url:"""",target:""iframe_body"",open:true}"
			get_pass=get_pass&",{id:-3,pId:-2,name:""内容列表"",url:""sd_content.asp?act=list"",target:""iframe_body""}"
			if admingroupid=0 then	
				get_pass=get_pass&",{id:-3,pId:-2,name:""区块管理"",url:""sd_block.asp"",target:""iframe_body""}"
				get_pass=get_pass&",{id:-3,pId:-2,name:""投稿管理"",url:""sd_publish.asp"",target:""iframe_body""}"
				get_pass=get_pass&",{id:-3,pId:-2,name:""回收站"",url:""sd_recycle.asp"",target:""iframe_body""}"
			else
				if instr(","&admin_page_lever&",",",20,")>0 or instr(","&admin_page_lever&",",",21,")>0 or instr(","&admin_page_lever&",",",32,")>0 then
					if instr(","&admin_page_lever&",",",32,")>0 then
						get_pass=get_pass&",{id:-3,pId:-2,name:""区块管理"",url:""sd_block.asp"",target:""iframe_body""}"
					end if
					if instr(","&admin_page_lever&",",",20,")>0 then
						get_pass=get_pass&",{id:-3,pId:-2,name:""投稿管理"",url:""sd_publish.asp"",target:""iframe_body""}"
					end if
					if instr(","&admin_page_lever&",",",21,")>0 then
						get_pass=get_pass&",{id:-3,pId:-2,name:""回收站"",url:""sd_recycle.asp"",target:""iframe_body""}"
					end if
				end if
			end if
			get_tree="["&get_pass&get_tree&"]"
			
			sdcms.echo get_tree
		else
			if id=8 and webmode<3 then
				dim w:w=" and id=45"
			end if
			data=sdcms.db.dbload("","title,url,id","sd_admin_menu","followid="&id&" and islock=1 "&w&" "&admin_lever_where&"","ordnum,id")
			if ubound(data)>0 then
				dim str,j
				str="["
				str=str&"{id:"&id&",pId:0,name:"""&title&""",open:true}"
				for j=0 to ubound(data,2)
					str=str&",{id:"&data(2,j)&",pId:"&id&",name:"""&data(0,j)&""",url:"""&sdcms.iif(left(data(1,j),1)="?",url,"")&data(1,j)&""",target:""iframe_body""}"
				next
				if id=7 then
					dim fso,fsofolder,fsocontent,fsocount
					dim xml,versions,author,website,plugkey
					set fso=createobject("scripting.filesystemobject")
					set fsofolder=fso.getfolder(server.mappath("../plug/"))
					set fsocontent=fsofolder.files
					for each fsocount in fsofolder.subfolders
						if sdcms.isfile("../plug/"&fsocount.name&"/config.xml") then
						set xml=server.createobject("microsoft.xmldom")
						xml.async=false
						xml.load(server.mappath("../plug/"&fsocount.name&"/config.xml"))
						title=xml.documentelement.childnodes(0).text
						plugkey=xml.documentelement.childnodes(4).text
						if sdcms.strlen(sdcms.getsys(plugkey))>0 then
							str=str&",{id:1,pId:"&id&",name:"""&title&""",url:""../plug/"&fsocount.name&"/"",target:""iframe_body""}"
						end if
						end if
					next
					set xml=nothing
					set fsofolder=nothing
					set fsocontent=nothing
				end if
				str=str&"]"
				sdcms.echo str
			end if
		end if	
	%>
    <%
	end sub
	
	sub gettree(byval t0,byval t1)
		dim i
		for i=0 to ubound(data,2)
			if admingroupid=0 then
				get_tree=get_tree&",{"
				get_tree=get_tree&"id:"&data(0,i)&""
				get_tree=get_tree&",pId:"&sdcms.iif(data(3,i)=0,"-1",data(3,i))&""
				get_tree=get_tree&",name:"""&data(1,i)&""""
				get_tree=get_tree&",url:"""
				select case data(10,i)
					case "-1":get_tree=get_tree&"sd_model_page.asp?classid="&data(0,i)
					case "-2":get_tree=get_tree&""
					case else:get_tree=get_tree&"sd_content.asp?classid="&data(0,i)
				end select
				get_tree=get_tree&""""
				get_tree=get_tree&",target:""iframe_body"""
				get_tree=get_tree&"}"
			else
				if instr(","&admin_cate_array&",",","&data(0,i)&",")>0 then
					get_tree=get_tree&",{"
					get_tree=get_tree&"id:"&data(0,i)&""
					get_tree=get_tree&",pId:"&sdcms.iif(data(3,i)=0,"-1",data(3,i))&""
					get_tree=get_tree&",name:"""&data(1,i)&""""
					get_tree=get_tree&",url:"""
					select case data(10,i)
						case "-1":get_tree=get_tree&"sd_model_page.asp?classid="&data(0,i)
						case "-2":get_tree=get_tree&""
						case else:get_tree=get_tree&"sd_content.asp?classid="&data(0,i)
					end select
					get_tree=get_tree&""""
					get_tree=get_tree&",target:""iframe_body"""
					get_tree=get_tree&"}"
				end if
			end if
		next
	end sub
	
	islogin
	dim act:act=lcase(sdcms.fget("act",0))
	dim data,get_tree
	select case act
		case "right":load theme_right
		case "menu":menudb
		case else
			dim s:s=sdcms.strlen(sdcms.getsys("qq.login"))
			load theme_frame
	end select
	sdcms.db.dbclose
%>