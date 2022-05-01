<%
'=====================================================================================
'flash饼图投票系统多用户版1.0
'flashballot1.0
'作者:毛虫
'网地:www.flashado.com
'email:mc@flashado.com
'如有BUG请尽快向我提出，这样我会尽快更新
'=====================================================================================
'-------------------------------------------------------------------------------------
'参数设置个别参数请到下面下载=============================================================
filtrate=true'是否防止重复投票,当为true是启用防止重复投票
myday=1'设置重复投票的天数
mydata="../Database/ballot.mdb"'数据库路经
'=======================================================
 dim conn   
   dim rs
   rs="DBQ="+server.mappath(mydata)+";DefaultDir=;DRIVER={Microsoft Access Driver (*.mdb)};Pwd=netroom;"
     set conn=server.createobject("ADODB.CONNECTION")
     conn.open rs

'目的：SQL注入攻击预防装置[字符型]

function strtext(str)
    strtext=replace(str,chr(34),"&quot;")
end function

function strSql(str)
    strSql=replace(str,"'","''")
end function

function flashSql(str)
    flashSql=replace(str,"chr(124)","|")
end function

'目的：SQL注入攻击预防装置[数字型]
function intSql(Numeric)
    if IsNumeric(Numeric) then
        intSql=Numeric
    else
        intSql=0
    end if
end function

function inthit(Numeric)
	If(Numeric="") Then
		inthit=1
	else
	    if IsNumeric(Numeric) and Numeric>=1 then
		inthit=Numeric
	    else
		inthit=1
	    end if
	End if
end function

Function validpersonal(username,password)
sql="select * from admin where name='"& strSql(username) &"' and pass ='"& strSql(password) &"'"
	set rs=server.createobject("adodb.recordset")
		rs.open sql,conn,3,2	
	If(rs.eof) Then
		validpersonal=false
	else
		validpersonal=true	
	End if
End Function

'判断发言是否来自外部
function ChkPost()
	dim server_v1,server_v2
	chkpost=false
	server_v1=Cstr(Request.ServerVariables("HTTP_REFERER"))
	server_v2=Cstr(Request.ServerVariables("SERVER_NAME"))
	if mid(server_v1,8,len(server_v2))<>server_v2 then
		chkpost=false
	else
		chkpost=true
	end if
end function
%>