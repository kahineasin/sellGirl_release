<%
'=====================================================================================
'flash��ͼͶƱϵͳ���û���1.0
'flashballot1.0
'����:ë��
'����:www.flashado.com
'email:mc@flashado.com
'����BUG�뾡����������������һᾡ�����
'=====================================================================================
'-------------------------------------------------------------------------------------
'�������ø�������뵽��������=============================================================
filtrate=true'�Ƿ��ֹ�ظ�ͶƱ,��Ϊtrue�����÷�ֹ�ظ�ͶƱ
myday=1'�����ظ�ͶƱ������
mydata="../Database/ballot.mdb"'���ݿ�·��
'=======================================================
 dim conn   
   dim rs
   rs="DBQ="+server.mappath(mydata)+";DefaultDir=;DRIVER={Microsoft Access Driver (*.mdb)};Pwd=netroom;"
     set conn=server.createobject("ADODB.CONNECTION")
     conn.open rs

'Ŀ�ģ�SQLע�빥��Ԥ��װ��[�ַ���]

function strtext(str)
    strtext=replace(str,chr(34),"&quot;")
end function

function strSql(str)
    strSql=replace(str,"'","''")
end function

function flashSql(str)
    flashSql=replace(str,"chr(124)","|")
end function

'Ŀ�ģ�SQLע�빥��Ԥ��װ��[������]
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

'�жϷ����Ƿ������ⲿ
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