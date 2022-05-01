<%
Dim Conn,ConnStr
On error resume next
Set Conn=Server.CreateObject("Adodb.Connection")
ConnStr="Provider=Microsoft.Jet.OLEDB.4.0;Data Source="&Server.MapPath(SiteDataPath)
Conn.open ConnStr
if err then
   err.clear
   Set Conn = Nothing
   Response.Write "系统错误：数据库连接出错，请检查'系统管理>>站点常量设置',或者/Include/Const.asp文件!"
   Response.End
end if
%>