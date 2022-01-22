<%
''' SDCMS 分页
''' ==================================================================
''' 版权所有 http://www.sdcms.cn
''' -----------------------------------------------------------------
''' 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和使用；
''' 未经授权不允许对程序代码以任何形式任何目的的再发布。
''' ==================================================================
''' 编写: 爱·哲学
''' 修改：IT平民 in 2014.09
class sdcms_pagelist

	private table_,field_,join_,where_,group_,order_,sql_,conn_,rs_,pagesize_,page_,pagenumber_,htmlurl_,isadminurl_
	private rspage,totalnumber,pagecount
	private home_url,pre_url,next_url,last_url,page_url
	
	public property let field(str)
		field_=str
	end property
	
	public property let table(str)
		table_=str
	end property
	
	public property let join(str)
		join_=str
	end property
	
	public property let where(str)
		if str<>"" then
			where_=" where "&str
		end if
	end property
	
	public property let group(str)
		if str<>"" then
			group_=" group by "&str
		end if
	end property
	
	public property let order(str)
		if str<>"" then
			order_=" order by "&str
		end if
	end property
	
	public property let pagesize(num)
		if isnumeric(num) then
			pagesize_=cint(num)
			if pagesize_<1 then
				pagesize_=20
			end if
		else
			pagesize_=20
		end if
	end property
	
	public property let page(num)
		if isnumeric(num) then
			page_=cint(num)
			if page_<1 then
				page_=1
			end if
		else
			page_=1
		end if
	end property
	
	public property let pagenumber(num)
		if isnumeric(num) then
			pagenumber_=clng(num)
			if pagenumber_<8 then
				pagenumber_=8
			end if
		else
			pagenumber_=8
		end if
		if pagenumber_ mod 2=0 then
			pagenumber_=8
		end if
	end property
	
	public property let htmlurl(str)
		htmlurl_=str
	end property
	
	public property let isadminurl(str)
		isadminurl_=str
	end property
	
	private sub class_initialize()
		table_=""
		field_="*"
		join_=""
		where_=""
		group_=""
		order_=""
		pagesize_=20
		pagecount=0
		page_=1
		pagenumber_=6
		htmlurl_=""
		isadminurl_=1
		set rspage=server.createobject("adodb.recordset")
	end Sub
	
	private sub class_terminate()
		set rspage=nothing
	end Sub
	
	public function getrs()
		sql_="select "&field_&" from ["&table_&"]"&join_&where_&group_&order_
		rspage.open sql_,sdcms.db.conn,1,1
		dbquery=dbquery+1
		if not rspage.eof and not rspage.bof then
			rspage.pagesize=pagesize_
			rspage.absolutepage=page_
			totalnumber=rspage.recordcount
			pagecount=abs(int(-abs(totalnumber/pagesize_)))
		end if
		set getrs=rspage
		dopage
	end function
	
	public function number(byval num)
		number=pagesize_*(page_-1)+num
	end function
	
	public function totalurl()
		totalurl=pagecount
	end function
	
	public function homeurl()
		homeurl=home_url
	end function
	
	public function nexturl()
		nexturl=replace(next_url,"amp;","")
	end function
	
	public function preurl()
		preurl=pre_url
	end function
	
	public function lasturl()
		lasturl=last_url
	end function
	
	public function pageurl()
		pageurl=page_url
	end function
	
	public sub dopage()
		home_url=geturl(1)
		if page_>1 then
			pre_url=geturl(page_-1)
		else
			pre_url=""
		end if
		
		if page_<pagecount then
			next_url=geturl(page_+1)
		else
			next_url=""
		end if
		
		if page_<>pagecount then
			last_url=geturl(pagecount)
		else
			last_url=""
		end if
		
		page_url=page_&"/"&pagecount
	end sub
	
	public function showpage()
		if totalnumber=0 then showpage="":exit function
		dim pagehtml,beginpage,endpage,i
		beginpage=page_
		endpage=page_
		i=pagenumber_
		if ismobile then
		i=3
		end if
		if page_>pagecount then page_=pagecount
		if endpage>pagecount then endpage=pagecount
		do while true
			if beginpage>1 then
				beginpage=beginpage - 1
				i=i-1
			end if 
			if i>1 and endpage<pagecount then
				endpage=endpage + 1
				i=i-1
			end if
			if (beginpage<=1 and endpage>=pagecount) or i<=1 then exit do
		loop
		pagehtml="<li><a>&#24635;&#25968; "&totalnumber&"</a></li>"
		if page_>1 then pagehtml = pagehtml&"<li><a href="""&geturl(page_-1)&""">&#19978;&#19968;&#39029;</a></li>"
		if beginpage<>1 then pagehtml = pagehtml&"<li><a href="""&geturl(1)&""">1...</a></li>"
		for i = beginpage To endpage
			if i=page_ then
				pagehtml=pagehtml&"<li class=""active""><a href="""&geturl(i)&""">"&i&"</a></li>"
			else
				pagehtml=pagehtml&"<li><a href="""&geturl(i)&""">"&I&"</a></li>"
			end if
		next
		if endpage<>pagecount then pagehtml=pagehtml&"<li><a href="""&geturl(pagecount)&""">..."&pagecount&"</a></li>"
		if page_<pagecount then pagehtml=pagehtml&"<li><a href="""&geturl(page_+1)&""">&#19979;&#19968;&#39029;</a></li>"
		pagehtml=pagehtml&"<li><a>"&page_&"/"&pagecount&"</a></li>"
		showpage=pagehtml
	end function
	
	public function show_page_num()
		show_page_num=page_
	end function
	
	public function show_page_total()
		show_page_total=pagecount
	end function
	
	private function geturl(byval num)
		select case webmode
		case "1"
			geturl="?"&sdcms.geturlparam&"page="&num
		case "2"
			if isadminurl_=1 then
				geturl=replace(htmlrule,"[page]",num)
				if num="1" then
					geturl=replace(geturl,"1/","")
				end if
				geturl=replace(geturl,"//","/")
			else
				geturl="?"&sdcms.geturlparam&"page="&num
			end if
		case "3"
			if isadminurl_=1 then
				geturl=replace("index_[page].html","[page]",num)
				if num="1" then
					geturl=replace(geturl,"index_1.html","./")
				end if
			else
				geturl="?"&sdcms.geturlparam&"page="&num
			end if
		end select
	end function
	
end class
%>