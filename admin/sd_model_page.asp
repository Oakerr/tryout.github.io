﻿<!--#include file="base.asp"-->
<%
''' SDCMS 单页
''' ==================================================================
''' 版权所有 http://www.sdcms.cn
''' ------------------------------------------------------------------
''' 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和使用；
''' 未经授权不允许对程序代码以任何形式任何目的的再发布。
''' ==================================================================
''' 编写: IT平民
''' 修改：IT平民 in 2014.07

	sub savedb()
		dim t0,t1
		dim datanum
		t0=sdcms.fpost("t0",0)
		if sdcms.strlen(t0)=0 then sdcms.ajaxjson "&#20869;&#23481;&#19981;&#33021;&#20026;&#31354;",0:exit sub
		datanum=sdcms.db.dbcount("sd_model_page","classid="&classid&"")
		if datanum=0 then
			data=array(array("classid",classid,0,0),array("content",t0,0,1))
			sdcms.db.insert "sd_model_page",data
		else
			data=array(array("content",t0,0,1))
			sdcms.db.dbupdate "sd_model_page","classid="&classid&"",data
		end if
		sdcms.ajaxjson "保存成功",1
	end sub
	
	islogin
	dim act:act=lcase(sdcms.fget("act",0))
	dim classid:classid=sdcms.getint(sdcms.fget("classid",0),0)
	dim data
	select case act
		case "savedb":savedb
		case else
			dim content
			dim catedata,catename
			catedata=sdcms.categorydata
			catedata=sdcms.getclassdb(classid)
			if not isarray(catedata) then
				sdcms.echo "&#26639;&#30446;&#19981;&#23384;&#22312;&#25110;&#24050;&#34987;&#21024;&#38500;"
				sdcms.db.dbclose
				sdcms.die
			end if
			catename=catedata(1)
			data=sdcms.db.dbload(1,"content","sd_model_page","classid="&classid&"","")
			if ubound(data)>=0 then
				content=data(0,0)
			end if
			load theme_pageadd
	end select
	
	sdcms.db.dbclose
%>