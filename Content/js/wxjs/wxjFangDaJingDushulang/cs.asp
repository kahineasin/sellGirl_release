<!--#include file="Include/Const.asp" -->
<!--#include file="Include/ConnSiteData.asp" -->
<!--#include file="Include/lockyou.asp" -->
<!--#include file="Include/ListSort.asp" -->
<!--#include file="Include/NoSqlHack.Asp" -->
<!--#include file="Include/wxjinclude.asp" -->
<%if miewFlag=0 then
response.Write("this Site is closed what is being updated······")
response.End()
end if
%>
<%

function nwdanqian()
dim rs,sql,Sortid
Sortid=Trim(Request.QueryString("Sortid"))
set rs = server.createobject("adodb.recordset")
 if Sortid<>"" then 
 sql="select * from pp_NewsSort where  id="&Sortid
  else
 sql="select * from pp_NewsSort where id=61 " 
  end if
  rs.open sql,conn,1,3
  
   while not rs.eof
  response.Write rs("sortname")
  rs.movenext
  wend
     rs.close
 set rs=nothing

end function
function servicedanqian()
dim rs,sql,SortPath
SortPath=Trim(Request.QueryString("id"))
set rs = server.createobject("adodb.recordset")
 if SortPath<>"" then 
 sql="select * from pp_NewsSort where  id="&SortPath 

  rs.open sql,conn,1,3
 
  response.Write rs("sortname")
     rs.close 
 else
 response.Write "服务标准"
  end if
 set rs=nothing

end function

function contactdanqian()
dim rs,sql,Sortid
Sortid=Trim(Request.QueryString("id"))
set rs = server.createobject("adodb.recordset")
 if Sortid<>"" then 
 sql="select * from pp_News where  id="&Sortid
  else
 sql="select * from pp_News where id=433 " 
  end if
  rs.open sql,conn,1,3
  
   
  response.Write rs("newsname")

     rs.close
 set rs=nothing

end function



function work()
dim rs,sql
dim SortPath
      SortPath=Trim(request.QueryString("Sortid"))
set rs = server.createobject("adodb.recordset")
if SortPath<>"" then
 sql="select * from pp_News where sortid=" & SortPath
 else
  sql="select * from pp_News where sortid=100 " 
  end if
  rs.open sql,conn,1,3
 
  response.Write rs("content")
     rs.close 

 set rs=nothing

end function
function contact()
dim rs,sql
set rs = server.createobject("adodb.recordset")
  sql="select * from pp_News where id=408" 
  rs.open sql,conn,1,3
 
  response.Write rs("content")
     rs.close 

 set rs=nothing

end function


function httprolist()
dim sid,rs,sql
id=cint(request.QueryString("id"))
set rs = server.createobject("adodb.recordset")
if id<>0 then
  sql="select * from pp_products where instr(sortpath,"&id&") and ViewFlag  order by Sequence desc"
  else
  sql="select * from pp_products where ViewFlag  order by Sequence desc"
  end if
  rs.open sql,conn,1,3
   while not rs.eof
      dim BigPicPath
	  BigPicPath=replace(rs("BigPic"),"../","")
	  
	response.write "<a rel='"&BigPicPath&"' href='#' title='"&rs("productname")&"'>"&rs("enproductname")&"</a>"

  rs.movenext
  wend
     rs.close
 set rs=nothing
end function


function contactlist()
dim rs,sql,id,idd
id=cint(Request.QueryString("id"))
set rs = server.createobject("adodb.recordset")
  sql="select * from pp_News where instr(sortpath,97)>0 and sortid<>126"
  rs.open sql,conn,1,3
 while not rs.eof


       response.Write"<li><a href='contact.asp?id="&rs("id")&"'><p>"&rs("newsname")&"</p></a></li>"

	
  rs.movenext
  wend
     rs.close 
 set rs=nothing

end function

function contactlistview()
dim rs,sql
dim SortPath
      SortPath=Trim(request.QueryString("id"))
set rs = server.createobject("adodb.recordset")
if SortPath<>"" then
 sql="select * from pp_News where id=" & SortPath
 else
  sql="select * from pp_News where id=433 " 
  end if
  rs.open sql,conn,1,3
 
  response.Write rs("content")
     rs.close 

 set rs=nothing

end function

function tradeview()
dim rss,sqll
dim id
      id=request.QueryString("id")
set rss = server.createobject("adodb.recordset")
if id<>"" then
 sqll="select * from pp_News where id=" & id
 else
  sqll="select * from pp_News where id=460 " 
  end if
  rss.open sqll,conn,1,3
 if id=461 then
 
 
   dim SortPath
      SortPath=request.QueryString("SortPath")
  dim idCount'记录总数
  dim pages'每页条数
      pages=8
  dim pagec'总页数
  dim page'页码
      page=clng(request("Page"))
  dim pagenc'每页显示的分页页码数量=pagenc*2+1
      pagenc=2
  dim pagenmax'每页显示的分页的最大页码
  dim pagenmin'每页显示的分页的最小页码
  dim datafrom'数据表名
      datafrom="pp_download"
  dim datawhere'数据条件
      datawhere="where ViewFlag "
  dim sqlid'本页需要用到的id
  dim Myself,PATH_INFO,QUERY_STRING'本页地址和参数
      PATH_INFO = request.servervariables("PATH_INFO")
	  QUERY_STRING = request.ServerVariables("QUERY_STRING")'
      if QUERY_STRING = "" then
	    Myself = PATH_INFO & "?"
	  elseif Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")=0 then
	    Myself= PATH_INFO & "?" & QUERY_STRING & "&"
	  else
	    Myself = Left(PATH_INFO & "?" & QUERY_STRING,Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")-1)
	  end if
  dim taxis'排序的语句 asc,desc
      taxis="order by id desc "
  dim i'用于循环的整数
  dim rs,sql'sql语句
  '获取记录总数
  sql="select count(ID) as idCount from ["& datafrom &"]" & datawhere
  set rs=server.createobject("adodb.recordset")
  rs.open sql,conn,0,1
  idCount=rs("idCount")
  '获取记录总数

  if(idcount>0) then'如果记录总数=0,则不处理
    if(idcount mod pages=0)then'如果记录总数除以每页条数有余数,则=记录总数/每页条数+1
	  pagec=int(idcount/pages)'获取总页数
   	else
      pagec=int(idcount/pages)+1'获取总页数
    end if
	'获取本页需要用到的id============================================
    '读取所有记录的id数值,因为只有id所以速度很快
    sql="select id from ["& datafrom &"] " & datawhere & taxis
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,1,1
    rs.pagesize = pages '每页显示记录数
    if page < 1 then page = 1
    if page > pagec then page = pagec
    if pagec > 0 then rs.absolutepage = page  
    for i=1 to rs.pagesize
	  if rs.eof then exit for  
	  if(i=1)then
	    sqlid=rs("id")
	  else
	    sqlid=sqlid &","&rs("id")
	  end if
	  rs.movenext
    next
  '获取本页需要用到的id结束============================================
  end if
  Response.Write "<table width='100%' border='0' cellpadding='3' cellspacing='0' style='color:#222222;font-size:12px;'>"
 
  if(idcount>0 and sqlid<>"") then'如果记录总数=0,则不处理
    '用in刷选本页所语言的数据,仅读取本页所需的数据,所以速度快
    sql="select * from ["& datafrom &"] where id in("& sqlid &") "&taxis
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,0,1
	dim JobNO
	JobNO=1
    while not rs.eof '填充数据到表格
    Response.Write "  <a href='"&rs("fileurl")&"'><tr height=30px  style='cursor:hand;'>" &_
                   "    <td width='4%'align='center'>"&JobNO&"</td>" &_
                   "    <td width='25%' align='left'>"&rs("DownName")&"</td>" &_
      
                   "  </tr></a>"	
	 Response.Write"<tr>"&_
                         "<td height='1' colspan='3' ><div style='margin:0px;padding:0px;border-top:1px solid #ebebeb;height:1px;overflow:hidden;'> </div></td> </tr>"
	  rs.movenext
	  JobNO=JobNO+1
    wend
  else
    response.write "<tr><td align='center' colspan='3'  >暂无信息</td></tr></table>"
	exit function
  end if

  Response.Write "<tr>" & vbCrLf
  Response.Write "<td colspan='3' align='right' >" & vbCrLf
    Response.Write "<div class='sabrosus'><div class='manu' >页码：" & vbCrLf
  

  pagenmin=page-pagenc '计算页码开始值
  pagenmax=page+pagenc '计算页码结束值
  if(pagenmin<1) then pagenmin=1 '如果页码开始值小于1则=1
 
  if(pagenmax>pagec) then pagenmax=pagec '如果页码结束值大于总页数,则=总页数
  for i = pagenmin to pagenmax'循环输出页码
	if(i=page) then
	  response.write ("<span class='current'>"& i &"</span>")
	else
	  response.write ("<a href="& myself &"Page="& i &">"& i &"</a>")
	end if
  next
 
Response.Write "</div>"
Response.Write "</div>"
  Response.Write "</td>" & vbCrLf
  Response.Write "</tr>" & vbCrLf
  Response.Write "</table>" & vbCrLf
  rs.close
  set rs=nothing
 
 
 
 
 
 
 
 else
  response.Write rss("content")
  end if
     rss.close 

 set rss=nothing

end function

function online()
dim rs,sql
dim SortPath
      SortPath=Trim(request.QueryString("SortPath"))
set rs = server.createobject("adodb.recordset")
if SortPath<>"" then
 sql="select * from pp_News where sortid=" & SortPath
 else
  sql="select * from pp_News where sortid=112 " 
  end if
  rs.open sql,conn,1,3
 
  response.Write rs("content")
     rs.close 

 set rs=nothing

end function
function story()
dim rs,sql
dim SortPath
      SortPath=Trim(request.QueryString("SortPath"))
set rs = server.createobject("adodb.recordset")
if SortPath<>"" then
 sql="select * from pp_News where sortid=" & SortPath
 else
  sql="select * from pp_News where sortid=113 " 
  end if
  rs.open sql,conn,1,3
 
  response.Write rs("content")
     rs.close 

 set rs=nothing

end function
function join()
dim rs,sql
dim SortPath
      SortPath=Trim(request.QueryString("SortPath"))
set rs = server.createobject("adodb.recordset")
if SortPath<>"" then
 sql="select * from pp_News where sortid=" & SortPath
 else
  sql="select * from pp_News where sortid=115 " 
  end if
  rs.open sql,conn,1,3
 
  response.Write rs("content")
     rs.close 

 set rs=nothing

end function
function newsdanqian()
dim rs,sql,SortPath
SortPath=Trim(Request.QueryString("id"))
set rs = server.createobject("adodb.recordset")
 if SortPath<>"" then 
 sql="select * from pp_NewsSort where  id="&SortPath 

  rs.open sql,conn,1,3
 
  response.Write rs("sortname")
     rs.close 
 else
 response.Write "信息中心"
  end if
 set rs=nothing
end function

function newsviewdanqian()
dim rs,sql,id
id=Trim(Request.QueryString("sid"))
set rs = server.createobject("adodb.recordset")
 sql="select * from pp_Newssort where  id="&id 
 
  rs.open sql,conn,1,3
  
  response.Write rs("sortname")
     rs.close
 set rs=nothing

end function
function newsviewdanqians()
dim rs,sql,id
id=Trim(Request.QueryString("id"))
set rs = server.createobject("adodb.recordset")
 sql="select * from pp_News where  id="&id 
 
  rs.open sql,conn,1,3
  
  response.Write rs("newsname")
     rs.close
 set rs=nothing

end function
function joindanqian()
dim rs,sql,SortPath
SortPath=Trim(Request.QueryString("id"))
set rs = server.createobject("adodb.recordset")
 if SortPath<>"" then 
 sql="select * from pp_NewsSort where  id="&SortPath 

  rs.open sql,conn,1,3
 
  response.Write rs("sortname")
     rs.close 
 else
 response.Write "招商加盟"
  end if
 set rs=nothing

end function
function serverdanqian()
dim rs,sql,SortPath
SortPath=Trim(Request.QueryString("id"))
set rs = server.createobject("adodb.recordset")
 if SortPath<>"" then 
 sql="select * from pp_News where  id="&SortPath 

  rs.open sql,conn,1,3
 
  response.Write rs("newsname")
     rs.close 
 else
 response.Write "服务中心"
  end if
 set rs=nothing

end function

function joinviewdanqian()
dim rs,sql,id
id=Trim(Request.QueryString("id"))
set rs = server.createobject("adodb.recordset")
 sql="select * from pp_News where  id="&id 
 
  rs.open sql,conn,1,3
  
  response.Write rs("newsname")
     rs.close
 set rs=nothing

end function
function indexabout()
dim rs,sql
set rs = server.createobject("adodb.recordset")
 sql="select * from pp_About where id=53 " 
  rs.open sql,conn,1,3
      if StrLen(Removehtml(rs("content")))<=500 then
         content=Removehtml(rs("content"))
	  else 
	     content=StrLeft(Removehtml(rs("content")),499)
	   end if
  if rs("content")<>"" then
  response.Write content
  else
   response.Write"数据更新中..."
end if
  rs.close
 set rs=nothing
end function

function indexcontact()
dim rs,sql,id,NewsName
set rs = server.createobject("adodb.recordset")
  sql="select top 1 * from pp_News where ViewFlag and sortid=142"
  rs.open sql,conn,1,3

	     
  response.Write rs("content")
  rs.close
 set rs=nothing
end function
function indexprocon()
dim rs,sql,id,NewsName
set rs = server.createobject("adodb.recordset")
  sql="select top 1 * from pp_News where ViewFlag and sortid=143"
  rs.open sql,conn,1,3

	     
  response.Write rs("content")
  rs.close
 set rs=nothing
end function


function indexnews()
dim e,Addtime,dnsimg,content,newsname
set rs = server.createobject("adodb.recordset")
sql="select  * from pp_News where instr(sortpath,156)>0 and ViewFlag and NoticeFlag order by id desc"
  rs.open sql,conn,1,3
  
  if rs.bof and rs.eof then
    response.write "<li>暂无相关信息</li>"
	exit function
  end if
  
  for e=1 to 6
    
	if StrLen(Removehtml(rs("newsname")))<=60 then
        newsname=Removehtml(rs("newsname"))
	else 
		newsname=StrLeft(Removehtml(Removehtml(rs("newsname"))),59)
	end if
	    
	if StrLen(Removehtml(rs("content")))<=200 then
        content=Removehtml(rs("content"))
	else 
		content=StrLeft(Removehtml(Removehtml(rs("content"))),199)
	end if
	
   
   if e=1 then
   		if rs("bigpic")="" then
   		dnsimg="images/index_news.jpg"
		else
   		dnsimg=replace(rs("bigpic"),"../","")
		end if
   response.Write "<div id='main_line_box_l_con_top'>" &_
"		<div id='main_line_box_l_con_top_l'><a href='NewsView.asp?ID="&rs("ID")&"&SortID="&rs("SortID")&"'><img src='"&dnsimg&"'/></a></div>" &_
"		<div id='main_line_box_l_con_top_r'>" &_
"			<div id='main_line_box_l_con_top_r_tit'><a href='NewsView.asp?ID="&rs("ID")&"&SortID="&rs("SortID")&"'>"&e&"."&newsname&"</a></div>" &_
"			<div id='main_line_box_l_con_top_r_con'>"&content&"</div>" &_
"		</div>" &_
"	</div>" &_
"	<ul>"
	else
	response.Write "<li>" &_
"			<div class='main_line_box_l_con_li_l'><a href='NewsView.asp?ID="&rs("ID")&"&SortID="&rs("SortID")&"'>"&e&"."&newsname&"</a></div>" &_
"			<div class='main_line_box_l_con_li_r'></div>" &_
"		</li>"
	end if
  rs.movenext
  next
	response.Write "</ul>"
     rs.close
 set rs=nothing
end function


function indexnews22()
dim rs,sql,id,NewsName
set rs = server.createobject("adodb.recordset")
  sql="select top 2 * from pp_News where ViewFlag and NoticeFlag and Instr(SortPath,156)>0 order by id desc"
  rs.open sql,conn,1,3
  for i=1 to 2
    if StrLen(Removehtml(rs("NewsName")))<=21 then
         NewsName=Removehtml(rs("NewsName"))
	  else 
	     NewsName=StrLeft(Removehtml(rs("NewsName")),20)
	   end if
	     
  response.Write "<li><a href='newsview.asp?id="&rs("id")&"&sid="&rs("sortid")&"'>"&NewsName&"</a><p>"&left(rs("addtime"),instr(rs("addtime")," ")-1)&"</p></li>"
                
             
  rs.movenext
  next
   
 
  rs.close
 set rs=nothing
end function
function indexnewsd()
dim rs,sql,id,NewsName
set rs = server.createobject("adodb.recordset")
  sql="select top 6 * from pp_News where ViewFlag and NoticeFlag and Instr(SortPath,145)>0 order by id desc"
  rs.open sql,conn,1,3
  for i=1 to 6
    if StrLen(Removehtml(rs("NewsName")))<=35 then
         NewsName=Removehtml(rs("NewsName"))
	  else 
	     NewsName=StrLeft(Removehtml(rs("NewsName")),34)
	   end if
	     
  response.Write "<li><div class='index_n_l_l'><a href='NewsView.asp?ID="&rs("ID")&"&SortID="&rs("SortID")&"'>"&NewsName&"</a></div><div class='index_n_l_r'>"&left(rs("addtime"),instr(rs("addtime")," ")-1)&"</div></li>"
                
             
  rs.movenext
  next
   
 
  rs.close
 set rs=nothing
end function


function indexnewss()
dim rs,sql,id,NewsName
set rs = server.createobject("adodb.recordset")
  sql="select top 5 * from pp_News where ViewFlag and NoticeFlag and Instr(SortPath,130)>0 order by id desc"
  rs.open sql,conn,1,3
  for i=1 to 6
    if StrLen(Removehtml(rs("NewsName")))<=34 then
         NewsName=Removehtml(rs("NewsName"))
	  else 
	     NewsName=StrLeft(Removehtml(rs("NewsName")),33)
	   end if
	       
  response.Write "<li><div style='float:left;'><a href='news.asp?id="&rs("id")&"' title='"&rs("NewsName")&"'>"&NewsName&"</a></div>     <div style='float:right;margin-right:15px;display:inline;'>资料来源："&rs("source")&"</div></li>"
                
             
  rs.movenext
  next
   
 
  rs.close
 set rs=nothing
end function




function dh()
dim rs,sql,id,NavName
set rs = server.createobject("adodb.recordset")
  sql="select * from pp_Navigation where ViewFlag order by Sequence asc"
  rs.open sql,conn,1,3
  while not rs.eof
    if StrLen(Removehtml(rs("NavName")))<=40 then
         NavName=Removehtml(rs("NavName"))
	  else 
	     NavName=StrLeft(Removehtml(rs("NavName")),39)
	   end if
  response.Write"<td class='lan' align='center'><a href="&rs("Navurl")&">"&NavName&"</a></td><td align='center'>|</td>"
                
             
  rs.movenext
  wend
   
 
  rs.close
 set rs=nothing
end function

  function newsleft()
dim SortPath
SortPath=cint(request("SortPath"))
set rs = server.createobject("adodb.recordset")
  sql="select  * from pp_NewsSort where parentID=144 and ViewFlag  order by id asc"
  rs.open sql,conn,1,3
  
   while not rs.eof
   response.Write "<li><a href='news.asp?id="&rs("id")&"'><p>"&rs("sortname")&"</p></a></li>"

  rs.movenext
  wend
     rs.close
 set rs=nothing

end function

  function indeximgs()
  dim i
set rs = server.createobject("adodb.recordset")
  sql="select top 5 * from pp_News where instr(sortpath,205)>0 and ViewFlag  order by id asc"
  rs.open sql,conn,1,3
  '获取记录总数开始
    sql2="select count(ID) as idCount from pp_News where instr(sortpath,205)>0 and ViewFlag"
  set rs2=server.createobject("adodb.recordset")
  rs2.open sql2,conn,0,1
  idCount=rs2("idCount")
  '获取记录总数结束
  i=1
	for i=1 to idCount
		If rs.eof Then Exit For
   response.Write "pics += '"&replace(rs("bigpic"),"../","")&"';"
   if i=idCount then
   else
   response.Write "links += '#';pics += '|';links += '|';"
   end if
	 rs.movenext
	next

     rs.close
 set rs=nothing
end function


  function aboutbanner()
set rs = server.createobject("adodb.recordset")
  sql="select  * from pp_News where instr(sortpath,166)>0 and ViewFlag  order by id desc"
  rs.open sql,conn,1,3
  
   while not rs.eof
   
response.Write "<img src='"&replace(rs("bigpic"),"../","")&"' alt='"&rs("Source")&"' title='"&rs("content")&"'/>"

  rs.movenext
  wend
     rs.close
 set rs=nothing
end function

  function aboutbanner()
set rs = server.createobject("adodb.recordset")
  sql="select  * from pp_News where instr(sortpath,166)>0 and ViewFlag  order by id desc"
  rs.open sql,conn,1,3
  
   while not rs.eof
   
response.Write "<img src='"&replace(rs("bigpic"),"../","")&"' alt='"&rs("Source")&"' title='"&rs("content")&"'/>"

  rs.movenext
  wend
     rs.close
 set rs=nothing
end function

  function ppbanner()
set rs = server.createobject("adodb.recordset")
  sql="select  * from pp_News where instr(sortpath,167)>0 and ViewFlag  order by id desc"
  rs.open sql,conn,1,3
  
   while not rs.eof
   
response.Write "<img src='"&replace(rs("bigpic"),"../","")&"' alt='"&rs("Source")&"' title='"&rs("content")&"'/>"

  rs.movenext
  wend
     rs.close
 set rs=nothing
end function

  function newsbanner()
set rs = server.createobject("adodb.recordset")
  sql="select  * from pp_News where instr(sortpath,168)>0 and ViewFlag  order by id desc"
  rs.open sql,conn,1,3
  
   while not rs.eof
   
response.Write "<img src='"&replace(rs("bigpic"),"../","")&"' alt='"&rs("Source")&"' title='"&rs("content")&"'/>"

  rs.movenext
  wend
     rs.close
 set rs=nothing
end function

  function probanner()
set rs = server.createobject("adodb.recordset")
  sql="select  * from pp_News where instr(sortpath,169)>0 and ViewFlag  order by id desc"
  rs.open sql,conn,1,3
  
   while not rs.eof
   
response.Write "<img src='"&replace(rs("bigpic"),"../","")&"' alt='"&rs("Source")&"' title='"&rs("content")&"'/>"

  rs.movenext
  wend
     rs.close
 set rs=nothing
end function



  function casebanner()
set rs = server.createobject("adodb.recordset")
  sql="select  * from pp_News where instr(sortpath,170)>0 and ViewFlag  order by id desc"
  rs.open sql,conn,1,3
  
   while not rs.eof
   
response.Write "<img src='"&replace(rs("bigpic"),"../","")&"' alt='"&rs("Source")&"' title='"&rs("content")&"'/>"

  rs.movenext
  wend
     rs.close
 set rs=nothing
end function

 function servicebanner()
set rs = server.createobject("adodb.recordset")
  sql="select  * from pp_News where instr(sortpath,171)>0 and ViewFlag  order by id desc"
  rs.open sql,conn,1,3
  
   while not rs.eof
   
response.Write "<img src='"&replace(rs("bigpic"),"../","")&"' alt='"&rs("Source")&"' title='"&rs("content")&"'/>"

  rs.movenext
  wend
     rs.close
 set rs=nothing
end function

 function jobbanner()
set rs = server.createobject("adodb.recordset")
  sql="select  * from pp_News where instr(sortpath,172)>0 and ViewFlag  order by id desc"
  rs.open sql,conn,1,3
  
   while not rs.eof
   
response.Write "<img src='"&replace(rs("bigpic"),"../","")&"' alt='"&rs("Source")&"' title='"&rs("content")&"'/>"

  rs.movenext
  wend
     rs.close
 set rs=nothing
end function

 function mamberbanner()
set rs = server.createobject("adodb.recordset")
  sql="select  * from pp_News where instr(sortpath,183)>0 and ViewFlag  order by id desc"
  rs.open sql,conn,1,3
  
   while not rs.eof
   
response.Write "<img src='"&replace(rs("bigpic"),"../","")&"' alt='"&rs("Source")&"' title='"&rs("content")&"'/>"

  rs.movenext
  wend
     rs.close
 set rs=nothing
end function


 function flinkbanner()
set rs = server.createobject("adodb.recordset")
  sql="select  * from pp_News where instr(sortpath,173)>0 and ViewFlag  order by id desc"
  rs.open sql,conn,1,3
  
   while not rs.eof
   
response.Write "<img src='"&replace(rs("bigpic"),"../","")&"' alt='"&rs("Source")&"' title='"&rs("content")&"'/>"

  rs.movenext
  wend
     rs.close
 set rs=nothing
end function

  function newsinfoleft()
dim SortPath
SortPath=cint(request("SortPath"))
set rs = server.createobject("adodb.recordset")
  sql="select  * from pp_NewsSort where parentID=156 and ViewFlag  order by id asc"
  rs.open sql,conn,1,3
  
   while not rs.eof
   response.Write "<li><a href='newsinfo.asp?sid="&rs("id")&"'><p>"&rs("sortname")&"</p></a></li>"

  rs.movenext
  wend
     rs.close
 set rs=nothing

end function



function flink()
dim i,n
set rs = server.createobject("adodb.recordset")
  sql="select  * from pp_News where instr(sortpath,162)>0 and ViewFlag  order by id desc"
  rs.open sql,conn,1,3
  i=1
	for n=1 to 9  
	
   if i mod 3=0 then
   response.Write "<div style='float:left;margin-bottom:25px;width:140px; height:40px;border-bottom:1px solid #dddddd;'><a href='"&rs("source")&"' target='_blank'><img src='"&replace(rs("bigpic"),"../","")&"' width='130' height='40' border='0'/></a></div>"
   else
   response.Write "<div style='float:left;margin-bottom:25px;width:140px; height:40px;border-bottom:1px solid #dddddd;'><a href='"&rs("source")&"' target='_blank'><img src='"&replace(rs("bigpic"),"../","")&"' width='130' height='40' border='0'/><a></div><div style='float:left;margin:0px;padding:0px;width:1px;height:40px;background:#dddddd;'></div>"
   end if

   i=i+1
  rs.movenext
  next
     rs.close
 set rs=nothing

end function

function flinktxt()
dim i,n
set rs = server.createobject("adodb.recordset")
  sql="select  * from pp_News where instr(sortpath,163)>0 and ViewFlag  order by id desc"
  rs.open sql,conn,1,3
 response.Write "<div style='float:left;margin:0px;padding:0px;;width:870px;height:1px;overflow:hidden;clear:both;'></div>"
   while not rs.eof
   
   response.Write "<div style='float:left;margin-bottom:10px;width:120px; height:24px;'><a href='"&rs("source")&"' target='_blank'>"&rs("newsname")&"</a></div>"


  rs.movenext
  wend
     rs.close
 set rs=nothing

end function


  function snleft()

set rs = server.createobject("adodb.recordset")
  sql="select  * from pp_NewsSort where parentID=24 and ViewFlag  order by id desc"
  rs.open sql,conn,1,3
  
   while not rs.eof
  response.Write"<tr><td class='leftan'><a href='salesnetwork.asp?Sortid="&rs("id")&"'>"&rs("sortname")&"</a></td></tr>"
  rs.movenext
  wend
     rs.close
 set rs=nothing

end function

function joinleft()
dim SortPath,id
id=cint(request("id"))
SortPath=cint(request("SortPath"))
set rs = server.createobject("adodb.recordset")
  sql="select  * from pp_NewsSort where parentID=132 and ViewFlag  order by id asc"
  rs.open sql,conn,1,3
  
   while not rs.eof
    if rs("id")=id or id="" then
   response.write "<li id='current'><a href='join.asp?id="&rs("id")&"'><div class='main_left_li_bg'><p>"&rs("ensortname")&"</p></div></a></li>"
	else
	response.write "<li><a href='join.asp?id="&rs("id")&"'><div class='main_left_li_bg'><p>"&rs("ensortname")&"</p></div></a></li>"
 	end if
  rs.movenext
  wend
     rs.close
 set rs=nothing

end function
 function wleft()
dim SortPath
SortPath=cint(request("SortPath"))
set rs = server.createobject("adodb.recordset")
  sql="select  * from pp_NewsSort where parentID=100 and ViewFlag  order by id asc"
  rs.open sql,conn,1,3
  
   while not rs.eof
     response.Write"<div class=""menuLine""> &nbsp;&nbsp;&nbsp;&nbsp; <b><a href='ca.asp'>"&rs("sortname")&"</a></b></div>"
        set rs2 = server.createobject("adodb.recordset")
  sql2="select  * from pp_NewsSort where parentID="&rs("id")&" and ViewFlag  order by id asc"
  rs2.open sql2,conn,1,3
       while not rs2.eof
	      response.Write"<a class=""carLeft"" border=""0"" href=""ca.asp?sortid="&rs2("id")&"""  onMouseOver=""menuOver('L"&rs2("id")&"')"" onMouseOut=""menuOut('L"&rs2("id")&"')"">"
            response.Write" <div id='L"&rs2("id")&"' class=""menuLine""> &nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp; "&rs2("sortname")&"</div></a>"
	   
         rs2.movenext
       wend
	  response.Write"<div class='menuLine'></div>"
  rs.movenext
  wend
     rs.close
 set rs=nothing

end function
 function sleft()
dim SortPath
SortPath=cint(request("SortPath"))
set rs = server.createobject("adodb.recordset")
  sql="select  * from pp_NewsSort where parentID=110 and ViewFlag  order by id asc"
  rs.open sql,conn,1,3
  
   while not rs.eof
   
      response.Write"<li><a href='story.asp?SortPath="&rs("id")&"'>"&rs("sortname")&"</a></li>"

 
  rs.movenext
  wend
     rs.close
 set rs=nothing

end function
 function jleft()
dim SortPath
SortPath=cint(request("SortPath"))
set rs = server.createobject("adodb.recordset")
  sql="select  * from pp_NewsSort where parentID=111 and ViewFlag  order by id asc"
  rs.open sql,conn,1,3
  
   while not rs.eof
   
      response.Write"<li><a href='join.asp?SortPath="&rs("id")&"'>"&rs("sortname")&"</a></li>"

 
  rs.movenext
  wend
     rs.close
 set rs=nothing

end function
 function cleft()
dim SortPath
SortPath=cint(request("SortPath"))
set rs = server.createobject("adodb.recordset")
  sql="select  * from pp_NewsSort where parentID=97 and ViewFlag  order by id asc"
  rs.open sql,conn,1,3
  
   while not rs.eof
   
      response.Write"<li><a href='contact.asp?SortPath="&rs("id")&"'>"&rs("sortname")&"</a></li>"

 
  rs.movenext
  wend
     rs.close
 set rs=nothing

end function
function tp(id)
set rs = server.createobject("adodb.recordset")
  sql="select  * from pp_ny where ViewFlag  and id="&id
  rs.open sql,conn,1,1
  
 while not rs.eof 
 
      response.Write replace(rs("enbigpic"),"../","")

  rs.movenext
  wend
     rs.close
 set rs=nothing

end Function

function aboutleft()
dim id
If request.queryString("id")<>"" Then
	id=cint(request("id"))
Else
	id=53
End If

set rs = server.createobject("adodb.recordset")
  sql="select * from pp_About where ViewFlag  order by id asc "
  rs.open sql,conn,1,1
  
 while not rs.eof
		If rs("id")=id Then
		'if rs("id")=57 then
			'response.Write "<li><a href='aboutlist.asp'><p>"&rs("aboutname")&"</p></a></li>"
		'else
		response.Write("<li class='divAboutLNavSel'><a href='about.asp?id="&rs("id")&"'>"&rs("aboutname")&"</a></li>")
		Else
		response.Write("<li class='divAboutLNavNor'><a href='about.asp?id="&rs("id")&"'>"&rs("aboutname")&"</a></li>")

		End If
			'response.Write "<li><a href='about.asp?id="&rs("id")&"'><p>"&rs("aboutname")&"</p></a></li>"
		'end if
	  rs.movenext

  wend
     rs.close
 set rs=nothing

end function
function aboutdanqian()
dim rs,sql,id
 id=Trim(Request.QueryString("id"))
set rs = server.createobject("adodb.recordset")
 if id<>"" then 
 sql="select * from pp_About where id="&id 
  else
 sql="select * from pp_About where id=53 " 
  end if
  rs.open sql,conn,1,3
  
   while not rs.eof
  response.Write rs("aboutname")
  rs.movenext
  wend
     rs.close
 set rs=nothing

end function

function aboutlist()
dim rs,sql,id

set rs = server.createobject("adodb.recordset")
 sql="select * from pp_About where id<>40"
  rs.open sql,conn,1,3
  
   while not rs.eof
  response.Write "<LI><A HREF='company.asp?id="&rs("id")&"'>"&rs("enaboutname")&"</A></LI>"
  rs.movenext
  wend
     rs.close
 set rs=nothing

end function


function serviceleft()
dim id
id=cint(request("id"))
set rs = server.createobject("adodb.recordset")
  'sql="select * from pp_news where ViewFlag and instr(sortpath,137)>0  order by id asc "
  sql="select  * from pp_NewsSort where parentID=137 and ViewFlag  order by id asc"
  rs.open sql,conn,1,1
  
 while not rs.eof  

   'response.Write "<li><a href='service.asp?id="&rs("id")&"'><p>"&rs("newsname")&"</p></a></li>"
   response.Write "<li><a href='service.asp?id="&rs("id")&"'><p>"&rs("sortname")&"</p></a></li>"

  rs.movenext
  wend
     rs.close
 set rs=nothing

end function



function sales()
dim rs,sql,id
 id=Trim(Request.QueryString("id"))
set rs = server.createobject("adodb.recordset")
if id<>"" then 
 sql="select * from pp_About where id="&id 
  else
 sql="select * from pp_About where id=40 " 
  end if
  rs.open sql,conn,1,3
  if rs("encontent")<>"" then
  response.Write rs("encontent")
  else
   response.Write"Data update......"
end if
  rs.close
 set rs=nothing
end function
function Privacy()
dim rs,sql,id
 id=Trim(Request.QueryString("id"))
set rs = server.createobject("adodb.recordset")
if id<>"" then 
 sql="select * from pp_About where id="&id 
  else
 sql="select * from pp_About where id=37 " 
  end if
  rs.open sql,conn,1,3
  if rs("content")<>"" then
  response.Write rs("content")
  else
   response.Write"Data update......"
end if
  rs.close
 set rs=nothing
end function
function about()
dim rs,sql,id
 id=Trim(Request.QueryString("id"))
set rs = server.createobject("adodb.recordset")
if id<>"" then 
 sql="select * from pp_About where id="&id 
  else
 sql="select * from pp_About where id=53 " 
  end if
  rs.open sql,conn,1,3
  if rs("content")<>"" then
  response.Write rs("content")
  else
   response.Write"Data update......"
end if
  rs.close
 set rs=nothing
end function
function serverview()
dim rs,sql,id
 id=Trim(Request.QueryString("id"))
set rs = server.createobject("adodb.recordset")
if id<>"" then 
 sql="select * from pp_news where sortid="&id 
  else
 sql="select * from pp_news where sortid=149 " 
  end if
  rs.open sql,conn,1,3
  if rs("content")<>"" then
  response.Write rs("content")
  else
   response.Write"Data update......"
end if
  rs.close
 set rs=nothing
end function


function joblistview()
dim rs,sql,id
 id=Trim(Request.QueryString("id"))
set rs = server.createobject("adodb.recordset")
if id<>"" then 
 sql="select * from pp_news where sortid="&id 
  else
 sql="select * from pp_news where sortid=179 " 
  end if
  rs.open sql,conn,1,3
  if rs("content")<>"" then
  response.Write rs("content")
  else
   response.Write"资料更新中......"
end if
  rs.close
 set rs=nothing
end function

function joinview()
dim rs,sql,id
 id=Trim(Request.QueryString("id"))
set rs = server.createobject("adodb.recordset")
if id<>"" then 
 sql="select * from pp_news where sortid="&id 
  else
 sql="select * from pp_news where sortid=133 "
  end if
  rs.open sql,conn,1,3
  if rs("content")<>"" then
  response.Write rs("content")
  else
   response.Write"Data update......"
end if
  rs.close
 set rs=nothing
end function
function Terms()
dim rs,sql,id
 id=Trim(Request.QueryString("id"))
set rs = server.createobject("adodb.recordset")
if id<>"" then 
 sql="select * from pp_About where id="&id 
  else
 sql="select * from pp_About where id=31 " 
  end if
  rs.open sql,conn,1,3
  if rs("content")<>"" then
  response.Write rs("content")
  else
   response.Write"Data update......"
end if
  rs.close
 set rs=nothing
end function
function news()

  dim SortPath
      SortPath=Trim(request.QueryString("id"))
  dim idCount'记录总数
  dim pages'每页条数
      pages=10
  dim pagec'总页数
  dim page'页码
      page=clng(request("Page"))
  dim pagenc'每页显示的分页页码数量=pagenc*2+1
      pagenc=2
  dim pagenmax'每页显示的分页的最大页码
  dim pagenmin'每页显示的分页的最小页码
  dim datafrom'数据表名
      datafrom="PP_News"
  dim datawhere'数据条件
      if SortPath<>"" then'是否查看的分类产品
		 datawhere="where ViewFlag and Instr(SortPath,'"&SortPath&"')>0 "
      else
		 datawhere="where ViewFlag and Instr(SortPath,144)>0 "
	  end if
  dim sqlid'本页需要用到的id
  dim Myself,PATH_INFO,QUERY_STRING,Addtime'本页地址和参数
      PATH_INFO = request.servervariables("PATH_INFO")
	  QUERY_STRING = request.ServerVariables("QUERY_STRING")'
      if QUERY_STRING = "" then
	    Myself = PATH_INFO & "?"
	  elseif Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")=0 then
	    Myself= PATH_INFO & "?" & QUERY_STRING & "&"
	  else
	    Myself = Left(PATH_INFO & "?" & QUERY_STRING,Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")-1)
	  end if
  dim taxis'排序的语句 asc,desc
      taxis="order by id desc "
  dim i'用于循环的整数
  dim rs,sql'sql语句
  '获取记录总数
  sql="select count(ID) as idCount from ["& datafrom &"]" & datawhere
  set rs=server.createobject("adodb.recordset")
  rs.open sql,conn,0,1
  idCount=rs("idCount")
  '获取记录总数

  if(idcount>0) then'如果记录总数=0,则不处理
    if(idcount mod pages=0)then'如果记录总数除以每页条数有余数,则=记录总数/每页条数+1
	  pagec=int(idcount/pages)'获取总页数
   	else
      pagec=int(idcount/pages)+1'获取总页数
    end if
	'获取本页需要用到的id============================================
    '读取所有记录的id数值,因为只有id所以速度很快
    sql="select id from ["& datafrom &"] " & datawhere & taxis
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,1,1
    rs.pagesize = pages '每页显示记录数
    if page < 1 then page = 1
    if page > pagec then page = pagec
    if pagec > 0 then rs.absolutepage = page  
    for i=1 to rs.pagesize
	  if rs.eof then exit for  
	  if(i=1)then
	    sqlid=rs("id")
	  else
	    sqlid=sqlid &","&rs("id")
	  end if
	  rs.movenext
    next
  '获取本页需要用到的id结束============================================
  end if
  Response.Write "<table width='98%' border='0' cellspacing='0' cellpadding='0' style='margin-left:1%;clear:both;'>"
  if(idcount>0 and sqlid<>"") then'如果记录总数=0,则不处理
    '用in刷选本页所语言的数据,仅读取本页所需的数据,所以速度快
    sql="select * from ["& datafrom &"] where id in("& sqlid &") "&taxis
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,0,1
    while not rs.eof '填充数据到表格
	Addtime=year(rs("AddTime"))&"-"&month(rs("AddTime"))&"-"&day(rs("AddTime"))
	  Response.Write "<tr>" & vbCrLf
      Response.Write "<td width='400' height=30 ><a href='NewsView.asp?ID="&rs("ID")&"&SortID="&rs("SortID")&"' style='width:300px;color:#444444'>"&rs("NewsName")&"</a></td>" & vbCrLf
      Response.Write "<td width='185' style='border-bottom:#cccccc 1px dashed'><font color=#444444>添加日期："&rs("addtime")&"</font></td>" & vbCrLf
      Response.Write "</tr>" & vbCrLf
	  rs.movenext
    wend
  else
    response.write "<tr><td align='center'>暂无相关信息</td></tr></table>"
	exit function
  end if
  Response.Write "<tr style='height:30px;line-height:30px;padding-right:30px;'>" & vbCrLf
  Response.Write "<td colspan='2' align='right' style='color:#444444'>" & vbCrLf
  Response.Write "<div class='nav'></div>" & vbCrLf
  Response.Write "共计：<font color='#ff6600'>"&idcount&"</font>条记录&nbsp;页次：<font color='#ff6600'>"&page&"</font></strong>/"&pagec&"&nbsp;每页：<font color='#ff6600'>"&pages&"</font>条&nbsp;&nbsp;&nbsp;&nbsp;" & vbCrLf
  pagenmin=page-pagenc '计算页码开始值
  pagenmax=page+pagenc '计算页码结束值
  if(pagenmin<1) then pagenmin=1 '如果页码开始值小于1则=1
  if(page>1) then response.write ("<a href='"& myself &"Page=1'><font style='FONT-SIZE: 14px; FONT-FAMILY: Webdings'>9</font></a>&nbsp;") '如果页码大于1则显示(第一页)
  if(pagenmin>1) then response.write ("<a href='"& myself &"Page="& page-(pagenc*2+1) &"'><font style='FONT-SIZE: 14px; FONT-FAMILY: Webdings'>7</font></a>&nbsp;") '如果页码开始值大于1则显示(更前)
  if(pagenmax>pagec) then pagenmax=pagec '如果页码结束值大于总页数,则=总页数
  for i = pagenmin to pagenmax'循环输出页码
	if(i=page) then
	  response.write ("&nbsp;<font color='#ff6600'>"& i &"</font>&nbsp;")
	else
	  response.write ("[<a href="& myself &"Page="& i &">"& i &"</a>]")
	end if
  next
  if(pagenmax<pagec) then response.write ("&nbsp;<a href='"& myself &"Page="& page+(pagenc*2+1) &"'><font style='FONT-SIZE: 14px; FONT-FAMILY: Webdings'>8</font></a>&nbsp;") '如果页码结束值小于总页数则显示(更后)
  if(page<pagec) then response.write ("<a href='"& myself &"Page="& pagec &"'><font style='FONT-SIZE: 14px; FONT-FAMILY: Webdings'>:</font></a>") '如果页码小于总页数则显示(最后页)	
  Response.Write "</td>" & vbCrLf
  Response.Write "</tr>" & vbCrLf
  Response.Write "</table>" & vbCrLf
  rs.close
  set rs=nothing
end function 
function newsview()
dim ID,content,numbers,pagenum,maxpage,requestpage,thispage,sid
dim rs,sql
sid=request.QueryString("sid")
  ID=cint(Request("ID"))
  if ID=0 or (not isnumeric(ID)) then
    response.write "<div align='center'>数据读取异常错误</div>"
    exit function
  end if
  set rs = server.createobject("adodb.recordset")
  sql="select * from pp_News where ViewFlag and id="&ID
  rs.open sql,conn,1,3
	if not rs.eof then
	numbers=len(rs("content"))  '总字节数
	pagenum=Sitenum            '每页显示的数量
	maxpage=-int(-numbers/pagenum)'总页数
	requestpage=clng(request("p"))'接收页码
	if requestpage="" or requestpage=0 then'获取默认页码
	requestpage=1
	end if
	if requestpage>maxpage then  '当前页的页码大于最大页码时，使当前页码等于最大页码
	requestpage=maxpage
	end if
	if not requestpage=1 then  '当前页码不等于1时，向下移动相应的字节数
	content=mid(rs("content"),(requestpage-1)*pagenum+1,Sitenum)
	else
	content=left(rs("content"),Sitenum) '当页码等于1时，截取相应文本
	end if
	if isempty(requestpage) then  
             thispage=1  
            else  
             thispage=cint(requestpage)  
     end if  
    response.write"<table width='100%' border='0' cellspacing='0' cellpadding='0' style='color:#222222' style=' border-collapse:collapse;font-size:12px;margin-left:4%;' >"
    response.write "<tr><td align='center' colspan='2' height=40><font style='font-size:14px;font-weight: bold;color: #790C2A'>"&rs("NewsName")&"</font></td></tr>"
    response.write "<tr><td align='center' colspan='2'><div style='float:left;margin-left:35%;display:inline;color:#222222;'>&nbsp;&nbsp;&nbsp;&nbsp;点击数："&rs("ClickNumber")&"&nbsp;&nbsp;&nbsp;&nbsp;更新时间："& year(rs("addtime"))&"-"&right(("0"&month(rs("addtime"))),2)&"-"&right(("0"&day(rs("addtime"))),2)&"&nbsp;&nbsp;&nbsp;&nbsp;</div><div style='float:left;'><a style='cursor:hand'  onclick='window.external.AddFavorite(location.href,document.title);' >收藏此页</a></div></td></tr>"
	response.write "<tr><td colspan='2'><div  style='border-bottom:#cccccc 1px dashed'>&nbsp;</div></td></tr>"
   
	  response.write "<tr><td colspan='2' style='line-height:200%;' align=left ><div style=' color:#000000;  padding-right:20px'><br>"
	 ' if rs("bigpic")<>"" then
	 '  response.write "<img src='"&replace(rs("bigpic"),"../","")&"' style='text-align:center'><br>"
	'end if
	   
	  
      response.write "<div style='margin-left:20px;color:#222222;'>"&rs("content")&"</div>"
	  response.write "</div></td></tr>"
	  rs("ClickNumber")=rs("ClickNumber")+1

	rs.update	
  else 
    response.write "<tr><td>暂无相关信息</td></tr>"
  end if

  rs.close

  response.write"</table>"

  set rs=nothing
  end function
  
  function newss()
dim ID,content,numbers,pagenum,maxpage,requestpage,thispage,sid
dim rs,sql
sid=request.QueryString("sid")

  ID=cint(Request("ID"))
  
  set rs = server.createobject("adodb.recordset")


  	  if ID=0 or (not isnumeric(ID)) then
	  sql="select top 1 * from pp_News where ViewFlag and instr(sortpath,145)>0 order by id desc"
	  else
	  sql="select top 1 * from pp_News where ViewFlag and instr(sortpath,"&ID&")>0 order by id desc"
		end if

  rs.open sql,conn,1,3
	if not rs.eof then
	numbers=len(rs("content"))  '总字节数
	pagenum=Sitenum            '每页显示的数量
	maxpage=-int(-numbers/pagenum)'总页数
	requestpage=clng(request("p"))'接收页码
	if requestpage="" or requestpage=0 then'获取默认页码
	requestpage=1
	end if
	if requestpage>maxpage then  '当前页的页码大于最大页码时，使当前页码等于最大页码
	requestpage=maxpage
	end if
	if not requestpage=1 then  '当前页码不等于1时，向下移动相应的字节数
	content=mid(rs("content"),(requestpage-1)*pagenum+1,Sitenum)
	else
	content=left(rs("content"),Sitenum) '当页码等于1时，截取相应文本
	end if
	if isempty(requestpage) then  
             thispage=1  
            else  
             thispage=cint(requestpage)  
     end if  
    response.write"<table width='100%' border='0' cellspacing='0' cellpadding='0' style='color:#222222' style=' border-collapse:collapse;font-size:12px;margin-left:4%;' >"
    response.write "<tr><td align='center' colspan='2' height=40><font style='font-size:14px;font-weight: bold;color: #790C2A'>"&rs("NewsName")&"</font></td></tr>"
  
	response.write "<tr><td colspan='2'><div  style='border-bottom:#cccccc 1px dashed'>&nbsp;</div></td></tr>"
   
	  response.write "<tr><td colspan='2' style='line-height:200%;' align=left ><div style=' color:#000000;  padding-right:20px'><br>"
	   
	  
      response.write "<div style='margin-left:20px;color:#222222;'>"&rs("content")&"</div>"
	  response.write "</div></td></tr>"
	  rs("ClickNumber")=rs("ClickNumber")+1

	rs.update	
  else 
    response.write "<tr><td>暂无相关信息</td></tr>"
  end if

  rs.close

  response.write"</table>"

  set rs=nothing
  end function
  
  
    function aboutview()
dim content,numbers,pagenum,maxpage,requestpage,thispage,aid
dim rs,sql
aid=cint(request("aid"))
  
  set rs = server.createobject("adodb.recordset")

 if aid<>0 then
  sql="select * from pp_News where ViewFlag and id="&aid
 end if
  rs.open sql,conn,1,3
	if not rs.eof then

    response.write"<table width='92%' border='0' cellspacing='0' cellpadding='0' style='color:#222222' style=' border-collapse:collapse;font-size:12px;margin-left:4%;' >"
    response.write "<tr><td align='center' colspan='2' height=40><font style='font-size:14px;font-weight: bold;color: #790C2A'>"&rs("NewsName")&"</font></td></tr>"
  
	response.write "<tr><td colspan='2'><div style='border-bottom:#cccccc 1px dashed'>&nbsp;</div></td></tr>"
   
	  response.write "<tr><td colspan='2' style='line-height:200%;' align=left ><div style=' color:#000000;  padding-right:20px;text-align:center;'><br>"
	'  if rs("bigpic")<>"" then
	'   response.write "<img src='"&replace(rs("bigpic"),"../","")&"' style='text-align:center'><br>"
	'end if
	   
	  
      response.write "<div style='margin-left:20px;color:#222222;width:100%;text-align:left;'>"&rs("content")&"</div>"
	  response.write "</div></td></tr>"

  else 
    response.write "<tr><td>暂无相关信息</td></tr>"
  end if

  rs.close

  response.write"</table>"

  set rs=nothing
  end function
  
 function newsview2222()
dim ID,content,numbers,pagenum,maxpage,requestpage,thispage,SortID
SortID=request.QueryString("SortID")
  ID=Request("ID")
  if ID="" or (not isnumeric(ID)) then
    response.write "<div align='center'>Data access exception error</div>"
    exit function
  end if
  dim rs,sql
  set rs = server.createobject("adodb.recordset")
  sql="select * from pp_News where ViewFlag and ID="&ID
  rs.open sql,conn,1,3
	if not rs.eof then
	numbers=len(rs("content"))  '总字节数
	pagenum=Sitenum            '每页显示的数量
	maxpage=-int(-numbers/pagenum)'总页数
	requestpage=clng(request("p"))'接收页码
	if requestpage="" or requestpage=0 then'获取默认页码
	requestpage=1
	end if
	if requestpage>maxpage then  '当前页的页码大于最大页码时，使当前页码等于最大页码
	requestpage=maxpage
	end if
	if not requestpage=1 then  '当前页码不等于1时，向下移动相应的字节数
	content=mid(rs("content"),(requestpage-1)*pagenum+1,Sitenum)
	else
	content=left(rs("content"),Sitenum) '当页码等于1时，截取相应文本
	end if
	if isempty(requestpage) then  
             thispage=1  
            else  
             thispage=cint(requestpage)  
     end if  
    response.write"<table width='100%' border='0' cellspacing='0' cellpadding='0'>"
    response.write "<tr><td align='center' colspan='2' height=40><font style='font-size:14px;font-weight: bold;color: #ff0000'>"&rs("NewsName")&"</font></td></tr>"
    response.write "<tr><td align='center' colspan='2'>新闻来源："&rs("Source")&"&nbsp;&nbsp;&nbsp;&nbsp;点击数："&rs("ClickNumber")&"&nbsp;&nbsp;&nbsp;&nbsp;更新时间："&rs("AddTime")&"&nbsp;&nbsp;&nbsp;&nbsp;<a style='cursor:hand'  onclick='window.external.AddFavorite(location.href,document.title);' >收藏此页</a></td></tr>"
	response.write "<tr><td colspan='2'><hr width='100%' size='1' noshade='noshade' color='#cccccc'></td></tr>"
    if ViewNoRight(rs("GroupID"),rs("Exclusive")) then
	  response.write "<tr><td colspan='2'>"
	  %>
     <%=Replace(content,chr(13),"")%>
	 <% response.write "</td></tr>"
	  rs("ClickNumber")=rs("ClickNumber")+1
	else
	  response.write "<tr><td colspan='2'><div align='center'></div></td></tr>"
	end if
    response.write "<tr><td height='25' align='right' >"
	response.write "总页数：<font color=red>"&maxpage&"</font>&nbsp;&nbsp;第&nbsp;&nbsp;" 
	  for i=1 to maxpage
         if thispage=i then  
          response.write ""&i&"&nbsp;&nbsp;"  
         else 
      response.write "<a href='?p="&i&"&ID="&ID&"&SortID="&Request("SortID")&"'>"&i&"</a>&nbsp;&nbsp;"
	   end if
	   next
   	response.write "&nbsp;&nbsp;页&nbsp;</td><td width='10%'><a href='#TOP'><img src='Images/Button_top_01.gif' align='absbottom' border='0'></a></td></tr>" 
	rs.update	
  else 
    response.write "<tr><td>暂无相关信息</td></tr>"
  end if
  response.write "<tr><td colspan='2'><hr width='600px' size='1' noshade='noshade' color='#cccccc'></td></tr><tr><td colspan='2'>"
  rs.close
    Dim IDmax,IDmin,rs1
'获取上一个,取ID比当前ID大的第一个同类资讯,因为新闻资讯排序是按ID逆序排列的,感观上的上一个其实是ID要比当前大的
   rs1=server.CreateObject("adodb.recordset")   
 sql="select top 1 * from pp_News where ViewFlag and SortID="&SortID&" and ID>"&ID&" order by ID"
    set rs1=conn.execute(sql)   
    if rs1.eof then   
  Response.Write "上一篇：没有上一篇资讯了&nbsp;&nbsp;&nbsp;"
 else
     IDmin=rs1("ID") 
  Response.Write "上一篇：<a href='?id="&IDmin&"&SortID="&rs1("SortID")&"'><font color='#FF0000'>"&rs1("NewsName")&"</font></a>&nbsp;&nbsp;&nbsp;"
 end if
 set rs1=nothing
'获取下一个,取ID比当前ID小的第一个同类资讯,因为新闻资讯排序是按ID逆序排列的,感观上的下一个其实是ID要比当前小的
 set rsn = server.createobject("adodb.recordset")
 sql="select top 1 * from pp_News where ViewFlag and SortID="&SortID&" and ID<"&ID&" order by ID desc"
    set rsn=conn.execute(sql)   
 if rsn.eof then
  Response.Write "下一篇：没有下一篇资讯了"
 else
     IDmax=rsn("ID") 
  Response.Write "下一篇：<a href='?id="&IDmax&"&SortID="&rsn("SortID")&"'><font color='#FF0000'>"&rs1("NewsName")&"</font></a>"
 end if
 set rsn=nothing

  response.write "<tr><td colspan='2' align='right'> <a onClick='history.go(0)'>【刷新页面】</a><a style='cursor:hand'  onclick='window.external.AddFavorite(location.href,document.title);' >【加入收藏】</a><A href='javascript:window.print();'>【打印此文】</A> <a onClick='window.self.close()'>【关闭窗口】</a></td></tr>"
  response.write"</td></tr></table>"

  set rs=nothing
  end function


function service()
dim rs,sql,sortid
sortid=Trim(Request.QueryString("id"))
set rs = server.createobject("adodb.recordset")
if sortid<>"" then 
 sql="select * from pp_news where sortid="&sortid
  else
 sql="select * from pp_news where sortid=99 " 
end if
  rs.open sql,conn,1,1
 If rs.Eof And rs.bof Then 
response.write"数据更新中..."
  
  end if
if rs.RecordCount=1 then
  if rs("encontent")<>"" then
  response.Write rs("encontent")
  else
   response.Write"Data update......"
   end if
else
page=Trim(Request.QueryString("Page"))
If Request("Page")<>"" Then
If Cint(Request("Page"))<1 Then
CurrentPage=1
Else
CurrentPage=Cint(Request("Page"))
End If
End If
If Request("Page")="" Then
CurrentPage=1
End If
dim strnews,plist_bottom
PageCount1=1
Totalnumber=0

Maxperpage=10
rs.Pagesize=MaxperPage
PageCount1=Rs.PageCount
rs.Move  (CurrentPage-1)*MaxperPage
Totalnumber=rs.RecordCount
N=0

plist_bottom=plist_bottom&"<div style='padding-right:15px; margin-top:15px;margin-left:380px'>"
plist_bottom=plist_bottom&"[<b>"&CurrentPage&"</b>/<b>"&PageCount1&"</b>]页"
Pageno=CurrentPage
If cint(Pageno)>1 Then
plist_bottom=plist_bottom&"<a href='service.asp?sortid="&sortid&"'title=""index"">"
End If
plist_bottom=plist_bottom&"[主页]</a>&nbsp;"
If Cint(Pageno)>1 Then
plist_bottom=plist_bottom&"<a href=service.asp?sortid="&sortid&"&page="&Pageno-1&" title=""Previous"">"
End If
plist_bottom=plist_bottom&"[上一页]</a>&nbsp;"
If Cint(Pageno)< PageCount1 Then
plist_bottom=plist_bottom&"<a href=service.asp?sortid="&sortid&"&page="&Pageno+1&" title=""Next"">"
End If
plist_bottom=plist_bottom&"[下一页]</a>&nbsp;"
If Cint(Pageno)< Pagecount1 Then
plist_bottom=plist_bottom&"<a href='service.asp?sortid="&sortid&"&page="&PageCount1&"' title=""Last"">"
End If
plist_bottom=plist_bottom&"[尾页]</a>"
plist_bottom=plist_bottom&"</div>"

response.write"<div style='width:600px;height:300px; '>"
Row_Count=1
do while not rs.eof
dim NewsName
	   if StrLen(Removehtml(rs("enNewsName")))<=80 then
        NewsName=Removehtml(rs("enNewsName"))
	  else 
	    NewsName=StrLeft(Removehtml(Removehtml(rs("enNewsName"))),79)
	   end if
response.Write"<li style='float:left;list-style-type:none;margin-top:5px;padding:3px;width:330px;margin-left:12px'><img src='images/sc1.gif' > &nbsp;&nbsp;<a href='serviceview.asp?SortID="&rs("SortID")&"&id="&rs("id")&"'>"&NewsName&"</a></li><li style='list-style-type:none;width:190px;float:RIGHT;border-bottom:#cccccc 1px dashed'>添加时间："&formatdatetime(rs("AddTime"),2)&"</li>"
  
row_count=row_count+1
if n>=MaxPerPage then exit do
rs.movenext
loop
 response.write"</div>"
response.write plist_bottom
end if
  rs.close
 set rs=nothing
end function

function joins()
dim rs,sql,sortid
sortid=Trim(Request.QueryString("sortpath"))
set rs = server.createobject("adodb.recordset")
if sortid<>"" then 
 sql="select * from pp_news where sortid="&sortid
  else
 sql="select * from pp_news where sortid=67 " 
end if
  rs.open sql,conn,1,1
 If rs.Eof And rs.bof Then 
response.write"Data update...."
  
  end if
if rs.RecordCount=1 then
  if rs("content")<>"" then
  response.Write rs("content")
  else
   response.Write"Data update......"
   end if
else
page=Trim(Request.QueryString("Page"))
If Request("Page")<>"" Then
If Cint(Request("Page"))<1 Then
CurrentPage=1
Else
CurrentPage=Cint(Request("Page"))
End If
End If
If Request("Page")="" Then
CurrentPage=1
End If
dim strnews,plist_bottom
PageCount1=1
Totalnumber=0

Maxperpage=10
rs.Pagesize=MaxperPage
PageCount1=Rs.PageCount
rs.Move  (CurrentPage-1)*MaxperPage
Totalnumber=rs.RecordCount
N=0

plist_bottom=plist_bottom&"<div style='padding-right:15px; margin-top:15px;margin-left:380px'>"
plist_bottom=plist_bottom&"[<b>"&CurrentPage&"</b>/<b>"&PageCount1&"</b>]pages"
Pageno=CurrentPage
If cint(Pageno)>1 Then
plist_bottom=plist_bottom&"<a href='service.asp?sortid="&sortid&"'title=""index"">"
End If
plist_bottom=plist_bottom&"[主页]</a>&nbsp;"
If Cint(Pageno)>1 Then
plist_bottom=plist_bottom&"<a href=service.asp?sortid="&sortid&"&page="&Pageno-1&" title=""Previous"">"
End If
plist_bottom=plist_bottom&"[上一页]</a>&nbsp;"
If Cint(Pageno)< PageCount1 Then
plist_bottom=plist_bottom&"<a href=service.asp?sortid="&sortid&"&page="&Pageno+1&" title=""Next"">"
End If
plist_bottom=plist_bottom&"[下一页]</a>&nbsp;"
If Cint(Pageno)< Pagecount1 Then
plist_bottom=plist_bottom&"<a href='oem.asp?sortid="&sortid&"&page="&PageCount1&"' title=""Last"">"
End If
plist_bottom=plist_bottom&"[尾页]</a>"
plist_bottom=plist_bottom&"</div>"

response.write"<div style='width:650px;height:300px; '>"
Row_Count=1
do while not rs.eof
dim NewsName
	   if StrLen(Removehtml(rs("NewsName")))<=80 then
        NewsName=Removehtml(rs("NewsName"))
	  else 
	    NewsName=StrLeft(Removehtml(Removehtml(rs("NewsName"))),79)
	   end if
 response.Write"<li style='float:left ;border-bottom:1px solid #CCCCCC;list-style-type:none;margin-top:5px;padding:3px;width:540px;margin-left:2px'><img src='images/tit.jpg' >&nbsp;&nbsp;<a href='joinview.asp?id="&rs("id")&"&sortid="&rs("sortid")&"'>"&NewsName&"</a></li><li style='list-style-type:none;width:80px;float:left ;'>"&formatdatetime(rs("AddTime"),2)&"</li>"
  
row_count=row_count+1
if n>=MaxPerPage then exit do
rs.movenext
loop
 response.write"</div>"
response.write plist_bottom
end if
  rs.close
 set rs=nothing
end function

function search() 


 dim rs,sql,page,key
key=Trim(Request("key"))
page=Trim(Request.QueryString("Page"))

If Request("Page")<>"" Then
If Cint(Request("Page"))<1 Then
CurrentPage=1
Else
CurrentPage=Cint(Request("Page"))
End If
End If
If Request("Page")="" Then
CurrentPage=1
End If
dim strnews,plist_bottom

Set rs=Server.CreateObject("ADODB.RecordSet")

  sql="select * from pp_Products where  ViewFlag and productname like '%"&key&"%' order by Sequence asc"

   rs.open sql,conn,1,1
If rs.Eof And rs.bof Then


response.write"<Div style='margin-top:20px;text-align:center'>No products</DIV>"
PageCount1=1
Totalnumber=0
Else

Maxperpage=4
rs.Pagesize=MaxperPage
PageCount1=Rs.PageCount
rs.Move  (CurrentPage-1)*MaxperPage
Totalnumber=rs.RecordCount
N=0

plist_bottom=plist_bottom&"<table style='width:100%;clear:both;'><tr><td><div style=' padding-left:422px'>"
plist_bottom=plist_bottom&"[ <b>"&CurrentPage&"</b>/<b>"&PageCount1&"</b> ]&nbsp;"
Pageno=CurrentPage
If cint(Pageno)>1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href='product.asp?sortid="&sortid&"&sortpath="&sortpath&"'title=""index"">"
else
plist_bottom=plist_bottom&"<a href='product.asp'title=""index"">"
end if
End If
plist_bottom=plist_bottom&"[ 首页 ]</a>&nbsp;"
If Cint(Pageno)>1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href=product.asp?page="&Pageno-1&"&sortid="&sortid&"&sortpath="&sortpath&" title=""Previous"">"
else
plist_bottom=plist_bottom&"<a href=product.asp?page="&Pageno-1&" title=""Previous"">"
end if
End If
plist_bottom=plist_bottom&"[ 上一页 ]</a>&nbsp;"
If Cint(Pageno)< PageCount1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href=product.asp?page="&Pageno+1&"&sortid="&sortid&"&sortpath="&sortpath&" title=""Next"">"
else
plist_bottom=plist_bottom&"<a href=product.asp?page="&Pageno+1&" title=""Next"">"
End If
End If
plist_bottom=plist_bottom&"[ 下一页 ]</a>&nbsp;"
If Cint(Pageno)< Pagecount1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href='product.asp?page="&PageCount1&"&sortid="&sortid&"&sortpath="&sortpath&"' title=""Last"">"
else
plist_bottom=plist_bottom&"<a href='product.asp?page="&PageCount1&"' title=""Last"">"
End If
End If
plist_bottom=plist_bottom&"[ 末页 ]</a>"
plist_bottom=plist_bottom&"</div></td></tr></table>"

Row_Count=1
do while not rs.eof
N=N+1
	      if n=3 and n=6 then
   response.write"<br>"
   end if

	 if StrLen(Removehtml(rs("ProductName")))<=18 then
        ProductName=Removehtml(rs("ProductName"))
	  else 
	     ProductName=StrLeft(Removehtml(Removehtml(rs("ProductName"))),17)
	   end if
	   
	   
   response.Write "<div class='main_line_r_con_probox'><div class='main_line_r_con_probox_img'><a href='productview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'><img src='"&rs("smallpic")&"' width='161px' height='112px' border='0'/></a></div><div class='main_line_r_con_probox_txt'><a href='productview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'>"&ProductName&"</a></div></div>"
   
  
row_count=row_count+1
if n>=MaxPerPage then exit do
rs.movenext
loop
rs.close
response.write plist_bottom
end if
end function

function indexproduct() 
 dim rs,sql,names
Set rs=Server.CreateObject("ADODB.RecordSet") 
  sql="select top 1 * from pp_Products where  ViewFlag and Exclusive order by id desc"
   rs.open sql,conn,1,1
If rs.Eof And rs.bof Then
response.write"<Div style='margin-top:20px;text-align:center'>暂无产品</DIV>"
Else
do while not rs.eof

if StrLen(Removehtml(rs("indexcon")))<=80 then
         indexcon=Removehtml(rs("indexcon"))
	  else 
	     indexcon=StrLeft(Removehtml(Removehtml(rs("indexcon"))),79)
	   end if

	response.Write "<div id='index_pro_list'><div id='index_pro_img'><a href='product.asp?sid="&rs("sortid")&"&pid="&rs("id")&"'><img src='"&replace(rs("smallpic"),"../","")&"' width='128' height='84' border='0' alt='"&rs("productname")&"' title='新绿洲优质木地板推荐："&rs("productname")&"'/></a></div><div id='index_pro_txt_box'><div id='index_pro_tit'>"&rs("productname")&"</div><div id='index_pro_txt_c'><p>"&indexcon&"</p></div></div></div>"	
rs.movenext
loop
end if
rs.close
end function

function indexnewproduct() 
 dim rs,sql,names
Set rs=Server.CreateObject("ADODB.RecordSet") 
  sql="select top 1 * from pp_Products where  ViewFlag and Exclusive2 order by id desc"
   rs.open sql,conn,1,1
If rs.Eof And rs.bof Then
response.write"<Div style='margin-top:20px;text-align:center'>暂无产品</DIV>"
Else
do while not rs.eof

if StrLen(Removehtml(rs("indexcon")))<=80 then
         indexcon=Removehtml(rs("indexcon"))
	  else 
	     indexcon=StrLeft(Removehtml(Removehtml(rs("indexcon"))),79)
	   end if
	   
	response.Write "<div id='index_pro_list2'><div id='index_pro_img'><a href='product.asp?sid="&rs("sortid")&"&pid="&rs("id")&"'><img src='"&replace(rs("smallpic"),"../","")&"' width='128' height='84' border='0' alt='"&rs("productname")&"' title='新绿洲优质木地板推荐："&rs("productname")&"'/></a></div><div id='index_pro_txt_box'><div id='index_pro_tit'>"&rs("productname")&"</div><div id='index_pro_txt_c'><p>"&indexcon&"</p></div></div></div>"	
rs.movenext
loop
end if
rs.close
end function


function newproduct() 

 dim rs,sql,page

page=Trim(Request.QueryString("Page"))
If Request("Page")<>"" Then
If Cint(Request("Page"))<1 Then
CurrentPage=1
Else
CurrentPage=Cint(Request("Page"))
End If
End If
If Request("Page")="" Then
CurrentPage=1
End If
dim strnews,plist_bottom

Set rs=Server.CreateObject("ADODB.RecordSet")
 
  sql="select * from pp_Products where  ViewFlag  order by Sequence asc"

   rs.open sql,conn,1,1
If rs.Eof And rs.bof Then


response.write"<Div style='margin-top:20px;text-align:center'>No products</DIV>"
PageCount1=1
Totalnumber=0
Else
Maxperpage=6
rs.Pagesize=MaxperPage
PageCount1=Rs.PageCount
rs.Move  (CurrentPage-1)*MaxperPage
Totalnumber=rs.RecordCount
N=0

plist_bottom=plist_bottom&"<div style='float:right;margin-top:10px'>page:"
For I=1 to PageCount1
If Currentpage=I Then
plist_bottom=plist_bottom&"<a href='newsproduct.asp?page="&i&"'>"&i&"</a>&nbsp;&nbsp;"
else
plist_bottom=plist_bottom&"<a href='newsproduct.asp?page="&i&"'><u>"&i&"</u></a>&nbsp;&nbsp;"
End If

Next'主页面
plist_bottom=plist_bottom&"</div>"
response.write"<div style='width:670px;height:350px'>"
Row_Count=1
do while not rs.eof
N=N+1
	      if n=2 and n=4 then
   response.write"<br>"
   end if
	        response.write"<div style='float:left;margin-top:30px'>"
	 if StrLen(Removehtml(rs("content")))<=60 then
         content=Removehtml(rs("content"))
	  else 
	     content=StrLeft(Removehtml(Removehtml(rs("content"))),59)
	   end if
	response.write"<div style='margin-left:18px;width:180px;height:110px; text-align:center'><a href='productview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"'><img src='"&replace(rs("smallpic"),"../","")&"' border='0'  width='170px' height='120px' style='padding:1px;'alt='"
	response.write rs("productname")
   response.write"'></a></div><div style='width:175px;text-align:left;padding-top:5px;list-style: circle;margin-left:14px'><li><a href='productview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"'>"&rs("ProductName")&"</a></li></div>"
   
   response.write"</div>"
  
row_count=row_count+1
if n>=MaxPerPage then exit do
rs.movenext
loop
 response.write"</div>"
rs.close
response.write plist_bottom
end if

end function
function Workshop()

dim rs,sql,id,page,parentid,sortid
 parentid=Request.QueryString("parentid")
 sortid=Request.QueryString("sortid")
page=Trim(Request.QueryString("Page"))
If Request("Page")<>"" Then
If Cint(Request("Page"))<1 Then
CurrentPage=1
Else
CurrentPage=Cint(Request("Page"))
End If
End If
If Request("Page")="" Then
CurrentPage=1
End If
dim strnews,plist_bottom

Set rs=Server.CreateObject("ADODB.RecordSet")

if sortid<>"" then 
  sql="select * from pp_Products where  ViewFlag and sortid="&sortid&" and id=199  order by Sequence asc"
  else
    sql="select * from pp_Products where  ViewFlag and sortid=199  order by Sequence asc"
  end if
   rs.open sql,conn,1,1
If rs.Eof And rs.bof Then


response.write"<Div style='margin-top:20px;text-align:center'>No products</DIV>"
PageCount1=1
Totalnumber=0
Else
Maxperpage=6
rs.Pagesize=MaxperPage
PageCount1=Rs.PageCount
rs.Move  (CurrentPage-1)*MaxperPage
Totalnumber=rs.RecordCount
N=0

plist_bottom=plist_bottom&" <table align='right'><tr><td align='right'>"
plist_bottom=plist_bottom&"[<b>"&CurrentPage&"</b>/<b>"&PageCount1&"</b>]page"
Pageno=CurrentPage
If cint(Pageno)>1 Then
plist_bottom=plist_bottom&"<a href='Workshop.asp?parentid="&parentid&"&sortid="&sortid&"'title=""index"">"
End If
plist_bottom=plist_bottom&"[ HOME ]</a>&nbsp;&nbsp;"
If Cint(Pageno)>1 Then
plist_bottom=plist_bottom&"<a href=Workshop.asp?parentid="&parentid&"&sortid="&sortid&"&page="&Pageno-1&" title=""Previous"">"
End If
plist_bottom=plist_bottom&"[ Previous ]</a>&nbsp;&nbsp;"
If Cint(Pageno)< PageCount1 Then
plist_bottom=plist_bottom&"<a href=Workshop.asp?parentid="&parentid&"&sortid="&sortid&"&page="&Pageno+1&" title=""Next"">"
End If
plist_bottom=plist_bottom&"[ Next ]</a>&nbsp;&nbsp;"
If Cint(Pageno)< Pagecount1 Then
plist_bottom=plist_bottom&"<a href='Workshop.asp?parentid="&parentid&"&sortid="&sortid&"&page="&PageCount1&"' title=""Last"">"
End If
plist_bottom=plist_bottom&"[  Last  ]&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp</a>"
plist_bottom=plist_bottom&"</td></tr></table>"
response.write"<div style='width:660px;'>"
Row_Count=1
do while not rs.eof
N=N+1
	  
	        response.write"<div  style='float:left;margin-left:10px;margin-top:6px'>"
		 if StrLen(Removehtml(rs("enProductName")))<=10 then
         content=Removehtml(rs("enProductName"))
	  else 
	     content=StrLeft(Removehtml(Removehtml(rs("enProductName"))),9)
	   end if
	response.write"<div style=' width:200px!important; width:143px; padding-top:5px; padding-left:2px;'><a href='productview.asp?sortid="&sortid&"&id="&rs("id")&"'><img src='"&replace(rs("smallpic"),"../","")&"' border='0'  width='200px' height='134px' style='padding:1px;'alt='"
	response.write rs("enproductname")
   response.write"'></a></div><div style=' width:200px; padding-top:10px; text-align:center'>"&rs("enproductname")&"</div>"
   
   response.write"</div>"
  
row_count=row_count+1
if n>=MaxPerPage then exit do
rs.movenext
loop
 response.write"</div>"
rs.close
 
response.write plist_bottom

end if
 
end function

function Equipment()

dim rs,sql,id,page,parentid,sortid
 parentid=Request.QueryString("parentid")
 sortid=Request.QueryString("sortid")
page=Trim(Request.QueryString("Page"))
If Request("Page")<>"" Then
If Cint(Request("Page"))<1 Then
CurrentPage=1
Else
CurrentPage=Cint(Request("Page"))
End If
End If
If Request("Page")="" Then
CurrentPage=1
End If
dim strnews,plist_bottom

Set rs=Server.CreateObject("ADODB.RecordSet")

if sortid<>"" then 
  sql="select * from pp_Products where  ViewFlag and sortid="&sortid&"  order by Sequence asc"
  else
    sql="select * from pp_Products where  ViewFlag and sortid=200  order by Sequence asc"
  end if
   rs.open sql,conn,1,1
If rs.Eof And rs.bof Then


response.write"<Div style='margin-top:20px;text-align:center'>No products</DIV>"
PageCount1=1
Totalnumber=0
Else
Maxperpage=6
rs.Pagesize=MaxperPage
PageCount1=Rs.PageCount
rs.Move  (CurrentPage-1)*MaxperPage
Totalnumber=rs.RecordCount
N=0

plist_bottom=plist_bottom&" <table align='right'><tr><td align='right'>"
plist_bottom=plist_bottom&"[<b>"&CurrentPage&"</b>/<b>"&PageCount1&"</b>]page"
Pageno=CurrentPage
If cint(Pageno)>1 Then
plist_bottom=plist_bottom&"<a href='Equipment.asp?parentid="&parentid&"&sortid="&sortid&"'title=""index"">"
End If
plist_bottom=plist_bottom&"[ HOME ]</a>&nbsp;&nbsp;"
If Cint(Pageno)>1 Then
plist_bottom=plist_bottom&"<a href=Equipment.asp?parentid="&parentid&"&sortid="&sortid&"&page="&Pageno-1&" title=""Previous"">"
End If
plist_bottom=plist_bottom&"[ Previous ]</a>&nbsp;&nbsp;"
If Cint(Pageno)< PageCount1 Then
plist_bottom=plist_bottom&"<a href=Equipment.asp?parentid="&parentid&"&sortid="&sortid&"&page="&Pageno+1&" title=""Next"">"
End If
plist_bottom=plist_bottom&"[ Next ]</a>&nbsp;&nbsp;"
If Cint(Pageno)< Pagecount1 Then
plist_bottom=plist_bottom&"<a href='Equipment.asp?parentid="&parentid&"&sortid="&sortid&"&page="&PageCount1&"' title=""Last"">"
End If
plist_bottom=plist_bottom&"[  Last  ]&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp</a>"
plist_bottom=plist_bottom&"</td></tr></table>"
response.write"<div style='width:660px;'>"
Row_Count=1
do while not rs.eof
N=N+1
	  
	        response.write"<div  style='float:left;margin-left:10px;margin-top:6px'>"
		 if StrLen(Removehtml(rs("enProductName")))<=10 then
         content=Removehtml(rs("enProductName"))
	  else 
	     content=StrLeft(Removehtml(Removehtml(rs("enProductName"))),9)
	   end if
	response.write"<div style=' width:200px!important; width:143px; padding-top:5px; padding-left:2px;'><a href='productview.asp?sortid="&sortid&"&id="&rs("id")&"'><img src='"&replace(rs("smallpic"),"../","")&"' border='0'  width='200px' height='134px' style='padding:1px;'alt='"
	response.write rs("enproductname")
   response.write"'></a></div><div style=' width:200px; padding-top:10px; text-align:center'>"&rs("enproductname")&"</div>"
   
   response.write"</div>"
  
row_count=row_count+1
if n>=MaxPerPage then exit do
rs.movenext
loop
 response.write"</div>"
rs.close
 
response.write plist_bottom

end if
 
end function


function productview()
  dim ID,SortID
SortID=request.QueryString("SortID")
  ID=request.QueryString("ID")
  if ID="" or (not isnumeric(ID)) then
    response.write "<div align='center'>Data access exception error</div>"
    exit function
  end if
  dim rs,sql
  set rs = server.createobject("adodb.recordset")
  sql="select * from pp_Products where ViewFlag and ID="&ID
  rs.open sql,conn,1,3

  if rs.bof and rs.eof then
    response.write "<div>No relevant information</div>"
  else
      dim BigPicPath
	  BigPicPath=replace(rs("BigPic"),"../","")
	  	  	  response.Write "<div style='width:100%;margin-padding:10px;'><div style='float:left;width:350px;height:274px;text-align:right;margin-left:20px;display:inline;'><a href='"&bigPicPath&"' rel=""lightbox[]"" title='"&rs("productname")&"'><img src='"&bigPicPath&"' width='350' height='274' style='border:1px solid #dddddd;'/></a></div><div style='float:right;width:330px;height:284px;text-align:left;'><div style='width:100%;height:24px;line-height:24px;'>产品编号:<b>"&rs("productname")&"</b></div><div style='margin-top:10px;width:100%;height:240px;overflow:hidden;word-wrap:break-word;'>"&rs("tedian")&"</div></div></div>"
	  response.Write "<div style='margin:0px;padding:0px;margin-left:20px;width:90%;height:30px;text-align:right;clear:both;'><!-- JiaThis Button BEGIN --><div id='ckepop' style='margin-top:6px;'><a href='http://www.jiathis.com/share/?uid=896622' class='jiathis jiathis_txt jtico jtico_jiathis' target='_blank' style='color:#222222;'>共享:</a><a class='jiathis_button_qzone'>QQ空间</a><a class='jiathis_button_tsina'>新浪微博</a><a class='jiathis_button_tools_1'>腾讯微博</a><a class='jiathis_button_tools_2'>人人网</a></div><script type='text/javascript' src='http://v2.jiathis.com/code/jia.js?uid=896622' charset='utf-8'></script><!-- JiaThis Button END --></div>"
	  
	  response.Write "<div style='margin-top:20px;margin-left:3%;width:90%;height:24;line-height:24px;border-bottom:1px solid #888888;'>产品详细图：</div>"
	  response.Write "<div style='margin-top:10px;margin-left:3%;padding:0px;width:90%;'>"&rs("content")&"</div>"
	  end if
  rs.close
  set rs=nothing
end function

function caseview()
  dim ID,SortID
SortID=request.QueryString("SortID")
  ID=request.QueryString("ID")
  if ID="" or (not isnumeric(ID)) then
    response.write "<div align='center'>数据读取出错，请联系管理员。</div>"
    exit function
  end if
  dim rs,sql
  set rs = server.createobject("adodb.recordset")
  sql="select * from pp_cgal where ViewFlag and ID="&ID
  rs.open sql,conn,1,3

  if rs.bof and rs.eof then
    response.write "<div>暂无相关内容</div>"
  else
      dim BigPicPath
	  BigPicPath=rs("BigPic")
	  

			 
			 response.Write "<div id='main_line_left_caseview_t'>"&rs("productname")&"</div><div id='main_line_left_caseview_c'>"&rs("content")&"</div>"

	end if  
  rs.close
  set rs=nothing
end function

function orderleft()
dim sortid,i,rs2,sql2,rs

set rs = server.createobject("adodb.recordset") 

  sql="select  * from pp_productsort where parentID=0 and ViewFlag  order by id asc"
  rs.open sql,conn,1,1
   i=0
   while not rs.eof

  response.Write"<li><a href='product.asp?parentid="&rs("id")&"'>"&rs("ensortname")&"</a></li>"
 

  rs.movenext
  wend 
     rs.close
 set rs=nothing
 
end function
function productleftt()
dim sortid,i,rs,id

set rs = server.createobject("adodb.recordset") 

  sql="select  * from pp_productsort where parentID=0  and ViewFlag  order by Sequence desc"
  rs.open sql,conn,1,1
   i=0
   while not rs.eof

	response.Write "<li><a href='product.asp?sortid="&rs("id")&"'><p>"&rs("sortname")&"</p></a></li>"

  rs.movenext
  wend 
     rs.close
 set rs=nothing
end function

function productleft()
dim sortid,i,rs2,sql2,rs,id
id=cint(request("Sortid"))
set rs = server.createobject("adodb.recordset") 

  sql="select  * from pp_productsort where parentID=0  and ViewFlag  order by id desc"
  rs.open sql,conn,1,1
   i=0
   while not rs.eof
   if rs("id")=id then
   	response.Write "<li class='cover'><p>"&rs("sortname")&"</p></li>"
   else
	response.Write "<li><a href='product.asp?sortid="&rs("id")&"'>"&rs("sortname")&"</a></li>"
	end if
  rs.movenext
  wend 
     rs.close
 set rs=nothing
end function

function productlefts()
dim sid,i,rs,id
id=cint(request("sid"))
set rs = server.createobject("adodb.recordset") 
	if id<>"" then
  sql="select  * from pp_products where instr(sortpath,"&id&")>0 and ViewFlag  order by Sequence desc"
	else
  sql="select  * from pp_products where parentID=0  and ViewFlag  order by Sequence desc"
	end if
  rs.open sql,conn,1,1
   i=0
   
   if rs.eof and rs.bof then
    response.Write("<li style='text-align:center;'>暂无信息</li>")
   else
   while not rs.eof
	
	response.Write "<li><img src='"&replace(rs("smallpic"),"../","")&"' width='136' height='101' border='0' uimg='"&replace(rs("bigpic"),"../","")&"' utxt='"&rs("content")&"' uname='promsg.asp?pname="&rs("productname")&"' pname='"&rs("productname")&"'/></li>"

  rs.movenext
  wend 
  end if
     rs.close
 set rs=nothing
end function


function productimg()
dim rs,sql,id,bigpic
id=Request.QueryString("id")
set rs = server.createobject("adodb.recordset")

 if id<>"" then 
 sql="select * from pp_products where id="&id
   rs.open sql,conn,1,1
  
	response.Write "<a href='productview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"' target='_blank' title='Click here'><img src='"&replace(rs("bigpic"),"../","")&"' width='725' height='567' border='0' /></a>"

 else

	response.Write "<img src='images/pro_img.jpg' width='725' height='567' border='0' />"
 end if
     rs.close
 set rs=nothing
 end function

function caseright()
dim sid,i,rs,id,sqls,rss,sql
id=cint(request("sid"))
set rs = server.createobject("adodb.recordset") 

  sql="select  * from pp_cgalsort where parentID=0  and ViewFlag  order by id asc"
  rs.open sql,conn,1,1
   i=0
   while not rs.eof

	response.Write "<li><a href='case.asp?sid="&rs("id")&"&pid="&rs("id")&"'><p>"&rs("sortname")&"</p></a></li>"

  rs.movenext
  wend 
     rs.close
 set rs=nothing
 
 
 set rss = server.createobject("adodb.recordset") 

  sqls="select  * from pp_newssort where instr(sortpath,161)>0  and ViewFlag  order by id asc"
  rss.open sqls,conn,1,1
   while not rss.eof

	response.Write "<li><a href='caseinfo.asp?id="&rss("id")&"'><p>"&rss("sortname")&"</p></a></li>"

  rss.movenext
  wend 
     rss.close
 set rss=nothing
 
end function


function protwotit()
dim sortid,i,rs,sql
sortid=cint(request("parentid"))
set rs = server.createobject("adodb.recordset") 

  sql="select  * from pp_productsort where instr(sortpath,"&sortid&") and ViewFlag and parentid<>0  order by id asc"
  rs.open sql,conn,1,1
   i=0
   if sortid=0 then
   else
   response.Write "<div style='float:left;margin-bottom:10px;width:660px;height:24px;clear:both;'><ul style='float:right;margin:0px;padding:0px;'>"
   while not rs.eof
	response.Write "<li style='float:left;width:80px;heigth:24px;line-height:24px;border-bottom:1px solid #dddddd;'><a href='product.asp?sortid="&rs("id")&"&parentID="&sortid&"'>"&rs("sortname")&"</a></li>"

  rs.movenext
  wend 
  response.Write "</ul></div>"
 end if
     rs.close
 set rs=nothing
end Function

function messages()
  dim SortPath
      SortPath=request.QueryString("SortPath")
  dim idCount'记录总数
  dim pages'每页条数
      pages=8
  dim pagec'总页数
  dim page'页码
      page=clng(request("Page"))
  dim pagenc'每页显示的分页页码数量=pagenc*2+1
      pagenc=2
  dim pagenmax'每页显示的分页的最大页码
  dim pagenmin'每页显示的分页的最小页码
  dim datafrom'数据表名
      datafrom="pp_Message"
  dim datawhere'数据条件
		 datawhere="where viewflag "
  dim sqlid'本页需要用到的id
  dim Myself,PATH_INFO,QUERY_STRING'本页地址和参数
      PATH_INFO = request.servervariables("PATH_INFO")
	  QUERY_STRING = request.ServerVariables("QUERY_STRING")'
      if QUERY_STRING = "" then
	    Myself = PATH_INFO & "?"
	  elseif Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")=0 then
	    Myself= PATH_INFO & "?" & QUERY_STRING & "&"
	  else
	    Myself = Left(PATH_INFO & "?" & QUERY_STRING,Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")-1)
	  end if
  dim taxis'排序的语句 asc,desc
      taxis="order by id desc "
  dim i'用于循环的整数
  dim rs,sql'sql语句
  '获取记录总数
  sql="select count(ID) as idCount from ["& datafrom &"]" & datawhere
  set rs=server.createobject("adodb.recordset")
  rs.open sql,conn,0,1
  idCount=rs("idCount")
  '获取记录总数

  if(idcount>0) then'如果记录总数=0,则不处理
    if(idcount mod pages=0)then'如果记录总数除以每页条数有余数,则=记录总数/每页条数+1
	  pagec=int(idcount/pages)'获取总页数
   	else
      pagec=int(idcount/pages)+1'获取总页数
    end if
	'获取本页需要用到的id============================================
    '读取所有记录的id数值,因为只有id所以速度很快
    sql="select id from ["& datafrom &"] " & datawhere & taxis
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,1,1
    rs.pagesize = pages '每页显示记录数
    if page < 1 then page = 1
    if page > pagec then page = pagec
    if pagec > 0 then rs.absolutepage = page  
    for i=1 to rs.pagesize
	  if rs.eof then exit for  
	  if(i=1)then
	    sqlid=rs("id")
	  else
	    sqlid=sqlid &","&rs("id")
	  end if
	  rs.movenext
    next
  '获取本页需要用到的id结束============================================
  end if
  if(idcount>0 and sqlid<>"") then'如果记录总数=0,则不处理
    '用in刷选本页所语言的数据,仅读取本页所需的数据,所以速度快
    sql="select * from ["& datafrom &"] where id in("& sqlid &") "&taxis
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,0,1
    while not rs.eof '填充数据到表格
	
	
	
      'Response.Write "<td colspan='2' bgcolor='#FFFFFF'>"&HtmlStrReplace(rs("Content"))&"</td>" & vbCrLf	  
	  'Response.Write "</tr>" & vbCrLf
	  'MessageReply rs("MesName"),rs("ReplyTime"),rs("ReplyContent")
	  response.Write "<div style='width:100%;border:1px solid #dddddd;margin-bottom:20px;'>"
	  response.Write "<div style='width:100%;height:24px;line-height:24px;clear:both;background:#dddddd;'>　　"&rs("Linkman")&" 　　发表时间："&rs("addtime")&"</div>"
	  response.Write "<div style='width:100%;height:auto !important;height:50px;line-height:150%;min-height:50px;clear:both;'>"&rs("Content")&"</div>"
	  response.Write "<div style='width:100%;height:24px;line-height:24px;clear:both;background:#dddddd;'>　　回复 　　回复时间："&rs("ReplyTime")&"</div>"
	  response.Write "<div style='width:100%;height:auto !important;height:50px;line-height:150%;min-height:50px;clear:both;'>"&rs("ReplyContent")&"</div>"
	  response.Write "</div>"
	  
	  rs.movenext
    wend
  else
    response.write "<div>暂无相关信息</div>"
	exit function
  end if
  
  Response.Write "<div style='width:100%;height:24px;line-height:24px;text-align:right;'>" & vbCrLf
  Response.Write "共计：<font color='#ff6600'>"&idcount&"</font>条记录&nbsp;页次：<font color='#ff6600'>"&page&"</font></strong>/"&pagec&"&nbsp;每页：<font color='#ff6600'>"&pages&"</font>条&nbsp;&nbsp;&nbsp;&nbsp;" & vbCrLf
  pagenmin=page-pagenc '计算页码开始值
  pagenmax=page+pagenc '计算页码结束值
  if(pagenmin<1) then pagenmin=1 '如果页码开始值小于1则=1
  if(page>1) then response.write ("<a href='"& myself &"Page=1'><font style='FONT-SIZE: 14px; FONT-FAMILY: Webdings'>9</font></a>&nbsp;") '如果页码大于1则显示(第一页)
  if(pagenmin>1) then response.write ("<a href='"& myself &"Page="& page-(pagenc*2+1) &"'><font style='FONT-SIZE: 14px; FONT-FAMILY: Webdings'>7</font></a>&nbsp;") '如果页码开始值大于1则显示(更前)
  if(pagenmax>pagec) then pagenmax=pagec '如果页码结束值大于总页数,则=总页数
  for i = pagenmin to pagenmax'循环输出页码
	if(i=page) then
	  response.write ("&nbsp;<font color='#ff6600'>"& i &"</font>&nbsp;")
	else
	  response.write ("[<a href="& myself &"Page="& i &">"& i &"</a>]")
	end if
  next
  if(pagenmax<pagec) then response.write ("&nbsp;<a href='"& myself &"Page="& page+(pagenc*2+1) &"'><font style='FONT-SIZE: 14px; FONT-FAMILY: Webdings'>8</font></a>&nbsp;") '如果页码结束值小于总页数则显示(更后)
  if(page<pagec) then response.write ("<a href='"& myself &"Page="& pagec &"'><font style='FONT-SIZE: 14px; FONT-FAMILY: Webdings'>:</font></a>") '如果页码小于总页数则显示(最后页)	
  Response.Write "</div>" & vbCrLf
  rs.close
  set rs=nothing
end function 

function MessageReply(MesName,ReplyTime,ReplyContent)
  if ReplyContent<>"" then
    Response.Write "<tr bgcolor='#F5F5F5' height='24'>" & vbCrLf	  
    Response.Write "<td><img src='../Images/Msg_reply.gif'></td>" & vbCrLf	  
    Response.Write "<td><img src='../Images/Msg_replytime.gif' width='11' height='11'>&nbsp;"&ReplyTime&"</td>" & vbCrLf	  
    Response.Write "</tr>" & vbCrLf
    Response.Write "<tr>" & vbCrLf	  
    Response.Write "<td colspan='2' bgcolor='#FFFFFF'>"&HtmlStrReplace(ReplyContent)&"</td>" & vbCrLf	  
    Response.Write "</tr>" & vbCrLf
  end if
end function
function joblist()
  dim SortPath
      SortPath=request.QueryString("SortPath")
  dim idCount'记录总数
  dim pages'每页条数
      pages=8
  dim pagec'总页数
  dim page'页码
      page=clng(request("Page"))
  dim pagenc'每页显示的分页页码数量=pagenc*2+1
      pagenc=2
  dim pagenmax'每页显示的分页的最大页码
  dim pagenmin'每页显示的分页的最小页码
  dim datafrom'数据表名
      datafrom="pp_Jobs"
  dim datawhere'数据条件
      datawhere="where ViewFlag "
  dim sqlid'本页需要用到的id
  dim Myself,PATH_INFO,QUERY_STRING'本页地址和参数
      PATH_INFO = request.servervariables("PATH_INFO")
	  QUERY_STRING = request.ServerVariables("QUERY_STRING")'
      if QUERY_STRING = "" then
	    Myself = PATH_INFO & "?"
	  elseif Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")=0 then
	    Myself= PATH_INFO & "?" & QUERY_STRING & "&"
	  else
	    Myself = Left(PATH_INFO & "?" & QUERY_STRING,Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")-1)
	  end if
  dim taxis'排序的语句 asc,desc
      taxis="order by id desc "
  dim i'用于循环的整数
  dim rs,sql'sql语句
  '获取记录总数
  sql="select count(ID) as idCount from ["& datafrom &"]" & datawhere
  set rs=server.createobject("adodb.recordset")
  rs.open sql,conn,0,1
  idCount=rs("idCount")
  '获取记录总数

  if(idcount>0) then'如果记录总数=0,则不处理
    if(idcount mod pages=0)then'如果记录总数除以每页条数有余数,则=记录总数/每页条数+1
	  pagec=int(idcount/pages)'获取总页数
   	else
      pagec=int(idcount/pages)+1'获取总页数
    end if
	'获取本页需要用到的id============================================
    '读取所有记录的id数值,因为只有id所以速度很快
    sql="select id from ["& datafrom &"] " & datawhere & taxis
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,1,1
    rs.pagesize = pages '每页显示记录数
    if page < 1 then page = 1
    if page > pagec then page = pagec
    if pagec > 0 then rs.absolutepage = page  
    for i=1 to rs.pagesize
	  if rs.eof then exit for  
	  if(i=1)then
	    sqlid=rs("id")
	  else
	    sqlid=sqlid &","&rs("id")
	  end if
	  rs.movenext
    next
  '获取本页需要用到的id结束============================================
  end if
  Response.Write "<table width='100%' border='0' cellpadding='3' cellspacing='0' style='color:#222222;font-size:12px;'>"
 
  if(idcount>0 and sqlid<>"") then'如果记录总数=0,则不处理
    '用in刷选本页所语言的数据,仅读取本页所需的数据,所以速度快
    sql="select * from ["& datafrom &"] where id in("& sqlid &") "&taxis
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,0,1
	dim JobNO
	JobNO=1
    while not rs.eof '填充数据到表格
    Response.Write "  <a href='JobsView.asp?ID="&rs("ID")&"'><tr height=30px  style='cursor:hand;'>" &_
                   "    <td width='4%'align='center'>"&JobNO&"</td>" &_
                   "    <td width='25%' align='left'>"&rs("JobName")&"</td>" &_
           
                   "    <td width='23%' align='right'>"&FormatDate(rs("AddTime"),13)&"-"&FormatDate(rs("EndDate"),13)&"</td>" &_
      
                   "  </tr></a>"	
	 Response.Write"<tr>"&_
                         "<td height='1' colspan='3' ><div style='margin:0px;padding:0px;border-top:1px solid #ebebeb;height:1px;overflow:hidden;'> </div></td> </tr>"
	  rs.movenext
	  JobNO=JobNO+1
    wend
  else
    response.write "<tr><td align='center' colspan='3'  >No relevant information</td></tr></table>"
	exit function
  end if

  Response.Write "<tr>" & vbCrLf
  Response.Write "<td colspan='3' align='right' >" & vbCrLf
    Response.Write "<div class='sabrosus'><div class='manu' >页码：" & vbCrLf
  

  pagenmin=page-pagenc '计算页码开始值
  pagenmax=page+pagenc '计算页码结束值
  if(pagenmin<1) then pagenmin=1 '如果页码开始值小于1则=1
 
  if(pagenmax>pagec) then pagenmax=pagec '如果页码结束值大于总页数,则=总页数
  for i = pagenmin to pagenmax'循环输出页码
	if(i=page) then
	  response.write ("<span class='current'>"& i &"</span>")
	else
	  response.write ("<a href="& myself &"Page="& i &">"& i &"</a>")
	end if
  next
 
Response.Write "</div>"
Response.Write "</div>"
  Response.Write "</td>" & vbCrLf
  Response.Write "</tr>" & vbCrLf
  Response.Write "</table>" & vbCrLf
  rs.close
  set rs=nothing
end function 
function jobview()
  dim ID
  ID=request.QueryString("ID")
  if ID="" or (not isnumeric(ID)) then
    response.write "<div align='center'>数据读取异常错误</div>"
    exit function
  end if
  dim rs,sql
  set rs = server.createobject("adodb.recordset")
  sql="select * from pp_Jobs where ViewFlag and ID="&ID
  rs.open sql,conn,1,3
  response.write"<table width='100%' border='0' cellspacing='0' cellpadding='0' style='color:#ffffff'>"
  if rs.bof and rs.eof then
    response.write "<tr><td>暂无相关信息</td></tr>"
  else
    response.write "<tr><td colspan='2'><hr width='100%' size='1' noshade='noshade' color='#73B4CC'></td></tr>"
    response.write "<tr><td width='420'>职位名称：<font style='font-weight: bold;color: #1874CD'>"&rs("JobName")&"</font></td>"
    response.write "<td width='184'>工作地点："&rs("JobAddress")&"</td></tr>"
    response.write "<tr><td>招聘人数："&rs("JobNumber")&"</td>"
    response.write "<td>工资待遇："&rs("Emolument")&"</td></tr>"
    response.write "<tr><td>有 效 期："&FormatDate(rs("AddTime"),13)&"-"&FormatDate(rs("EndDate"),13)&"</td>"
    response.write "<td>提交简历：<a href='#'  onClick=""window.open('submit.asp?JobID="&rs("ID")&"&JobName="&server.urlencode(rs("JobName"))&"','yourname','toolbars=no,location=no,scrollbars=no,status=no,resizable=no,width=600,height=518')""><img src='Images/Jobs_resume_up.gif' border='0' align='absmiddle'></a></td></tr>"
    response.write "<tr><td height='22' colspan='2'>详细内容:</td></tr>"
    response.write "<tr><td colspan='2' height='12'></td></tr>"
    response.write "<tr><td colspan='2' width='604'>"&rs("Content")&"</td></tr>"
	rs("ClickNumber")=rs("ClickNumber")+1
    response.write "<tr><td class='ListTitle' colspan='2'></td></tr>" 
    response.write "<tr><td>点击次数："&rs("ClickNumber")&"</td>"
	response.write "<td align='right'><a href='#TOP'><img src='Images/Button_top_01.gif' align='absbottom' border='0'></a></td></tr>" 
	rs.update	   
  end if
  response.write"</table>"
  rs.close
  set rs=nothing
end function
function pdanqian()
dim rs,sql,sid
sid=Trim(Request.QueryString("sid"))
set rs = server.createobject("adodb.recordset")

 if sid<>"" then 
 sql="select * from pp_productsort where id="&sid
   rs.open sql,conn,1,1
  
  response.Write rs("sortname")

 else

  response.Write "所有产品"
 end if

     rs.close
 set rs=nothing

end function
function cdanqian()
dim rs,sql,sid
sid=Trim(Request.QueryString("sid"))
set rs = server.createobject("adodb.recordset")

 if sid<>"" then 
 sql="select * from pp_cgalsort where id="&sid
   rs.open sql,conn,1,1
  
  response.Write rs("sortname")

 else

  response.Write "工程展示"
 end if

     rs.close
 set rs=nothing

end function

function searchdanqian()
dim key
key=request("key")
if key<>""then
response.write key
else
response.write"搜索所有产品"
end if
end function

function productlist()
dim rs,sql,bigPicPath
set rs = server.createobject("adodb.recordset")

  sql="select * from pp_Products where sortid=222 and exclusive=false" 

  rs.open sql,conn,1,3
 while not rs.eof
 bigPicPath=replace(rs("bigpic"),"../","")
  response.write "<li><a href='da.asp?id="&rs("id")&"' target='da'>"&rs("enproductname")&"</a></li>"
  
  rs.movenext
  wend 
     rs.close 

 set rs=nothing

end function


function classphlist()
dim rs,sql,smallPicPath
set rs = server.createobject("adodb.recordset")

  sql="select top 6 * from pp_Products where sortid=222 and Exclusive=false order by id" 

  rs.open sql,conn,1,3
 while not rs.eof
 smallPicPath=replace(rs("smallpic"),"../","")
  response.write "<li><a href='da.asp?id="&rs("id")&"' target='da'><img src='"&smallPicPath&"' width='82' height='55' border='0'></a></li>"
  
  rs.movenext
  wend 
     rs.close 

 set rs=nothing

end function

function daphurl()
dim rs,sql,id,bigpic
id=Request.QueryString("id")
set rs = server.createobject("adodb.recordset")

 if id<>"" then 
 sql="select * from pp_products where id="&id
   rs.open sql,conn,1,1
  
 bigpicPath=replace(rs("bigpic"),"../","")
  response.Write bigpicpath

 else

  response.Write "images/defaultph.jpg"
 end if
     rs.close
 set rs=nothing
 end function
 
 
 function daphshowurl()
dim rs,sql,id,xx
id=Request.QueryString("id")
set rs = server.createobject("adodb.recordset")

 if id<>"" then 
 sql="select * from pp_products where id="&id
   rs.open sql,conn,1,1
  
 xx=replace(rs("renzheng"),"../","")
  response.Write xx

 else

  response.Write "images/v1.jpg"
 end if
     rs.close
 set rs=nothing
 end function
 
  function daphshowid()
dim rs,sql,id
id=Request.QueryString("id")
set rs = server.createobject("adodb.recordset")

 if id<>"" then 
 sql="select * from pp_products where id="&id
   rs.open sql,conn,1,1
  
  response.Write rs("xinghao")

 else

  response.Write "ST SERIES"
 end if
     rs.close
 set rs=nothing
 end function
 
 
function searchphlist() 
dim rs,sql,key
key=Trim(Request("key"))
Set rs=Server.CreateObject("ADODB.RecordSet")
sql="select * from pp_Products where  ViewFlag and enproductname like '%"&key&"%' order by id asc"
rs.open sql,conn,1,1
     
If rs.Eof And rs.bof Then
response.write"<li>No information!</li>>"
else
  

 while not rs.eof
	response.write "<li><a href='da.asp?id="&rs("id")&"' target='da'>"&rs("enproductname")&"</a></li>"
  
  rs.movenext
  wend 

end if

rs.close
set rs=nothing
end function
 
 
 
function down()
  dim sortid
	  sortid=request.querystring("sortid")
  dim SortPath
      SortPath=request.QueryString("SortPath")
  dim idCount'记录总数
  dim pages'每页条数
      pages=12
  dim pagec'总页数
  dim page'页码
      page=clng(request("Page"))
  dim pagenc'每页显示的分页页码数量=pagenc*2+1
      pagenc=2
  dim pagenmax'每页显示的分页的最大页码
  dim pagenmin'每页显示的分页的最小页码
  dim datafrom'数据表名
      datafrom="pp_Download"
  dim datawhere'数据条件
      if sortid<>"" then'是否查看的分类产品
		 datawhere="where ViewFlag and Instr(SortPath,'"&sortid&"')>0 "
      else
		 datawhere="where ViewFlag "
	  end if
  dim sqlid'本页需要用到的id
  dim Myself,PATH_INFO,QUERY_STRING'本页地址和参数
      PATH_INFO = request.servervariables("PATH_INFO")
	  QUERY_STRING = request.ServerVariables("QUERY_STRING")'
      if QUERY_STRING = "" then
	    Myself = PATH_INFO & "?"
	  elseif Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")=0 then
	    Myself= PATH_INFO & "?" & QUERY_STRING & "&"
	  else
	    Myself = Left(PATH_INFO & "?" & QUERY_STRING,Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")-1)
	  end if
  dim taxis'排序的语句 asc,desc
      taxis="order by id desc "
  dim i'用于循环的整数
  dim rs,sql'sql语句
  '获取记录总数
  sql="select count(ID) as idCount from ["& datafrom &"]" & datawhere
  set rs=server.createobject("adodb.recordset")
  rs.open sql,conn,0,1
  idCount=rs("idCount")
  '获取记录总数

  if(idcount>0) then'如果记录总数=0,则不处理
    if(idcount mod pages=0)then'如果记录总数除以每页条数有余数,则=记录总数/每页条数+1
	  pagec=int(idcount/pages)'获取总页数
   	else
      pagec=int(idcount/pages)+1'获取总页数
    end if
	'获取本页需要用到的id============================================
    '读取所有记录的id数值,因为只有id所以速度很快
    sql="select id from ["& datafrom &"] " & datawhere & taxis
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,1,1
    rs.pagesize = pages '每页显示记录数
    if page < 1 then page = 1
    if page > pagec then page = pagec
    if pagec > 0 then rs.absolutepage = page  
    for i=1 to rs.pagesize
	  if rs.eof then exit for  
	  if(i=1)then
	    sqlid=rs("id")
	  else
	    sqlid=sqlid &","&rs("id")
	  end if
	  rs.movenext
    next
  '获取本页需要用到的id结束============================================
  end if
  Response.Write "<table width='80%' border='0' cellspacing='2' cellpadding='1' style='margin-left:10%;'>"
  if(idcount>0 and sqlid<>"") then'如果记录总数=0,则不处理
    '用in刷选本页所语言的数据,仅读取本页所需的数据,所以速度快
    sql="select * from ["& datafrom &"] where id in("& sqlid &") "&taxis
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,0,1
    while not rs.eof '填充数据到表格
	Addtime=year(rs("AddTime"))&"-"&month(rs("AddTime"))&"-"&day(rs("AddTime"))
	  Response.Write "<tr style='height:24px;line-height:24px;'>" & vbCrLf
	  dim fileurl
	  fileurl=replace(rs("FileUrl"),"../","")
      Response.Write "<td width='80%'><img src='images/ball.gif'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href='"&fileurl&"'  target='_blank'>"&rs("DownName")&"</a></td><td>"&Addtime&"</td>" & vbCrLf
	  
      Response.Write "</tr>" & vbCrLf
	  rs.movenext
    wend
  else
    response.write "<tr><td align='center'>暂无信息</td></tr></table>"
	exit function
  end if
  Response.Write "<tr height=60px>" & vbCrLf
  Response.Write "<td colspan='2' align='center'>" & vbCrLf
  Response.Write "共计：&nbsp;"&idcount&"&nbsp;条&nbsp;&nbsp;&nbsp;&nbsp;页码：<font color='#ff6600'>"&page&"</font></strong>/"&pagec&"&nbsp;&nbsp;&nbsp;&nbsp;每页：&nbsp;"&pages&"&nbsp;&nbsp;条&nbsp;&nbsp;" & vbCrLf
  pagenmin=page-pagenc '计算页码开始值
  pagenmax=page+pagenc '计算页码结束值
  if(pagenmin<1) then pagenmin=1 '如果页码开始值小于1则=1
  if(page>1) then response.write ("<a href='"& myself &"Page=1'><font style='FONT-SIZE: 14px; FONT-FAMILY: Webdings'>9</font></a>&nbsp;") '如果页码大于1则显示(第一页)
  if(pagenmin>1) then response.write ("<a href='"& myself &"Page="& page-(pagenc*2+1) &"'><font style='FONT-SIZE: 14px; FONT-FAMILY: Webdings'>7</font></a>&nbsp;") '如果页码开始值大于1则显示(更前)
  if(pagenmax>pagec) then pagenmax=pagec '如果页码结束值大于总页数,则=总页数
  for i = pagenmin to pagenmax'循环输出页码
	if(i=page) then
	  response.write ("&nbsp;<font color='#ff6600'>["& i &"]</font>&nbsp;")
	else
	  response.write ("[<a href="& myself &"Page="& i &">["& i &"]</a>]")
	end if
  next
  if(pagenmax<pagec) then response.write ("&nbsp;<a href='"& myself &"Page="& page+(pagenc*2+1) &"'><font style='FONT-SIZE: 14px; FONT-FAMILY: Webdings'>8</font></a>&nbsp;") '如果页码结束值小于总页数则显示(更后)
  if(page<pagec) then response.write ("<a href='"& myself &"Page="& pagec &"'><font style='FONT-SIZE: 14px; FONT-FAMILY: Webdings'>:</font></a>") '如果页码小于总页数则显示(最后页)	
  Response.Write "</td>" & vbCrLf
  Response.Write "</tr>" & vbCrLf
  Response.Write "</table>" & vbCrLf
  rs.close
  set rs=nothing
end function

function downlist()
dim rs,sql
Set rs=Server.CreateObject("ADODB.RecordSet")
sql="select * from pp_downsort where  ViewFlag order by id asc"
rs.open sql,conn,1,1
     
If rs.Eof And rs.bof Then
response.write"<li>No information!</li>>"
else
  

 while not rs.eof
	response.write "<li><a href='other.asp?sortid="&rs("id")&"' target='da'>"&rs("ensortname")&"</a></li>"
  
  rs.movenext
  wend 

end if

rs.close
set rs=nothing

end function


function proteng()
dim sortid,rs
parentid=cint(request("parentid"))
set rs = server.createobject("adodb.recordset") 

  sql="select  * from pp_products where sortID=224  and ViewFlag  order by id asc"
  rs.open sql,conn,1,1
   while not rs.eof
	
      dim BigPicPath,SmallPicPath
	  BigPicPath=replace(rs("BigPic"),"../","")
	  SmallPicPath=replace(rs("SmallPic"),"../","")
  response.Write"&nbsp;&nbsp;<a class='cl-click1'><img src="&SmallPicPath&" width='31px' height='20px' bigph="&BigPicPath&" border='none'></a>"
 

  rs.movenext
  wend 
     rs.close
 set rs=nothing
 
end function 


function probuliao()
dim sortid,rs
parentid=cint(request("parentid"))
set rs = server.createobject("adodb.recordset") 

  sql="select  * from pp_products where sortID=225  and ViewFlag  order by id asc"
  rs.open sql,conn,1,1
   while not rs.eof
	
      dim BigPicPath,SmallPicPath
	  BigPicPath=replace(rs("BigPic"),"../","")
	  SmallPicPath=replace(rs("SmallPic"),"../","")
  response.Write"&nbsp;&nbsp;<a class='cl-click2'><img src="&SmallPicPath&" width='31px' height='20px' bigph="&BigPicPath&" border='none'></a>"
 

  rs.movenext
  wend 
     rs.close
 set rs=nothing
 
end function 


function proboli()
dim sortid,rs
parentid=cint(request("parentid"))
set rs = server.createobject("adodb.recordset") 

  sql="select  * from pp_products where sortID=226  and ViewFlag  order by id asc"
  rs.open sql,conn,1,1
   while not rs.eof
	
      dim BigPicPath,SmallPicPath
	  BigPicPath=replace(rs("BigPic"),"../","")
	  SmallPicPath=replace(rs("SmallPic"),"../","")
  response.Write"&nbsp;&nbsp;<a class='cl-click3'><img src="&SmallPicPath&" width='31px' height='20px' bigph="&BigPicPath&" border='none'></a>"
 

  rs.movenext
  wend 
     rs.close
 set rs=nothing
 
end function 

function productlistvip()
dim rs,sql,bigPicPath
set rs = server.createobject("adodb.recordset")

  sql="select * from pp_Products where sortid=222 and exclusive" 

  rs.open sql,conn,1,3
 while not rs.eof
 bigPicPath=replace(rs("bigpic"),"../","")
  response.write "<li><a href='da.asp?id="&rs("id")&"' target='da'>"&rs("enproductname")&"</a></li>"
  
  rs.movenext
  wend 
     rs.close 

 set rs=nothing

end function

function productls()
dim rs,sql,id
id=Request.QueryString("pid")
set rs = server.createobject("adodb.recordset")
if id <> "" then
  sql="select top 1 * from pp_products where ViewFlag and (instr(sortpath,"&id&")>0 or id="&id&") order by id desc" 
else 
  sql="select top 1 * from pp_products where ViewFlag and instr(sortpath,227)>0 order by id desc" 
end if
  rs.open sql,conn,1,3
 

  response.Write "<div id='main_line_left_pro_r_t'><a id='xlzproa' href='"&replace(rs("bigpic"),"../","")&"' rel=""lightbox[]"" title='"&rs("productname")&"'><img src='"&replace(rs("bigpic"),"../","")&"' border='0' id='proimg' width='648' height='335'/></a></div><div id='main_line_left_pro_r_c'><div id='main_line_left_pro_r_c_box'>"&rs("content")&"</div></div>"
  
  
  rs.movenext
     rs.close 

 set rs=nothing

end function

function productorderls()
dim rs,sql,id
id=Request.QueryString("pid")
set rs = server.createobject("adodb.recordset")
if id <> "" then
  sql="select top 1 * from pp_products where ViewFlag and (instr(sortpath,"&id&")>0 or id="&id&") order by id desc" 
else 
  sql="select top 1 * from pp_products where ViewFlag and instr(sortpath,227)>0 order by id desc" 
end if
  rs.open sql,conn,1,3
 

  response.Write "<div id='main_line_left_pro_r_t'><img src='"&replace(rs("bigpic"),"../","")&"' border='0' id='proimg' width='648' height='335'/></div><div id='main_line_left_pro_r_c'><div id='main_line_left_pro_r_c_box'>"&rs("content")&"</div></div>"
  
  
  rs.movenext
     rs.close 

 set rs=nothing

end function

function product_p() 

 dim rs,sql,page,sid,sth
 sth=Request.QueryString("pid")
 sid=Request.QueryString("sortid")
page=Trim(Request.QueryString("Page"))
If Request("Page")<>"" Then
If Cint(Request("Page"))<1 Then
CurrentPage=1
Else
CurrentPage=Cint(Request("Page"))
End If
End If
If Request("Page")="" Then
CurrentPage=1
End If
dim strnews,plist_bottom

Set rs=Server.CreateObject("ADODB.RecordSet")
  sql="select * from pp_news where  ViewFlag and instr(sortpath,151)>0 order by id desc"
   rs.open sql,conn,1,1
If rs.Eof And rs.bof Then


response.write"<Div style='margin-top:20px;text-align:center'>No Products</DIV>"
PageCount1=1
Totalnumber=0
Else

Maxperpage=9
rs.Pagesize=MaxperPage
PageCount1=Rs.PageCount
rs.Move  (CurrentPage-1)*MaxperPage
Totalnumber=rs.RecordCount
N=0

plist_bottom=plist_bottom&"<table width='100%' style='margin-top:10px;'><tr><td><div style='margin-left:460px'>"
plist_bottom=plist_bottom&"[ <b>"&CurrentPage&"</b>/<b>"&PageCount1&"</b> ]&nbsp;"
Pageno=CurrentPage
If cint(Pageno)>1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href='aboutlist.asp?sortid="&sortid&"&sortpath="&sortpath&"'title=""index"">"
else
plist_bottom=plist_bottom&"<a href='aboutlist.asp'title=""index"">"
end if
End If
plist_bottom=plist_bottom&"[ 首页 ]</a>&nbsp;"
If Cint(Pageno)>1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href=aboutlist.asp?page="&Pageno-1&"&sortid="&sortid&"&sortpath="&sortpath&" title=""Previous"">"
else
plist_bottom=plist_bottom&"<a href=aboutlist.asp?page="&Pageno-1&" title=""Previous"">"
end if
End If
plist_bottom=plist_bottom&"[ 上一页 ]</a>&nbsp;"
If Cint(Pageno)< PageCount1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href=aboutlist.asp?page="&Pageno+1&"&sortid="&sortid&"&sortpath="&sortpath&" title=""Next"">"
else
plist_bottom=plist_bottom&"<a href=aboutlist.asp?page="&Pageno+1&" title=""Next"">"
End If
End If
plist_bottom=plist_bottom&"[ 下一页 ]</a>&nbsp;"
If Cint(Pageno)< Pagecount1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href='aboutlist.asp?page="&PageCount1&"&sortid="&sortid&"&sortpath="&sortpath&"' title=""Last"">"
else
plist_bottom=plist_bottom&"<a href='aboutlist.asp?page="&PageCount1&"' title=""Last"">"
End If
End If
plist_bottom=plist_bottom&"[ 末页 ]</a>"
plist_bottom=plist_bottom&"</div></td></tr></table>"


Row_Count=1
do while not rs.eof
N=N+1
	      if n=3 and n=6 then
   response.write"<br>"
   end if

	 if StrLen(Removehtml(rs("newsName")))<=18 then
        ProductName=Removehtml(rs("newsName"))
	  else 
	     ProductName=StrLeft(Removehtml(Removehtml(rs("newsName"))),17)
	   end if

   
   response.Write "<div style='float:left;display:inline;width:200px;height:179px;margin-top:10px;margin-right:40px;padding-top:5px;border:1px solid #dddddd;'><div style='width:100%;'><a href='aboutview.asp?aid="&rs("id")&"'><img src='"&replace(rs("bigpic"),"../","")&"' width='190px' height='145px' border='0' style='margin-left:5px;'/></a></div><div style='margin-top:5px;width:100%;height:29px;line-height:29px;text-align:center;border-top:1px solid #dddddd;'><a href='aboutview.asp?aid="&rs("id")&"'>"&ProductName&"</a></div></div>"
  
row_count=row_count+1
if n>=MaxPerPage then exit do
rs.movenext
loop

rs.close
response.write plist_bottom
end if
end function

function case_p_c() 

 dim rs,sql,page,sortid,sortpath
 sortpath=Request.QueryString("pid")
 sortid=Request.QueryString("sortid")
page=Trim(Request.QueryString("Page"))
If Request("Page")<>"" Then
If Cint(Request("Page"))<1 Then
CurrentPage=1
Else
CurrentPage=Cint(Request("Page"))
End If
End If
If Request("Page")="" Then
CurrentPage=1
End If
dim strnews,plist_bottom

Set rs=Server.CreateObject("ADODB.RecordSet")
 if sortid<>"" then
 	if sortid = 192 then
  sql="select * from pp_cgal where  ViewFlag and instr(sortpath,192)>0 order by Sequence asc"
  else
  sql="select * from pp_cgal where  ViewFlag and sortid="&sortid&" order by Sequence asc"
  end if
else
   if sortpath<>"" then
  sql="select * from pp_cgal where  ViewFlag and Instr(SortPath,'"&SortPath&"')>0 order by Sequence asc"
  else
  sql="select * from pp_cgal where  ViewFlag order by Sequence desc"
  end if
  end if
   rs.open sql,conn,1,1
If rs.Eof And rs.bof Then


response.write"<Div style='margin-top:20px;text-align:center'>No Products</DIV>"
PageCount1=1
Totalnumber=0
Else

Maxperpage=6
rs.Pagesize=MaxperPage
PageCount1=Rs.PageCount
rs.Move  (CurrentPage-1)*MaxperPage
Totalnumber=rs.RecordCount
N=0

plist_bottom=plist_bottom&"<table><tr><td><div style=' padding-left:422px;'>"
plist_bottom=plist_bottom&"[ <b>"&CurrentPage&"</b>/<b>"&PageCount1&"</b> ]&nbsp;"
Pageno=CurrentPage
If cint(Pageno)>1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href='case.asp?sortid="&sortid&"&sortpath="&sortpath&"'title=""index"">"
else
plist_bottom=plist_bottom&"<a href='case.asp'title=""index"">"
end if
End If
plist_bottom=plist_bottom&"[ Home ]</a>&nbsp;"
If Cint(Pageno)>1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href=case.asp?page="&Pageno-1&"&sortid="&sortid&"&sortpath="&sortpath&" title=""Previous"">"
else
plist_bottom=plist_bottom&"<a href=case.asp?page="&Pageno-1&" title=""Previous"">"
end if
End If
plist_bottom=plist_bottom&"[ Previous ]</a>&nbsp;"
If Cint(Pageno)< PageCount1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href=case.asp?page="&Pageno+1&"&sortid="&sortid&"&sortpath="&sortpath&" title=""Next"">"
else
plist_bottom=plist_bottom&"<a href=case.asp?page="&Pageno+1&" title=""Next"">"
End If
End If
plist_bottom=plist_bottom&"[ Next ]</a>&nbsp;"
If Cint(Pageno)< Pagecount1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href='case.asp?page="&PageCount1&"&sortid="&sortid&"&sortpath="&sortpath&"' title=""Last"">"
else
plist_bottom=plist_bottom&"<a href='case.asp?page="&PageCount1&"' title=""Last"">"
End If
End If
plist_bottom=plist_bottom&"[ Last ]</a>"
plist_bottom=plist_bottom&"</div></td></tr></table>"


Row_Count=1
do while not rs.eof
N=N+1
	      if n=3 and n=6 then
   response.write"<br>"
   end if

	 if StrLen(Removehtml(rs("ProductName")))<=18 then
        ProductName=Removehtml(rs("ProductName"))
	  else 
	     ProductName=StrLeft(Removehtml(Removehtml(rs("ProductName"))),17)
	   end if

   
   response.Write "<div class='main_line_r_con_probox'><div class='main_line_r_con_probox_img'><img src='"&rs("smallpic")&"' width='161px' height='112px' border='0'/></div><div class='main_line_r_con_probox_txt'>"&ProductName&"</div></div>"
  'caseview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"
  
  response.Write "<div style='float:left;display:inline;width:200px;height:179px;margin-top:10px;margin-right:40px;padding-top:5px;border:1px solid #dddddd;'><div style='width:100%;'><a href='aboutview.asp?aid="&rs("id")&"'><img src='"&replace(rs("smallpic"),"../","")&"' width='190px' height='145px' border='0' style='margin-left:5px;'/></a></div><div style='margin-top:5px;width:100%;height:29px;line-height:29px;text-align:center;border-top:1px solid #dddddd;'><a href='aboutview.asp?aid="&rs("id")&"'>"&ProductName&"</a></div></div>"
  
row_count=row_count+1
if n>=MaxPerPage then exit do
rs.movenext
loop

rs.close
response.write plist_bottom
end if
end function

function leftcontact()
dim rs,sql
set rs = server.createobject("adodb.recordset")
  sql="select * from pp_News where id=436" 
  rs.open sql,conn,1,3
 
  response.Write rs("content")
     rs.close 

 set rs=nothing

end function

function menuabout()
set rs = server.createobject("adodb.recordset")
  sql="select * from pp_About where ViewFlag  order by id asc "
  rs.open sql,conn,1,1
  
 while not rs.eof  	
 	

    response.Write"<li><a href='about.asp?id="&rs("id")&"'>"&rs("aboutname")&"</a></li>"

  rs.movenext
  wend
     rs.close
 set rs=nothing

end function
function menunews()
set rs = server.createobject("adodb.recordset")
  sql="select * from pp_newssort where ViewFlag and parentid=156  order by id asc "
  rs.open sql,conn,1,1
  
 while not rs.eof 
    response.Write"<li><a href='newsinfo.asp?id="&rs("id")&"'>"&rs("sortname")&"</a></li>"
	
  rs.movenext
  wend
     rs.close
 set rs=nothing

end function

function menutrade()
set rs = server.createobject("adodb.recordset")
  sql="select * from pp_news where ViewFlag and instr(sortpath,137)>0  order by id "
  rs.open sql,conn,1,1
  
 while not rs.eof 
    response.Write"<li><a href='trade.asp?id="&rs("id")&"'>"&rs("newsname")&"</a></li>"

  rs.movenext
  wend
     rs.close
 set rs=nothing

end function
function menucontact()
set rs = server.createobject("adodb.recordset")
  sql="select * from pp_News where instr(sortpath,97)>0 and sortid<>126"
  rs.open sql,conn,1,1
  
 while not rs.eof 
    response.Write"<li><a href='contact.asp?id="&rs("id")&"'>"&rs("Newsname")&"</a></li>"

  rs.movenext
  wend
     rs.close
 set rs=nothing

end function
function menuserver()
set rs = server.createobject("adodb.recordset")
  sql="select * from pp_newssort where ViewFlag and parentid=131  order by id asc "
  rs.open sql,conn,1,1
  
 while not rs.eof 
    response.Write"<li><a href='service.asp?id="&rs("id")&"'>"&rs("sortname")&"</a></li>"

  rs.movenext
  wend
     rs.close
 set rs=nothing

end function

function menujob()
set rs = server.createobject("adodb.recordset")
  sql="select * from pp_newssort where ViewFlag and parentid=178  order by id asc "
  rs.open sql,conn,1,1
  
 while not rs.eof 
    response.Write"<li><a href='joblist.asp?id="&rs("id")&"'>"&rs("sortname")&"</a></li>"

  rs.movenext
  wend
     rs.close
 set rs=nothing

end function

function menujoin()
set rs = server.createobject("adodb.recordset")
  sql="select * from pp_newssort where ViewFlag and parentid=132  order by id asc "
  rs.open sql,conn,1,1
  
 while not rs.eof 
    response.Write"<li><a href='join.asp?id="&rs("id")&"'>"&rs("sortname")&"</a></li>"

  rs.movenext
  wend
     rs.close
 set rs=nothing

end function





function case_a()

  dim sid
  sid=request.QueryString("sid")
  if sid="" or (not isnumeric(sid)) then
    response.write "<div align='center'>数据读取出错...</div>"
    exit function
  end if
  dim rs,sql
  set rs = server.createobject("adodb.recordset")
  sql="select * from pp_cgal where ViewFlag and sortid="&sid
  rs.open sql,conn,1,3
  if rs.bof and rs.eof then
    response.write "<div style='width:100%;clear:both;height:30px;'></div><div align='center'>数据更新中...</div>"
  else
     response.Write rs("content")
end if
  rs.close
  set rs=nothing

end function

function indexpro()
dim tedians
set rs = server.createobject("adodb.recordset")
  sql="select top 4 * from pp_products where ViewFlag and Exclusive  order by id desc"
  rs.open sql,conn,1,3
  
  	 if StrLen(Removehtml(rs("tedian")))<=130 then
        tedians=Removehtml(rs("tedian"))
	  else 
	     tedians=StrLeft(Removehtml(Removehtml(rs("tedian"))),129)
	   end if



do while not rs.eof
response.Write "<div class='index_pro_box'><div class='index_pro_box_img'><a href='productview.asp?id="&rs("id")&"&sortid="&rs("sortid")&"'><img src='"&rs("bigpic2")&"' width=140 height=190 border=0/></a></div><div class='index_pro_box_txt'><a href='productview.asp?id="&rs("id")&"&sortid="&rs("sortid")&"'>"&rs("productname")&"</a></div></div>"
rs.movenext
loop
     rs.close
 set rs=nothing

end function


function caseleft()
dim sid,i,rss,sqll,rs,id
sid=cint(request("pid"))
set rs = server.createobject("adodb.recordset") 
	if sid=5 or sid =4 or sid=0 then
  sql="select  * from pp_cgalsort where parentID=3  and ViewFlag  order by id asc"
  else
  sql="select  * from pp_cgalsort where parentID="&sid&"  and ViewFlag  order by id asc"
  end if
  rs.open sql,conn,1,1
   i=0
   if rs.eof and rs.bof then
   		response.Write "<div class='collapsed'><span><p class='spanp'>暂无信息</p></span></div>"
   end if
   while not rs.eof


	response.Write "<div class='collapsed'><span><p class='spanp'>"&rs("sortname")&"</p></span>"
	

	set rss = server.createobject("adodb.recordset") 
    sqll="select  * from pp_cgalsort where parentID="&rs("id")&"  and ViewFlag  order by id asc"
  rss.open sqll,conn,1,1
   while not rss.eof
	response.Write "<a href='case.asp?sid="&rss("id")&"&pid="&sid&"'><p>"&rss("sortname")&"</p></a>"
  rss.movenext
  wend 
     rss.close
 set rss=nothing


response.Write "</div>"
  rs.movenext
  wend 
     rs.close
 set rs=nothing
 
end function

function case_p() 

 dim rs,sql,page,sid,pid
 pid=Request.QueryString("pid")
 sid=Request.QueryString("sid")
page=Trim(Request.QueryString("Page"))
If Request("Page")<>"" Then
If Cint(Request("Page"))<1 Then
CurrentPage=1
Else
CurrentPage=Cint(Request("Page"))
End If
End If
If Request("Page")="" Then
CurrentPage=1
End If
dim strnews,plist_bottom

Set rs=Server.CreateObject("ADODB.RecordSet")
 if sid<>"" then
 	if sid = 3 then
  sql="select * from pp_cgal where  ViewFlag and instr(sortpath,3)>0 order by Sequence asc"
  else
  sql="select * from pp_cgal where  ViewFlag and instr(sortpath,"&sid&")>0 order by Sequence asc"
  end if
else
   if pid<>"" then
  sql="select * from pp_cgal where  ViewFlag and Instr(SortPath,'"&pid&"')>0 order by Sequence asc"
  else
  sql="select * from pp_cgal where  ViewFlag and instr(sortpath,3)>0 order by Sequence asc"
  end if
  end if
   rs.open sql,conn,1,1
If rs.Eof And rs.bof Then


response.write"<Div style='margin-top:20px;text-align:center'>暂无信息！</DIV>"
PageCount1=1
Totalnumber=0
Else

Maxperpage=6
rs.Pagesize=MaxperPage
PageCount1=Rs.PageCount
rs.Move  (CurrentPage-1)*MaxperPage
Totalnumber=rs.RecordCount
N=0

plist_bottom=plist_bottom&"<table width='990px' hight='100px'><tr><td><div style='padding-left:400px;'>"
plist_bottom=plist_bottom&"[ <b>"&CurrentPage&"</b>/<b>"&PageCount1&"</b> ]&nbsp;"
Pageno=CurrentPage
If cint(Pageno)>1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href='case.asp?sortid="&sortid&"&sortpath="&sortpath&"'title=""index"">"
else
plist_bottom=plist_bottom&"<a href='case.asp'title=""index"">"
end if
End If
plist_bottom=plist_bottom&"[ 首页 ]</a>&nbsp;"
If Cint(Pageno)>1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href=case.asp?page="&Pageno-1&"&sortid="&sortid&"&sortpath="&sortpath&" title=""Previous"">"
else
plist_bottom=plist_bottom&"<a href=case.asp?page="&Pageno-1&" title=""Previous"">"
end if
End If
plist_bottom=plist_bottom&"[ 上一页 ]</a>&nbsp;"
If Cint(Pageno)< PageCount1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href=case.asp?page="&Pageno+1&"&sortid="&sortid&"&sortpath="&sortpath&" title=""Next"">"
else
plist_bottom=plist_bottom&"<a href=case.asp?page="&Pageno+1&" title=""Next"">"
End If
End If
plist_bottom=plist_bottom&"[ 下一页 ]</a>&nbsp;"
If Cint(Pageno)< Pagecount1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href='case.asp?page="&PageCount1&"&sortid="&sortid&"&sortpath="&sortpath&"' title=""Last"">"
else
plist_bottom=plist_bottom&"<a href='case.asp?page="&PageCount1&"' title=""Last"">"
End If
End If
plist_bottom=plist_bottom&"[ 末页 ]</a>"
plist_bottom=plist_bottom&"</div></td></tr></table>"


Row_Count=1
do while not rs.eof
N=N+1
	      if n=3 and n=6 then
   response.write"<br>"
   end if

	 if StrLen(Removehtml(rs("ProductName")))<=26 then
        ProductName=Removehtml(rs("ProductName"))
	  else 
	     ProductName=StrLeft(Removehtml(Removehtml(rs("ProductName"))),25)
	   end if
	   
	   if StrLen(Removehtml(rs("content")))<=180 then
        content=Removehtml(rs("content"))
	  else 
	     content=StrLeft(Removehtml(Removehtml(rs("content"))),179)
	   end if
   
   response.Write "<div class='main_line_left_case_r_box'><div class='main_line_left_case_r_l'><a href='caseview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'><img src='"& replace(rs("smallpic"),"../","")&"' width='300' height='280' border='0'/></a></div><div class='main_line_left_case_r_r'><div class='main_line_left_case_r_r_tit'><a href='caseview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'>"&ProductName&"</a></div><div class='main_line_left_case_r_r_con'><p><a href='caseview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'>"&content&"</a></p></div></div></div>"
  
  
row_count=row_count+1
if n>=MaxPerPage then exit do
rs.movenext
loop

rs.close
response.write plist_bottom
end if
end function

function productleft2()
dim sid,i,rss,sqll,rs,id
sid=cint(request("pid"))
set rs = server.createobject("adodb.recordset") 

  sql="select  * from pp_productsort where parentID=0  and ViewFlag  order by id asc"
  rs.open sql,conn,1,1
   i=0
   while not rs.eof

'	if rs("id")=230 then
'	response.Write "<div id='prorighta' style='margin-top:10px;width:135px;height:24px;background:url(images/main_right_li_bg.jpg);'><a href='promsg.asp' style='width:100%;height:100%;display:block;text-align:right;font-weight:600;color:#545454;text-align:left;cursor:pointer;'><p style='width:90px;text-align:right;'>"&rs("sortname")&"</p></a></div>"
'	else
	response.Write "<div class='collapsed' style='margin-top:10px;height:auto !important;height:170px;min-height:170px;'><span style='text-align:left;'><p class='spanp'>"&rs("sortname")&"</p></span>"
	

	set rss = server.createobject("adodb.recordset") 
  sqll="select  * from pp_productsort where parentID="&rs("id")&"  and ViewFlag  order by sortid desc"
  rss.open sqll,conn,1,1
   while not rss.eof
	response.Write "<a href='product.asp?sid="&rss("id")&"&pid="&rss("id")&"'><p>"&rss("sortname")&"</p></a>"
  rss.movenext
  wend 
     rss.close
 set rss=nothing


response.Write "</div>"
'end if
  rs.movenext
  wend 
     rs.close
 set rs=nothing
 
end function


function menuabout()
set rs = server.createobject("adodb.recordset")
  sql="select * from pp_About where ViewFlag  order by id asc "
  rs.open sql,conn,1,1
  
 while not rs.eof 	
 	if rs("id")=57 then
    response.Write"<li><a href='aboutlist.asp'>"&rs("aboutname")&"</a></li>"
	else
    response.Write"<li><a href='about.asp?id="&rs("id")&"'>"&rs("aboutname")&"</a></li>"
	end if
  rs.movenext
  wend
     rs.close
 set rs=nothing

end function


function menuserver()
set rs = server.createobject("adodb.recordset")
  sql="select * from pp_newssort where ViewFlag and parentid=137  order by id asc "
  rs.open sql,conn,1,1
  
 while not rs.eof 
    response.Write"<li><a href='service.asp?id="&rs("id")&"'>"&rs("sortname")&"</a></li>"

  rs.movenext
  wend
     rs.close
 set rs=nothing

end function



function menunewsinfo()
set rs = server.createobject("adodb.recordset")
  sql="select * from pp_newssort where ViewFlag and parentid=156  order by id asc "
  rs.open sql,conn,1,1
  
 while not rs.eof 
 
    response.Write"<li><a href='newsinfo.asp?sid="&rs("id")&"'>"&rs("sortname")&"</a></li>"

  rs.movenext
  wend
     rs.close
 set rs=nothing

end function


function menupro()
set rs = server.createobject("adodb.recordset")
  sql="select * from pp_productsort where parentid=0 order by id asc "
  rs.open sql,conn,1,1
  
 while not rs.eof 

    response.Write"<li><a href='product.asp?sid="&rs("id")&"&pid="&rs("id")&"'>"&rs("sortname")&"</a></li>"

  rs.movenext
  wend
     rs.close
 set rs=nothing
end function

function menucase()
set rs = server.createobject("adodb.recordset")
  sql="select  * from pp_cgalsort where parentID=0  order by id asc"
  rs.open sql,conn,1,1
  
 while not rs.eof 
    response.Write"<li><a href='case.asp?sid="&rs("id")&"&pid="&rs("id")&"'>"&rs("sortname")&"</a></li>"

  rs.movenext
  wend
     rs.close
 set rs=nothing
 
 
  set rss = server.createobject("adodb.recordset") 

  sqls="select  * from pp_newssort where instr(sortpath,161)>0  and ViewFlag  order by id asc"
  rss.open sqls,conn,1,1
   while not rss.eof

	response.Write "<li><a href='caseinfo.asp?id="&rss("id")&"'><p>"&rss("sortname")&"</p></a></li>"

  rss.movenext
  wend 
     rss.close
 set rss=nothing
 
 
end function




function search() 
 dim rs,sql,page,key
key=Trim(Request("key"))
page=Trim(Request.QueryString("Page"))

If Request("Page")<>"" Then
If Cint(Request("Page"))<1 Then
CurrentPage=1
Else
CurrentPage=Cint(Request("Page"))
End If
End If
If Request("Page")="" Then
CurrentPage=1
End If
dim strnews,plist_bottom

Set rs=Server.CreateObject("ADODB.RecordSet")

  sql="select * from pp_Products where  ViewFlag and productname like '%"&key&"%' order by Sequence asc"

   rs.open sql,conn,1,1
If rs.Eof And rs.bof Then


response.write"<Div style='margin-top:20px;text-align:center'>抱歉！没有找到符合条件的相关信息</DIV>"
PageCount1=1
Totalnumber=0
Else

Maxperpage=4
rs.Pagesize=MaxperPage
PageCount1=Rs.PageCount
rs.Move  (CurrentPage-1)*MaxperPage
Totalnumber=rs.RecordCount
N=0

plist_bottom=plist_bottom&"<table style='width:100%;'><tr><td><div style='margin-top:10px;margin-left:370px'>"
plist_bottom=plist_bottom&"[ <b>"&CurrentPage&"</b>/<b>"&PageCount1&"</b> ]&nbsp;"
Pageno=CurrentPage
If cint(Pageno)>1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href='search.asp?sortid="&sortid&"&key="&key&"&sortpath="&sortpath&"'title=""index"">"
else
plist_bottom=plist_bottom&"<a href='search.asp&key="&key&"'title=""index"">"
end if
End If
plist_bottom=plist_bottom&"[ 第一页 ]</a>&nbsp;"
If Cint(Pageno)>1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href=search.asp?page="&Pageno-1&"&key="&key&"&sortid="&sortid&"&sortpath="&sortpath&" title=""Previous"">"
else
plist_bottom=plist_bottom&"<a href=search.asp?page="&Pageno-1&"&key="&key&" title=""Previous"">"
end if
End If
plist_bottom=plist_bottom&"[ 上一页 ]</a>&nbsp;"
If Cint(Pageno)< PageCount1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href=search.asp?page="&Pageno+1&"&sortid="&sortid&"&sortpath="&sortpath&"&key="&key&" title=""Next"">"
else
plist_bottom=plist_bottom&"<a href=search.asp?page="&Pageno+1&"&key="&key&" title=""Next"">"
End If
End If
plist_bottom=plist_bottom&"[ 下一页 ]</a>&nbsp;"
If Cint(Pageno)< Pagecount1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href='search.asp?page="&PageCount1&"&key="&key&"&sortid="&sortid&"&sortpath="&sortpath&"' title=""Last"">"
else
plist_bottom=plist_bottom&"<a href='search.asp?page="&PageCount1&"&key="&key&"' title=""Last"">"
End If
End If
plist_bottom=plist_bottom&"[ 尾页 ]</a>"
plist_bottom=plist_bottom&"</div></td></tr></table>"

Row_Count=1
do while not rs.eof
N=N+1
	      if n=3 and n=6 then
   response.write"<br>"
   end if
	  response.write"<div style='float:left;width:140px;margin:7px;' >"
	 if StrLen(Removehtml(rs("ProductName")))<=18 then
        ProductName=Removehtml(rs("ProductName"))
	  else 
	     ProductName=StrLeft(Removehtml(Removehtml(rs("ProductName"))),17)
	   end if
	response.write"<div style='width:140px;height:111px; text-align:left;'><a href='product.asp?sid="&rs("sortid")&"&pid="&rs("id")&"'><img src='"& replace(rs("smallpic"),"../","")&"' border='0'  width='140px' height='100px' alt='"
	response.write rs("productname")
   response.write"'></a></div><div style='text-align:center; '><a href='product.asp?sid="&rs("sortid")&"&pid="&rs("id")&"'><font color=#000000>&nbsp;"&ProductName&"&nbsp;</font></a></div>"
   
   response.write"</div>"
  
row_count=row_count+1
if n>=MaxPerPage then exit do
rs.movenext
loop
rs.close
response.write plist_bottom
end if



end function

function search2() 
 dim rs,sql,pagess,key
key=Trim(Request("key"))
pagess=Trim(Request.QueryString("Pagess"))

If Request("pagess")<>"" Then
If Cint(Request("pagess"))<1 Then
CurrentPage=1
Else
CurrentPage=Cint(Request("pagess"))
End If
End If
If Request("pagess")="" Then
CurrentPage=1
End If
dim strnews,plist_bottom

Set rs=Server.CreateObject("ADODB.RecordSet")

  sql="select * from pp_cgal where  ViewFlag and (instr(sortpath,1)>0 or instr(sortpath,3)>0) and productname like '%"&key&"%' order by Sequence desc"

   rs.open sql,conn,1,1
If rs.Eof And rs.bof Then


response.write"<Div style='margin-top:20px;text-align:center'>抱歉！没有找到符合条件的相关信息</DIV>"
PageCount1=1
Totalnumber=0
Else

Maxperpage=4
rs.Pagesize=MaxperPage
PageCount1=Rs.PageCount
rs.Move  (CurrentPage-1)*MaxperPage
Totalnumber=rs.RecordCount
N=0

plist_bottom=plist_bottom&"<table style='width:100%;'><tr><td><div style='margin-top:10px;margin-left:370px'>"
plist_bottom=plist_bottom&"[ <b>"&CurrentPage&"</b>/<b>"&PageCount1&"</b> ]&nbsp;"
Pageno=CurrentPage
If cint(Pageno)>1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href='search.asp?sortid="&sortid&"&key="&key&"&sortpath="&sortpath&"'title=""index"">"
else
plist_bottom=plist_bottom&"<a href='search.asp&key="&key&"'title=""index"">"
end if
End If
plist_bottom=plist_bottom&"[ 第一页 ]</a>&nbsp;"
If Cint(Pageno)>1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href=search.asp?pagess="&Pageno-1&"&key="&key&"&sortid="&sortid&"&sortpath="&sortpath&" title=""Previous"">"
else
plist_bottom=plist_bottom&"<a href=search.asp?pagess="&Pageno-1&"&key="&key&" title=""Previous"">"
end if
End If
plist_bottom=plist_bottom&"[ 上一页 ]</a>&nbsp;"
If Cint(Pageno)< PageCount1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href=search.asp?pagess="&Pageno+1&"&sortid="&sortid&"&sortpath="&sortpath&"&key="&key&" title=""Next"">"
else
plist_bottom=plist_bottom&"<a href=search.asp?pagess="&Pageno+1&"&key="&key&" title=""Next"">"
End If
End If
plist_bottom=plist_bottom&"[ 下一页 ]</a>&nbsp;"
If Cint(Pageno)< Pagecount1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href='search.asp?pagess="&PageCount1&"&key="&key&"&sortid="&sortid&"&sortpath="&sortpath&"' title=""Last"">"
else
plist_bottom=plist_bottom&"<a href='search.asp?pagess="&PageCount1&"&key="&key&"' title=""Last"">"
End If
End If
plist_bottom=plist_bottom&"[ 尾页 ]</a>"
plist_bottom=plist_bottom&"</div></td></tr></table>"

Row_Count=1
do while not rs.eof
N=N+1
	      if n=3 and n=6 then
   response.write"<br>"
   end if
	  response.write"<div style='float:left;width:140px;margin:7px;' >"
	 if StrLen(Removehtml(rs("ProductName")))<=18 then
        ProductName=Removehtml(rs("ProductName"))
	  else 
	     ProductName=StrLeft(Removehtml(Removehtml(rs("ProductName"))),17)
	   end if
	response.write"<div style='width:140px;height:111px; text-align:left;'><a href='caseview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'><img src='"& replace(rs("smallpic"),"../","")&"' border='0'  width='140px' height='100px' alt='"
	response.write rs("productname")
   response.write"'></a></div><div style='text-align:center; '><a href='caseview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'><font color=#000000>&nbsp;"&ProductName&"&nbsp;</font></a></div>"
   
   response.write"</div>"
  
row_count=row_count+1
if n>=MaxPerPage then exit do
rs.movenext
loop
rs.close
response.write plist_bottom
end if



end function

function searchl() 
 dim rs,sql,page,key
key=Trim(Request("key"))
page=Trim(Request.QueryString("Page"))

If Request("Page")<>"" Then
If Cint(Request("Page"))<1 Then
CurrentPage=1
Else
CurrentPage=Cint(Request("Page"))
End If
End If
If Request("Page")="" Then
CurrentPage=1
End If
dim strnews,plist_bottom

Set rs=Server.CreateObject("ADODB.RecordSet")

  sql="select * from pp_Products where  ViewFlag and productname like '%"&key&"%' order by Sequence asc"

   rs.open sql,conn,1,1
If rs.Eof And rs.bof Then


response.write"<Div style='margin-top:20px;text-align:center'>抱歉！没有找到符合条件的相关信息</DIV>"
PageCount1=1
Totalnumber=0
Else

Maxperpage=12
rs.Pagesize=MaxperPage
PageCount1=Rs.PageCount
rs.Move  (CurrentPage-1)*MaxperPage
Totalnumber=rs.RecordCount
N=0

plist_bottom=plist_bottom&"<table style='width:100%;'><tr><td><div style='margin-top:5px;margin-left:370px'>"
plist_bottom=plist_bottom&"[ <b>"&CurrentPage&"</b>/<b>"&PageCount1&"</b> ]&nbsp;"
Pageno=CurrentPage
If cint(Pageno)>1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href='search.asp?sortid="&sortid&"&key="&key&"&sortpath="&sortpath&"&search=p' title=""index"">"
else
plist_bottom=plist_bottom&"<a href='search.asp&key="&key&"&search=p' title=""index"">"
end if
End If
plist_bottom=plist_bottom&"[ 第一页 ]</a>&nbsp;"
If Cint(Pageno)>1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href='search.asp?page="&Pageno-1&"&key="&key&"&sortid="&sortid&"&sortpath="&sortpath&"&search=p' title=""Previous"">"
else
plist_bottom=plist_bottom&"<a href='search.asp?page="&Pageno-1&"&key="&key&"&search=p' title=""Previous"">"
end if
End If
plist_bottom=plist_bottom&"[ 上一页 ]</a>&nbsp;"
If Cint(Pageno)< PageCount1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href='search.asp?page="&Pageno+1&"&sortid="&sortid&"&sortpath="&sortpath&"&key="&key&"&search=p' title=""Next"">"
else
plist_bottom=plist_bottom&"<a href='search.asp?page="&Pageno+1&"&key="&key&"&search=p' title=""Next"">"
End If
End If
plist_bottom=plist_bottom&"[ 下一页 ]</a>&nbsp;"
If Cint(Pageno)< Pagecount1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href='search.asp?page="&PageCount1&"&key="&key&"&sortid="&sortid&"&sortpath="&sortpath&"&search=p' title=""Last"">"
else
plist_bottom=plist_bottom&"<a href='search.asp?page="&PageCount1&"&key="&key&"&search=p' title=""Last"">"
End If
End If
plist_bottom=plist_bottom&"[ 尾页 ]</a>"
plist_bottom=plist_bottom&"</div></td></tr></table>"

Row_Count=1
do while not rs.eof
N=N+1
	      if n=3 and n=6 then
   response.write"<br>"
   end if
	  response.write"<div style='float:left;width:140px;margin:7px;' >"
	 if StrLen(Removehtml(rs("ProductName")))<=18 then
        ProductName=Removehtml(rs("ProductName"))
	  else 
	     ProductName=StrLeft(Removehtml(Removehtml(rs("ProductName"))),17)
	   end if
	response.write"<div style='width:140px;height:111px; text-align:left;'><a href='product.asp?sid="&rs("sortid")&"&pid="&rs("id")&"'><img src='"& replace(rs("smallpic"),"../","")&"' border='0'  width='140px' height='100px' alt='"
	response.write rs("productname")
   response.write"'></a></div><div style='text-align:center; '><a href='product.asp?sid="&rs("sortid")&"&pid="&rs("id")&"'><font color=#000000>&nbsp;"&ProductName&"&nbsp;</font></a></div>"
   
   response.write"</div>"
  
row_count=row_count+1
if n>=MaxPerPage then exit do
rs.movenext
loop
rs.close
response.write plist_bottom
end if



end function

function search3() 
 dim rs,sql,page,key
key=Trim(Request("key"))
page=Trim(Request.QueryString("Page"))

If Request("Page")<>"" Then
If Cint(Request("Page"))<1 Then
CurrentPage=1
Else
CurrentPage=Cint(Request("Page"))
End If
End If
If Request("Page")="" Then
CurrentPage=1
End If
dim strnews,plist_bottom

Set rs=Server.CreateObject("ADODB.RecordSet")

  sql="select * from pp_cgal where  ViewFlag and (instr(sortpath,1)>0 or instr(sortpath,3)>0) and productname like '%"&key&"%' order by Sequence desc"

   rs.open sql,conn,1,1
If rs.Eof And rs.bof Then


response.write"<Div style='margin-top:20px;text-align:center'>抱歉！没有找到符合条件的相关信息</DIV>"
PageCount1=1
Totalnumber=0
Else

Maxperpage=12
rs.Pagesize=MaxperPage
PageCount1=Rs.PageCount
rs.Move  (CurrentPage-1)*MaxperPage
Totalnumber=rs.RecordCount
N=0

plist_bottom=plist_bottom&"<table style='width:100%;'><tr><td><div style='margin-top:5px;margin-left:370px'>"
plist_bottom=plist_bottom&"[ <b>"&CurrentPage&"</b>/<b>"&PageCount1&"</b> ]&nbsp;"
Pageno=CurrentPage
If cint(Pageno)>1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href='search.asp?sortid="&sortid&"&key="&key&"&sortpath="&sortpath&"&search=p' title=""index"">"
else
plist_bottom=plist_bottom&"<a href='search.asp&key="&key&"&search=p' title=""index"">"
end if
End If
plist_bottom=plist_bottom&"[ 第一页 ]</a>&nbsp;"
If Cint(Pageno)>1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href='search.asp?page="&Pageno-1&"&key="&key&"&sortid="&sortid&"&sortpath="&sortpath&"&search=c' title=""Previous"">"
else
plist_bottom=plist_bottom&"<a href='search.asp?page="&Pageno-1&"&key="&key&"&search=c' title=""Previous"">"
end if
End If
plist_bottom=plist_bottom&"[ 上一页 ]</a>&nbsp;"
If Cint(Pageno)< PageCount1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href='search.asp?page="&Pageno+1&"&sortid="&sortid&"&sortpath="&sortpath&"&key="&key&"&search=c' title=""Next"">"
else
plist_bottom=plist_bottom&"<a href='search.asp?page="&Pageno+1&"&key="&key&"&search=c' title=""Next"">"
End If
End If
plist_bottom=plist_bottom&"[ 下一页 ]</a>&nbsp;"
If Cint(Pageno)< Pagecount1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href='search.asp?page="&PageCount1&"&key="&key&"&sortid="&sortid&"&sortpath="&sortpath&"&search=c' title=""Last"">"
else
plist_bottom=plist_bottom&"<a href='search.asp?page="&PageCount1&"&key="&key&"&search=c' title=""Last"">"
End If
End If
plist_bottom=plist_bottom&"[ 尾页 ]</a>"
plist_bottom=plist_bottom&"</div></td></tr></table>"

Row_Count=1
do while not rs.eof
N=N+1
	      if n=3 and n=6 then
   response.write"<br>"
   end if
	  response.write"<div style='float:left;width:140px;margin:7px;' >"
	 if StrLen(Removehtml(rs("ProductName")))<=18 then
        ProductName=Removehtml(rs("ProductName"))
	  else 
	     ProductName=StrLeft(Removehtml(Removehtml(rs("ProductName"))),17)
	   end if
	response.write"<div style='width:140px;height:111px; text-align:left;'><a href='caseview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'><img src='"& replace(rs("smallpic"),"../","")&"' border='0'  width='140px' height='100px' alt='"
	response.write rs("productname")
   response.write"'></a></div><div style='text-align:center; '><a href='caseview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'><font color=#000000>&nbsp;"&ProductName&"&nbsp;</font></a></div>"
   
   response.write"</div>"
  
row_count=row_count+1
if n>=MaxPerPage then exit do
rs.movenext
loop
rs.close
response.write plist_bottom
end if



end function

function searchnews() 
 dim rs,sql,pages,key,Addtime
key=Trim(Request("key"))
pages=Trim(Request.QueryString("pages"))

If Request("pages")<>"" Then
If Cint(Request("pages"))<1 Then
CurrentPage=1
Else
CurrentPage=Cint(Request("pages"))
End If
End If
If Request("pages")="" Then
CurrentPage=1
End If
dim strnews,plist_bottom
Set rs=Server.CreateObject("ADODB.RecordSet")

  sql="select * from pp_news where  ViewFlag and newsname like '%"&key&"%' order by id asc"

   rs.open sql,conn,1,1
Response.Write "<table width='100%' border='0' cellspacing='0' cellpadding='0' >"
If rs.Eof And rs.bof Then


response.write"<Div style='margin-top:20px;margin-left:0px;text-align:center'>抱歉！没有找到符合条件的相关信息</DIV></table>"
PageCount1=1
Totalnumber=0
Else

Maxperpage=6
rs.Pagesize=MaxperPage
PageCount1=Rs.PageCount
rs.Move  (CurrentPage-1)*MaxperPage
Totalnumber=rs.RecordCount
N=0

plist_bottom=plist_bottom&"<table style='width:100%;'><tr><td><div style='margin-top:10px;margin-left:370px'>"
plist_bottom=plist_bottom&"[ <b>"&CurrentPage&"</b>/<b>"&PageCount1&"</b> ]&nbsp;"
Pageno=CurrentPage
If cint(Pageno)>1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href='search.asp?sortid="&sortid&"&sortpath="&sortpath&"&key="&key&"' title=""index"">"
else
plist_bottom=plist_bottom&"<a href='search.asp&key="&key&"' title=""index"">"
end if
End If
plist_bottom=plist_bottom&"[ 第一页 ]</a>&nbsp;"
If Cint(Pageno)>1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href=search.asp?pages="&Pageno-1&"&sortid="&sortid&"&sortpath="&sortpath&"&key="&key&" title=""Previous"">"
else
plist_bottom=plist_bottom&"<a href=search.asp?pages="&Pageno-1&"&key="&key&" title=""Previous"">"
end if
End If
plist_bottom=plist_bottom&"[ 上一页 ]</a>&nbsp;"
If Cint(Pageno)< PageCount1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href=search.asp?pages="&Pageno+1&"&key="&key&"&sortid="&sortid&"&sortpath="&sortpath&" title=""Next"">"
else
plist_bottom=plist_bottom&"<a href=search.asp?pages="&Pageno+1&"&key="&key&" title=""Next"">"
End If
End If
plist_bottom=plist_bottom&"[ 下一页 ]</a>&nbsp;"
If Cint(Pageno)< Pagecount1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href='search.asp?pages="&PageCount1&"&key="&key&"&sortid="&sortid&"&sortpath="&sortpath&"' title=""Last"">"
else
plist_bottom=plist_bottom&"<a href='search.asp?pages="&PageCount1&"&key="&key&"' title=""Last"">"
End If
End If
plist_bottom=plist_bottom&"[ 尾页 ]</a>"
plist_bottom=plist_bottom&"</div></td></tr></table>"

Row_Count=1
do while not rs.eof
N=N+1
	      if n=3 and n=6 then
   response.write"<br>"
   end if
   





	Addtime=year(rs("AddTime"))&"-"&month(rs("AddTime"))&"-"&day(rs("AddTime"))
	  Response.Write "<tr>" & vbCrLf
      Response.Write "<td width='350' height=30 ><a href='NewsView.asp?ID="&rs("ID")&"&sid="&rs("SortID")&"' style='width:300px;'>"&rs("NewsName")&"</a></td>" & vbCrLf
      Response.Write "<td width='185' style='border-bottom:#222222 1px dashed'><font color=#222222>添加日期："&rs("addtime")&"</font></td>" & vbCrLf
      Response.Write "</tr>" & vbCrLf




   

  
row_count=row_count+1
if n>=MaxPerPage then exit do
rs.movenext
loop 
rs.close
response.write "</table>"
response.write plist_bottom
end if



end function
function searchnewsl() 
 dim rs,sql,pages,key,Addtime
key=Trim(Request("key"))
pages=Trim(Request.QueryString("pages"))

If Request("pages")<>"" Then
If Cint(Request("pages"))<1 Then
CurrentPage=1
Else
CurrentPage=Cint(Request("pages"))
End If
End If
If Request("pages")="" Then
CurrentPage=1
End If
dim strnews,plist_bottom
Set rs=Server.CreateObject("ADODB.RecordSet")

  sql="select * from pp_news where  ViewFlag and newsname like '%"&key&"%' order by id asc"

   rs.open sql,conn,1,1
Response.Write "<table width='100%' border='0' cellspacing='0' cellpadding='0' >"
If rs.Eof And rs.bof Then


response.write"<Div style='margin-top:20px;margin-left:50px;text-align:center'>抱歉！没有找到符合条件的相关信息</DIV></table>"
PageCount1=1
Totalnumber=0
Else

Maxperpage=14
rs.Pagesize=MaxperPage
PageCount1=Rs.PageCount
rs.Move  (CurrentPage-1)*MaxperPage
Totalnumber=rs.RecordCount
N=0

plist_bottom=plist_bottom&"<table style='width:100%;'><tr><td><div style=' margin-left:370px'>"
plist_bottom=plist_bottom&"[ <b>"&CurrentPage&"</b>/<b>"&PageCount1&"</b> ]&nbsp;"
Pageno=CurrentPage
If cint(Pageno)>1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href='search.asp?sortid="&sortid&"&sortpath="&sortpath&"&key="&key&"&search=n' title=""index"">"
else
plist_bottom=plist_bottom&"<a href='search.asp&key="&key&"&search=n' title=""index"">"
end if
End If
plist_bottom=plist_bottom&"[ 第一页 ]</a>&nbsp;"
If Cint(Pageno)>1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href='search.asp?pages="&Pageno-1&"&sortid="&sortid&"&sortpath="&sortpath&"&key="&key&"&search=n' title=""Previous"">"
else
plist_bottom=plist_bottom&"<a href='search.asp?pages="&Pageno-1&"&key="&key&"&search=n' title=""Previous"">"
end if
End If
plist_bottom=plist_bottom&"[ 上一页 ]</a>&nbsp;"
If Cint(Pageno)< PageCount1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href='search.asp?pages="&Pageno+1&"&key="&key&"&sortid="&sortid&"&sortpath="&sortpath&"&search=n' title=""Next"">"
else
plist_bottom=plist_bottom&"<a href='search.asp?pages="&Pageno+1&"&key="&key&"&search=n' title=""Next"">"
End If
End If
plist_bottom=plist_bottom&"[ 下一页 ]</a>&nbsp;"
If Cint(Pageno)< Pagecount1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href='search.asp?pages="&PageCount1&"&key="&key&"&sortid="&sortid&"&sortpath="&sortpath&"&search=n' title=""Last"">"
else
plist_bottom=plist_bottom&"<a href='search.asp?pages="&PageCount1&"&key="&key&"&search=n' title=""Last"">"
End If
End If
plist_bottom=plist_bottom&"[ 尾页 ]</a>"
plist_bottom=plist_bottom&"</div></td></tr></table>"

Row_Count=1
do while not rs.eof
N=N+1
	      if n=3 and n=6 then
   response.write"<br>"
   end if
   





	Addtime=year(rs("AddTime"))&"-"&month(rs("AddTime"))&"-"&day(rs("AddTime"))
	  Response.Write "<tr>" & vbCrLf
      Response.Write "<td width='400' height=30 ><a href='NewsView.asp?ID="&rs("ID")&"&sid="&rs("SortID")&"' style='width:300px;'>"&rs("NewsName")&"</a></td>" & vbCrLf
      Response.Write "<td width='185' style='border-bottom:#222222 1px dashed'><font color=#222222>添加日期："&rs("addtime")&"</font></td>" & vbCrLf
      Response.Write "</tr>" & vbCrLf
  
row_count=row_count+1
if n>=MaxPerPage then exit do
rs.movenext
loop 
rs.close
response.write "</table>"
response.write plist_bottom
end if
end function


function searchlist()
key=Trim(Request("key"))
response.Write "<li><a href='search.asp?key="&key&"&search=n'><div class='main_line_con_li'><p>信息检索结果</p></div></a></li><li><a href='search.asp?key="&key&"&search=p'><div class='main_line_con_li'><p>产品检索结果</p></div></a></li><li><a href='search.asp?key="&key&"&search=c'><div class='main_line_con_li'><p>工程检索结果</p></div></a></li>"
end function


function jobslist()
dim rs,sql,id

set rs = server.createobject("adodb.recordset")
 sql="select * from pp_jobs where ViewFlag"
  rs.open sql,conn,1,3
  
  if rs.eof and rs.bof then
  	response.Write "<div style='width:100%;text-align:center;height:50px;line-height:50px;'>暂无信息</div>"
  else
  
   while not rs.eof
  response.Write "<LI><A HREF='jobview.asp?id="&rs("id")&"'><p style='width:100%;height:24px;line-height:24px;font-weight:600;'>职位："&rs("jobname")&"</p>"&rs("content")&"</A></LI><li style='margin:0px;padding:0px;width:100%;height:20px;clear:both;overflow:hidden;border-bottom:none;'></li>"
  rs.movenext
  wend
  end if
     rs.close
 set rs=nothing
end function



function videolist()
  dim SortPath
      SortPath=request.QueryString("SortPath")
  dim idCount'记录总数
  dim pages'每页条数
      pages=8
  dim pagec'总页数
  dim page'页码
      page=clng(request("Page"))
  dim pagenc'每页显示的分页页码数量=pagenc*2+1
      pagenc=2
  dim pagenmax'每页显示的分页的最大页码
  dim pagenmin'每页显示的分页的最小页码
  dim datafrom'数据表名
      datafrom="pp_news"
  dim datawhere'数据条件
      datawhere="where ViewFlag and instr(sortpath,154)>0 "
  dim sqlid'本页需要用到的id
  dim Myself,PATH_INFO,QUERY_STRING'本页地址和参数
      PATH_INFO = request.servervariables("PATH_INFO")
	  QUERY_STRING = request.ServerVariables("QUERY_STRING")'
      if QUERY_STRING = "" then
	    Myself = PATH_INFO & "?"
	  elseif Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")=0 then
	    Myself= PATH_INFO & "?" & QUERY_STRING & "&"
	  else
	    Myself = Left(PATH_INFO & "?" & QUERY_STRING,Instr(PATH_INFO & "?" & QUERY_STRING,"Page=")-1)
	  end if
  dim taxis'排序的语句 asc,desc
      taxis="order by id desc "
  dim i'用于循环的整数
  dim rs,sql'sql语句
  '获取记录总数
  sql="select count(ID) as idCount from ["& datafrom &"]" & datawhere
  set rs=server.createobject("adodb.recordset")
  rs.open sql,conn,0,1
  idCount=rs("idCount")
  '获取记录总数

  if(idcount>0) then'如果记录总数=0,则不处理
    if(idcount mod pages=0)then'如果记录总数除以每页条数有余数,则=记录总数/每页条数+1
	  pagec=int(idcount/pages)'获取总页数
   	else
      pagec=int(idcount/pages)+1'获取总页数
    end if
	'获取本页需要用到的id============================================
    '读取所有记录的id数值,因为只有id所以速度很快
    sql="select id from ["& datafrom &"] " & datawhere & taxis
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,1,1
    rs.pagesize = pages '每页显示记录数
    if page < 1 then page = 1
    if page > pagec then page = pagec
    if pagec > 0 then rs.absolutepage = page  
    for i=1 to rs.pagesize
	  if rs.eof then exit for  
	  if(i=1)then
	    sqlid=rs("id")
	  else
	    sqlid=sqlid &","&rs("id")
	  end if
	  rs.movenext
    next
  '获取本页需要用到的id结束============================================
  end if
 
  if(idcount>0 and sqlid<>"") then'如果记录总数=0,则不处理
    '用in刷选本页所语言的数据,仅读取本页所需的数据,所以速度快
    sql="select * from ["& datafrom &"] where instr(sortpath,154)>0 and id in("& sqlid &") "&taxis
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,0,1
	dim JobNO
	JobNO=1
    while not rs.eof '填充数据到表格
	
		 if StrLen(Removehtml(rs("newsname")))<=25 then
        newsname=Removehtml(rs("newsname"))
	  else 
	     newsname=StrLeft(Removehtml(Removehtml(rs("newsname"))),24)
	   end if
	
    Response.Write " <li><div class='video_img'><a href='videoview.asp?sid="&rs("id")&"'><img src='"&replace(rs("bigpic"),"../","")&"' width='290' height='240' border='0' alt='"&rs("newsname")&"'/></a></div><div class='video_txt'><a href='videoview.asp?sid="&rs("id")&"' title='"&rs("newsname")&"'>"&newsname&"</a></div></li>"	
	
	  rs.movenext
	  JobNO=JobNO+1
    wend
  else
    response.write "<div>No relevant information</div>"
	exit function
  end if


'   Response.Write "<li style='width:95%;text-align:right;'>页码：" & vbCrLf
  

'  pagenmin=page-pagenc '计算页码开始值
'  pagenmax=page+pagenc '计算页码结束值
'  if(pagenmin<1) then pagenmin=1 '如果页码开始值小于1则=1
 
'  if(pagenmax>pagec) then pagenmax=pagec '如果页码结束值大于总页数,则=总页数
'  for i = pagenmin to pagenmax'循环输出页码
'	if(i=page) then
'	  response.write ("&nbsp;<span class='current'>"& i &"</span>&nbsp;</li>")
'	else
'	  response.write ("&nbsp;<a href="& myself &"Page="& i &">"& i &"</a>&nbsp;</li>")
'	end if
'  next
  rs.close
  set rs=nothing
end function 

  function newsfaceback()
dim SortPath
SortPath=request.QueryString("id")
set rs = server.createobject("adodb.recordset")
  sql="select  * from pp_Newstxt where newid="&sortpath&" and ViewFlag  order by id desc"
  rs.open sql,conn,1,3
  
   while not rs.eof

   
   response.Write "<div class='news_faceback_con'><div class='news_faceback_con_tit'>"&rs("uname")&":</div><div class='news_faceback_con_con'>"&rs("utxt")&"</div></div>"


  rs.movenext
  wend

     rs.close
 set rs=nothing

end function


function aboutlistlc()
dim rs,sql,id

set rs = server.createobject("adodb.recordset")
 sql="select * from pp_news where instr(sortpath,175)>0 order by id desc"
  rs.open sql,conn,1,3
  
   while not rs.eof
  response.Write "<A HREF='about.asp?id=54&sid="&rs("id")&"'>"&rs("newsname")&"</A>　　"
  rs.movenext
  wend
     rs.close
 set rs=nothing

end function

function aboutlistlcv()
dim rs,sql,sid
sid=request.QueryString("sid")
set rs = server.createobject("adodb.recordset")
if sid="" then
 sql="select top 1 * from pp_news where instr(sortpath,175)>0 order by id desc"
else
 sql="select * from pp_news where id="&sid&" order by id desc"
 end if
  rs.open sql,conn,1,3
  
  response.Write rs("content")

     rs.close
 set rs=nothing

end function
%>