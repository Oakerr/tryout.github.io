﻿<!--#include file="base.asp"-->
<%
''' SDCMS 设置
''' ==================================================================
''' 版权所有 http://www.sdcms.cn
''' ------------------------------------------------------------------
''' 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和使用；
''' 未经授权不允许对程序代码以任何形式任何目的的再发布。
''' ==================================================================
''' 编写: IT平民
''' 修改：IT平民 in 2014.07

	sub sitedb()
		dim t0,t1,t2,t3,t4,t5,t6,t7
		t0=sdcms.enhtml(sdcms.fpost("t0",0))
		t1=sdcms.enhtml(sdcms.fpost("t1",0))
		t2=sdcms.enhtml(sdcms.fpost("t2",0))
		t3=sdcms.enhtml(sdcms.fpost("t3",0))
		t4=sdcms.getint(sdcms.fpost("t4",0),60)
		t5=sdcms.enhtml(sdcms.fpost("t5",0))
		t6=sdcms.fpost("t6",0)
		t7=sdcms.enhtml(sdcms.fpost("t7",0))
		if sdcms.strlen(t0)=0 then sdcms.ajaxjson "&#32593;&#31449;&#21517;&#31216;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		if sdcms.strlen(t1)=0 then sdcms.ajaxjson "&#36816;&#34892;&#27169;&#24335;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		if sdcms.strlen(t2)=0 then sdcms.ajaxjson "&#39029;&#38754;&#21387;&#32553;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		if sdcms.strlen(t3)=0 then sdcms.ajaxjson "&#26159;&#21542;&#32531;&#23384;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		if sdcms.strlen(t4)=0 then sdcms.ajaxjson "&#32531;&#23384;&#26102;&#38388;&#19981;&#33021;&#20026;&#31354;",0:exit sub
	
		sdcms.db.dbupdate "sd_config","setname='sdcms.site' and setkey='webname'",array(array("setvalue",t0,50,1))
		sdcms.db.dbupdate "sd_config","setname='sdcms.site' and setkey='webmode'",array(array("setvalue",t1,50,1))
		sdcms.db.dbupdate "sd_config","setname='sdcms.site' and setkey='isgzip'",array(array("setvalue",t2,50,1))
		sdcms.db.dbupdate "sd_config","setname='sdcms.site' and setkey='iscache'",array(array("setvalue",t3,50,1))
		sdcms.db.dbupdate "sd_config","setname='sdcms.site' and setkey='cachedate'",array(array("setvalue",t4,9,1))
		sdcms.db.dbupdate "sd_config","setname='sdcms.site' and setkey='webicp'",array(array("setvalue",t5,20,1))
		sdcms.db.dbupdate "sd_config","setname='sdcms.site' and setkey='webcount'",array(array("setvalue",t6,0,1))
		sdcms.db.dbupdate "sd_config","setname='sdcms.site' and setkey='tempcache'",array(array("setvalue",t7,0,1))
		sdcms.clearcache
		if t1="2" then
			dim t8
			t8=sdcms.loadfile("../lib/urlrule/httpd.ini")
			t8=replace(t8,"{admin}",replace(get_adminfolder,"/",""))
			sdcms.newfile "../","httpd.ini",t8,"gb2312"
			t8=sdcms.loadfile("../lib/urlrule/.htaccess")
			t8=replace(t8,"{admin}",replace(get_adminfolder,"/",""))
			sdcms.newfile "../",".htaccess",t8,""
		else
			sdcms.delfile "../httpd.ini"
			sdcms.delfile "../httpd.parse.errors"
			sdcms.delfile "../.htaccess"
		end if
		sdcms.ajaxjson "保存成功",1
	end sub
	
	sub seodb()
		dim t0,t1,t2
		t0=sdcms.enhtml(sdcms.fpost("t0",0))
		t1=sdcms.enhtml(sdcms.fpost("t1",0))
		t2=sdcms.enhtml(sdcms.fpost("t2",0))
		sdcms.db.dbupdate "sd_config","setname='sdcms.seo' and setkey='seotitle'",array(array("setvalue",t0,255,1))
		sdcms.db.dbupdate "sd_config","setname='sdcms.seo' and setkey='seokey'",array(array("setvalue",t1,255,1))
		sdcms.db.dbupdate "sd_config","setname='sdcms.seo' and setkey='seodesc'",array(array("setvalue",t2,255,1))
		sdcms.delcache "sdcmsdata"
		sdcms.ajaxjson "保存成功",1
	end sub
	
	sub uploaddb()
		dim t0,t1,t2,t3,t4
		t0=sdcms.enhtml(sdcms.fpost("t0",0))
		t1=sdcms.getint(sdcms.fpost("t1",0),102400)
		t2=sdcms.enhtml(sdcms.fpost("t2",0))
		t3=sdcms.enhtml(sdcms.fpost("t3",0))
		t4=sdcms.enhtml(sdcms.fpost("t4",0))
		if sdcms.strlen(t0)=0 then sdcms.ajaxjson "&#19978;&#20256;&#30446;&#24405;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		if sdcms.strlen(t1)=0 then sdcms.ajaxjson "&#22823;&#23567;&#38480;&#21046;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		if sdcms.strlen(t2)=0 then sdcms.ajaxjson "&#25991;&#20214;&#31867;&#22411;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		sdcms.db.dbupdate "sd_config","setname='sdcms.upload' and setkey='upfile'",array(array("setvalue",t0,50,1))
		sdcms.db.dbupdate "sd_config","setname='sdcms.upload' and setkey='upmaxsize'",array(array("setvalue",t1,11,1))
		sdcms.db.dbupdate "sd_config","setname='sdcms.upload' and setkey='uptype_pic'",array(array("setvalue",t2,255,1))
		sdcms.db.dbupdate "sd_config","setname='sdcms.upload' and setkey='uptype_video'",array(array("setvalue",t3,255,1))
		sdcms.db.dbupdate "sd_config","setname='sdcms.upload' and setkey='uptype_file'",array(array("setvalue",t4,255,1))
		sdcms.delcache "sdcmsdata"
		sdcms.ajaxjson "保存成功",1
	end sub
	
	sub maildb()
		dim t0,t1,t2,t3,t4
		t0=sdcms.enhtml(sdcms.fpost("t0",0))
		t1=sdcms.enhtml(sdcms.fpost("t1",0))
		t2=sdcms.enhtml(sdcms.fpost("t2",0))
		t3=sdcms.enhtml(sdcms.fpost("t3",0))
		t4=sdcms.enhtml(sdcms.fpost("t4",0))
		if sdcms.strlen(t0)>0 then
			if sdcms.strlen(t1)=0 then sdcms.ajaxjson "&#83;&#109;&#116;&#112;&#26381;&#21153;&#22120;&#19981;&#33021;&#20026;&#31354;":exit sub
			if sdcms.strlen(t2)=0 then sdcms.ajaxjson "&#37038;&#31665;&#36134;&#25143;&#19981;&#33021;&#20026;&#31354;",0:exit sub
			if sdcms.strlen(t3)=0 then sdcms.ajaxjson "&#37038;&#31665;&#23494;&#30721;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		end if
		sdcms.db.dbupdate "sd_config","setname='sdcms.mail' and setkey='mailtype'",array(array("setvalue",t0,20,1))
		sdcms.db.dbupdate "sd_config","setname='sdcms.mail' and setkey='mailsmtp'",array(array("setvalue",t1,50,1))
		sdcms.db.dbupdate "sd_config","setname='sdcms.mail' and setkey='mailuser'",array(array("setvalue",t2,50,1))
		sdcms.db.dbupdate "sd_config","setname='sdcms.mail' and setkey='mailpass'",array(array("setvalue",t3,50,1))
		sdcms.db.dbupdate "sd_config","setname='sdcms.mail' and setkey='adminemail'",array(array("setvalue",t4,50,1))
		sdcms.delcache "sdcmsdata"
		sdcms.ajaxjson "保存成功",1
	end sub
	
	sub smsdb()
		dim t0,t1,t2,t3
		t0=sdcms.enhtml(sdcms.fpost("t0",0))
		t1=sdcms.enhtml(sdcms.fpost("t1",0))
		t2=sdcms.enhtml(sdcms.fpost("t2",0))
		t3=sdcms.enhtml(sdcms.fpost("t3",0))
		if t0="true" then
			if sdcms.strlen(t1)=0 then sdcms.ajaxjson "&#29992;&#25143;&#21517;&#19981;&#33021;&#20026;&#31354;",0:exit sub
			if sdcms.strlen(t2)=0 then sdcms.ajaxjson "&#36890;&#35759;&#23494;&#38053;&#19981;&#33021;&#20026;&#31354;",0:exit sub
			if sdcms.strlen(t3)=0 then sdcms.ajaxjson "&#25163;&#26426;&#21495;&#30721;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		end if
		sdcms.db.dbupdate "sd_config","setname='sdcms.sms' and setkey='smstype'",array(array("setvalue",t0,20,1))
		sdcms.db.dbupdate "sd_config","setname='sdcms.sms' and setkey='smsuser'",array(array("setvalue",t1,50,1))
		sdcms.db.dbupdate "sd_config","setname='sdcms.sms' and setkey='smskey'",array(array("setvalue",t2,50,1))
		sdcms.db.dbupdate "sd_config","setname='sdcms.sms' and setkey='mobile'",array(array("setvalue",t3,11,1))
		sdcms.delcache "sdcmsdata"
		sdcms.ajaxjson "保存成功",1
	end sub
	
	sub aspjpegdb()
		dim t0,t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13
		t0=sdcms.enhtml(sdcms.fpost("t0",0))
		t1=sdcms.enhtml(sdcms.fpost("t1",0))
		t2=sdcms.enhtml(sdcms.fpost("t2",0))
		t3=sdcms.enhtml(sdcms.fpost("t3",0))
		t4=sdcms.enhtml(sdcms.fpost("t4",0))
		t5=sdcms.enhtml(sdcms.fpost("t5",0))
		t6=sdcms.enhtml(sdcms.fpost("t6",0))
		t7=sdcms.enhtml(sdcms.fpost("t7",0))
		t8=sdcms.getint(sdcms.fpost("t8",0),200)
		t9=sdcms.getint(sdcms.fpost("t9",0),200)
		t10=sdcms.enhtml(sdcms.fpost("t10",0))
		t11=sdcms.getint(sdcms.fpost("t11",0),1)
		t12=sdcms.getint(sdcms.fpost("t12",0),0)
		t13=sdcms.getint(sdcms.fpost("t13",0),12)
		sdcms.db.dbupdate "sd_config","setname='sdcms.aspjpeg' and setkey='jpeg_name'",array(array("setvalue",t0,50,1))
		sdcms.db.dbupdate "sd_config","setname='sdcms.aspjpeg' and setkey='jpeg_type'",array(array("setvalue",t1,50,1))
		sdcms.db.dbupdate "sd_config","setname='sdcms.aspjpeg' and setkey='jpeg_text'",array(array("setvalue",t2,50,1))
		sdcms.db.dbupdate "sd_config","setname='sdcms.aspjpeg' and setkey='jpeg_textcolor'",array(array("setvalue",t3,50,1))
		sdcms.db.dbupdate "sd_config","setname='sdcms.aspjpeg' and setkey='jpeg_textfont'",array(array("setvalue",t4,50,1))
		sdcms.db.dbupdate "sd_config","setname='sdcms.aspjpeg' and setkey='jpeg_fontsize'",array(array("setvalue",t13,50,1))
		sdcms.db.dbupdate "sd_config","setname='sdcms.aspjpeg' and setkey='jpeg_bold'",array(array("setvalue",t5,50,1))
		sdcms.db.dbupdate "sd_config","setname='sdcms.aspjpeg' and setkey='jpeg_photo'",array(array("setvalue",t6,50,1))
		sdcms.db.dbupdate "sd_config","setname='sdcms.aspjpeg' and setkey='jpeg_bgcolor'",array(array("setvalue",t7,50,1))
		sdcms.db.dbupdate "sd_config","setname='sdcms.aspjpeg' and setkey='jpeg_minwidth'",array(array("setvalue",t8,50,1))
		sdcms.db.dbupdate "sd_config","setname='sdcms.aspjpeg' and setkey='jpeg_minheight'",array(array("setvalue",t9,50,1))
		sdcms.db.dbupdate "sd_config","setname='sdcms.aspjpeg' and setkey='jpeg_transparent'",array(array("setvalue",t10,50,1))
		sdcms.db.dbupdate "sd_config","setname='sdcms.aspjpeg' and setkey='jpeg_quality'",array(array("setvalue",t11,50,1))
		sdcms.db.dbupdate "sd_config","setname='sdcms.aspjpeg' and setkey='jpeg_position'",array(array("setvalue",t12,50,1))
		sdcms.delcache "sdcmsdata"
		sdcms.ajaxjson "保存成功",1
	end sub
	
	sub htmldb()
		dim t0,t1,t2,t3,t4,t5
		t0=sdcms.enhtml(sdcms.fpost("t0",0))
		t1=sdcms.getint(sdcms.fpost("t1",0),0)
		t2=sdcms.getint(sdcms.fpost("t2",0),0)
		t3=sdcms.getint(sdcms.fpost("t3",0),0)
		t4=sdcms.getint(sdcms.fpost("t4",0),0)
		if sdcms.strlen(t0)>0 then
			if instr(t0,"//")>0 or not(sdcms.checkstr(t0,"file")) or t0="/" or left(t0,1)="/" then
				sdcms.ajaxjson "&#29983;&#25104;&#30446;&#24405;&#35774;&#32622;&#38169;&#35823;",0:exit sub
			end if
			if right(t0,1)<>"/" then
				t0=t0&"/"
			end if
		end if
		t1=sdcms.iif(t1=0,false,true)
		t2=sdcms.iif(t2=0,false,true)
		t3=sdcms.iif(t3=0,false,true)
		
		sdcms.db.dbupdate "sd_config","setname='sdcms.html' and setkey='htmldir'",array(array("setvalue",t0,50,1))
		sdcms.db.dbupdate "sd_config","setname='sdcms.html' and setkey='htmlhome'",array(array("setvalue",t1,0,1))
		sdcms.db.dbupdate "sd_config","setname='sdcms.html' and setkey='htmlclass'",array(array("setvalue",t2,0,1))
		sdcms.db.dbupdate "sd_config","setname='sdcms.html' and setkey='htmlcontent'",array(array("setvalue",t3,0,1))
		sdcms.db.dbupdate "sd_config","setname='sdcms.html' and setkey='htmltotal'",array(array("setvalue",t4,10,1))
		sdcms.delcache "sdcmsdata"
		sdcms.ajaxjson "保存成功",1
	end sub
	
	sub sysdb()
		dim t0,t1,t2
		t0=sdcms.enhtml(sdcms.fpost("t0",0))
		t1=sdcms.enhtml(sdcms.fpost("t1",0))
		t2=sdcms.enhtml(sdcms.fpost("t2",0))
		sdcms.db.dbupdate "sd_config","setname='sdcms.sys' and setkey='sys_mobile'",array(array("setvalue",t0,50,1))
		sdcms.db.dbupdate "sd_config","setname='sdcms.sys' and setkey='sys_optional'",array(array("setvalue",t1,0,1))
		sdcms.db.dbupdate "sd_config","setname='sdcms.sys' and setkey='sys_murl'",array(array("setvalue",t2,50,1))
		sdcms.delcache "sdcmsdata"
		sdcms.ajaxjson "保存成功",1
	end sub
	
	islogin
	dim act:act=lcase(sdcms.fget("act",0))
	select case act
		case "rnd":sdcms.echo(sdcms.getrnd(12))
		case "sitedb":sitedb
		case "site"
			checkpagelever 9
			dim sitedata
			sitedata=sdcms.db.dbload("","setvalue","sd_config","setname='sdcms."&act&"'","")
			load eval("theme_set"&act)
		case "seo"
			checkpagelever 10
			sitedata=sdcms.db.dbload("","setvalue","sd_config","setname='sdcms."&act&"'","")
			load eval("theme_set"&act)
		case "upload"
			checkpagelever 11
			sitedata=sdcms.db.dbload("","setvalue","sd_config","setname='sdcms."&act&"'","")
			load eval("theme_set"&act)
		case "mail"
			checkpagelever 12
			sitedata=sdcms.db.dbload("","setvalue","sd_config","setname='sdcms."&act&"'","")
			load eval("theme_set"&act)
		case "sms"
			checkpagelever 13
			sitedata=sdcms.db.dbload("","setvalue","sd_config","setname='sdcms."&act&"'","")
			load eval("theme_set"&act)
		case "aspjpeg"
			checkpagelever 14
			sitedata=sdcms.db.dbload("","setvalue","sd_config","setname='sdcms."&act&"'","")
			load eval("theme_set"&act)
		case "html"
			checkpagelever 15
			sitedata=sdcms.db.dbload("","setvalue","sd_config","setname='sdcms."&act&"'","")
			load eval("theme_set"&act)
		case "sys"
			checkpagelever 50
			sitedata=sdcms.db.dbload("","setvalue","sd_config","setname='sdcms."&act&"'","")
			load eval("theme_set"&act)
		case "sitedb":checkpagelever 9:sitedb
		case "seodb":checkpagelever 10:seodb
		case "uploaddb":checkpagelever 11:uploaddb
		case "maildb":checkpagelever 12:maildb
		case "smsdb":checkpagelever 13:smsdb
		case "aspjpegdb":checkpagelever 14:aspjpegdb
		case "htmldb":checkpagelever 15:htmldb
		case "sysdb":checkpagelever 50:sysdb
	end select
	
	sdcms.db.dbclose
%>