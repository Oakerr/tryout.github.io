﻿<!--#include file="../lib/base.asp"-->
<!--#include file="../theme.asp"-->
<%
''' SDCMS Rss
''' ==================================================================
''' 版权所有 http://www.sdcms.cn
''' ------------------------------------------------------------------
''' 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和使用；
''' 未经授权不允许对程序代码以任何形式任何目的的再发布。
''' ==================================================================
''' 编写: IT平民
''' 修改：IT平民 in 2014.07

	dim id:id=sdcms.getint(sdcms.fget("id",0),0)
	if id=0 then
		sdcms.show theme_rss,""
	else
		dim rss_01,rss_02,rss_03
		rss_01="<?xml version=""1.0"" encoding=""utf-8""?>"&vbcrlf
		rss_01=rss_01&"<rss version=""2.0"">"&vbcrlf
		rss_01=rss_01&"<channel>"&vbcrlf
		rss_01=rss_01&"<title>{classname}</title>"&vbcrlf
		rss_01=rss_01&"<link>{classurl}</link>"&vbcrlf
		rss_01=rss_01&"<description><![CDATA[{classdesc}]]></description>"&vbcrlf
		rss_01=rss_01&"<language>zh-cn</language>"&vbcrlf
		rss_01=rss_01&"<generator>Rss Generator By "&sdcms_version&" 4-54-9-75-9-0-9</generator>"&vbcrlf
		
		rss_02="<item>"&vbcrlf
		rss_02=rss_02&"	<title>{title}</title>"&vbcrlf
		rss_02=rss_02&"	<link>{link}</link>"&vbcrlf
		rss_02=rss_02&"	<description><![CDATA[{desc}]]></description>"&vbcrlf
		rss_02=rss_02&"	<pubDate><![CDATA[{date}]]></pubDate>"&vbcrlf
		rss_02=rss_02&"	<category><![CDATA[{catename}]]></category>"&vbcrlf
		rss_02=rss_02&"</item>"&vbcrlf
		
		rss_03="</channel>"&vbcrlf
		rss_03=rss_03&"</rss>"
		
		dim t1:t1=sdcms.getclassdb(id)
		if not isarray(t1) then
		
		else
			dim classname:classname=t1(1)
			dim classurl:classurl=sdcms.get_cateurl(id,t1(2),t1(10),t1(9))
			dim classdesc:classdesc=t1(18)
			dim sonid:sonid=t1(5)
			dim str
			rss_01=replace(rss_01,"{classname}",classname)
			rss_01=replace(rss_01,"{classurl}",weburl&classurl)
			if sdcms.strlen(classdesc)>0 then
				rss_01=replace(rss_01,"{classdesc}",classdesc)
			else
				rss_01=replace(rss_01,"{classdesc}","")
			end if
			str=rss_01
			dim data,content
			data=sdcms.db.dbload(20,"id,isurl,url,catedir,title,createdate,catename,intro,classid","sd_content left join sd_category on sd_content.classid=sd_category.cateid","sd_content.islock=1 and classid in("&sonid&")","ontop desc,id desc")
			if ubound(data)>=0 then
				dim i,s
				for i=0 to ubound(data,2)
					s=rss_02
					s=replace(s,"{title}",data(4,i))
					if data(1,i)=0 then
						s=replace(s,"{link}",weburl&sdcms.geturl(data(0,i),data(8,i),data(1,i),data(2,i)))
					else
						s=replace(s,"{link}",data(2,i))
					end if
					s=replace(s,"{date}",data(5,i))
					s=replace(s,"{catename}",data(6,i))
					content=data(7,i)
					if sdcms.strlen(content)>0 then
						content=sdcms.dehtml(content)
						s=replace(s,"{desc}",content)
					else
						s=replace(s,"{desc}","")
					end if
					str=str&s
				next
			end if
			str=str&rss_03
			sdcms.echo str
		end if
	end if
%>