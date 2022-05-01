			  
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
	  FolderName=rs("SortName")
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
	  FolderName=rs("SortName")
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
  SortText=rs("SortName")
  rs.close
  set rs=nothing
End Function

dim rs,sql,enSiteTitle,SiteUrl,enComName,enAddress,ZipCode,Telephone,Fax,Email,enKeywords,enDescriptions,IcpNumber,enMesViewFlag,enmiewFlag,Sitenum,gg
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
gg=rs("gg")
Keywords=rs("Keywords")
Descriptions=rs("Descriptions")
IcpNumber=rs("IcpNumber")
enMesViewFlag=rs("enMesViewFlag")
MesViewFlag=rs("MesViewFlag")
rs.close
set rs=nothing

function StrLeft(Str,StrLen)
  dim L,T,I,C
  if Str="" then
    StrLeft=""
    exit function
  end if
  Str=Replace(Replace(Replace(Replace(Str,"&nbsp;"," "),"&quot;",Chr(34)),"&gt;",">"),"&lt;","<")
  L=Len(Str)
  T=0
  for i=1 to L
    C=Abs(AscW(Mid(Str,i,1)))
    if C>255 then
      T=T+2
    else
      T=T+1
    end if
    if T>=StrLen then
      StrLeft=Left(Str,i) & "…"
      exit for
    else
      StrLeft=Str
    end if
  next
  StrLeft=Replace(Replace(Replace(replace(StrLeft," ","&nbsp;"),Chr(34),"&quot;"),">","&gt;"),"<","&lt;")
end function
Function Removehtml(Strhtml)'去掉HTML标签
     Dim Objregexp, Match, Matches 
     Set Objregexp = New Regexp 
     Objregexp.Ignorecase = True 
     Objregexp.Global = True 
     '取闭合的<> 
     Objregexp.Pattern = "<.+?>" 
     '进行匹配 
     Set Matches = Objregexp.Execute(Strhtml) 
     ' 遍历匹配集合，并替换掉匹配的项目 
     For Each Match In Matches 
     Strhtml=Replace(Strhtml,Match.Value,"") 
     Next 
     Removehtml=Strhtml 
     Set Objregexp = Nothing
End Function
function StrLen(Str)
  if Str="" or isnull(Str) then 
    StrLen=0
    exit function 
  else
    dim regex
    set regex=new regexp
    regEx.Pattern ="[^\x00-\xff]"
    regex.Global =true
    Str=regEx.replace(Str,"^^")
    set regex=nothing
    StrLen=len(Str)
  end if
end function
%>