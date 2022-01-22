<!--#include file="../../lib/base.asp"-->
<%
dim apidb:apidb=sdcms.getsys("qq.login")
dim apiarr:apiarr=eval(apidb)
if sdcms.strlen(apidb)<=0 then
	sdcms.echo "&#24212;&#29992;&#31243;&#24207;&#26410;&#23433;&#35013;"
	sdcms.die
end if
if apiarr(1)="" or apiarr(2)="" then
	sdcms.echo "&#21442;&#25968;&#27809;&#26377;&#37197;&#32622;"
	sdcms.die
end if
'申请到的appid
dim qq_appid:qq_appid=apiarr(1)

'申请到的appkey
dim qq_appkey:qq_appkey=apiarr(2)

'登录成功后跳转的地址,不需要更改
dim qq_callback:qq_callback=weburl&webroot&sdcms.get_thisfolder&"/api/callback.asp"
	qq_callback=server.urlencode(qq_callback)

'QQ授权api接口.按需调用:get_user_info,add_share,list_album,add_album,upload_pic,add_topic,add_one_blog,add_weibo
dim qq_scope:qq_scope="get_user_info"
%>