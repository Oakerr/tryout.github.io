<!--#include file="../lib/base.asp"-->
<!--#include file="../theme.asp"-->
<%
''' SDCMS 评论
''' ==================================================================
''' 版权所有 http://www.sdcms.cn
''' ------------------------------------------------------------------
''' 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和使用；
''' 未经授权不允许对程序代码以任何形式任何目的的再发布。
''' ==================================================================
''' 编写: IT平民
''' 修改：IT平民 in 2012.12

	sub userstaus()
		dim gourl:gourl=sdcms.enhtml(sdcms.fpost("gourl",0))
		dim str:str=""
		dim avatar:avatar=0
		dim staus
		
			str=str&"<form class=""form_comment"" method=""post"">"
			str=str&"	<div class=""commentadd"">"
			str=str&"		<div class=""face""><img src="""&webroot&"upfile/avatar/{avatar}/normal.jpg"" /></div>"
			str=str&"		<div class=""text"">"
			str=str&"			<div class=""div""><textarea name=""t0"" id=""comment_content"" data-rule=""评论内容:required;"" onKeyUp=""strlen_verify(this,'commentlen',255)""></textarea>"
			str=str&"			<span>还可以输入<span id=""commentlen"">255</span>个字符</span>"
			str=str&"			</div>"
			str=str&"			{staus}"
			str=str&"		</div>"
			str=str&"	</div>"
			str=str&"	</form>"
			if sdcms.is_login then
				dim userdata:userdata=sdcms.userinfo
				avatar=userdata(12)
				staus="<div class=""input""><input type=""submit"" value=""发表评论"" name=""send"" class=""send"" />"&userdata(13)&"<input type=""hidden"" name=""t1"" class=""ip"" value="""&userdata(13)&""" maxlength=""20"" readonly=""readonly"" />(<a href="""&webroot&"user/login.asp?act=out&gourl="&gourl&""">匿名发表</a>)</div>"
				str=replace(str,"{avatar}",avatar)
				str=replace(str,"{staus}",staus)
			else
				dim nickname:nickname=sdcms.get_cityname("")&"网友"
				staus="<div class=""input""><input type=""submit"" value=""发表评论"" class=""send"" />"&nickname&"<input type=""hidden"" name=""t1"" class=""ip"" value="""&nickname&""" maxlength=""20"" />(<a href="""&webroot&"user/login.asp?gourl="&gourl&""">登陆发表</a>)</div>"
				str=replace(str,"{avatar}",0)
				str=replace(str,"{staus}",staus)
			end if
		if commentconfig(2) then
			if not(sdcms.is_login) then
				str="<a href="""&webroot&"user/login.asp?gourl="&gourl&""">请登陆后发表评论</a>"
			end if
		end if
		sdcms.echo str 
	end sub
	
	sub adddb()
		if commentconfig(2) then
			if not(sdcms.is_login) then
				sdcms.ajaxjson "&#35831;&#30331;&#38470;&#21518;&#20877;&#21457;&#34920;&#35780;&#35770;",0
				exit sub
			end if
		end if
		dim t0,t1,id
		t0=sdcms.enhtml(sdcms.fpost("t0",0))
		t1=sdcms.enhtml(sdcms.fpost("t1",0))
		id=sdcms.getint(sdcms.fget("id",0),0)
		if not(syscomment) then
			sdcms.ajaxjson "&#31995;&#32479;&#26410;&#24320;&#21551;&#35780;&#35770;",0
			exit sub
		end if
		dim f,passnum
		if commentconfig(1) then
			f=1
			passnum=0
		else
			f=2
			passnum=1
		end if
		if not(sdcms.checkpost) then
			sdcms.ajaxjson "&#31105;&#27490;&#22806;&#37096;&#25552;&#20132;&#25968;&#25454;",0
			exit sub
		end if
		if id=0 then
			sdcms.ajaxjson "&#21442;&#25968;&#38169;&#35823;",0
			exit sub
		end if
		if sdcms.strlen(t0)=0 then
			sdcms.ajaxjson "&#35780;&#35770;&#20869;&#23481;&#19981;&#33021;&#20026;&#31354;",0
			exit sub
		end if
		if sdcms.strlen(t0)<5 then
			sdcms.ajaxjson "&#35780;&#35770;&#20869;&#23481;&#33267;&#23569;&#36755;&#20837;&#53;&#20010;&#23383;&#31526;",0
			exit sub
		end if
		if sdcms.strlen(t1)=0 then
			sdcms.ajaxjson "&#26165;&#31216;&#19981;&#33021;&#20026;&#31354;",0
			exit sub
		end if
		if sdcms.loadcookie("comment_add_"&id)<>"" then
			if int(datediff("s",sdcms.loadcookie("comment_add_"&id),now()))<=60 then
				sdcms.ajaxjson "&#35831;&#21247;&#37325;&#22797;&#25552;&#20132;",0
				exit sub
			end if
		end if
		dim userid,avatar
		userid=0
		avatar=0
		
		if sdcms.is_login then
			dim userdata:userdata=sdcms.userinfo
			userid=userdata(0)
			avatar=userdata(12)
			if t1<>userdata(1) then
				t1=userdata(1)
			end if
		end if
		dim data,comments,tname
		data=sdcms.db.dbload(1,"comments,iscomment,title","sd_content","id="&id&"","")
		if ubound(data)<0 then
			sdcms.ajaxjson "&#21442;&#25968;&#38169;&#35823;",0
			exit sub
		else
			comments=data(0,0)
			tname=data(2,0)
			if data(1,0)=0 then
				sdcms.ajaxjson "&#26412;&#25991;&#31105;&#27490;&#35780;&#35770;",0
				exit sub
			end if
		end if
		data=array(array("contentid",id,0,1),array("username",t1,20,1),array("userid",userid,0,0),array("avatar",avatar,0,0),array("content",t0,255,1),array("createdate",sqltime,0,0),array("islock",passnum,0,0),array("followid",0,0,0),array("postip",sdcms.getip,0,1))
		sdcms.db.insert "sd_expand_comment",data
		sdcms.setcookie "comment_add_"&id,now()
		sdcms.setcookie "content_"&id,""
		sdcms.db.dbupdate "sd_content","id="&id&"",array(array("comments",comments+1,0,0))
		dim body:body=""
		dim title:title="您有一条新评论(来自网站)"
		body=body&"昵　称："&t1
		body=body&"<br>日　期："&now()
		body=body&"<br>标　题："&tname
		body=body&"<br>内　容："&t0
		sdcms.sendmail sdcms.getsys("adminemail"),title,body
		if commentconfig(1) then
			sdcms.ajaxjson f&"&#25552;&#20132;&#25104;&#21151;&#65292;&#23457;&#26680;&#21518;&#26174;&#31034;&#65281;",1
		else
			sdcms.ajaxjson f&"&#25552;&#20132;&#25104;&#21151;&#65281;",1
		end if
	end sub
	
	sub loadtop()
		dim id:id=sdcms.getint(sdcms.fget("id",0),0)
		if id=0 then
			exit sub
		end if
		if not(syscomment) then
			sdcms.echo "&#31995;&#32479;&#26410;&#24320;&#21551;&#35780;&#35770;"
			exit sub
		end if
		dim data:data=sdcms.db.dbload(10,"avatar,username,createdate,content,reply","sd_expand_comment","contentid="&id&" and islock=1","commentid desc")
		if ubound(data)<0 then
			sdcms.echo "&#27809;&#26377;&#35780;&#35770;"
			exit sub
		else
			dim i,str,temp,show
			temp=""
			temp=temp&"<div class=""comment"">"
            temp=temp&"        <div class=""face""><img src="""&webroot&"upfile/avatar/{avatar}/normal.jpg"" /></div>"
            temp=temp&"        <div class=""text"">"
            temp=temp&"            <div class=""div"">"
            temp=temp&"                <div class=""icon""></div>"
            temp=temp&"                <div class=""base""><span>{createdate}</span>{username}</div>"
            temp=temp&"                <div class=""content"">{content}</div>"
            temp=temp&"                {reply}"
            temp=temp&"            </div>"
            temp=temp&"        </div>"
            temp=temp&"    </div>"
			for i=0 to ubound(data,2)
				show=temp
				show=replace(show,"{avatar}",data(0,i))
				show=replace(show,"{username}",data(1,i))
				show=replace(show,"{createdate}",data(2,i))
				show=replace(show,"{content}",data(3,i))
				if sdcms.strlen(data(4,i))>0 then
					show=replace(show,"{reply}","<div class=""reply""><strong>管理员回复：</strong>"&data(4,i)&"</div>")
				else
					show=replace(show,"{reply}","")
				end if
				str=str&show
			next
			sdcms.echo str
		end if
	end sub
	
	dim act:act=sdcms.fget("act",0)
	select case act
		case "islogin":userstaus
		case "add":adddb
		case "load":loadtop
		case else
			if not(syscomment) then
				dim errormsg:errormsg="&#31995;&#32479;&#26410;&#24320;&#21551;&#35780;&#35770;"
				sdcms.show theme_404,""
				sdcms.die
			end if
			dim infoid:infoid=sdcms.getint(sdcms.fget("id",0),0)
			dim data,comments
			data=sdcms.db.dbload(1,"comments,iscomment,title,isurl,url,catedir,intro,classid,point,islock","sd_content left join sd_category on sd_content.classid=sd_category.cateid","id="&infoid&"","")
			if ubound(data)<0 then
				errormsg="&#21442;&#25968;&#38169;&#35823;"
				sdcms.show theme_404,""
				sdcms.die
			else
				if data(9,0)<>1 then
					errormsg="&#24744;&#26597;&#30475;&#30340;&#20869;&#23481;&#19981;&#23384;&#22312;"
					sdcms.show theme_404,""
					sdcms.die
				end if
				if data(1,0)=0 then
					errormsg="&#26412;&#25991;&#31105;&#27490;&#35780;&#35770;"
					sdcms.show theme_404,""
					sdcms.die
				end if
				dim infotitle,infourl,infointro,infopoint,classid
				infotitle=data(2,0)
				infourl=sdcms.geturl(infoid,data(7,0),data(3,0),data(4,0))
				infointro=data(6,0)
				classid=data(7,0)
				infopoint=data(8,0)
				data=sdcms.getclassdb(classid)
				dim parentid:parentid=data(6)
			end if
			dim sqlwhere:sqlwhere="and contentid="&infoid&""
			sdcms.show theme_comment,""
	end select
	sdcms.db.dbclose
%>