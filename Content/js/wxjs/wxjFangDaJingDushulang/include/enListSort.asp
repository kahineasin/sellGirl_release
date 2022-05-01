			  
<%

Function ListSort(id)
  Dim rs,sql,i,ChildCount,FolderType,FolderName,onMouseUp,ListType
  Set rs=server.CreateObject("adodb.recordset")
  sql="Select * From "&Datafrom&" where ParentID="&id&" order by id"
  rs.open sql,conn,1,1
  if id=0 and rs.recordcount=0 then
    response.write ("暂无分类!")
    response.end
  end if  
  i=1
  response.write("<table border='0' cellspacing='0' cellpadding='0'>")
  while not rs.eof
    ChildCount=conn.execute("select count(*) from "&Datafrom&" where ParentID="&rs("id"))(0)
    if ChildCount=0 then
	  if i=rs.recordcount then
	    FolderType="SortFileEnd"
	  else
	    FolderType="SortFile"
	  end if
	  FolderName=rs("enSortName")
	  onMouseUp=""
    else
	  if i=rs.recordcount then
	 	FolderType="SortEndFolderClose"
		ListType="SortEndListline"
		onMouseUp="EndSortChange('a"&rs("id")&"','b"&rs("id")&"');"
	  else
		FolderType="SortFolderClose"
		ListType="SortListline"
		onMouseUp="SortChange('a"&rs("id")&"','b"&rs("id")&"');"
	  end if
	  FolderName=rs("enSortName")
    end if
    response.write("<tr>")
    response.write("<td nowrap id='b"&rs("id")&"' class='"&FolderType&"' onMouseUp="&onMouseUp&"></td><td nowrap><a href='"&ListView&"List.asp?SortID="&rs("ID")&"&SortPath="&rs("SortPath")&"'>"&FolderName&"</a>")	
    response.write("</td></tr>")
    if ChildCount>0 then
%>
      <tr id="a<%= rs("id")%>" style="display:yes"><td class="<%= ListType%>" nowrap></td><td ><% ListSort(rs("id")) %></td></tr>
<%
    end if
    rs.movenext
    i=i+1
  wend
  response.write("</table>")
  rs.close
  set rs=nothing
end function
'生成所属类别--------------------------
Function SortText(ID)
  Dim rs,sql
  Set rs=server.CreateObject("adodb.recordset")
  sql="Select * From "&Datafrom&" where ID="&ID
  rs.open sql,conn,1,1
  SortText=rs("enSortName")
  rs.close
  set rs=nothing
End Function

dim rs,sql,enSiteTitle,SiteUrl,enComName,enAddress,ZipCode,Telephone,Fax,Email,enKeywords,enDescriptions,IcpNumber,enMesViewFlag,enmiewFlag,Sitenum
set rs = server.createobject("adodb.recordset")
sql="select top 1 * from pp_Site"
rs.open sql,conn,1,1
enmiewFlag=rs("enmiewFlag")
enSiteTitle=rs("enSiteTitle")
miewFlag=rs("miewFlag")
SiteTitle=rs("SiteTitle")
SiteUrl=rs("SiteUrl")
enComName=rs("enComName")
ComName=rs("ComName")
Sitenum=rs("Sitenum")
enAddress=rs("enAddress")
Address=rs("Address")
ZipCode=rs("ZipCode")
Telephone=rs("Telephone")
Fax=rs("Fax")
Email=rs("Email")
enKeywords=rs("enKeywords")
enDescriptions=rs("enDescriptions")
Keywords=rs("Keywords")
Descriptions=rs("Descriptions")
IcpNumber=rs("IcpNumber")
enMesViewFlag=rs("enMesViewFlag")
MesViewFlag=rs("MesViewFlag")
rs.close
set rs=nothing
%>