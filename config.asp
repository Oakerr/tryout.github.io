<%
'以下配置请勿随便更改

'系统路径，根目录为："/"，虚拟目录配置示范："/test/"
dim webroot
    webroot="/"

dim weburl
    weburl="http://"&request.servervariables("http_host")


dim preurl
	preurl=request.servervariables("http_referer")

'变量前缀，如一个空间下多次使用本程序的话，请每个程序配置不同的值
dim prefix
    prefix="9V1711m"

'数据库类型，true:Access，false:Mssql(即sql server)
dim datatype
    datatype=true

'以下为Access配置，依次是：数据库目录，数据库名
dim datapath
    datapath="data"

dim datadbname
    datadbname="#c1h9e9n2g.mdb"

'以下为Mssql配置，依次是：主机IP,用户名，密码，数据库名
dim datahost
    datahost=""

dim datauser
    datauser=""

dim datapass
    datapass=""

dim datasqlname
    datasqlname=""
%>