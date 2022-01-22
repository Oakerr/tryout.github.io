﻿<%
''' SDCMS 数据库操作
''' ==================================================================
''' 版权所有 http://www.sdcms.cn
''' ------------------------------------------------------------------
''' 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和使用；
''' 未经授权不允许对程序代码以任何形式任何目的的再发布。
''' ==================================================================
''' 编写: IT平民
''' 修改：IT平民 in 2014.07

class sdcms_dbbase
	private rs
	public conn
	
	private sub class_initialize()
		dbquery=0
	end sub
	
	private sub class_terminate
		on error resume next
		if isobject(conn) or conn.state=1 then
			conn.close
			set conn=nothing
		end if
		err.clear
	end sub
	
	public sub dbopen()
		on error resume next
		if isobject(conn) then exit sub
		dim connstr
		if webroot="" then
			sdcms.echo "&#21451;&#24773;&#25552;&#31034;&#65306;&#35831;&#20808;&#25191;&#34892;&#23433;&#35013;&#31243;&#24207;"
			sdcms.die
		end if
		if datatype then
			connstr="Provider=Microsoft.Jet.OLEDB.4.0;Data Source="&server.mappath(webroot&datapath&"/"&datadbname)
		else
			connstr="Provider=Sqloledb;User ID="&datauser&";Password="&datapass&";Initial CataLog="&datasqlname&";Data Source="&datahost&";"
		end if
		set conn=server.createobject("adodb.connection")
		conn.open connstr
		if err then
			sdcms.echo "&#25968;&#25454;&#24211;&#36830;&#25509;&#22833;&#36133;("&err.description&")"
			err.clear
			sdcms.die
		end if
	end sub
	
	public sub dbclose()
		on error resume next
		if isobject(conn) or conn.state=1 then
			conn.close
			set conn=nothing
		end if
		err.clear
	end sub
	
	public function exedb(byval t0)
		on error resume next
		set exedb=conn.execute(t0)
		dbquery=dbquery+1
		if err then
			sdcms.errlog "Sql："&t0&"<br>详情："&err.description,1
			err.clear
			sdcms.die
		end if
	end function
	
	public sub insert(byval t0,byval t1)
		dim dbfield,dbvalue,dbarray,i,temparr,fieldlen,filedtype,sqlvalue
		dbfield=""
		dbvalue=""
		dbarray=t1
		filedtype=""
		for i=0 to ubound(dbarray)
			temparr=dbarray(i)
			if len(dbfield)>0 then
				dbfield=dbfield&","
				dbvalue=dbvalue&","
			end if
			if instr(temparr(0),"(")>0 or instr(temparr(0),")")>0 or instr(temparr(0)," ")>0 or instr(temparr(0),".")>0 then
				dbfield=dbfield&temparr(0)
			else
				dbfield=dbfield&"["&temparr(0)&"]"
			end if
			fieldlen=temparr(2)
			filedtype=temparr(3)
			sqlvalue=replace(temparr(1),"'","''")
			if fieldlen=0 then
				if filedtype=1 then
					dbvalue=dbvalue&"'"&sqlvalue&"'"
				else
					dbvalue=dbvalue&sqlvalue
				end if
			else
				if filedtype=1 then
					dbvalue=dbvalue&"'"&left(sqlvalue,fieldlen)&"'"
				else
					dbvalue=dbvalue&left(sqlvalue,fieldlen)
				end if
			end if
		next
		exedb("insert into "&t0&" ("&dbfield&") values ("&dbvalue&")")
	end sub
	
	public function dbnew(byval t0,byval t1,byval t2)
		dim dbfield,dbvalue,dbnum,dbarray,i,temparr,fieldlen,sqlvalue
		dbfield=""
		dbvalue=""
		dbarray=t1
		dbnew=0
		dbnum=ubound(dbarray)
		if len(t2)>0 then t2="where "&t2
		dim fieldarr(999)
		for i=0 to dbnum
			temparr=dbarray(i)
			if len(dbfield)>0 then
				dbfield=dbfield&","
			end if
			fieldlen=temparr(2)
			sqlvalue=temparr(1)
			if fieldlen=0 then
				fieldarr(i)=sqlvalue
			else
				fieldarr(i)=left(sqlvalue,fieldlen)
			end if
			if instr(temparr(0),"(")>0 or instr(temparr(0),")")>0 or instr(temparr(0)," ")>0 or instr(temparr(0),".")>0 then
				dbfield=dbfield&temparr(0)
			else
				dbfield=dbfield&"["&temparr(0)&"]"
			end if
		next

		set rs=server.createobject("adodb.recordset")
		rs.open "select "&dbfield&" from "&t0&" "&t2&"",conn,1,3
		dbquery=dbquery+1
		if len(t2)>0 then
			if not rs.eof then
				rs.close
				set rs=nothing
				exit function
			end if
		end if
		rs.addnew
		for i=0 to dbnum
			rs(i)=fieldarr(i)
		next
		rs.update
		rs.close
		set rs=nothing
		dbnew=1
	end function
	
	public function dbupdate(byval t0,byval t1,byval t2)
		dbupdate=0
		dim i,dbarray,sqlvalue
		dim n1,n2,n3,n4
		dbarray=t2
		sqlvalue=""
		for i=0 to ubound(dbarray)
			if len(sqlvalue)>0 then
				sqlvalue=sqlvalue&","
			end if
			 n1=dbarray(i)(0)
			 n2=dbarray(i)(1)
			 n3=dbarray(i)(2)
			 n4=dbarray(i)(3)
			 if n3<>0 then n2=left(n2,n3)
			 if n4=1 then n2=sdcms.sqlstr(n2)
			 if instr(n1,"(")>0 or instr(n1,")")>0 or instr(n1," ")>0 or instr(n1,".")>0 then
				  sqlvalue=sqlvalue&n1&"="&n2&""
			 else
				sqlvalue=sqlvalue&"["&n1&"]="&n2&""
			 end if
		next
		dim sql
		sql="update "&t0&" set "&sqlvalue
		if len(t1)>0 then sql=sql&" where "&t1
		exedb(sql)
		dbupdate=1
	end function

	public function dbload(byval t0,byval t1,byval t2,byval t3,byval t4)
		if len(t0)>0 then t0=" top "&t0
		if len(t1)=0 then t1=" * "
		if len(t3)>0 then t3=" where "&t3
		if left(lcase(t4),3)="rnd" then
			if datatype then
				randomize
				dim orderid
				if len(t4)>4 then orderid=right(t4,len(t4)-4)
				if len(orderid)=0 then orderid="id"
				t4="rnd(-("&orderid&" +"&rnd()&"))"
			else
				t4="newid()"
			end if
		end if
		if len(t4)>0 then t4=" order by "&t4
		if t1<>" * " then
			dim str:str=""
			dim arr:arr=split(t1,",")
			dim i
			for i=0 to ubound(arr)
				if i>0 then str=str&","
				if instr(arr(i),"(")>0 or instr(arr(i),")")>0 or instr(arr(i)," ")>0 or instr(arr(i),".")>0 then
					str=str&arr(i)
				else
					str=str&"["&arr(i)&"]"
				end if
			next
			t1=str
		end if
		set rs=exedb("select "&t0&" "&t1&" from "&t2&" "&t3&" "&t4)
		if rs.eof then
			dbload=array()
		else
			dbload=rs.getrows()
		end if
		rs.close
		set rs=nothing
	end function
	
	public function dbloadone(byval t0,byval t1,byval t2)
		if len(t2)>0 then t2=" where "&t2
		dbloadone=exedb("select "&t0&" from "&t1&" "&t2&"")(0)
	end function
	
	public sub dbdel(byval t0,byval t1)
		dim sql
		sql="delete from "&t0
		if len(t1)>0 then sql=sql&" where "&t1
		exedb(sql)
	end sub
	
	public function dbcount(byval t0,byval t1)
		dim sql
		sql="select count(1) from "&t0
		if len(t1)>0 then sql=sql&" where "&t1
		dbcount=exedb(sql)(0)
	end function
	
	public function insertid(byval t0,byval t1)
		'if datatype then
			insertid=exedb("select max("&t0&") from "&t1&"")(0)
		'else
			'insertid=exedb("select @@identity")
		'end if
	end function
	
	public function insertid_new(byval t0,byval t1,byval t2)
		if len(t2)>0 then t2=" where "&t2
		insertid_new=exedb("select max("&t0&") from "&t1&" "&t2&"")(0)
	end function
end class
%>