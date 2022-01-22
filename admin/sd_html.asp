<!--#include file="base.asp"-->
<%
''' SDCMS 生成html
''' ==================================================================
''' 版权所有 http://www.sdcms.cn
''' ------------------------------------------------------------------
''' 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和使用；
''' 未经授权不允许对程序代码以任何形式任何目的的再发布。
''' ==================================================================
''' 编写: IT平民
''' 修改：IT平民 in 2015.08

	sub html_content_category()
		dim t0:t0=sdcms.getint(sdcms.fquery("t0",0),0)
		dim t1:t1=sdcms.getint(sdcms.fquery("t1",0),0)
		dim t2:t2=sdcms.getint(sdcms.fquery("t2",0),100)
		dim lastid:lastid=sdcms.getint(sdcms.fget("lastid",0),0)
		dim sqlwhere:sqlwhere="isurl=0 and islock=1"
		dim topstr:topstr=""
		if t0<>0 then
			if t1=1 then
				sqlwhere=sqlwhere&" and classid in("&sdcms.get_sonid(t0)&")"
			else
				sqlwhere=sqlwhere&" and classid="&t0&""
			end if
		end if
		if t2<>0 then
			topstr=t2
		end if
		dim data:data=sdcms.db.dbload(topstr,"id","sd_content",sqlwhere&" and id> "&lastid&"","id")
		if ubound(data)<0 then
			sdcms.echo "0没有内容需要生成"
			exit sub
		end if
		dim i,content_total,idarr
		content_total=ubound(data,2)+1
		for i=0 to ubound(data,2)
			if i>0 then
				idarr=idarr&","
			end if
			idarr=idarr&data(0,i)
			lastid=data(0,i)
		next
		data=sdcms.db.dbload(1,"id","sd_content",sqlwhere&" and id> "&lastid&"","id")
		if ubound(data)<0 then
			sdcms.echo "2"
		else
			sdcms.echo "1"
		end if
		sdcms.echo idarr
	end sub
	
	sub html_content_date()
		dim t0:t0=sdcms.getint(sdcms.fquery("t0",0),0)
		dim t1:t1=sdcms.getint(sdcms.fquery("t1",0),0)
		dim lastid:lastid=sdcms.getint(sdcms.fget("lastid",0),0)
		dim sqlwhere:sqlwhere="isurl=0 and islock=1"
		dim topstr:topstr=""
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
		if t1<>0 then
			topstr=t1
		end if
		dim data:data=sdcms.db.dbload(topstr,"id","sd_content",sqlwhere&" and id> "&lastid&"","id")
		if ubound(data)<0 then
			sdcms.echo "0没有内容需要生成"
			exit sub
		end if
		dim i,content_total,idarr
		content_total=ubound(data,2)+1
		for i=0 to ubound(data,2)
			if i>0 then
				idarr=idarr&","
			end if
			idarr=idarr&data(0,i)
			lastid=data(0,i)
		next
		data=sdcms.db.dbload(1,"id","sd_content",sqlwhere&" and id> "&lastid&"","id")
		if ubound(data)<0 then
			sdcms.echo "2"
		else
			sdcms.echo "1"
		end if
		sdcms.echo idarr
	end sub
	
	sub html_content_id()
		dim t0:t0=sdcms.getint(sdcms.fquery("t0",0),0)
		dim t1:t1=sdcms.getint(sdcms.fquery("t1",0),0)
		dim t2:t2=sdcms.getint(sdcms.fquery("t2",0),100)
		dim lastid:lastid=sdcms.getint(sdcms.fget("lastid",0),0)
		dim sqlwhere:sqlwhere="isurl=0 and islock=1"
		dim topstr:topstr=""
		if t0<>0 and t1<>0 then
			sqlwhere=sqlwhere&" and id between "&t0&" and "&t1&""
		end if
		if t0=0 and t1<>0 then
			sqlwhere=sqlwhere&" and id <="&t1&""
		end if
		if t0<>0 and t1=0 then
			sqlwhere=sqlwhere&" and id >="&t0&""
		end if
		if t2<>0 then
			topstr=t2
		end if

		dim data:data=sdcms.db.dbload(topstr,"id","sd_content",sqlwhere&" and id> "&lastid&"","id")
		if ubound(data)<0 then
			sdcms.echo "0没有内容需要生成"
			exit sub
		end if
		dim i,content_total,idarr
		content_total=ubound(data,2)+1
		for i=0 to ubound(data,2)
			if i>0 then
				idarr=idarr&","
			end if
			idarr=idarr&data(0,i)
			lastid=data(0,i)
		next
		data=sdcms.db.dbload(1,"id","sd_content",sqlwhere&" and id> "&lastid&"","id")
		if ubound(data)<0 then
			sdcms.echo "2"
		else
			sdcms.echo "1"
		end if
		sdcms.echo idarr
	end sub
	
	sub html_sitemap()
		dim t0:t0=sdcms.getint(sdcms.fpost("t0",0),0)
		dim t1:t1=sdcms.getint(sdcms.fpost("t1",0),0)
		dim t2:t2=sdcms.enhtml(sdcms.fpost("t2",0))
		dim t3:t3=sdcms.enhtml(sdcms.fpost("t3",0))
		dim total:total=0
		dim thisnum:thisnum=0
		if t1<=0 then t1=100
		dim isbaidu:isbaidu=false
		dim isgoogle:isgoogle=false
		select case t0
			case "1":isbaidu=true:total=total+1
			case "2":isgoogle=true:total=total+1
			case "0":isbaidu=true:isgoogle=true:total=2
		end select
		sdcms.echo "<script src=""../lib/js/jquery.js""></script>"&vbcrlf
		dim data,i
		data=sdcms.db.dbload(t1,"id,createdate,catedir,url","sd_content n left join sd_category c on n.classid=c.cateid","islock=1 and isurl=0","id desc")
		if ubound(data)<0 then
			seterror "没有内容可生成"
			exit sub
		end if
		
		if isbaidu then
			dim baidustr_01,baidustr,baidustr_02
			baidustr_01=baidustr_01&"<?xml version=""1.0"" encoding=""utf-8""?>"&vbcrlf
			baidustr_01=baidustr_01&"<urlset>"&vbcrlf
			baidustr=baidustr&"    <url>"&vbcrlf
			baidustr=baidustr&"        <loc>{loc}</loc>"&vbcrlf
			baidustr=baidustr&"        <lastmod>{lastmod}</lastmod>"&vbcrlf
			baidustr=baidustr&"        <changefreq>"&t2&"</changefreq>"&vbcrlf
			baidustr=baidustr&"        <priority>"&t3&"</priority>"&vbcrlf
			baidustr=baidustr&"    </url>"&vbcrlf
			baidustr_02=baidustr_02&"</urlset>"&vbcrlf
			dim baiduhtml:baiduhtml=""
			dim bstr,loc,lastmod
			for i=0 to ubound(data,2)
				bstr=baidustr
				lastmod=sdcms.getdate(data(1,i),"-",1)
				select case webmode
					case "1"
						loc=weburl&webroot&"show.asp?id="&data(0,i)
					case "2"
						loc=weburl&webroot&data(2,i)&"/"&data(3,i)&".html"
					case "3"
						loc=weburl&webroot&htmldir&data(2,i)&"/"&data(3,i)&".html"
				end select
				bstr=replace(bstr,"{loc}",loc)
				bstr=replace(bstr,"{lastmod}",lastmod)
				baiduhtml=baiduhtml&bstr
			next
			baiduhtml=baidustr_01&baiduhtml&baidustr_02
			dim baiduurl:baiduurl="<a href=../sitemap_baidu.xml target=_blank>百度地图</a>　"
			sdcms.newfile "../","sitemap_baidu.xml",baiduhtml,""
			thisnum=thisnum+1
			setstatus "百度地图生成完毕，总计生成了<span>"&thisnum&"</span>条内容",thisnum,total
		end if
		
		if isgoogle then
			dim googlestr_01,googlestr,googlestr_02
			googlestr_01=googlestr_01&"<?xml version=""1.0"" encoding=""utf-8""?>"&vbcrlf
			googlestr_01=googlestr_01&"<urlset xmlns=""http://www.sitemaps.org/schemas/sitemap/0.9"">"&vbcrlf
			googlestr=googlestr&"    <url>"&vbcrlf
			googlestr=googlestr&"        <loc>{loc}</loc>"&vbcrlf
			googlestr=googlestr&"        <lastmod>{lastmod}</lastmod>"&vbcrlf
			googlestr=googlestr&"        <changefreq>"&t2&"</changefreq>"&vbcrlf
			googlestr=googlestr&"        <priority>"&t3&"</priority>"&vbcrlf
			googlestr=googlestr&"    </url>"&vbcrlf
			googlestr_02=googlestr_02&"</urlset>"&vbcrlf
			dim googlehtml:googlehtml=""
			dim gstr
			for i=0 to ubound(data,2)
				gstr=googlestr
				lastmod=googledate(data(1,i))
				select case webmode
				case "1"
					loc=weburl&webroot&"show.asp?id="&data(0,i)
				case "2"
					loc=weburl&webroot&data(2,i)&"/"&data(3,i)&".html"
				case "3"
					loc=weburl&webroot&htmldir&data(2,i)&"/"&data(3,i)&".html"
			end select
				gstr=replace(gstr,"{loc}",loc)
				gstr=replace(gstr,"{lastmod}",lastmod)
				googlehtml=googlehtml&gstr
			next
			googlehtml=googlestr_01&googlehtml&googlestr_02
			dim googleurl:googleurl="<a href=../sitemap_google.xml target=_blank>谷歌地图</a>　"
			sdcms.newfile "../","sitemap_google.xml",googlehtml,""
			thisnum=thisnum+1
			setstatus "谷歌地图生成完毕，总计生成了<span>"&thisnum&"</span>条内容",thisnum,total
		end if
		setstatus "生成完毕，总计生成了<span>"&total&"</span>个地图( 点击查看："&baiduurl&googleurl&")",total,total
	end sub
	
	sub setstatus(byval t0,byval t1,byval t2)
		on error resume next
		dim str:str="<script>"&vbcrlf
		str=str&"$(""#create_text"",window.parent.document).html("""&t0&""");"&vbcrlf
		str=str&"$(""#create_staus"",window.parent.document).css(""border"",""1px solid #91B6E5"");"&vbcrlf
		str=str&"$(""#create_percent"",window.parent.document).css(""background"",""#91B6E5"");"&vbcrlf
		str=str&"$(""#create_percent"",window.parent.document).css(""color"",""#fff"");"&vbcrlf
		str=str&"$(""#create_percent"",window.parent.document).css(""width"",parseInt("&t1/t2&"*100)+""%"");"&vbcrlf
		str=str&"$(""#create_percent"",window.parent.document).html(parseInt("&t1/t2&"*100)+""%"");"&vbcrlf
		str=str&"</script>"&vbcrlf
		sdcms.echo str
		response.flush()
		err.clear
	end sub
	
	sub seterror(byval t0)
		dim str:str="<script>"&vbcrlf
		str=str&"$(""#create_text"",window.parent.document).html("""");"&vbcrlf
		str=str&"$(""#create_staus"",window.parent.document).css(""border"",""1px solid #f00"");"&vbcrlf
		str=str&"$(""#create_percent"",window.parent.document).css(""background"",""#f00"");"&vbcrlf
		str=str&"$(""#create_percent"",window.parent.document).css(""color"",""#fff"");"&vbcrlf
		str=str&"$(""#create_percent"",window.parent.document).css(""width"",""100%"");"&vbcrlf
		str=str&"$(""#create_percent"",window.parent.document).html(""发生错误："&t0&""");"&vbcrlf
		str=str&"</script>"&vbcrlf
		sdcms.echo str
		response.flush()
	end sub
	
	function googledate(byval t0)
		googledate=year(t0)&"-"&right("0"&month(t0),2)&"-"&right("0"&day(t0),2)&"T"&right("0"&hour(t0),2)&":"&right("0"&minute(t0),2)&":"&right("0"&second(t0),2)&"+08:00"
	end function
	
	islogin
	dim act:act=lcase(sdcms.fget("act",0))
	select case act
		case "left":load eval("theme_html_"&act)
		case "home":checkpagelever 42:load eval("theme_html_"&act)
		case "category":checkpagelever 43:load eval("theme_html_"&act)
		case "content":checkpagelever 44:load eval("theme_html_"&act)
		case "sitemap":checkpagelever 45:load eval("theme_html_"&act)
		case "html_content_category":checkpagelever 44:html_content_category
		case "html_content_date":checkpagelever 44:html_content_date
		case "html_content_id":checkpagelever 44:html_content_id
		case "html_sitemap":checkpagelever 45:html_sitemap
	end select
	sdcms.db.dbclose
%>