﻿<%
''' SDCMS 系统核心函数
''' ==================================================================
''' 版权所有 http://www.sdcms.cn
''' ------------------------------------------------------------------
''' 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和使用；
''' 未经授权不允许对程序代码以任何形式任何目的的再发布。
''' ==================================================================
''' 编写: IT平民

dim sdcms,sysdata,get_cate_option
dim get_content_page
set sdcms=new sdcms_function
	sdcms.init
class sdcms_function
	private reg,match,matches
	private fso,stm
	public db,temp,page,sysdb,classdb
	
	private sub class_initialize
		set reg=new regexp
			reg.ignorecase=true
			reg.global=true
		set fso=createobject("scripting.filesystemobject") 
		set stm=server.createobject("adodb.stream")
		set sysdb=server.createobject("scripting.dictionary")
		set classdb=server.createobject("scripting.dictionary")
	end sub
	
	private sub class_terminate
		set reg=nothing
		set fso=nothing
		set stm=nothing
		set sysdb=nothing
		set classdb=nothing
		set page=nothing
		set db=nothing
	end sub
	
	public sub init()
		set db=new sdcms_dbbase
		set page=new sdcms_pagelist
		set temp=new sdcms_template
	end sub
	
	public sub show(byval t0,byval t1)
		dim temproot:temproot=getsplitname(t0)
		temp.isgzip=isgzip
		temp.iscache=tempcache
		temp.cname=t1
		temp.cachepath=webroot&"cache/theme/"&theme_root&temproot(0)
		temp.templatepath=webroot&"theme/"&theme_root&temproot(0)
		temp.templatename=temproot(1)
		temp.templateext=temproot(2)
		temp.load()
		temp.display()
	end sub
	
	public sub sitedb()
		dim i,t0
		t0=sdcmsdata
		for i=0 to ubound(t0,2)
			if sysdb.exists(t0(0,i)) then
				sysdb.item(t0(0,i))=t0(1,i)
			else
				sysdb.add t0(0,i),t0(1,i)
			end if
		next
	end sub
	
	public sub catedb()
		dim i,t0,t1
		t0=categorydata
		if isarray(t0) then
			for i=0 to ubound(t0,2)
			t1=array(t0(0,i),t0(1,i),t0(2,i),t0(3,i),t0(4,i),t0(5,i),t0(6,i),t0(7,i),t0(8,i),t0(9,i),t0(10,i),t0(11,i),t0(12,i),t0(13,i),t0(14,i),t0(15,i),t0(16,i),t0(17,i),t0(18,i),t0(19,i),t0(20,i),t0(21,i),t0(22,i),t0(23,i),t0(24,i),t0(25,i),t0(26,i),t0(27,i),t0(28,i),t0(29,i),t0(30,i),t0(31,i),t0(32,i))
				if classdb.exists(t0(0,i)) then
					classdb.item(t0(0,i))=t1
				else
					classdb.add t0(0,i),t1
				end if
			next
		end if
	end sub
	
	public sub auto_update()	 
	end sub
	
	public function getsys(byval t0)
		getsys=sysdb.item(t0)
	end function
	
	public function getclassdb(byval t0)
		getclassdb=classdb.item(cdbl(t0))
	end function
	
	public function runtime()
		runtime=formatnumber(timer()-startime,4,true,false,true)
	end function
	
	public sub echo(byval t0)
		response.write t0
	end sub
	
	public sub die()
		response.end()
	end sub

	sub ajaxjson(byval t0,byval t1)
		dim t2:t2=iif(t1=1,"y","n")
		echo "{""info"":"""&t0&""",""status"":"""&t2&"""}"
	end sub
	
	public sub trans(t0)
		err.clear
		on error resume next
		server.transfer t0
		if err then
			echo "&#25991;&#20214;&#27809;&#26377;&#29983;&#25104;&#65292;&#26080;&#27861;&#35775;&#38382;"
			err.clear
		end if
	end sub
	
	public sub go(byval t0)
		response.redirect t0
	end sub
	
	function strlen(byval t0)
		if isnull(t0) then strlen=0:exit function
		strlen=len(t0)
	end function
	
	function is_null(byval t0)
		if isnull(t0) or isempty(t0) or t0="" then
			is_null=true
		else
			is_null=false
		end if
	end function
	
	public sub back(byval t0)
		echo "<script>alert("""&t0&""");location.href=""javascript:history.go(-1)""</script>"
	end sub
	
	public sub backurl(byval t0,byval t1)
		echo "<script>alert("""&t0&""");location.href="""&t1&"""</script>"
	end sub
	
	public sub script(byval t0)
		echo "<script>"&t0&"</script>"
	end sub
	
	public function iif(byval t0,byval t1,byval t2)
		if t0 then iif=t1 else iif=t2
	end function
	
	public function iiif(byval t0,byval t1,byval t2,byval t3,byval t4)
		if t0 then
			iiif=t2
		elseif t1 then
			iiif=t3
		else
			iiif=t4
		end if
	end function
	
	public function sqlstr(byval t0)
		sqlstr="'"&replace(t0,"'","''")&"'"
		sqlstr=replace(sqlstr,"%27","")
	end function
	
	public function fget(byval t0,byval t1)
		fget=request.querystring(t0)
		if t1=0 then fget=trim(fget)
	end function
	
	public function fpost(byval t0,byval t1)
		fpost=request.form(t0)
		if t1=0 then fpost=trim(fpost)
	end function
	
	public function fquery(byval t0,byval t1)
		fquery=request(t0)
		if t1=0 then fquery=trim(fquery)
	end function
	
	public function isnum(byval t0)
		isnum=true
		if not isnumeric(t0) then isnum=false
	end function
	
	public function ismoney(byval t0)
		ismoney=true
		if not isnumeric(t0) then ismoney=false:exit function
		if t0<0 then ismoney=false
	end function
	
	public function isinstall(byval t0)
		err.clear
		on error resume next
		isinstall=false
		dim obj
		set obj=server.createobject(t0)
			if err.number=0 then isinstall=true
		set obj=nothing
		err.clear()
	end function
	
	public function get_ismobile()
		if not(getsys("sys_mobile")) then get_ismobile=false:exit function
		dim t1:t1=request.servervariables("http_user_agent")
		if sdcms.strlen(t1)=0 then get_ismobile=false:exit function
		dim arr
		arr=array("android","phone","ipod","mqqbrowser","blackberry","nokia","windowsce","symbian","lg","ucweb","skyfire","webos","incognito","blackberry","mobile","bada")
		dim i,t0
		t0=false
		for i=0 to ubound(arr)
			if instr(lcase(t1),arr(i))>0 then
				t0=true
			end if
		next
		if t0 then
			if webmode=3 then webmode=1
		end if
		get_ismobile=t0
	end function
	
	public function getrnd(byval t0)
		randomize
		dim n1,n2,n3
		t0=getint(t0,10)
		do while len(getrnd)<t0
			n1=cstr(chrw((57-48)*rnd+48))
			n2=cstr(chrw((90-65)*rnd+65))
			n3=cstr(chrw((122-97)*rnd+97))
			getrnd=getrnd&n1&n2&n3 
		loop
	end function
	
	public function getrndfilename()
		dim t0,t1
		randomize
		t0=int(900*rnd)+100
		t1=now()
		getrndfilename=year(t1)&month(t1)&day(t1)&hour(t1)&minute(t1)&second(t1)&t0
	end function
	
	public function get_pinyin(byval t0)
		t0=replace(t0," ","-")
		t0=replace(t0,"　","-")
		dim py
		set py=new sdcms_pinyin
			get_pinyin=py.pinyin(t0)
		set py=nothing
		get_pinyin=left(get_pinyin,50)
	end function
	
	public function get_english(byval t0)
		dim url:url="http://fanyi.youdao.com/openapi.do?keyfrom=sdcms2015&key=1680379450&type=data&doctype=json&version=1.1&q="&server.urlencode(t0)&"&only=translate"
		dim html:html=gethttp(url,"")
		dim json,str
		set json=toobject(html)
			if json.errorCode="0" then
				str=json.translation
			end if
		set json=nothing
		str=replace(str," ","-")
		get_english=str
	end function
	
	
	public function split_tags(byval t0)
		on error resume next
		dim xml,objnodes,i,str
		t0=server.urlencode(t0)
		set xml=server.createObject("microsoft.xmldom")
		with xml
			.async="false"
			.resolveexternals="false"
			.setproperty "ServerHTTPRequest",true
			.load("http://keyword.discuz.com/related_kw.html?title="&t0&"&ics=utf-8&ocs=utf-8")
			if .getelementsbytagname("info")(0).selectsinglenode("count").text>0 then
				set objnodes=.getelementsbytagname("item")
				for i=0 to objnodes.length-1
					str=str&trim(objnodes(i).selectsinglenode("kw").text)&","
				next
				set objnodes=nothing
				str=left(str,len(str)-1)
			else
				str=""
			end If
		end with
		set xml=nothing
		if err then err.clear:str=""
		split_tags=str
	end function

	public function replacetext(byval t0,byval t1,byval t2)
		reg.pattern=t1
		reg.ignorecase=true
		reg.global=true
		replacetext=reg.replace(""&t0&"",""&t2&"")
	end function
	
	public function getkey()
		getkey=getrnd(5)
	end function

	public function get_thisfolder
		dim a,b,c
		a=request.servervariables("script_name")
		b=split(a,"/")
		c=ubound(b)
		if c<=1 then
			get_thisfolder=""
		else
			get_thisfolder=b(c-2)
		end if
	end function
	
	public function getsplitname(byval t0)
		dim str:str=t0
		if t0="" then
			echo "模板文件不能为空":die
		end if
		if instr(t0,".")<=0 then
			echo "模板路径错误("&t0&")":die
		end if
		dim str_arr:str_arr=split(str,"/")
		dim file_full_name:file_full_name=str_arr(ubound(str_arr))
		dim file_dir:file_dir=replace(t0,file_full_name,"")
		dim filearr:filearr=split(file_full_name,".")
		dim filename:filename=filearr(0)
		dim file_fix:file_fix=filearr(1)
		if len(file_dir)=0 then file_dir="/" else file_dir="/"&file_dir
		getsplitname=array(file_dir,filename,file_fix)
	end function
	
	public function getint(byval t0,byval t1)
		on error resume next
		if isnum(t0) then getint=cdbl(t0) else getint=t1
		if err then
			errlog "getint："&t0&","&t1&"<br>详情："&err.description,1
			err.clear
		end if
	end function
	
	public function get_int(byval t0,byval t1)
		get_int=iif(checkstr(t0,"int"),t0,t1)
	end function
	
	public function getdate(byval t0,byval t1,byval t2)
		getdate=""
		if t2=1 then getdate=getdate&year(t0)&t1
		getdate=getdate&right("0"&month(t0),2)&t1
		getdate=getdate&right("0"&day(t0),2)
	end function
	
	public function numtodate(byval t0)
		if not isnumeric(t0) or len(t0)<>8 then
			numtodate=""
		else
			numtodate=mid(t0,1,4)&"-"&mid(t0,5,2)&"-"&mid(t0,7,2)
		end if
	end function
	
	public function getnum(byval t0)
		getnum=formatnumber(t0,2,true,false,true)
	end function
	
	public function getmoney(byval t0)
		getmoney=formatcurrency(t0,2,true,false,true)
	end function
	
	public function getpcent(byval t0,byval t1)
		dim t2
		if t1="" then
			t1=0
			t2="0%"
		else
			t2="0.00%"
		end if
		if isnum(t0) then getpcent=formatpercent(t0,t1,true) else getpcent=t2
	end function
	
	public function getthisurl()
		dim t0
		t0=fget("url",0)
		if len(t0)>0 then
			getthisurl=t0
		else
			t0=request.servervariables("http_x_rewrite_url")
			if len(t0)=0 then t0=request.servervariables("http_x_original_url")
			if len(t0)>0 then
				getthisurl=weburl&t0
			else
				dim t5 
				dim t1,t2,t3,t4 
				t1=request.servervariables("server_name") 
				t2=request.servervariables("server_port") 
				t3=request.servervariables("script_name") 
				t4=request.servervariables("query_string") 
				t5="http://"&t1 
				if t2<>"80" then t5=t5&":"&t2 
				t5=t5&t3 
				if t4<>"" then t5=t5&"?"&t4 
				getthisurl=t5
			end if
		end if
		getthisurl=enhtml(replace(getthisurl,"&","%26"))
	end function
	
	public function geturlparam()
		dim x,queryarray,tempstr
		for each x in split(request.querystring,"&")
		   queryarray=split(x,"=")
		   if ubound(queryarray)>0 then
			   if lcase(queryarray(0))<>"page" then
				   tempstr=tempstr&queryarray(0)&"="&queryarray(1)&"&"
			   end if
		   end if
		next
		geturlparam=enhtml(tempstr)
	end function
	
	public function getip()
		getip=request.servervariables("http_x_forwarded_for")
		if getip="" then getip=request.servervariables("remote_addr")
		if not(checkstr(getip,"ip")) then getip="unknow"
	end function
	
	public function gethttp(byval t0,byval t1)
		select case t1
			case "get","post"
			case else:t1="get"
		end select
		t1=ucase(t1)
		on error resume next
		dim http
		set http=server.createobject(xmlhttp)
			http.open t1,t0,false
			http.setRequestHeader "If-Modified-Since","0"
			http.send()
			gethttp=http.responsetext
		set http=nothing
	end function
	
	public function deal_strmid(byval t0,byval t1)
		if len(t0)=0 or len(t1)=0 then deal_strmid="":exit function
		dim i,t2,t3
		t2=split(t0,t1)
		t3=""
		for i=0 to ubound(t2)
			if len(t2(i))>0 then
				if len(t3)=0 then
					t3=t2(i)
				else
					t3=t3&t1&t2(i)
				end if
			end if
		next
		deal_strmid=t3
	end function
	
	public function is_pic(byval t0)
		if isnull(t0) or len(t0)=0 then is_pic=0:exit function
		if instr(t0,".")<0 then is_pic=0:exit function
		if len(t0)<4 then is_pic=0:exit function
		select case lcase(right(t0,3))
			case "gif","jpg","bmp","png":is_pic=1
			case else:is_pic=0
		end select
	end function
	
	public function is_video(byval t0)
		if isnull(t0) or len(t0)=0 then is_video="other":exit function
		if instr(t0,".")<0 then is_video="other":exit function
		if len(t0)<4 then is_video="other":exit function
		if instr(lcase(t0),".swf")>0 and instr(lcase(t0),"http://") then is_video="swf":exit function
		select case lcase(right(t0,3))
			case "flv":is_video="flv"
			case "swf":is_video="swf"
			case "mp4":is_video="mp4"
			case else:is_video="other"
		end select
	end function
	
	public function nohtml(byval t0)
		if strlen(t0)=0 then nohtml="":exit function
		reg.pattern="<.+?>"
		set matches=reg.execute(t0)
		for each match in matches
			t0=replace(t0,match.value,"")
		next
		t0=replace(t0,"&nbsp;"," ")
		t0=replace(t0,"　","")
		nohtml=t0
	end function
	
	public function enhtml(byval t0)
		if isnull(t0) then enhtml="":exit function
		if t0="<p>&nbsp;</p>" then enhtml="":exit function
		reg.pattern ="<script.+?/script>"
		t0=reg.replace(t0,"")
		reg.pattern ="<iframe.+?/iframe>"
		t0=reg.replace(t0,"")
		t0=replace(t0,"&","&amp;")
		t0=replace(t0,"'","&#39;")
		t0=replace(t0,"""","&#34;")
		t0=replace(t0,"<","&lt;")
		t0=replace(t0,">","&gt;")
		reg.pattern="(w)(here)"
		t0=reg.replace(t0,"$1h&#101;re")
		reg.pattern="(s)(elect)"
		t0=reg.replace(t0,"$1el&#101;ct")
		reg.pattern="(i)(nsert)"
		t0=reg.replace(t0,"$1ns&#101;rt")
		reg.pattern="(c)(reate)"
		t0=reg.replace(t0,"$1r&#101;ate")
		reg.pattern="(d)(rop)"
		t0=reg.replace(t0,"$1ro&#112;")
		reg.pattern="(a)(lter)"
		t0=reg.replace(t0,"$1lt&#101;r")
		reg.pattern="(d)(elete)"
		t0=reg.replace(t0,"$1el&#101;te")
		reg.pattern="(u)(pdate)"
		t0=reg.replace(t0,"$1p&#100;ate")
		reg.pattern="(\s)(or)"
		t0=reg.replace(t0,"$1o&#114;")
		reg.pattern="(java)(script)"
		t0=reg.replace(t0,"$1scri&#112;t")
		reg.pattern="(j)(script)"
		t0=reg.replace(t0,"$1scri&#112;t")
		reg.pattern="(vb)(script)"
		t0=reg.replace(t0,"$1scri&#112;t")
		if instr(t0,"expression")<>0 then
			t0=replace(t0,"expression","e&#173;xpression",1,-1,0)
		end if
		enhtml=t0
	end function
	
	public function theme_html(byval t0)
		t0=replace(t0,"&","&amp;")
		t0=replace(t0,"'","&#39;")
		t0=replace(t0,"""","&#34;")
		t0=replace(t0,"<","&lt;")
		t0=replace(t0,">","&gt;")
		theme_html=t0
	end function
	
	public function dehtml(byval t0)
		if isnull(t0) then
			dehtml=""
			exit function
		end if
		t0=replace(t0,"&amp;","&")
		t0=replace(t0,"&#39;","'")
		t0=replace(t0,"&#34;","""")
		t0=replace(t0,"&lt;","<")
		t0=replace(t0,"&gt;",">")
		t0=replace(t0,chr(10),vbcrlf)
		dehtml=t0
	end function
	
	public function checkstr(byval t0,byval t1)
		dim t2
		select case t1
			case "null":checkstr=is_null(t0):exit function
			case "en":t2="^[a-zA-Z]+$"
			case "cn":t2="^[\u4e00-\u9fa5]+$"
			case "int":t2="^[-\+]?\d+$"
			case "price":t2="^\d+(\.\d+)?$"
			case "username":t2="^[a-zA-Z0-9_]{5,20}$"
			case "password":t2="^[a-zA-Z0-9.]{6,16}$"
			case "email":t2="^[\w\-\.]+@[a-zA-Z0-9]+\.(([a-zA-Z0-9]{2,4})|([a-zA-Z0-9]{2,4}\.[a-zA-Z]{2,4}))$"
			case "date":checkstr=isdate(t0):exit function
			case "qqemail":t2="^[\w\-\.]+@qq.com"
			case "tel":t2="^((\(\+?\d{2,3}\))|(\+?\d{2,3}\-))?(\(0?\d{2,3}\)|0?\d{2,3}-)?[1-9]\d{4,7}(\-\d{1,4})?$"
			case "mobile":t2="^(\+?\d{2,3})?0?1(3\d|5\d|7[0]|8[0256789])\d{8}$"
			case "zipcode":t2="^\d{6}$"
			case "qq":t2="^[1-9]\d{4,15}$"
			case "url":t2 = "^(http|https|ftp):\/\/[a-zA-Z0-9]+\.[a-zA-Z0-9]+[\/=\?%\-&_~`@[\]\':+!]*([^<>\""])*$"
			case "ip":t2="^((25[0-5]|2[0-4]\d|(1\d|[1-9])?\d)\.){3}(25[0-5]|2[0-4]\d|(1\d|[1-9])?\d)$"
			case "file":t2="^[a-zA-Z0-9/_-]{1,50}$"
			case "filename":t2="^[a-zA-Z0-9._/]{1,50}$"
			case "urlname":t2="^[a-zA-Z0-9]{1,50}$"
		end select
		reg.pattern=t2
		checkstr=reg.test(trim(t0))
	end function
	
	public function cutstr(byval t0,byval t1,byval t2)
		dim l,t,c,i
		if strlen(t0)=0 then cutstr="":exit function
		l=len(t0)
		t1=int(t1)
		t=0
		for i=1 to l
			c=ascw(mid(t0,i,1))
			if c<0 or c>255 then t=t+2 else t=t+1
			if t>t1 then
				cutstr=left(t0,i)
				if t2=1 then cutstr=cutstr&"…"
				exit for
			else
				cutstr=t0
			end if
		next
	end function
	
	public function checkpost
		checkpost=false
		dim t0,t1,t2
		t0=cstr(request.servervariables("http_referer"))
		t1=cstr(request.servervariables("server_name"))
		t2=request.servervariables("http_user_agent")
		if instr(lcase(t2),"firefox")>0 Then
			checkpost=true
			exit function
		end if
		if instr(t0,replace(replace(t1,"http://",""),"www.",""))=0 then
			checkpost=false
		else
			checkpost=true
		end if
	end function
	
	public function closehtml(byval t0)
		dim t1,i,t2,t3,j
		t1=array("p","div","span","table","ul","font","b","u","i","h1","h2","h3","h4","h5","h6")
		for i=0 to ubound(t1)
			t2=0:t3=0
			reg.pattern="\<"&t1(i)&"( [^\<\>]+|)\>"
			set matches=reg.execute(t0)
			for each match in matches
				t2=t2+1
			next
			reg.pattern="\</"&t1(i)&"\>"
			set matches=reg.execute(t0)
			for each match in matches
				t3=t3+1
			next
			for j=1 to t2-t3
				t0=t0+"</"&t1(i)&">"
			next
		next
		closehtml=t0
	end function
	
	public function highlight(byval t0,byval t1)
		reg.pattern="("&t1&")"
		highlight=reg.replace(t0,"<font color=""red"">$1</font>")
	end function
	
	public function get_frist_pic(byval t0)
		get_frist_pic=""
		if strlen(t0)=0 then exit function
		reg.pattern="<img[^>]+src=""([^"">]+)""[^>]*>"
		set matches=reg.execute(t0)
		if reg.test(t0) then
		   get_frist_pic=matches(0).submatches(0)
		end if
	end function
	
	public function getpic(byval t0)
		dim pic:pic=""
		reg.pattern="<img[^>]+src=""([^"">]+)""[^>]*>"
		set matches=reg.execute(t0)
		if matches.count>0 then
			for each match in matches
				if left(lcase(match.submatches(0)),7)<>"http://" then
					pic=pic&"|"&match.submatches(0)
				end if
			next
		end if
		if len(pic)>1 then pic=right(pic,len(pic)-1)
		getpic=pic
	end function
	
	public function get_outfile(byval t0)
		if strlen(t0)=0 then get_outfile="":exit function
		dim filename:filename=""
		dim filedata,t1
		t0=replace(t0,".jpg_","\u002e\u006a\u0070\u0067\u005f")
		set filedata=server.createobject("scripting.dictionary")
		reg.pattern="(http://(.[^>]+?)\.(gif|jpg|png|bmp))"
		set matches=reg.execute(t0)
		if matches.count>0 then
			for each match in matches
				t1=match.submatches(0)
				if filedata.exists(t1) then
					filedata.item(t1)=t1
				else
					filedata.add t1,t1
				end if
			next
		end if
		dim labeltag:labeltag=filedata.keys
		dim labelval:labelval=filedata.items
		if filedata.count>0 then
			dim i
			for i=0 to filedata.count-1
				if filename="" then
					filename=labelval(i)
				else
					filename=filename&"|"&labelval(i)
				end if
			next
		end if
		set filedata=nothing
		filename=replace(filename,"\u002e\u006a\u0070\u0067\u005f",".jpg_")
		get_outfile=filename
	end function
	
	public function deal_outfile(byval t0,byval t1)
		dim htmlcontent:htmlcontent=t0
		dim filelist:filelist=get_outfile(htmlcontent)
		if filelist="" then deal_outfile=htmlcontent:exit function
		dim filearr,i
		filearr=split(filelist,"|")
		for i=0 to ubound(filearr)
			dim filetxt:filetxt=mid(filearr(i),instrrev(filearr(i),".")+1)
			dim filepath:filepath=uploaddir("")
			dim filename:filename=getrndfilename
			dim newfile:newfile=filepath&filename&"."&filetxt
			if save_outfile(filearr(i),array(filepath,filename,filetxt),t1) then
				htmlcontent=replace(htmlcontent,filearr(i),newfile)
			end if
		next
		deal_outfile=htmlcontent
	end function
	
	public function save_outfile(byval t0,byval t1,byval t2)
		on error resume next
		dim http,filedata,filesize,filename
		filename=t1(0)&t1(1)&"."&t1(2)
		set http=server.createobject(xmlhttp)
		with http
			.open "get",t0,false,"",""
			.send
			filedata=.responsebody
			filesize=getnum(round(lenb(filedata))/1024)
		end with
		with stm
			.type=1
			.open
			.write filedata
			.savetofile server.mappath(filename), 2
			.cancel
		.close
		end with
		if err then
			errlog "文件名："&filename&"<br>函数：save_outfile<br>详情："&err.description,1
			err.clear
			save_outfile=false
		else
			db.insert "sd_attachment",array(array("cid",t2(0),0,0),array("classid",t2(1),0,0),array("filepath",t1(0),255,1),array("filename",t1(1),255,1),array("filesize",filesize,255,1),array("oldname",t1(1),255,1),array("fileext",t1(2),50,1),array("ispic",1,1,0),array("createip",getip,255,1),array("createdate",sqltime,255,0),array("adminid",t2(2),0,0),array("userid",0,0,0),array("fullname",filename,0,1))
			save_outfile=true
		end if
	end function
	
	public function get_intro(byval t0)
		t0=dehtml(t0)
		if strlen(t0)=0 then get_intro="":exit function
		dim t1:t1=lcase(t0)
		t1=replace(t0,"div","p")
		dim str,i
		str=""
		if (instr(t1,"<p")<=0 or instr(t1,"</p>")<=0) and instr(t1,"<br")<=0 then
			get_intro=cutstr(t0,255,1)
			exit function
		else
			if left(t1,1)<>"<" and instr(t1,"<br")>0 then
				t0=replace(t0,"<br>","<br />")
				t0=replace(t0,"<br/>","<br />")
				t1=split(t0,"<br />")
				for i=0 to ubound(t1)
					if str="" then
						str=t1(i)
					else
						str=str&"<br />"&t1(i)
					end if
					if i>=5 then exit for
				next
			else
				i=0
				reg.pattern="<p(.+?)</p>"
				set matches=reg.execute(t0)
				if matches.count>0 then
					for each match in matches
						str=str&match.value
						i=i+1
						if i>=5 then exit for
					next
				end if
			end if
		end if
		str=replace(str,"_sdcms_content_page_","")
		str=closehtml(str)
		get_intro=str
	end function
	
	public sub setcache(byval t0,byval t1,byval t2)
		if t2=0 then
			dim t3(2)
			t3(0)=t1
			t3(1)=now()
		else
			t3=t1
		end if
		application.lock()
		application(prefix&t0)=t3
		application.unlock()
	end sub
	
	public sub delcache(byval t0)
		application.lock()
		application.contents.remove(prefix&t0)
		application.unlock()
	end sub
	
	public sub clearcache()
		application.contents.removeall()
	end sub
	
	public function checkcache(byval t0,byval t1)
		dim t2
		checkcache=false
		t2=application(prefix&t0)
		if cachedate="" then
			cachedate=60
		end if
		if t1=0 then
			if not isarray(t2) then
				exit function
			else
				if clng(datediff("s",cdate(t2(1)),now()))>clng(cachedate) then
					exit function
				end if
			end if
		else
			if isempty(t2) then
				exit function
			end if
		end if
		checkcache=true
	end function
	
	public function loadcache(byval t0,byval t1)
		dim t2:t2=application(prefix&t0)
		if t1=0 then
			if isarray(t2) then
				loadcache=t2(0)
			else
				loadcache=t2
			end if
		else
			loadcache=t2
		end if
	end function
	
	public sub setcookie(byval t0,byval t1)
		response.cookies(prefix)(t0)=t1
	end sub
	
	public function loadcookie(t0)
		loadcookie=request.cookies(prefix)(t0)
	end function
	
	public sub setsession(byval t0,byval t1)
		session(prefix&t0)=t1
	end sub
	
	public function loadsession(byval t0)
		loadsession=session(prefix&t0)
	end function
	
	public function uploaddir(byval t0)
		if strlen(t0)>0 then t0=t0&"/"
		Dim t1:t1=now()
		Dim t2:t2=year(t1)&right("0"&month(t1),2)&"/"
		uploaddir=webroot&getsys("upfile")&"/"&t0&t2
		newfolder uploaddir
	end function
	
	public function isfolder(byval t0)
		isfolder=fso.folderexists(server.mappath(t0))
	end function
	
	function isfile(byVal t0)
		on error resume next
		isfile=fso.fileexists(server.mappath(t0))
		if err then
			err.clear
			isfile=false
		end if
	end function
	
	public sub newfolder(byval t0)
		dim t1,t2,i
		err.clear
		on error resume next
		t0=server.mappath(t0)
		if fso.folderexists(t0) then exit sub
		t1=split(t0,"\")
		t2="" 
		for i=0 to ubound(t1)  
			t2=t2&t1(i)&"\"
			if not fso.folderexists(t2) then fso.createfolder(t2)
			if err then
				if err.number<>70 and err.number<>58 then
					echo "newfolder:<br />"&err.description&"<br />"
					errlog "文件夹："&t0&"<br>函数：newfolder<br>详情："&err.description,1
				end if
				err.clear
			end if
		next
	end sub
	
	public sub editfolder(byval t0,byval t1)
		err.clear
		on error resume next
		if fso.folderexists(server.mappath(t0)) then
			fso.movefolder server.mappath(t0),server.mappath(t1)
		end if
		if err then
			errlog "文件夹："&t0&"<br>函数：editfolder<br>详情："&err.description,1
			err.clear
		end if
	end sub
	
	public sub delfolder(byval t0)
		err.clear
		on error resume next
		dim f
		set f=fso.getfolder(server.mappath(t0))
		if not isnull(t0) then f.delete true
		if err then
			if err.number<>424 then
				errlog "文件名："&t0&"<br>函数：delfolder<br>详情："&err.description,1
			end if
			err.clear
		end if
		set f=nothing
	end sub
	
	public function loadfile(byval t0)
		if len(t0)=0 then loadfile="&#25991;&#20214;&#36335;&#24452;&#19981;&#33021;&#20026;&#31354;":exit function
		err.clear
		on error resume next
		dim t1
		with stm
			.type=2
			.mode=3 
			.charset="utf-8"
			.open
			.loadfromfile server.mappath(t0)
			t1=.readtext
			.close
		end with
		if err then
			errlog "文件名："&t0&"<br>函数：loadfile<br>详情："&err.description,1
			loadfile=t0&"<br />"&err.description&"<br />":err.clear
		else
			if len(t1)=0 then t1=t0&":<br />&#25991;&#20214;&#22823;&#23567;&#20026;&#48;"
			loadfile=t1
		end if
	end function
	
	public function newavatar(t0,t1,t2)
		newfolder t0
		err.clear
		on error resume next
		with stm
			.type=1
			.open
			.write t2
			.savetofile server.mappath(t0&t1),2
			.close
		end with
		if err then
			errlog "文件名："&t0&t1&"<br>函数：newavatar<br>详情："&err.description,1
			err.clear
		end if
	end function
	
	public sub newfile(byval t0,byval t1,byval t2,byval t3)
		if t3="" then t3="utf-8"
		newfolder t0
		err.clear
		on error resume next
		with stm
			.type=2
			.mode=3
			.charset=t3
			.open
			.writetext t2
			.savetofile server.mappath(t0&t1),2
			.close
		end with
		if err then
			errlog "文件名："&t0&t1&"<br>函数：newfile<br>详情："&err.description,1
			err.clear
		end if
	end sub
	
	public sub editfile(byval t0,byval t1)
		err.clear
		on error resume next
		if fso.fileexists(server.mappath(t0)) then
			fso.movefile server.mappath(t0),server.mappath(t1)
		end if
		if err then
			errlog "文件名："&t0&"<br>函数：editfile<br>详情："&err.description,1
			err.clear
		end if
	end sub
	
	public sub delfile(byval t0)
		err.clear
		on error resume next
		if fso.fileexists(server.mappath(t0)) then fso.deletefile server.mappath(t0)
		if err then
			errlog "文件名："&t0&"<br>函数：delfile<br>详情："&err.description,1
			err.clear
		end if
	end sub
	
	public function get_content_split(byval t0,byval t1)
		if instr(t0,"_sdcms_content_page_")<=0 then
			get_content_split=get_sitelink(t0)
			exit function
		end if
		dim t3:t3=split(t0,"_sdcms_content_page_")
		html_page_total=ubound(t3)+1
		page=getint(fget("page",0),1)
		if page>ubound(t3)+1 then page=ubound(t3)+1
		get_content_split=get_sitelink(t3(page-1))
		getcontentpage ubound(t3)+1,t1
	end function
	
	public sub getcontentpage(byval t0,byval t1)
		dim totalnum:totalnum=t0
		if totalnum=1 then get_content_page="":exit sub
		if page>totalnum then page=totalnum
		get_content_page=""
		dim ibegin,iend,icur,i
		icur=page
		ibegin=icur
		iend=icur
		if icur>totalnum then icur=totalnum
		if iend>totalnum then iend=totalnum
		i=6
		do while true 
			if ibegin>1 then 
				ibegin=ibegin-1
				i=i-1  
			end if 
			if i>1 and iend<totalnum then
				iend=iend+1
				i=i-1
			end if 
			if (ibegin<=1 and iend>=totalnum) or i<=1 then exit do     
		loop
		
		if ibegin<>1 then
			get_content_page=get_content_page&"<li><a href="""&content_pageurl(1,t1)&""">1..</a></li>"	
		end if
		if icur<>1 then get_content_page=get_content_page&"<li><a href="""&content_pageurl(icur-1,t1)&""">上一页</a></li>"
		
		for i=ibegin to iend
			if i=icur then
				get_content_page=get_content_page&"<li class=""active""><a href="""&content_pageurl(i,t1)&""">"&i&"</a></li>"
			else
				get_content_page=get_content_page&"<li><a href="""&content_pageurl(i,t1)&""">"&i&"</a></li>"
			end if 
		next 
		if icur<>totalnum then get_content_page=get_content_page&"<li><a href="""&content_pageurl(icur+1,t1)&""">下一页</a></li>"
		if iend<>totalnum then get_content_page=get_content_page&"<li><a href="""&content_pageurl(totalnum,t1)&""">.."&totalnum&"</a></li>"
	
		get_content_page=get_content_page&"<li><a>"&page&"/"&totalnum&"</a></li>"
	end sub
	
	public function content_pageurl(byval t0,byval t1)
		if webmode>1 then
			content_pageurl=replace(t1,"[page]",t0)
			if t0="1" then
				if instr(content_pageurl,"/index")>0 then
					dim t3,t4
					t3=split(content_pageurl,"/")
					t4=t3(ubound(t3))
					content_pageurl=replace(content_pageurl,t4,"")
				else
					content_pageurl=replace(content_pageurl,"_1.html",".html")
				end if
			end if
		else
			content_pageurl=t1&"&page="&t0
		end if
	end function
	
	public function stringtobytes(byval t0)
		with stm
			.type=2
			.charset="utf-8"
			.open
			.writetext t0
			.position=0
			.type=1
			.read 3
			stringtobytes=.read(-1)
			.close
		end with
	end function
	
	public function bytestostring(byval t0)
		with stm
			.type=1
			.open
			.write t0
			.position=0
			.type=2
			.charset="utf-8"
			bytestostring=.readtext(-1)
			.close
		end with
	end function
	
	public function base64encode(byval t0)
		dim t1,t2
		set t1=server.createobject("msxml2.domdocument")
		set t2=t1.createelement("b64")
		t2.datatype="bin.base64"
		if vartype(t0)=(vbbyte or vbarray) then
			t2.nodetypedvalue=t0
		else
			t2.nodetypedvalue=stringtobytes(t0)
		end if
		base64encode=t2.text
		set t2=nothing
		set t1=nothing
	end function
	
	public function base64decode(byval t0)
		dim t1,t2
		set t1=server.createobject("msxml2.domdocument")
		set t2=t1.createelement("b64")
		t2.datatype="bin.base64"
		t2.text=t0
		base64decode=bytestostring(t2.nodetypedvalue)
		set t2=nothing
		set t1=nothing
	end function
	
	public function base64_jpg(byval t0)
		dim tmpdoc,nodeb64
		set tmpdoc=server.createobject("msxml2.domdocument")
		set nodeb64=tmpdoc.createelement("b64")
			nodeb64.datatype="bin.base64"
			nodeb64.text=t0
			base64_jpg=nodeb64.nodetypedvalue
		set nodeb64=nothing
		set tmpdoc=nothing
	end function
	
	public sub errlog(byval t0,byval t1)
		if t0="" then exit sub
		t0=t0&"<br>网址："&getthisurl&"<br>IP："&getip&""
		db.insert "sd_errlog",array(array("content",t0,0,1),array("isread",0,0,0),array("createdate",sqltime,0,0))
		if t1=1 then echo "发生系统错误，系统已记录。"
	end sub
	
	public function sendmail(byval t0,byval t1,byval t2)
		sendmail=false
		if t0="" then exit function
		err.clear
		on error resume next
		select case getsys("mailtype")
			case "":exit function
			case "jmail"
				dim jmail
				set jmail=server.createobject("jmail.message")
				jmail.charset="utf-8"
				jmail.contenttype="text/html"
				jmail.addrecipient t0
				jmail.subject=t1
				jmail.body=t2
				jmail.from=getsys("mailuser")
				jmail.mailserverusername=getsys("mailuser")
				jmail.mailserverpassword=getsys("mailpass")
				jmail.send getsys("mailsmtp")
				set jmail=nothing
				if err then
					errlog "组件：jmail，函数：sendmail<br>详情："&err.description,0
					err.clear
					exit function
				else
					sendmail=true
				end if
			case "cdosys"
				dim objmail,objconfig
				set objmail=server.createobject("cdo.message") 
				set objconfig=server.createobject("cdo.configuration") 
				objconfig.fields("http://schemas.microsoft.com/cdo/configuration/smtpserverport")=25 
				objconfig.fields("http://schemas.microsoft.com/cdo/configuration/sendusing")=2 
				objconfig.fields("http://schemas.microsoft.com/cdo/configuration/smtpserver")=getsys("mailsmtp")
				objconfig.fields("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate")=1 
				objconfig.fields("http://schemas.microsoft.com/cdo/configuration/sendusername")=getsys("mailuser")
				objconfig.fields("http://schemas.microsoft.com/cdo/configuration/sendpassword")=getsys("mailpass")
				objconfig.fields("http://schemas.microsoft.com/cdo/configuration/languagecode")="0x0804" 
				objconfig.fields.update() 
				set objmail.configuration=objconfig
				objmail.subject=t1
				objmail.from=getsys("mailuser")
				objmail.to=t0
				objmail.htmlbody=t2
				objmail.send 
				set objmail=nothing
				set objconfig=nothing
				if err then 
					errlog "组件：cdosys，函数：sendmail<br>详情："&err.description,0
					err.clear
					exit function
				else
					sendmail=true
				end if
		end select
	end function
	
	public function get_tags_arr(byval t0)
		if strlen(t0)=0 then
			get_tags_arr=array()
			exit function
		end if
		get_tags_arr=split(t0,",")
	end function
	
	public function get_cityname(byval t0)
		dim t1:t1=getip
		if t1="unknow" or t1="127.0.0.1" or t1="" then
			get_cityname=t0
			exit function
		end if
		if sdcms.loadcookie("get_cityname_"&t1)<>"" then
			get_cityname=left(enhtml(sdcms.loadcookie("get_cityname_"&t1)),15)
		else
			dim t3
			t3=look_ip(t1)
			get_cityname=t3
			sdcms.setcookie "get_cityname_"&t1,t3
		end if
	end function
	
	public function look_ip(byval ip)
		dim wry,iptype,qqwryversion,ipcounter
		set wry=new tqqwry
			iptype=wry.qqwry(ip)
			look_ip=wry.country
		set wry=nothing
	end function
	
	public function get_sitelink(byval t0)
		dim t1:t1=sitelinkcache
		if not isarray(t1) then
			get_sitelink=t0
			exit function
		end if
		dim i,url,t2
		for i=0 to ubound(t1,2)
			if t1(5,i)=1 then 
				url="<a href="""&t1(2,i)&""" title="""&t1(1,i)&""" target=""_blank"" class=""sitelink"">"&t1(0,i)&"</a>" 
			else 
				url="<a href="""&t1(2,i)&""" title="""&t1(1,i)&""" class=""sitelink"">"&t1(0,i)&"</a>"
			end if
			if t1(4,i)=0 then
				t2=-1
			else
				t2=t1(4,i)
			end if
			t0=sitelink_replace(t0,t1(0,i),url,t2)
		next
		get_sitelink=t0
	end function
	
	public function sitelink_replace(byval t0,byval t1,byval t2,byval t3)
		dim t4:t4=t0
		reg.pattern="(\<a[^<>]+\>.+?\<\/a\>)|(\<img[^<>]+\>)"
		set matches=reg.execute(t4)
		dim i:i=0
		dim myarray()
		if matches.count>0 then
			for each match in matches
				redim preserve myarray(i)
				myarray(i)=mid(match.value,1,len(match.value))
				t4=replace(t4,match.value,"\u005b"&i&"\u005d",1,t3)
				i=i+1
			next
		end if
		if i=0 Then
			t0=replace(t0,t1,t2,1,t3)
			sitelink_replace=t0
			exit function
		end if
		t4=replace(t4,t1,t2,1,t3)
		for i=0 to ubound(myarray)
			t4=replace(t4,"\u005b"&i&"\u005d",myarray(i),1,t3)
		next
		sitelink_replace=t4
	end function
	
	public function is_current(byval t0,byval t1,byval t2)
		if instr(","&t0&",",","&t1&",")>0 then
			is_current=t2
		end if
	end function
	
	public sub deal_content_url(byval t0,byval t1)
		dim t2:t2=getclassdb(t1)		
		dim t3:t3=t2(25)
		dim t4:t4=""
		select case t3
			case "id"
				t4=t0
			case "dateid"
				t4=getdate(now(),"",1)&t0
		end select
		db.dbupdate "sd_content","id="&t0&"",array(array("url",t4,0,1))
	end sub

	public function getcateinfo(byval t0)
		dim t1:t1=getclassdb(t0)
		dim t2,t3,t4,t5,t6
		if not isarray(t1) then
			getcateinfo=""
		else
			t2=t1(2)
			t3=t1(9)
			t4=t1(10)
			t5=t1(1)
			getcateinfo="<a href="""&get_cateurl(t0,t2,t4,t3)&""" title="""&t5&""">"&t5&"</a>"
		end if
	end function
	
	public function getcatename(byval t0)
		 dim t1
		if checkcache("cate_name_"&t0,0) then
			t1=loadcache("cate_name_"&t0,0)
		else
			t1=getcatename_arr(t0)
			setcache "cate_name_"&t0,t1,0
		end if
		getcatename=t1
	end function
	
	public function getcatename_arr(byval t0)
		dim t1:t1=getclassdb(t0)
		if not isarray(t1) then
			getcatename_arr=""
		else
			getcatename_arr=t1(1)
		end if
	end function
	
	public function getcateurl(byval t0)
		dim t1
		if checkcache("cate_url_"&t0,0) then
			t1=loadcache("cate_url_"&t0,0)
		else
			t1=getcateurl_arr(t0)
			setcache "cate_url_"&t0,t1,0
		end if
		getcateurl=t1
	end function
	
	public function getcateurl_arr(byval t0)
		dim arr:arr=getclassdb(t0)
		dim t2,t3,t4,t5,t6
		if not isarray(arr) then
			getcateurl_arr=""
		else
			t2=arr(2)
			t3=arr(9)
			t4=arr(10)
			t5=arr(1)
			getcateurl_arr=get_cateurl(t0,t2,t4,t3)
		end if
	end function
	
	public function get_cateurl(byval t0,byval t1,byval t2,byval t3)
		if t2=-2 then
			t3=replace(t3,"{webroot}",webroot)
			get_cateurl=t3
		else
			select case webmode
				case "1"
					get_cateurl=webroot&"list.asp?classid="&t0
				case "2"
					get_cateurl=webroot&""&t1&"/"
				case else
					get_cateurl=webroot&htmldir&t1&"/"
			end select
		end if
	end function
	
	public function get_topid(byval t0)
		if strlen(t0)<=0 then
			get_topid=0:exit function
		end if
		dim arr:arr=split(t0,",")
		dim num:num=ubound(arr)
		get_topid=arr(num)
	end function
	
	public function get_fid(byval t0)
		if t0=0 then
			get_fid=0:exit function
		end if
		dim d:d=getclassdb(t0)
		if not isarray(d) then
			get_fid=0:exit function
		else
			if d(3)=0 then
				get_fid=t0
			else
				get_fid=d(3)
			end if
		end if
	end function
	
	public function geturl(byval t0,byval t1,byval t2,byval t3)
		if t2=1 then
			geturl=t3
		else
			dim t4:t4=""
			if webmode>1 then
				t4=getcateurl(t1)
			end if
			geturl=get_contenturl(t0,t3,t4,0)
		end if
	end function
	
	public function getcontenturl(byval t0)
		dim data
		data=db.dbload(1,"id,isurl,url,catedir","sd_content left join sd_category on sd_content.classid=sd_category.cateid","islock=1 and id="&t0&"","")
		if ubound(data)<0 then
			getcontenturl=""
		else
			getcontenturl=get_contenturl(data(0,0),data(2,0),data(3,0),data(1,0))
		end if
	end function
	
	public function get_contenturl(byval t0,byval t1,byval t2,byval t3)
		if t3=1 then
			get_contenturl=t1
		else
			select case webmode
				case "1"
					get_contenturl=webroot&"show.asp?id="&t0
				case "2"
					get_contenturl=t2&t1&".html"
				case else
					get_contenturl=t2&t1&".html"
			end select
		end if
	end function
	
	public function getpostion(byval t0,byval t1)
		getpostion=""
		dim arr:arr=split(t0,",")
		dim i
		for i=ubound(arr) to 0 step -1
			getpostion=getpostion&t1&getcateinfo(arr(i))
		next
	end function
	
	public sub userlogin_auto(byval t0) 
	end sub
	
	public sub userreg_auto(byval t0) 
	end sub
	
	public sub giftpoint(byval t0,byval t1)
		dim t2:t2=clng(getsys("str_gift"))
		if t2<=0 then exit sub
		dim point:point=db.dbloadone("point","sd_user","id="&t0&"")
		dim t3:t3=t1*t2+point
		db.dbupdate "sd_user","id="&t0&"",array(array("point",t3,10,0))
		createuserpoint array(array("point",t1*t2,0,0),array("userid",t0,0,0),array("type",1,0,0),array("content","消费："&t1&"元，获得："&t1*t2&"积分</a>",0,1),array("createdate",sqltime,0,0))
	end sub
	
	public function is_login()
		is_login=false
		dim t0
		t0=loadsession("userinfo")
		if strlen(t0)=0 then exit function
		t0=eval(t0)
		if not isarray(t0) then exit function
		if ubound(t0)=-1 then exit function
		if db.dbcount("sd_user","id="&t0(0)&"")<=0 then
			setsession "userinfo","":exit function
		end if
		if t0(5)<>1 then exit function
		is_login=true
	end function
	
	public function user_publish_num()
		user_publish_num=9999
		if is_vip then
			exit function
		end if
		dim userdata,gid
		userdata=userinfo
		gid=userdata(4)
		if strlen(gid)=0 then
			user_publish_num=0
			exit function
		end if
		dim gdata:gdata=db.dbload(1,"allowpost,allowpostnum","sd_user_group","id="&gid&"","")
		if ubound(gdata)<0 then
			user_publish_num=0
			exit function
		else
			if gdata(0,0)=0 then
				user_publish_num=-1
				exit function
			else
				if gdata(1,0)=0 then
					exit function
				else
					user_publish_num=gdata(1,0)
				end if
			end if
		end if
		dim hnum:hnum=db.dbcount("sd_content","userid="&userdata(0)&" and createdate>="&iif(datatype,"date()","getdate()")&"")
		user_publish_num=user_publish_num-hnum
	end function
	
	public function user_publish_upload()
		user_publish_upload=true
		if is_vip then
			exit function
		end if
		dim userdata,gid
		userdata=userinfo
		gid=userdata(4)
		if strlen(gid)=0 then
			user_publish_upload=false
			exit function
		end if
		dim gdata:gdata=db.dbload(1,"allowattachment","sd_user_group","id="&gid&"","")
		if ubound(gdata)<0 then
			user_publish_upload=false
			exit function
		else
			if gdata(0,0)=0 then
				user_publish_upload=false
				exit function
			end if
		end if
	end function
	
	public function is_buy(byval t0)
		dim userdata:userdata=userinfo
		dim userid:userid=userdata(0)
		is_buy=db.dbcount("sd_user_buy","contentid="&t0&" and userid="&userid&"")
	end function
	
	public function is_vip()
		if not(is_login) then
			is_vip=false
			exit function
		end if
		dim userdata:userdata=userinfo
		if userdata(8)=1 then
			if userdata(9)=0 then
				is_vip=false
			else
				is_vip=true
			end if
		else
			is_vip=false
		end if
	end function
	
	public function checkuserlogin()
		if not(is_login) then
			go webroot&"user/login.asp?msg="&server.urlencode("请先登录或注册")&"&url="&thisurl
			die
		end if
	end function
	
	public sub userupgrade(byval t0,byval t1,byval t2)
		if t1=0 then exit sub
		dim data:data=db.dbload(1,"point,allowupgrade","sd_user_group","id="&t1&"","")
		if ubound(data)<0 then exit sub
		if data(1,0)=0 then exit sub
		dim tpoint:tpoint=data(0,0)
		data=db.dbload(1,"id,groupname,point","sd_user_group","point>"&tpoint&" and point<="&t0&"","point")
		if ubound(data)<0 then
			exit sub
		else
			if cdbl(t0)<cdbl(data(2,0)) then
				exit sub
			else
				db.dbupdate "sd_user","id="&t2&"",array(array("groupid",data(0,0),0,0))
				createusermessage array(array("title","您已升级到"&data(1,0)&"",255,1),array("fromid",-3,0,0),array("userid",t2,0,0),array("content","恭喜，您已升级到"&data(1,0)&"",0,1),array("createdate",sqltime,0,0),array("isread",0,0,0))
			end if
		end if
	end sub
	
	public sub deal_user_attachment(byval t0,byval t1)
		db.dbupdate "sd_attachment","userid="&t0&" and cid=0 and classid=1",array(array("cid",t1,0,0))
	end sub
	
	public sub deal_user_publish_point(byval t0,byval t1)
		dim str_publish:str_publish=getsys("str_publish")
		if str_publish<=0 then
			exit sub
		end if
		if t1="" then
			dim userid:userid=db.dbloadone("userid","sd_content","id="&t0&"")
			if userid=0 then
				exit sub
			end if
		else
			userid=t1
		end if
		dim userdata
		userdata=sdcms.db.dbload(1,"point,groupid,(select allowupgrade from sd_user_group where id=sd_user.groupid)","sd_user","id="&userid&"","")
		if ubound(userdata)<0 then
			exit sub
		end if
		dim point,groupid,allowupgrade,npoint
		point=userdata(0,0)
		groupid=userdata(1,0)
		allowupgrade=userdata(2,0)
		npoint=point+str_publish
		sdcms.db.dbupdate "sd_user","id="&userid&"",array(array("point",npoint,10,0))
		sdcms.db.insert "sd_user_point",array(array("point",str_publish,0,0),array("userid",userid,0,0),array("type",1,0,0),array("content","投稿通过审核，获得积分："&str_publish&"",0,1),array("createdate",sqltime,0,0))
		if allowupgrade=1 then sdcms.userupgrade npoint,groupid,userid
	end sub
	
	public function resetuserinfo(byval t0)
		resetuserinfo=false
		if strlen(t0)<=0 then
			exit function
		end if
		dim t1
		t1=db.dbload(1,"u.id,u.username,u.password,u.email,u.groupid,u.islock,u.logintimes,u.[percent],u.isvip,u.overdate,g.groupname,g.rate,u.avatar,nickname","sd_user u left join sd_user_group g on u.groupid=g.id",t0,"")
		if ubound(t1)<0 then
			exit function
		end if
		dim u0,u1,u2,u3,u4,u5,u6,u7,u8,u9,u10,u11,u12,u13
		u0=t1(0,0)
		u1=t1(1,0)
		u2=t1(2,0)
		u3=t1(3,0)
		u4=t1(4,0)
		u5=t1(5,0)
		u6=t1(6,0)
		u7=t1(7,0)
		u8=t1(8,0)
		u9=t1(9,0)
		u10=t1(10,0)
		u11=t1(11,0)
		u12=t1(12,0)
		u13=t1(13,0)
		dim arr,thisdate,isover
		thisdate=year(now())&right("0"&month(now()),2)&right("0"&day(now()),2)
		isover=0
		if u8=1 then
			if clng(u9)>=clng(thisdate) then
				isover=1
			end if
		end if
		if strlen(u11)=0 then u11=100
		arr="array("&u0&","""&u1&""","""&u2&""","""&u3&""","&u4&","&u5&","&u6&","&u7&","&u8&","&isover&","""&u10&""","&u11/100&","&u12&","""&u13&""")"
		setsession "userinfo",arr
		resetuserinfo=true
	end function
	
	public function userinfo()
		userinfo=array()
		dim t0
		t0=loadsession("userinfo")
		t0=eval(t0)
		if not isarray(t0) then exit function
		if ubound(t0)=-1 then exit function
		userinfo=t0
	end function
	
	public sub createusermoney(byval t0)
		db.insert "sd_user_money",t0
	end sub
	
	public sub createuserpoint(byval t0)
		db.insert "sd_user_point",t0
	end sub
	
	public sub createusermessage(byval t0)
		db.insert "sd_user_message",t0
	end sub
	
	public sub stra_point(byval t0,byval t1,byval t2,byval t3)
		dim t4,t5
		select case t2
			case "1":t4=getsys("str_reg"):t5="新用户注册成功"
			case "2":t4=getsys("str_login"):t5="每日登录"
			case "3":t4=getsys("str_publish"):t5="投稿成功，标题："&t3&""
			case "4":t4=getsys("str_active"):t5="账户通过邮箱激活"
			case "5":t4=getsys("str_invite"):t5="邀请用户成功，用户名："&t3&""
			case else:exit sub
		end select
		if t4>0 then
			db.dbupdate "sd_user","id="&t0&"",array(array("point",t1+t4,0,0))
			createuserpoint array(array("content",t5,255,1),array("userid",t0,0,0),array("point",t4,0,0),array("type",1,0,0),array("createdate",sqltime,0,0))
		end if
	end sub
	
	public function get_sonid(byval t0)
		dim arr:arr=split(t0,",")
		dim i,str
		for i=0 to ubound(arr)
			if isnumeric(arr(i)) then
				if i>0 then str=str&","
				str=str&get_sonid_one(arr(i))
			end if
		next
		get_sonid=str
	end function
	
	public function get_sonid_one(byval t0)
		dim t1:t1=getclassdb(t0)
		if not isarray(t1) then
			get_sonid_one=0
		else
			get_sonid_one=t1(5)
		end if
	end function
	
	public function get_parentid(byval t0)
		dim t1:t1=getclassdb(t0)
		if not isarray(t1) then
			get_parentid=0
		else
			get_parentid=t1(6)
		end if
	end function
	
	public function is_channel_url(byval t0)
		is_channel_url=false
		dim t1:t1=getclassdb(t0)
		if not isarray(t1) then
			is_channel_url=true
			exit function
		else
			if t1(10)=-2 then
				is_channel_url=true
			end if
			if strlen(t1(2))=0 then
				is_channel_url=true
			end if
		end if
	end function
	
	public function get_cateoption(byval t0,byval t1)
		dim data:data=categorydata
		getcateoption 0,t0,data,t1
		get_cateoption=get_cate_option
	end function
	
	public sub getcateoption(byval t0,byval t1,byval t2,byval t3)
		dim data:data=t2
		dim i
		if not(isarray(data)) then
			exit sub
		end if
		for i=0 to ubound(data,2)
			if t0=data(3,i) then
				get_cate_option=get_cate_option&"<option value="""&data(0,i)&""" "&iif(t1=data(0,i),"selected","")&""
				if t3=2 then
					if data(10,i)="-2" or data(10,i)="-1" then
						get_cate_option=get_cate_option&" disabled=""disabled"""
					end if
				elseif t3=1 then
					if data(10,i)="-2" then
						get_cate_option=get_cate_option&" disabled=""disabled"""
					end if
				end if
				get_cate_option=get_cate_option&">"&string(data(4,i)-1,"　")&iif(data(3,i)>0,"├ ","")&""&data(1,i)&"</option>"
				getcateoption data(0,i),t1,data,t3
			end if
		next
	end sub
	
	public function sdcmsdata()
		db.dbopen
		if checkcache("sdcmsdata",1) then
			sdcmsdata=loadcache("sdcmsdata",1)
		else
			dim data
			data=db.dbload("","setkey,setvalue","sd_config","","setname")
			setcache "sdcmsdata",data,1
			sdcmsdata=data
		end if
	end function
	
	public function sitelinkcache()
		if checkcache("sitelink",1) then
			sitelinkcache=loadcache("sitelink",1)
		else
			dim data
			data=db.dbload("","title,intro,siteurl,ordnum,replacenum,linktype","sd_expand_sitelink","islock=1","ordnum desc,id desc")
			if ubound(data)<0 then
				setcache "sitelink","",1
				sitelinkcache=""
			else
				setcache "sitelink",data,1
				sitelinkcache=data
			end if
		end if
	end function
	
	public function i_self_field(byval t0,byval t1)
		dim arr:arr=split(t1,vbcrlf)
		dim i,m
		for i=0 to ubound(arr)
			if instr(arr(i),"|")>0 then
				m=split(arr(i),"|")
				if m(1)=t0 then
					i_self_field=m(0)
					exit function
				end if
			end if
		next
	end function
	
	public function get_model_field(byval t0)
		if checkcache("model_field"&t0,1) then
			get_model_field=loadcache("model_field"&t0,1)
		else
			dim data
			data=db.dbload("","fname,falias,fclass,fmode,fdatatype,flength,fdefault,foptions,fismust,frules,fistrim,fupload","sd_model_field","islock=1 and modelid="&t0&"","ordnum,id")
			if ubound(data)<0 then
				setcache "model_field"&t0,"",1
				get_model_field=""
			else
				setcache "model_field"&t0,data,1
				get_model_field=data
			end if
		end if
	end function
	
	public function get_form_field(byval t0)
		if checkcache("form_field"&t0,1) then
			get_form_field=loadcache("form_field"&t0,1)
		else
			dim data
			data=db.dbload("","fname,falias,fclass,fmode,fdatatype,flength,fdefault,foptions,fismust,frules,fistrim","sd_form_field","islock=1 and formid="&t0&"","ordnum,id")
			if ubound(data)<0 then
				setcache "form_field"&t0,"",1
				get_form_field=""
			else
				setcache "form_field"&t0,data,1
				get_form_field=data
			end if
		end if
	end function
	
	function deal_model_field(byval t0)
		dim a:a=sdcms.get_model_field(t0)
		if not isarray(a) then
			deal_model_field="":exit function
		end if
		dim fi,fstr,istrim,length,fname,fmode,iscn,formstr,rules
		for fi=0 to ubound(a,2)
			fstr=fstr&","
			fname=a(0,fi)
			istrim=a(10,fi)
			length=a(5,fi)
			fmode=a(3,fi)
			iscn=1
			rules=""
			select case a(2,fi)
				case "1"
					select case fmode
						case "2","5":length=10:iscn=0
						case "3":length=50
					end select
					formstr="sdcms.enhtml(sdcms.fpost("""&fname&""","&istrim&"))"
				case "2":length=0
					formstr="sdcms.enhtml(sdcms.fpost("""&fname&""","&istrim&"))"
				case "3","4","5":length=255
					formstr="sdcms.enhtml(sdcms.fpost("""&fname&""","&istrim&"))"
				case "6":length=0
					formstr="sdcms.fpost("""&fname&""","&istrim&")"
			end select
			fstr=fstr&"array("""&fname&""","&formstr&","&length&","&iscn&")"
			formstr=eval(formstr)
			if a(8,fi)=1 then
				if sdcms.strlen(formstr)=0 then sdcms.ajaxjson a(1,fi)&"不能为空",0:sdcms.die
				select case a(9,fi)
					case "2":rules="int"
					case "3":rules="price"
					case "4":rules="tel"
					case "5":rules="mobile"
					case "6":rules="email"
					case "7":rules="date"
					case "8":rules="zipcode"
					case "9":rules="qq"
					case "10":rules="url"
				end select
				if rules<>"" then
					if not(sdcms.checkstr(formstr,rules)) then
						sdcms.ajaxjson a(1,fi)&"格式错误",0:sdcms.die
					end if
				end if
			end if
		next
		deal_model_field=fstr
	end function
	
	function get_self_field(byval t0,byval t1,byval t2,byval t3,byval t4,byval t5,byval t6,byval t7,byval t8,byval t9,byval t10,byval t11,byval t12,byval t13,byval t14)
		dim str:str=""
		t8=sdcms.iif(isnull(t8),"",t8)
		if t12=0 then t8=sdcms.iif(t8="",t11,t8)
		if t6=1 then
			dim rule
			rule="data-rule="""&t1&":required;"
			select case t7
				case "2":rule=rule&"digits;"
				case "3":rule=rule&"dot;"
				case "4":rule=rule&"tel;"
				case "5":rule=rule&"mobile;"
				case "6":rule=rule&"email;"
				case "7":rule=rule&"date;"
				case "8":rule=rule&"postcode;"
				case "9":rule=rule&"qq;"
				case "10":rule=rule&"url;"
			end select
			rule=rule&""""
		end if
		dim i,arr,m
		arr=split(t5,vbcrlf)
		select case t2
		case "1"
			select case t3
				case "2":t4=10
				case "3":t4=50:t8=replace(t8,"/","-")
				case "4":t4=255
				case "5":t4=10
				if t8<>"" then t8=formatnumber(t8,-1,-1)
			end select
			str=str&"<input type=""text"" name="""&t0&""" id="""&t0&""" size=""50"" value="""&t8&""" maxlength="""&t4&""" class="""&t13&""" "&rule&" />"
			if t3=4 then
				str=str&"<input type=""button"" value=""上传"" config="""&t0&":"&t9&":"&t10&":1"" class=""bnt bnt_save"" />"
			end if
		case "3"
			str=str&"<select name="""&t0&""" id="""&t0&""" class="""&t13&""" "&rule&">"&vbcrlf
			str=str&"<option value="""">请选择"&t1&"</option>"&vbcrlf
			for i=0 to ubound(arr)
				if len(arr(i))>0 then
					if instr(arr(i),"|")>0 then
						m=split(arr(i),"|")
						str=str&"<option value="""&m(1)&""" "
						if m(1)=t8 then
							str=str&" selected"
						end if
						str=str&">"&m(0)&"</option>"&vbcrlf
					end if
				end if
			next
			str=str&"</select>"
		case "4","5"
			dim types:types=sdcms.iif(t2=4,"radio","checkbox")
			rule=replace(rule,"required;","checked")
			dim j:j=0
			for i=0 to ubound(arr)
				if len(arr(i))>0 then
					if instr(arr(i),"|")>0 then
						m=split(arr(i),"|")
						str=str&"<input type="""&types&""" name="""&t0&""" id="""&t0&"_"&i&""" value="""&m(1)&""" "
						if j=0 then
							str=str&" "&rule&" "
						end if
						if t2=4 then
							if m(1)=t8 then
								str=str&" checked"
							end if
						else
							if instr(", "&t8&", ",", "&m(1)&", ")>0 then
								str=str&" checked"
							end if
						end if
						str=str&">"&m(0)&""&vbcrlf
						j=j+1
					end if
				end if
			next
		case "2","6"
			str=str&"<textarea name="""&t0&""" id="""&t0&""" "
			if t2=2 then
				str=str&" class="""&t14&""" cols=""51"" rows=""4"" "&rule&""
			else
				str=str&" style=""width:98%;"""
			end if
			str=str&">"&t8&"</textarea>"
		end select
		'str=str&"<span for="""&t0&""" class=""msg-box"">"
		get_self_field=str
	end function
	
	public function categorydata()
		if checkcache("category",1) then
			categorydata=loadcache("category",1)
		else
			dim data,sql
			sql="cateid,catename,catedir,followid,depth,sonid"
			sql=sql&",parentid,ordnum,ismenu,cateurl,modeid"
			sql=sql&",modelname,tablename,islock,adminurl"
			sql=sql&",catepic,seotitle,catekey,catedesc,pagenum"
			sql=sql&",cate_list,cate_show,default_temp,list_temp,show_temp,urlrule"
			sql=sql&",admin_add_temp,admin_edit_temp,admin_publish_temp,pre_publish_temp,pre_publish_url,allowpost,domain"
			data=db.dbload("",sql,"view_category","","ordnum,cateid")
			if ubound(data)<0 then
				setcache "category","",1
				categorydata=""
			else
				setcache "category",data,1
				categorydata=data
			end if
		end if
	end function
	
	public function getcateid(byval t0)
		dim data
		data=categorydata
		getcateid=-1
		if not(isarray(data)) then
			exit function
		end if
		dim i
		for i=0 to ubound(data,2)
			if lcase(t0)=lcase(data(2,i)) then
				getcateid=data(0,i)
				exit function
			end if
		next
	end function
	
end class
%>