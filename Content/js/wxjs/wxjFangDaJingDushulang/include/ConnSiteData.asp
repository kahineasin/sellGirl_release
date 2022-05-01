<%
Dim Conn,ConnStr
On error resume next
Set Conn=Server.CreateObject("Adodb.Connection")
ConnStr="Provider=Microsoft.Jet.OLEDB.4.0;Data Source="&Server.MapPath(SiteDataPath)
Conn.open ConnStr
if err then
   err.clear
   Set Conn = Nothing
   Response.Write "系统错误：数据库连接出错，请检查!"
   Response.End
end if
%>
<!--#include file="Function.asp" -->