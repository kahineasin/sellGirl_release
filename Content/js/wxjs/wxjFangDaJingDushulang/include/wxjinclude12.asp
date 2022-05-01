<%
'用户中心显示用户信息(公用变量)
If Session("memName")<>"" Then
	Set rsMem=server.CreateObject("adodb.recordset")
	rsMem.open "select * from pp_Members where MemName='"&Session("memName")&"'",conn,1,3
	
	If rsMem("Sculpture")<>"" Then
		memSculpture=rsMem("Sculpture")
	Else
		memSculpture="img/user_face_no.jpg"
	End If
	memId=rsMem("id")
	memEmail=rsMem("email")
	memSex=rsMem("Sex")
	memMobile=rsMem("Mobile")
	memTelephone=rsMem("Telephone")
	memHomePage=rsMem("HomePage")
	memMoney=rsMem("money")
	memIntegral=rsMem("Integral")
	rsMem.close
	Set rsMem=Nothing
	
End If


'banner图,通用样式
  function wxjGetBanner(banId)
set rs = server.createobject("adodb.recordset")
  sql="select  * from pp_News where instr(sortpath,"&banid&")>0 and ViewFlag  order by id desc"
  rs.open sql,conn,1,3
  
   while not rs.eof
   
response.Write "<img src='"&replace(rs("bigpic"),"../","")&"' alt='"&rs("Source")&"' title='"&rs("content")&"'/>"

  rs.movenext
  wend
     rs.close
 set rs=nothing
end Function
'NAV栏-新闻表类生成,通用样式
Function wxjNewsGetNav(goUrl,id)
Set rs=server.CreateObject("adodb.recordset")
rs.open "select * from pp_NewsSort where ViewFlag and ParentID="&id,conn
	If rs.eof Then
		Response.write("<a href='#'>&nbsp;›&nbsp;no info</a>")
	Else
		Do While Not rs.eof
		Response.write("<a href='"&goUrl&".asp?id="&rs("id")&"&sid"&rs("id")&"'>&nbsp;›&nbsp;"&rs("SortName")&"</a>")
		rs.movenext
		Loop
	End If
End Function

'当前位置-about表类,通用样式
Function wxjAboutGetDangQian(defaultId)
	dim rs,sql,SortPath
	If Request.QueryString("pid")<>"" Then
		SortPath=Trim(Request.QueryString("pid"))
	Else
		SortPath=Trim(Request.QueryString("id"))
	End If
	set rs = server.createobject("adodb.recordset")
	 if SortPath<>"" then 
		 sql="select * from pp_About where id="&SortPath 

		  rs.open sql,conn,1,3
		 
		  response.Write rs("AboutName")
			 rs.close 
	 else
			 sql="select * from pp_About where id="&defaultId

		  rs.open sql,conn,1,3
		 
		  response.Write rs("AboutName")
			rs.close 
	  end if
	 set rs=nothing
End Function
'当前位置-News表类,通用样式
Function wxjGetDangQian(defaultId)
	dim rs,sql,SortPath
	If Request.QueryString("pid")<>"" Then
		SortPath=Trim(Request.QueryString("pid"))
	Else
		SortPath=Trim(Request.QueryString("id"))
	End If
	set rs = server.createobject("adodb.recordset")
	 if SortPath<>"" then 
		 sql="select * from pp_NewsSort where id="&SortPath 

		  rs.open sql,conn,1,3
		 
		  response.Write rs("sortname")
			 rs.close 
	 else
			 sql="select * from pp_NewsSort where id="&defaultId

		  rs.open sql,conn,1,3
		 
		  response.Write rs("sortname")
			rs.close 
	  end if
	 set rs=nothing
End Function
'新闻列表页-新闻表类(分页),通用样式

'详细展示页-新闻表类,通用样式
function wxjNewsView(idDefault)
dim rs,sql,sid
 sid=Trim(Request.QueryString("sid"))
  id=Trim(Request.QueryString("id"))
set rs = server.createobject("adodb.recordset")
if id<>"" then 
 sql="select top 1 * from pp_news where id="&id&" order by id desc" 
  else
 sql="select top 1 * from pp_news where instr(sortpath,"&idDefault&")>0 order by id desc"
  end if
  rs.open sql,conn,1,3
  if rs("content")<>"" then
  response.Write rs("content")
  else
   response.Write"更新中......"
end if
  rs.close
 set rs=nothing
end Function

'详细展示页-cgal表,通用样式
function wxjCgalSwfView(idDefault)
'response.Write("<script type='text/javascript' language='javascript'>alert('1234');</script>")
dim rs,sql,sid
 sid=Trim(Request.QueryString("sid"))
  id=Trim(Request.QueryString("id"))
set rs = server.createobject("adodb.recordset")
if id<>"" then 
 sql="select * from pp_cgal where id="&id&" order by id desc" 
  else
 'sql="select top 1 * from pp_cgal where instr(sortpath,"&idDefault&")>0 order by id desc"
 sql="select * from pp_cgal where id="&idDefault&" order by id desc"
  end if
  rs.open sql,conn,1,3
  
  if rs("SmallPic")<>"" then
  response.Write rs("SmallPic")
  else
   response.Write"更新中......"
end if
  rs.close
 set rs=nothing
end Function

'关于我们表,通用样式
function wxjAboutView(idDefault)
'response.Write("<script type='text/javascript' language='javascript'>alert('1234');</script>")
dim rs,sql,sid
 sid=Trim(Request.QueryString("sid"))
  id=Trim(Request.QueryString("id"))
set rs = server.createobject("adodb.recordset")
if id<>"" then 
 sql="select * from pp_About where id="&id&" order by id desc" 
  else
 'sql="select top 1 * from pp_cgal where instr(sortpath,"&idDefault&")>0 order by id desc"
 sql="select * from pp_About where id="&idDefault&" order by id desc"
  end if
  rs.open sql,conn,1,3
  
  if rs("Content")<>"" then
  response.Write rs("Content")
  else
   response.Write"更新中......"
end if
  rs.close
 set rs=nothing
end Function



'产品展示页(分页)
function suncangproduct()

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
  sql="select * from pp_Products where  ViewFlag and instr(sortpath,0)>0 order by AddTime desc"
  else
  sql="select * from pp_Products where  ViewFlag and instr(sortpath,"&sid&")>0 order by AddTime desc"
  end if
else
   if pid<>"" then
  sql="select * from pp_Products where  ViewFlag and Instr(SortPath,'"&pid&"')>0 order by AddTime desc"
  else
  sql="select * from pp_Products where  ViewFlag and instr(sortpath,0)>0 order by AddTime desc"
  end if
  end if
   rs.open sql,conn,1,1
If rs.Eof And rs.bof Then


response.write"<Div style='margin-top:20px;text-align:center;font-size:12px;color:#606060;'>暂无信息！</DIV>"
PageCount1=1
Totalnumber=0
Else

Maxperpage=10
rs.Pagesize=MaxperPage
PageCount1=Rs.PageCount
rs.Move  (CurrentPage-1)*MaxperPage
Totalnumber=rs.RecordCount
N=0

'plist_bottom=plist_bottom&"<div class='divBooklistPage'>"
'plist_bottom=plist_bottom&" <b style='font-size:12px;font-weight:normal;color:#707070;'>共有"&Totalnumber&"条&nbsp;显示第"&CurrentPage&"页&nbsp;总"&PageCount1&"页</b> &nbsp;"
Pageno=CurrentPage

'改样式

plist_bottom=plist_bottom&"<div class='divBooklistPage'>"
If cint(Pageno)>1 Then
	if sortid<>"" then
	plist_bottom=plist_bottom&"<a class='divBooklistPageBtnL' href='booklist.asp?sortid="&sortid&"&sortpath="&sortpath&"' title='index'>"
	else
	plist_bottom=plist_bottom&"<a class='divBooklistPageBtnL' href='booklist.asp' title=""index"">"
	end If
Else
	plist_bottom=plist_bottom&"<a class='divBooklistPageBtnL' href='booklist.asp' title=""index"">"
End If
plist_bottom=plist_bottom&" <img src='img/button_l_gray.jpg'/></a>"

If Cint(Pageno)>1 Then
	if sortid<>"" then
	plist_bottom=plist_bottom&"<a class='divBooklistPageInt' href=booklist.asp?page="&Pageno-1&"&sortid="&sortid&"&sortpath="&sortpath&" title=""Previous"">"
	else
	plist_bottom=plist_bottom&"<a class='divBooklistPageInt' href=booklist.asp?page="&Pageno-1&" title=""Previous"">"
	end If
	plist_bottom=plist_bottom&(CurrentPage-1)&"</a>"
End If

plist_bottom=plist_bottom&"<a class='divBooklistPageIntCurrent' href='#'>"&CurrentPage&"</a>"
If Cint(Pageno)< PageCount1 Then
	if sortid<>"" then
	plist_bottom=plist_bottom&"<a class='divBooklistPageInt' href=booklist.asp?page="&Pageno+1&"&sortid="&sortid&"&sortpath="&sortpath&" title=""Next"">"
	else
	plist_bottom=plist_bottom&"<a class='divBooklistPageInt' href=booklist.asp?page="&Pageno+1&" title=""Next"">"
	End If
	plist_bottom=plist_bottom&(CurrentPage+1)&"</a>"
End If

If Cint(Pageno)< Pagecount1 Then
	if sortid<>"" then
	plist_bottom=plist_bottom&"<a href='booklist.asp?page="&PageCount1&"&sortid="&sortid&"&sortpath="&sortpath&"' title=""Last"">"
	else
	plist_bottom=plist_bottom&"<a class='divBooklistPageBtnR' href='booklist.asp?page="&PageCount1&"' title=""Last"">"
	End If
Else
	plist_bottom=plist_bottom&"<a class='divBooklistPageBtnR' title=""Last"">"
End If
plist_bottom=plist_bottom&"<img src='img/button_r_orange.jpg'/></a>"
plist_bottom=plist_bottom&"</div>"


Row_Count=1
'页面内容
response.Write ("<div class='divBooklistC1'>")
n=0

do while not rs.eof
	n=n+1
	 if StrLen(Removehtml(rs("ProductName")))<=16 then
        ProductName=Removehtml(rs("ProductName"))
	  else 
	     ProductName=StrLeft(Removehtml(Removehtml(rs("ProductName"))),15)
	   end if
	   
	   if StrLen(Removehtml(rs("content")))<=180 then
        content=Removehtml(rs("content"))
	  else 
	     content=StrLeft(Removehtml(Removehtml(rs("content"))),179)
	   end if
   '<a href='produceview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'>
	response.Write ("<div style='position:relative;' class='divBooklistC1L'><div class='divBooklistC1LImg'><a title='"&ProductName&"' href='"& replace(rs("smallpic"),"../","")&"'><img src='"& replace(rs("smallpic"),"../","")&"'/></a></div><div class='divBooklistC1LC'><a href='")
	'这句输出文件地址
	If rs("downloadFile")<>"" Then
		Response.Write(replace(rs("downloadFile"),"../",""))
	Else
	End If
	
	Response.Write("'>"&ProductName&"<img style='position:absolute;right:19px;top:109px;float:right;height:13px;' src='img/download_btn.jpg'/></a></div></div>")
	rs.movenext
	If rs.eof Then
		response.Write ("</div>")
	Else
		If n Mod 5 = 0 Then
			If n Mod 10 = 0 Then
			response.Write ("</div>")
			Else
			response.Write ("</div><div class='divBooklistC1'>")
			End If
		Else
		End If
		
	End If

  
row_count=row_count+1
if n>=MaxPerPage then exit do
'rs.movenext
loop

rs.close
response.write plist_bottom
end if
end Function

'产品展示页(分页)
function suncangproductdisney()

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
  sql="select * from pp_Products where  ViewFlag and instr(sortpath,0)>0 order by AddTime desc"
  else
  sql="select * from pp_Products where  ViewFlag and instr(sortpath,"&sid&")>0 order by AddTime desc"
  end if
else
   if pid<>"" then
  sql="select * from pp_Products where  ViewFlag and Instr(SortPath,'"&pid&"')>0 order by AddTime desc"
  else
  sql="select * from pp_Products where  ViewFlag and instr(sortpath,272)>0 order by AddTime desc"
  end if
  end if
   rs.open sql,conn,1,1
If rs.Eof And rs.bof Then


response.write"<Div style='margin-top:20px;text-align:center;font-size:12px;color:#606060;'>暂无信息！</DIV>"
PageCount1=1
Totalnumber=0
Else

Maxperpage=10
rs.Pagesize=MaxperPage
PageCount1=Rs.PageCount
rs.Move  (CurrentPage-1)*MaxperPage
Totalnumber=rs.RecordCount
N=0

'plist_bottom=plist_bottom&"<div class='divBooklistPage'>"
'plist_bottom=plist_bottom&" <b style='font-size:12px;font-weight:normal;color:#707070;'>共有"&Totalnumber&"条&nbsp;显示第"&CurrentPage&"页&nbsp;总"&PageCount1&"页</b> &nbsp;"
Pageno=CurrentPage

'改样式

plist_bottom=plist_bottom&"<div class='divBooklistPage'>"
If cint(Pageno)>1 Then
	if sortid<>"" then
	plist_bottom=plist_bottom&"<a class='divBooklistPageBtnL' href='booklist.asp?sortid="&sortid&"&sortpath="&sortpath&"' title='index'>"
	else
	plist_bottom=plist_bottom&"<a class='divBooklistPageBtnL' href='booklist.asp' title=""index"">"
	end If
Else
	plist_bottom=plist_bottom&"<a class='divBooklistPageBtnL' href='booklist.asp' title=""index"">"
End If
plist_bottom=plist_bottom&" <img src='img/button_l_gray.jpg'/></a>"

If Cint(Pageno)>1 Then
	if sortid<>"" then
	plist_bottom=plist_bottom&"<a class='divBooklistPageInt' href=booklist.asp?page="&Pageno-1&"&sortid="&sortid&"&sortpath="&sortpath&" title=""Previous"">"
	else
	plist_bottom=plist_bottom&"<a class='divBooklistPageInt' href=booklist.asp?page="&Pageno-1&" title=""Previous"">"
	end If
	plist_bottom=plist_bottom&(CurrentPage-1)&"</a>"
End If

plist_bottom=plist_bottom&"<a class='divBooklistPageIntCurrent' href='#'>"&CurrentPage&"</a>"
If Cint(Pageno)< PageCount1 Then
	if sortid<>"" then
	plist_bottom=plist_bottom&"<a class='divBooklistPageInt' href=booklist.asp?page="&Pageno+1&"&sortid="&sortid&"&sortpath="&sortpath&" title=""Next"">"
	else
	plist_bottom=plist_bottom&"<a class='divBooklistPageInt' href=booklist.asp?page="&Pageno+1&" title=""Next"">"
	End If
	plist_bottom=plist_bottom&(CurrentPage+1)&"</a>"
End If

If Cint(Pageno)< Pagecount1 Then
	if sortid<>"" then
	plist_bottom=plist_bottom&"<a href='booklist.asp?page="&PageCount1&"&sortid="&sortid&"&sortpath="&sortpath&"' title=""Last"">"
	else
	plist_bottom=plist_bottom&"<a class='divBooklistPageBtnR' href='booklist.asp?page="&PageCount1&"' title=""Last"">"
	End If
Else
	plist_bottom=plist_bottom&"<a class='divBooklistPageBtnR' title=""Last"">"
End If
plist_bottom=plist_bottom&"<img src='img/button_r_orange.jpg'/></a>"
plist_bottom=plist_bottom&"</div>"


Row_Count=1
'页面内容
response.Write ("<div class='divBooklistC1'>")
n=0

do while not rs.eof
	n=n+1
	 if StrLen(Removehtml(rs("ProductName")))<=16 then
        ProductName=Removehtml(rs("ProductName"))
	  else 
	     ProductName=StrLeft(Removehtml(Removehtml(rs("ProductName"))),15)
	   end if
	   
	   if StrLen(Removehtml(rs("content")))<=180 then
        content=Removehtml(rs("content"))
	  else 
	     content=StrLeft(Removehtml(Removehtml(rs("content"))),179)
	   end if
   '<a href='produceview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'>
	response.Write ("<div style='position:relative;' class='divBooklistC1L'><div class='divBooklistC1LImg'><a title='"&ProductName&"' href='"& replace(rs("smallpic"),"../","")&"'><img src='"& replace(rs("smallpic"),"../","")&"'/></a></div><div class='divBooklistC1LC'><a href='")
	'这句输出文件地址
	If rs("downloadFile")<>"" Then
		Response.Write(replace(rs("downloadFile"),"../",""))
	Else
	End If
	
	Response.Write("'>"&ProductName&"<img style='position:absolute;right:19px;top:109px;float:right;height:13px;' src='img/download_btn.jpg'/></a></div></div>")
	rs.movenext
	If rs.eof Then
		response.Write ("</div>")
	Else
		If n Mod 5 = 0 Then
			If n Mod 10 = 0 Then
			response.Write ("</div>")
			Else
			response.Write ("</div><div class='divBooklistC1'>")
			End If
		Else
		End If
		
	End If

  
row_count=row_count+1
if n>=MaxPerPage then exit do
'rs.movenext
loop

rs.close
response.write plist_bottom
end if
end Function

'产品展示页(分页)
function suncangproductAge()

 dim rs,sql,page,sid,pid
 pid=Request.QueryString("pid")
 sid=Request.QueryString("sid")
 age=Request.QueryString("age")
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

   if age<>"" then
  sql="select * from pp_Products where  ViewFlag and age="&age&" order by AddTime desc"
  else
  sql="select * from pp_Products where  ViewFlag and instr(sortpath,0)>0 order by AddTime desc"
  end if

   rs.open sql,conn,1,1
If rs.Eof And rs.bof Then


response.write"<Div style='margin-top:20px;text-align:center;font-size:12px;color:#606060;'>暂无信息！</DIV>"
PageCount1=1
Totalnumber=0
Else

Maxperpage=10
rs.Pagesize=MaxperPage
PageCount1=Rs.PageCount
rs.Move  (CurrentPage-1)*MaxperPage
Totalnumber=rs.RecordCount
N=0

'plist_bottom=plist_bottom&"<div class='divBooklistPage'>"
'plist_bottom=plist_bottom&" <b style='font-size:12px;font-weight:normal;color:#707070;'>共有"&Totalnumber&"条&nbsp;显示第"&CurrentPage&"页&nbsp;总"&PageCount1&"页</b> &nbsp;"
Pageno=CurrentPage

'改样式

plist_bottom=plist_bottom&"<div class='divBooklistPage'>"
If cint(Pageno)>1 Then
	if sortid<>"" then
	plist_bottom=plist_bottom&"<a class='divBooklistPageBtnL' href='booklistage.asp?sortid="&sortid&"&sortpath="&sortpath&"' title='index'>"
	else
	plist_bottom=plist_bottom&"<a class='divBooklistPageBtnL' href='booklistage.asp' title=""index"">"
	end If
Else
	plist_bottom=plist_bottom&"<a class='divBooklistPageBtnL' href='booklistage.asp' title=""index"">"
End If
plist_bottom=plist_bottom&" <img src='img/button_l_gray.jpg'/></a>"

If Cint(Pageno)>1 Then
	if sortid<>"" then
	plist_bottom=plist_bottom&"<a class='divBooklistPageInt' href=booklistage.asp?page="&Pageno-1&"&sortid="&sortid&"&sortpath="&sortpath&" title=""Previous"">"
	else
	plist_bottom=plist_bottom&"<a class='divBooklistPageInt' href=booklistage.asp?page="&Pageno-1&" title=""Previous"">"
	end If
	plist_bottom=plist_bottom&(CurrentPage-1)&"</a>"
End If

plist_bottom=plist_bottom&"<a class='divBooklistPageInt' href='#'>"&CurrentPage&"</a>"
If Cint(Pageno)< PageCount1 Then
	if sortid<>"" then
	plist_bottom=plist_bottom&"<a class='divBooklistPageInt' href=booklistage.asp?page="&Pageno+1&"&sortid="&sortid&"&sortpath="&sortpath&" title=""Next"">"
	else
	plist_bottom=plist_bottom&"<a class='divBooklistPageInt' href=booklistage.asp?page="&Pageno+1&" title=""Next"">"
	End If
	plist_bottom=plist_bottom&(CurrentPage+1)&"</a>"
End If

If Cint(Pageno)< Pagecount1 Then
	if sortid<>"" then
	plist_bottom=plist_bottom&"<a href='booklistage.asp?page="&PageCount1&"&sortid="&sortid&"&sortpath="&sortpath&"' title=""Last"">"
	else
	plist_bottom=plist_bottom&"<a class='divBooklistPageBtnR' href='booklistage.asp?page="&PageCount1&"' title=""Last"">"
	End If
Else
	plist_bottom=plist_bottom&"<a class='divBooklistPageBtnR' title=""Last"">"
End If
plist_bottom=plist_bottom&"<img src='img/button_r_orange.jpg'/></a>"
plist_bottom=plist_bottom&"</div>"


Row_Count=1
'页面内容
response.Write ("<div class='divBooklistC1'>")
n=0

do while not rs.eof
	n=n+1
	 if StrLen(Removehtml(rs("ProductName")))<=16 then
        ProductName=Removehtml(rs("ProductName"))
	  else 
	     ProductName=StrLeft(Removehtml(Removehtml(rs("ProductName"))),15)
	   end if
	   
	   if StrLen(Removehtml(rs("content")))<=180 then
        content=Removehtml(rs("content"))
	  else 
	     content=StrLeft(Removehtml(Removehtml(rs("content"))),179)
	   end if
   '<a href='produceview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'>
	response.Write ("<div style='position:relative;' class='divBooklistC1L'><div class='divBooklistC1LImg'><a title='"&ProductName&"' href='"& replace(rs("smallpic"),"../","")&"'><img src='"& replace(rs("smallpic"),"../","")&"'/></a></div><div class='divBooklistC1LC'><a href='")
	'这句输出文件地址
	If rs("downloadFile")<>"" Then
		Response.Write(replace(rs("downloadFile"),"../",""))
	Else
	End If
	
	Response.Write("'>"&ProductName&"<img style='position:absolute;right:19px;top:109px;float:right;height:13px;' src='img/download_btn.jpg'/></a></div></div>")
	rs.movenext
	If rs.eof Then
		response.Write ("</div>")
	Else
		If n Mod 5 = 0 Then
			If n Mod 10 = 0 Then
			Else
			response.Write ("</div><div class='divBooklistC1'>")
			End If
		Else
		End If
		
	End If

  
row_count=row_count+1
if n>=MaxPerPage then exit do
'rs.movenext
loop

rs.close
response.write plist_bottom
end if
end Function
'最新活动信息
function wxjActivityNew()
dim rs,sql,sid
 sid=Trim(Request.QueryString("sid"))
set rs = server.createobject("adodb.recordset")

 sql="select * from pp_news where instr(sortpath,157)>0 order by AddTime desc" 

  rs.open sql,conn,1,3
  if rs("content")<>"" Then
	For i=1 To 2
		If rs.eof Then Exit For
			If i=1 Then
					if StrLen(Removehtml(rs("NewsName")))<=17 then
					ProductName=Removehtml(rs("NewsName"))
				  else 
					 ProductName=StrLeft(Removehtml(Removehtml(rs("NewsName"))),16)
				   end if
				
					if StrLen(Removehtml(rs("content")))<=180 then
					content=Removehtml(rs("content"))
				  else 
					 content=StrLeft(Removehtml(Removehtml(rs("content"))),179)
				   end if
				response.Write ("<div class='divActivityTCL'><div class='divActivityTCLImg'><a href='activityshow.asp?id="&rs("id")&"'><img src='"&rs("BigPic")&"'/></a></div><div class='divActivityTCLR'><div class='divActivityTCLRT'><a href='activityshow.asp?id="&rs("id")&"'>"&ProductName&"</a><span>(最新)</span></div><div class='divActivityTCLRC'><p><a href='activityshow.asp?id="&rs("id")&"'>"&content&"</a></p></div><div class='divActivityTCLRMore'><a href='activityshow.asp?id="&rs("id")&"'><img src='img/bbs_detail.jpg'/></a></div></div></div>")
			Else
				if StrLen(Removehtml(rs("NewsName")))<=17 then
					ProductName=Removehtml(rs("NewsName"))
				  else 
					 ProductName=StrLeft(Removehtml(Removehtml(rs("NewsName"))),16)
				   end if
				
					if StrLen(Removehtml(rs("content")))<=180 then
					content=Removehtml(rs("content"))
				  else 
					 content=StrLeft(Removehtml(Removehtml(rs("content"))),179)
				   end if
				response.Write ("<div class='divActivityTCR'><div class='divActivityTCLImg'><a href='activityshow.asp?id="&rs("id")&"'><img src='"&rs("BigPic")&"'/></a></div><div class='divActivityTCLR'><div class='divActivityTCLRT'><a href='activityshow.asp?id="&rs("id")&"'>"&ProductName&"</a><span>(最新)</span></div><div class='divActivityTCLRC'><p><a href='activityshow.asp?id="&rs("id")&"'>"&content&"&</a></p></div><div class='divActivityTCLRMore'><a href='activityshow.asp?id="&rs("id")&"'><img src='img/bbs_detail.jpg'/></a></div></div></div>")
			
			End If
			rs.movenext
		
	Next
 
  else
   response.Write"更新中......"
end if
  rs.close
 set rs=nothing
end Function

'活动回顾信息
function wxjActivityNewOld()
dim rs,sql,sid
 sid=Trim(Request.QueryString("sid"))
set rs = server.createobject("adodb.recordset")

 sql="select * from pp_news where instr(sortpath,158)>0 order by AddTime desc" 

  rs.open sql,conn,1,3
  if rs("content")<>"" Then
	For i=1 To 3
		If rs.eof Then Exit For
			
				if StrLen(Removehtml(rs("NewsName")))<=17 then
					ProductName=Removehtml(rs("NewsName"))
				  else 
					 ProductName=StrLeft(Removehtml(Removehtml(rs("NewsName"))),16)
				   end if
				
					if StrLen(Removehtml(rs("content")))<=180 then
					content=Removehtml(rs("content"))
				  else 
					 content=StrLeft(Removehtml(Removehtml(rs("content"))),179)
				   end If
				 
				 response.Write ("<div class='divActivity2L'><div class='divActivity2LImg'><a href='activityshow.asp?id="&rs("id")&"'><img src='"&rs("BigPic")&"'/></a></div><div class='divActivity2LT'><a href='activityshow.asp?id="&rs("id")&"'>"&ProductName&"</a></div><div class='divActivity2LC'><p><a href='activityshow.asp?id="&rs("id")&"'>"&content&"</a></p></div><div class='divActivity2LMore'><a href='activityshow.asp?id="&rs("id")&"'><img src='img/bbs_detail.jpg'/></a></div></div>"&Chr(13))

			
			rs.movenext
		
	Next
 
  else
   response.Write"更新中......"
end if
  rs.close
 set rs=nothing
end Function

'亲子活动信息
function wxjActivityNewParent()
dim rs,sql,sid
 sid=Trim(Request.QueryString("sid"))
set rs = server.createobject("adodb.recordset")

 sql="select * from pp_news where instr(sortpath,159)>0 order by AddTime desc" 

  rs.open sql,conn,1,3
  if rs("content")<>"" Then
	For i=1 To 3
		If rs.eof Then Exit For
			
				if StrLen(Removehtml(rs("NewsName")))<=17 then
					ProductName=Removehtml(rs("NewsName"))
				  else 
					 ProductName=StrLeft(Removehtml(Removehtml(rs("NewsName"))),16)
				   end if
				
					if StrLen(Removehtml(rs("content")))<=180 then
					content=Removehtml(rs("content"))
				  else 
					 content=StrLeft(Removehtml(Removehtml(rs("content"))),179)
				   end If
				 
				 response.Write ("<div class='divActivity3L'><div class='divActivity3LImg'><a href='activityshow.asp?id="&rs("id")&"'><img src='"&rs("BigPic")&"'/></a></div></div>")

				

			
			rs.movenext
		
	Next
 
  else
   response.Write"更新中......"
end if
  rs.close
 set rs=nothing
end Function

'产品特点AD广告IMG
Function cgaltedianadimg()
	If request.queryString("id")<>"" Then
		id=CInt(Trim(request.queryString("id")))
	Else
		id=54
	End If
	Set rs=server.CreateObject("adodb.recordset")
	rs.open "select * from pp_cgal where id="&id&" and ViewFlag",conn,1,3
	
	If rs.eof Then
		Response.write("no info")
	Else
		For i=1 To 10
		strSlidePic="slidepic"&CStr(i)
		strSlidePic1=CStr(strSlidePic)
		If rs(strSlidePic1)<>"" Then
		'Response.write("<script type='text/javascript' language='javascript'>alert('"&strSlidePic1&"');</script>")
		'If rs.eof Then Exit For
		Response.write("<a href='#' target='_blank'><img src='"&rs(strSlidePic1)&"' width='605' height='361' /><p>"&rs("ProductName")&"</p></a>")
		'rs.movenext
		End If
		Next
	End If
	rs.close
	Set rs=nothing

End Function

'cgal详细
function cgalview()
  dim sid,pid
  sid=request.QueryString("sid")
  pid=request.QueryString("pid")
  id=request.QueryString("id")

  dim rs,sql
  set rs = server.createobject("adodb.recordset")
  if id="" then
  sql="select top 1 * from pp_cgal where ViewFlag and SortID=36 order by id asc"
  else
  sql="select * from pp_cgal where ViewFlag and id="&id&" order by id desc"
  end if
  rs.open sql,conn,1,3

  if rs.bof and rs.eof then
    response.write "<div>暫無相關信息</div>"
  else
      'dim BigPic
	 ' BigPic=rs("BigPic2")
	 
	 response.Write "<div id='main_line_right_prozm_con_l' class='zoomybox'><a class='two zoom' id='proimg_a' href='"&rs("slidepicpart1")&"' ><img style='width:583px;height:348px;' alt='' id='idProShowPic' src='"&rs("slidepicpart1")&"' border='0'/></a></div>"
	 
	  end if
  rs.close
  set rs=nothing
end function

'cgal下列表
function cgallistzm()
dim sid,rs,id,pid
pid=trim(request.QueryString("pid"))
set rs = server.createobject("adodb.recordset") 
	if pid<>"" Then
	sql="select * from pp_products where SortID ="&pid&" and ViewFlag  order by id desc"
	
	else
	sql="select top 10 * from pp_products where ViewFlag  order by id desc"
  	end if
  rs.open sql,conn,1,1

   while not rs.eof


	response.Write "<li><a class='pro_a' ptxt='"&rs("content")&"' pname='"&rs("productname")&"' psrc='"&rs("bigpic2")&"' phref='productshow.asp?sid="&rs("sortid")&"&id="&rs("id")&"'><img style='width:119px;height:70px;' src='"&rs("smallpic")&"' onclick='document.getElementById(""idProShowPic"").src=this.src'/></a></li>"
	
  rs.movenext
  wend 
  
     rs.close
 set rs=nothing
end function
'产品show列表
function proshowlistzm()
	If request.queryString("id")<>"" Then
		id=CInt(Trim(request.queryString("id")))
	Else
		id=54
	End If
	Set rs=server.CreateObject("adodb.recordset")
	rs.open "select * from pp_cgal where id="&id&" and ViewFlag",conn,1,3
	
	If rs.eof Then
		Response.write("no info")
	Else
		For i=1 To 10
		strSlidePic="slidepicpart"&CStr(i)
		strSlidePic1=CStr(strSlidePic)
		If rs(strSlidePic1)<>"" Then
		'Response.write("<script type='text/javascript' language='javascript'>alert('"&strSlidePic1&"');</script>")
		'If rs.eof Then Exit For
		response.Write "<li><a class='pro_a' ptxt='' pname='"&rs("productname")&"' psrc='"&rs(strSlidePic1)&"' phref='productshow.asp?sid="&rs("sortid")&"&id="&rs("id")&"'><img style='width:119px;height:70px;' src='"&rs(strSlidePic1)&"' onclick='document.getElementById(""idProShowPic"").src=this.src'/></a></li>"
		'Response.write("<a href='1234' target='_blank'><img src='"&rs(strSlidePic1)&"' width='605' height='361' /><p>"&rs("ProductName")&"</p></a>")
		'rs.movenext
		End If
		Next
	End If
  
     rs.close
 set rs=nothing
end function
'论坛头条显示
function bbsindexhead()
	Set rs=server.createobject("adodb.RecordSet")
	rs.open "select top 2 * from pp_News where ViewFlag and sortid=194 order by id desc",conn,1,3
	If rs.eof Then
	Else
		For i=1 to 2
		If rs.eof Then Exit For
		'	if StrLen(Removehtml(rs("NewsName")))<=26 then
		    '    NewsName=Removehtml(rs("NewsName"))
		'	  else 
			'     NewsName=StrLeft(Removehtml(Removehtml(rs("NewsName"))),25)
			'   end if
			if StrLen(Removehtml(rs("NewsName")))<=26 then
		        NewsName=Removehtml(rs("NewsName"))
			  else 
			     NewsName=StrLeft(Removehtml(Removehtml(rs("NewsName"))),25)
			   end if
			   			
				 if StrLen(Removehtml(rs("Content")))<=500 then
					 content=Removehtml(rs("Content"))
				  else 
					 content=StrLeft(Removehtml(rs("Content")),499)
				   end if
		        content1=Removehtml(content)
				content2=Replace(content1, chr(13), "<br/>") 
		'response.Write("<script type='text/javascript' language='javascript'>alert('"&content1&"');</script>")
		'Response.write("<div style='width:230px;'><a href='#'>fjidoajfiodajf</a></div><div><p style='width:230px;height:250px;'><a href='#'>"&content2&"</a></p></div>")
		response.Write("<div class='divBbsHeadContentT'><a href='bbsread.asp?id="&rs("id")&"'>"&NewsName&"</a></div><div class='divBbsHeadContentC'><p><a href='bbsread.asp?id="&rs("id")&"'>"&content&"</a><a class='divBbsHeadMore' href='bbsread.asp?id="&rs("id")&"'>[&nbsp;详细&nbsp;]</a></p></div><div class='divBbsHeadHr'></div>")
		rs.movenext
		Next
		
	End If
	rs.close
	Set rs=nothing
End Function

'论坛产品显示
function bbsindexpro(getSortId)
	Dim content,content1,NewsName,content2
	Set rs=server.createobject("adodb.RecordSet")
	rs.open "select top 7 * from pp_News where ViewFlag and sortid="&getSortId&" order by id desc",conn,1,3
	If rs.eof Then
	Else
		For i=1 to 7
			If rs.eof Then Exit For
				
					content1=Removehtml(content)
					content2=Replace(content1, chr(13), "<br/>") 
			If rs("authorID")<>"" Then
				Set rs3=server.CreateObject("adodb.recordset")
				rs3.open "select * from pp_Members where id="&rs("authorID"),conn
				
			Else
				Set rs3=server.CreateObject("adodb.recordset")
				rs3.open "select * from pp_Members where id=11",conn
			End If
	

			If i=1 Then
				if StrLen(Removehtml(rs("NewsName")))<=26 then
					NewsName=Removehtml(rs("NewsName"))
				  else 
					 NewsName=StrLeft(Removehtml(Removehtml(rs("NewsName"))),25)
				   end if
							
					 if StrLen(Removehtml(rs("Content")))<=500 then
						 content=Removehtml(rs("Content"))
					  else 
						 content=StrLeft(Removehtml(rs("Content")),499)
					   end if
				response.Write("<div class='divBbs1CL'><a href='bbsread.asp?id="&rs("id")&"'><img style='width:280px;height:142px;' src='"&rs("BigPic")&"'/></a></div><div class='divBbs1CC'><div class='divBbs1CCT'><a href='bbsread.asp?id="&rs("id")&"'>"&NewsName&"</a></div><div class='divBbs1CCC'><p style='height:68px;overflow:hidden;'><a href='bbsread.asp?id="&rs("id")&"'>"&content&"</a></p></div><div class='divBbs1CCMore'><a href='bbsread.asp?id="&rs("id")&"'><img src='img/bbs_detail.jpg'/></a></div></div>")
				response.Write("<div class='divBbs1CR'><ul>")
			Else
				if StrLen(Removehtml(rs("NewsName")))<=26 then
					NewsName=Removehtml(rs("NewsName"))
				  else 
					 NewsName=StrLeft(Removehtml(Removehtml(rs("NewsName"))),25)
				   end if
							
					 if StrLen(Removehtml(rs("Content")))<=500 then
						 content=Removehtml(rs("Content"))
					  else 
						 content=StrLeft(Removehtml(rs("Content")),499)
				   end If
					   if StrLen(Removehtml(rs3("MemName")))<=7 then
						MemName=Removehtml(rs3("MemName"))
					  else 
						 MemName=StrLeft(Removehtml(Removehtml(rs3("MemName"))),6)
					   end if
				Set rs2=server.createobject("adodb.RecordSet")
				rs2.open "select * from pp_NewsSort where ViewFlag and instr(SortPath,'"&rs("SortID")&"')>0 order by id desc",conn,1,3
				response.Write("<li><a class='divBbs1CRT' href='bbsread.asp?id="&rs("id")&"'>【"&rs2("SortName")&"】"&NewsName&"</a><a class='divBbs1CRMore' href='bbsread.asp?id="&rs("id")&"'>"&MemName&"</a></li>"&Chr(13))
			End If
				

			rs.movenext
			rs3.close
			Set rs3=Nothing
		Next
		Response.Write("</ul></div>")
	End If
	rs.close
	Set rs=Nothing
	rs2.close
	Set rs2=Nothing
	
End Function

'论坛公告显示
function bbsindexannounce(getSortId)
	Dim content,content1,NewsName,content2
	Set rs=server.createobject("adodb.RecordSet")
	rs.open "select top 4 * from pp_News where ViewFlag and sortid="&getSortId&" order by id desc",conn,1,3
	If rs.eof Then
	Else
		For i=1 to 4
			if StrLen(Removehtml(rs("NewsName")))<=26 then
				NewsName=Removehtml(rs("NewsName"))
			else 
				NewsName=StrLeft(Removehtml(Removehtml(rs("NewsName"))),25)
			end if
			Response.Write("<li><a href='annoucelist.asp?id="&rs("id")&"'>"&NewsName&"</a></li>")
			rs.movenext
		Next
		
	End If
	rs.close
	Set rs=Nothing
	rs2.close
	Set rs2=Nothing
	
End Function

'cgal调出左边栏,产品展示页
Function cgalleft()
	
	'response.Write("<script type='text/javascript' language='javascript'>alert('134');</script>")
	If request.queryString("id")<>"" Then
		id=CInt(Trim(request.queryString("id")))
	Else
		id=54
	End If
	Set rs=server.createobject("adodb.RecordSet")
	
	rs.open "select * from pp_cgal where ViewFlag and SortID=36 order by id asc",conn,1,3
	If rs.eof Then
		Response.Write("no info")
		
	Else
		
		Do While Not rs.eof
			If id=rs("id") Then
			Response.Write("<a class='divProLeftBtnSel' href='?id="&rs("id")&"'>"&rs("ProductName")&"</a>")
			Else
			Response.Write("<a class='divProLeftBtnNor' href='?id="&rs("id")&"'>"&rs("ProductName")&"</a>")
			
			End If
			rs.movenext
		Loop
	End If
End Function


'质量认证展示
function credentialShow()

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
  sql="select * from pp_Products where  ViewFlag and instr(sortpath,0)>0 order by AddTime desc"
  else
  sql="select * from pp_Products where  ViewFlag and instr(sortpath,"&sid&")>0 order by AddTime desc"
  end if
else
   if pid<>"" then
  sql="select * from pp_Products where  ViewFlag and Instr(SortPath,'"&pid&"')>0 order by AddTime desc"
  else
  sql="select * from pp_Products where  ViewFlag and instr(sortpath,0)>0 order by AddTime desc"
  end if
  end if
   rs.open sql,conn,1,1
If rs.Eof And rs.bof Then


response.write"<Div style='margin-top:20px;text-align:center;font-size:12px;color:#606060;'>暂无信息！</DIV>"
PageCount1=1
Totalnumber=0
Else

Maxperpage=4
rs.Pagesize=MaxperPage
PageCount1=Rs.PageCount
rs.Move  (CurrentPage-1)*MaxperPage
Totalnumber=rs.RecordCount
N=0

'plist_bottom=plist_bottom&"<div class='divBooklistPage'>"
'plist_bottom=plist_bottom&" <b style='font-size:12px;font-weight:normal;color:#707070;'>共有"&Totalnumber&"条&nbsp;显示第"&CurrentPage&"页&nbsp;总"&PageCount1&"页</b> &nbsp;"
Pageno=CurrentPage

'改样式

plist_bottom=plist_bottom&"<div class='divCredentiallistPage'>"
If cint(Pageno)>1 Then
	if sortid<>"" then
	plist_bottom=plist_bottom&"<a class='divBooklistPageBtnL' href='credential.asp?sortid="&sortid&"&sortpath="&sortpath&"' title='index'>"
	else
	plist_bottom=plist_bottom&"<a class='divBooklistPageBtnL' href='credential.asp' title=""index"">"
	end If
Else
	plist_bottom=plist_bottom&"<a class='divBooklistPageBtnL' href='credential.asp' title=""index"">"
End If
plist_bottom=plist_bottom&" <img src='img/button_l_gray.jpg'/></a>"

If Cint(Pageno)>1 Then
	if sortid<>"" then
	plist_bottom=plist_bottom&"<a class='divBooklistPageInt' href='credential.asp?page="&Pageno-1&"&sortid="&sortid&"&sortpath="&sortpath&"' title=""Previous"">"
	else
	plist_bottom=plist_bottom&"<a class='divBooklistPageInt' href='credential.asp?page="&Pageno-1&"' title=""Previous"">"
	end If
	plist_bottom=plist_bottom&(CurrentPage-1)&"</a>"
End If

plist_bottom=plist_bottom&"<a class='divBooklistPageIntCurrent' href='#'>"&CurrentPage&"</a>"
If Cint(Pageno)< PageCount1 Then
	if sortid<>"" then
	plist_bottom=plist_bottom&"<a class='divBooklistPageInt' href=credential.asp?page="&Pageno+1&"&sortid="&sortid&"&sortpath="&sortpath&" title=""Next"">"
	else
	plist_bottom=plist_bottom&"<a class='divBooklistPageInt' href=credential.asp?page="&Pageno+1&" title=""Next"">"
	End If
	plist_bottom=plist_bottom&(CurrentPage+1)&"</a>"
End If

If Cint(Pageno)< Pagecount1 Then
	if sortid<>"" then
	plist_bottom=plist_bottom&"<a href='credential.asp?page="&PageCount1&"&sortid="&sortid&"&sortpath="&sortpath&"' title=""Last"">"
	else
	plist_bottom=plist_bottom&"<a class='divBooklistPageBtnR' href='credential.asp?page="&PageCount1&"' title=""Last"">"
	End If
Else
	plist_bottom=plist_bottom&"<a class='divBooklistPageBtnR' title=""Last"">"
End If
plist_bottom=plist_bottom&"<img src='img/button_r_orange.jpg'/></a>"
plist_bottom=plist_bottom&"</div>"


Row_Count=1
'页面内容
'response.Write ("<div class='divBooklistC1'>")
n=0

do while not rs.eof
	n=n+1
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
   '<a href='produceview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'>
   If n Mod 2 = 0 Then
   Response.Write("<div style='display:inline-block;' class='divCredentialCShow'><img src='"& replace(rs("smallpic"),"../","")&"'/></div>")
   Else
   Response.Write("<div style='float:left;' class='divCredentialCShow'><img src='"& replace(rs("smallpic"),"../","")&"'/></div>")
   End If
	 
	'response.Write ("<div class='divBooklistC1L'><div class='divBooklistC1LImg'><a href='produceview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'><img src='"& replace(rs("smallpic"),"../","")&"'/></a></div><div class='divBooklistC1LC'><a href='produceview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'>"&ProductName&"</a></div></div>")
	rs.movenext
	If rs.eof Then
		'response.Write ("</div>")
	Else
		If n Mod 5 = 0 Then
			If n Mod 10 = 0 Then
			Else
			'response.Write ("</div><div class='divBooklistC1'>")
			End If
		Else
		End If
		
	End If

  
row_count=row_count+1
if n>=MaxPerPage then exit do
'rs.movenext
loop

rs.close
response.write plist_bottom
end if
end Function

'book搜索显示

function booksearch()

 dim rs,sql,page,sid,pid
 nameSearch=request.queryString("nameSearch")
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
If nameSearch<>"" Then
	sql="select * from pp_Products where ProductName like '%"&nameSearch&"%' order by id desc"
	'Response.Write("<script type='text/javascript' language='javascript'>alert('1234');</script>")
Else
	 if sid<>"" then
			if sid = 3 then
		  sql="select * from pp_Products where  ViewFlag and instr(sortpath,0)>0 order by AddTime desc"
		  else
		  sql="select * from pp_Products where  ViewFlag and instr(sortpath,"&sid&")>0 order by AddTime desc"
		  end if
	else
		   if pid<>"" then
		  sql="select * from pp_Products where  ViewFlag and Instr(SortPath,'"&pid&"')>0 order by AddTime desc"
		  else
		  'sql="select * from pp_Products where  ViewFlag and instr(sortpath,0)>0 order by AddTime desc"
		  end if
	  end If
End If

   rs.open sql,conn,1,1
If rs.Eof And rs.bof Then


response.write"<Div style='margin-top:20px;text-align:center;font-size:12px;color:#606060;'>暂无信息！</DIV>"
PageCount1=1
Totalnumber=0
Else

Maxperpage=10
rs.Pagesize=MaxperPage
PageCount1=Rs.PageCount
rs.Move  (CurrentPage-1)*MaxperPage
Totalnumber=rs.RecordCount
N=0

'plist_bottom=plist_bottom&"<div class='divBooklistPage'>"
'plist_bottom=plist_bottom&" <b style='font-size:12px;font-weight:normal;color:#707070;'>共有"&Totalnumber&"条&nbsp;显示第"&CurrentPage&"页&nbsp;总"&PageCount1&"页</b> &nbsp;"
Pageno=CurrentPage

'改样式

plist_bottom=plist_bottom&"<div class='divBooklistPage'>"
If cint(Pageno)>1 Then
	if sortid<>"" then
	plist_bottom=plist_bottom&"<a class='divBooklistPageBtnL' href='booklist.asp?sortid="&sortid&"&sortpath="&sortpath&"' title='index'>"
	else
	plist_bottom=plist_bottom&"<a class='divBooklistPageBtnL' href='booklist.asp' title=""index"">"
	end If
Else
	plist_bottom=plist_bottom&"<a class='divBooklistPageBtnL' href='booklist.asp' title=""index"">"
End If
plist_bottom=plist_bottom&" <img src='img/button_l_gray.jpg'/></a>"

If Cint(Pageno)>1 Then
	if sortid<>"" then
	plist_bottom=plist_bottom&"<a class='divBooklistPageInt' href=booklist.asp?page="&Pageno-1&"&sortid="&sortid&"&sortpath="&sortpath&" title=""Previous"">"
	else
	plist_bottom=plist_bottom&"<a class='divBooklistPageInt' href=booklist.asp?page="&Pageno-1&" title=""Previous"">"
	end If
	plist_bottom=plist_bottom&(CurrentPage-1)&"</a>"
End If

plist_bottom=plist_bottom&"<a class='divBooklistPageIntCurrent' href='#'>"&CurrentPage&"</a>"
If Cint(Pageno)< PageCount1 Then
	if sortid<>"" then
	plist_bottom=plist_bottom&"<a class='divBooklistPageInt' href=booklist.asp?page="&Pageno+1&"&sortid="&sortid&"&sortpath="&sortpath&" title=""Next"">"
	else
	plist_bottom=plist_bottom&"<a class='divBooklistPageInt' href=booklist.asp?page="&Pageno+1&" title=""Next"">"
	End If
	plist_bottom=plist_bottom&(CurrentPage+1)&"</a>"
End If

If Cint(Pageno)< Pagecount1 Then
	if sortid<>"" then
	plist_bottom=plist_bottom&"<a href='booklist.asp?page="&PageCount1&"&sortid="&sortid&"&sortpath="&sortpath&"' title=""Last"">"
	else
	plist_bottom=plist_bottom&"<a class='divBooklistPageBtnR' href='booklist.asp?page="&PageCount1&"' title=""Last"">"
	End If
Else
	plist_bottom=plist_bottom&"<a class='divBooklistPageBtnR' title=""Last"">"
End If
plist_bottom=plist_bottom&"<img src='img/button_r_orange.jpg'/></a>"
plist_bottom=plist_bottom&"</div>"


Row_Count=1
'页面内容
response.Write ("<div class='divBooklistC1'>")
n=0

do while not rs.eof
	n=n+1
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
   '<a href='produceview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'>
	response.Write ("<div class='divBooklistC1L'><div class='divBooklistC1LImg'><a href='produceview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'><img src='"& replace(rs("smallpic"),"../","")&"'/></a></div><div class='divBooklistC1LC'><a href='produceview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'>"&ProductName&"</a></div></div>")
	rs.movenext
	If rs.eof Then
		response.Write ("</div>")
	Else
		If n Mod 5 = 0 Then
			If n Mod 10 = 0 Then
			response.Write ("</div>")
			Else
			response.Write ("</div><div class='divBooklistC1'>")
			End If
		Else
		End If
		
	End If

  
row_count=row_count+1
if n>=MaxPerPage then exit do
'rs.movenext
loop

rs.close
response.write plist_bottom
end if
end Function

'产品页大图显示下列表
function proindexBigPic()
dim sid,rs,id,pid
pid=trim(request.QueryString("pid"))
set rs = server.createobject("adodb.recordset") 
	if pid<>"" Then
	sql="select * from pp_cgal where SortID ="&pid&" and ViewFlag  order by id desc"
	
	else
	sql="select top 10 * from pp_cgal where ViewFlag and SortID=36 order by id desc"
  	end if
  rs.open sql,conn,1,1

   while not rs.eof


	response.Write "<li><a class='pro_a' ptxt='' pname='"&rs("productname")&"' psrc='"&rs("BigPic")&"' phref='productshow.asp?sid="&rs("sortid")&"&id="&rs("id")&"'><img style='width:510px;height:350px;' src='"&rs("BigPic")&"' onclick='document.getElementById(""idProShowPic"").src=this.src'/></a></li>"
	
  rs.movenext
  wend 
  
     rs.close
 set rs=nothing
end function

'首页AD广告IMG
Function indexadimg()
	If request.queryString("id")<>"" Then
		id=CInt(Trim(request.queryString("id")))
	Else
		id=54
	End If
	Set rs=server.CreateObject("adodb.recordset")
	rs.open "select * from pp_news where SortID=205 and ViewFlag",conn,1,3
	
	If rs.eof Then
		Response.write("no info")
	Else

		Do While Not rs.eof
			Response.Write("<a href='"&rs("Source")&"' target='_blank'><img src='"&rs("BigPic")&"' width='988' height='383' /><p style='display:none;'>"&rs("NewsName")&"</p></a>")
			rs.movenext
		Loop
		
		'同一记录中生成多张图

		'For i=1 To 10
		'strSlidePic="slidepic"&CStr(i)
		'strSlidePic1=CStr(strSlidePic)
		'If rs(strSlidePic1)="" Then Exit For

		'Response.write("<a href='"&rs("Source")&"' target='_blank'><img src='"&rs(strSlidePic1)&"' width='988' height='383' /><p>"&rs("ProductName")&"</p></a>")
		'Next
	End If
	rs.close
	Set rs=nothing

End Function

'论坛list页(分页)
function bbslistpage()

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
  sql="select * from pp_news where  ViewFlag and instr(sortpath,0)>0 order by AddTime desc"
  else
  sql="select * from pp_news where  ViewFlag and instr(sortpath,"&sid&")>0 order by AddTime desc"
  end if
else
   if pid<>"" then
  sql="select * from pp_news where  ViewFlag and Instr(SortPath,'"&pid&"')>0 order by AddTime desc"
  else
  sql="select * from pp_news where  ViewFlag and instr(sortpath,193)>0 order by AddTime desc"
  end If
end if
   rs.open sql,conn,1,1
If rs.Eof And rs.bof Then


response.write"<Div style='margin-top:20px;text-align:center;font-size:12px;color:#606060;'>暂无信息！</DIV>"
PageCount1=1
Totalnumber=0
Else

Maxperpage=4
rs.Pagesize=MaxperPage
PageCount1=Rs.PageCount
rs.Move  (CurrentPage-1)*MaxperPage
Totalnumber=rs.RecordCount
N=0

'plist_bottom=plist_bottom&"<div class='divBooklistPage'>"
'plist_bottom=plist_bottom&" <b style='font-size:12px;font-weight:normal;color:#707070;'>共有"&Totalnumber&"条&nbsp;显示第"&CurrentPage&"页&nbsp;总"&PageCount1&"页</b> &nbsp;"
Pageno=CurrentPage

'改样式

plist_bottom=plist_bottom&"<div class='divCredentiallistPage'>"
If cint(Pageno)>1 Then
	if sortid<>"" then
	plist_bottom=plist_bottom&"<a class='divBooklistPageBtnL' href='bbslist.asp?sortid="&sortid&"&sortpath="&sortpath&"&pid="&pid&"' title='index'>"
	else
	plist_bottom=plist_bottom&"<a class='divBooklistPageBtnL' href='bbslist.asp?pid="&pid&"' title=""index"">"
	end If
Else
	plist_bottom=plist_bottom&"<a class='divBooklistPageBtnL' href='bbslist.asp?pid="&pid&"' title=""index"">"
End If
plist_bottom=plist_bottom&" <img src='img/button_l_gray.jpg'/></a>"

If Cint(Pageno)>1 Then
	if sortid<>"" then
	plist_bottom=plist_bottom&"<a class='divBooklistPageInt' href='bbslist.asp?page="&Pageno-1&"&sortid="&sortid&"&sortpath="&sortpath&"&pid="&pid&"' title=""Previous"">"
	else
	plist_bottom=plist_bottom&"<a class='divBooklistPageInt' href='bbslist.asp?page="&Pageno-1&"&pid="&pid&"' title=""Previous"">"
	end If
	plist_bottom=plist_bottom&(CurrentPage-1)&"</a>"
End If

plist_bottom=plist_bottom&"<a class='divBooklistPageIntCurrent' href='#'>"&CurrentPage&"</a>"
If Cint(Pageno)< PageCount1 Then
	if sortid<>"" then
	plist_bottom=plist_bottom&"<a class='divBooklistPageInt' href='bbslist.asp?page="&Pageno+1&"&sortid="&sortid&"&sortpath="&sortpath&"&pid="&pid&"' title=""Next"">"
	else
	plist_bottom=plist_bottom&"<a class='divBooklistPageInt' href='bbslist.asp?page="&Pageno+1&"&pid="&pid&"' title=""Next"">"
	End If
	plist_bottom=plist_bottom&(CurrentPage+1)&"</a>"
End If

If Cint(Pageno)< Pagecount1 Then
	if sortid<>"" then
	plist_bottom=plist_bottom&"<a href='bbslist.asp?page="&PageCount1&"&sortid="&sortid&"&sortpath="&sortpath&"&pid="&pid&"' title=""Last"">"
	else
	plist_bottom=plist_bottom&"<a class='divBooklistPageBtnR' href='bbslist.asp?page="&PageCount1&"&pid="&pid&"' title=""Last"">"
	End If
Else
	plist_bottom=plist_bottom&"<a class='divBooklistPageBtnR' title=""Last"">"
End If
plist_bottom=plist_bottom&"<img src='img/button_r_orange.jpg'/></a>"
plist_bottom=plist_bottom&"</div>"


Row_Count=1
'页面内容
'response.Write ("<div class='divBooklistC1'>")
n=0
Do While Not rs.eof
	If rs("authorID")<>"" Then
		authorID=rs("authorID")
	Else
		authorID=11
	End If

	Set rs2=server.CreateObject("adodb.recordset")
	rs2.open "select * from pp_Members where id="&authorID,conn
	Set rs3=server.CreateObject("adodb.recordset")
	rs3.open "select top 1 * from pp_NewsReply where newsID="&rs("id")&" order by AddTime desc",conn
	If rs3.eof Then
		replyName="no info"
		replyTime="no time"
	Else
		replyTime=rs3("AddTime")
		Set rs4=server.CreateObject("adodb.recordset")
		rs4.open "select top 1 * from pp_Members where id="&rs3("authorID")&" order by AddTime desc",conn
		replyName=rs4("MemName")
		rs4.close
		Set rs4=Nothing
	End If
	
			if StrLen(Removehtml(rs("NewsName")))<=50 then
		        NewsName=Removehtml(rs("NewsName"))
			  else 
			     NewsName=StrLeft(Removehtml(Removehtml(rs("NewsName"))),49)
			   end if
	Response.Write("<tr class='divBbsListContent'><td class='divBbsListHeadTd1'><a href='bbsread.asp?id="&rs("id")&"'>"&NewsName&"</a></td><td class='divBbsListHeadTd2'><p>"&rs2("MemName")&"</p><p>"&rs("AddTime")&"</p></td><td class='divBbsListHeadTd3'>66/711</td><td class='divBbsListHeadTd4'><p>"&replyName&"</p><p>"&replyTime&"<p></td></tr>")
	 
	'response.Write ("<div class='divBooklistC1L'><div class='divBooklistC1LImg'><a href='produceview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'><img src='"& replace(rs("smallpic"),"../","")&"'/></a></div><div class='divBooklistC1LC'><a href='produceview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'>"&ProductName&"</a></div></div>")
	rs2.close
	Set rs2=Nothing
	rs3.close
	Set rs3=Nothing
	rs.movenext
	If rs.eof Then
		'response.Write ("</div>")
	Else
		If n Mod 5 = 0 Then
			If n Mod 10 = 0 Then
			Else
			'response.Write ("</div><div class='divBooklistC1'>")
			End If
		Else
		End If
		
	End If

  
row_count=row_count+1
if n>=MaxPerPage then exit do
'rs.movenext
loop

rs.close
Response.write("</table>")
response.write plist_bottom
end if
end Function

'公告list页(分页)
function annoucelistpage()

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
  sql="select * from pp_news where  ViewFlag and instr(sortpath,0)>0 order by AddTime desc"
  else
  sql="select * from pp_news where  ViewFlag and instr(sortpath,"&sid&")>0 order by AddTime desc"
  end if
else
   if pid<>"" then
  sql="select * from pp_news where  ViewFlag and Instr(SortPath,'"&pid&"')>0 order by AddTime desc"
  else
  sql="select * from pp_news where  ViewFlag and instr(sortpath,193)>0 order by AddTime desc"
  end If
end if
   rs.open sql,conn,1,1
If rs.Eof And rs.bof Then


response.write"<Div style='margin-top:20px;text-align:center;font-size:12px;color:#606060;'>暂无信息！</DIV>"
PageCount1=1
Totalnumber=0
Else

Maxperpage=4
rs.Pagesize=MaxperPage
PageCount1=Rs.PageCount
rs.Move  (CurrentPage-1)*MaxperPage
Totalnumber=rs.RecordCount
N=0

'plist_bottom=plist_bottom&"<div class='divBooklistPage'>"
'plist_bottom=plist_bottom&" <b style='font-size:12px;font-weight:normal;color:#707070;'>共有"&Totalnumber&"条&nbsp;显示第"&CurrentPage&"页&nbsp;总"&PageCount1&"页</b> &nbsp;"
Pageno=CurrentPage

'改样式

plist_bottom=plist_bottom&"<div class='divCredentiallistPage'>"
If cint(Pageno)>1 Then
	if sortid<>"" then
	plist_bottom=plist_bottom&"<a class='divBooklistPageBtnL' href='annoucelist.asp?sortid="&sortid&"&sortpath="&sortpath&"&pid="&pid&"' title='index'>"
	else
	plist_bottom=plist_bottom&"<a class='divBooklistPageBtnL' href='annoucelist.asp?pid="&pid&"' title=""index"">"
	end If
Else
	plist_bottom=plist_bottom&"<a class='divBooklistPageBtnL' href='annoucelist.asp?pid="&pid&"' title=""index"">"
End If
plist_bottom=plist_bottom&" <img src='img/button_l_gray.jpg'/></a>"

If Cint(Pageno)>1 Then
	if sortid<>"" then
	plist_bottom=plist_bottom&"<a class='divBooklistPageInt' href='annoucelist.asp?page="&Pageno-1&"&sortid="&sortid&"&sortpath="&sortpath&"&pid="&pid&"' title=""Previous"">"
	else
	plist_bottom=plist_bottom&"<a class='divBooklistPageInt' href='annoucelist.asp?page="&Pageno-1&"&pid="&pid&"' title=""Previous"">"
	end If
	plist_bottom=plist_bottom&(CurrentPage-1)&"</a>"
End If

plist_bottom=plist_bottom&"<a class='divBooklistPageIntCurrent' href='#'>"&CurrentPage&"</a>"
If Cint(Pageno)< PageCount1 Then
	if sortid<>"" then
	plist_bottom=plist_bottom&"<a class='divBooklistPageInt' href='annoucelist.asp?page="&Pageno+1&"&sortid="&sortid&"&sortpath="&sortpath&"&pid="&pid&"' title=""Next"">"
	else
	plist_bottom=plist_bottom&"<a class='divBooklistPageInt' href='annoucelist.asp?page="&Pageno+1&"&pid="&pid&"' title=""Next"">"
	End If
	plist_bottom=plist_bottom&(CurrentPage+1)&"</a>"
End If

If Cint(Pageno)< Pagecount1 Then
	if sortid<>"" then
	plist_bottom=plist_bottom&"<a href='annoucelist.asp?page="&PageCount1&"&sortid="&sortid&"&sortpath="&sortpath&"&pid="&pid&"' title=""Last"">"
	else
	plist_bottom=plist_bottom&"<a class='divBooklistPageBtnR' href='annoucelist.asp?page="&PageCount1&"&pid="&pid&"' title=""Last"">"
	End If
Else
	plist_bottom=plist_bottom&"<a class='divBooklistPageBtnR' title=""Last"">"
End If
plist_bottom=plist_bottom&"<img src='img/button_r_orange.jpg'/></a>"
plist_bottom=plist_bottom&"</div>"


Row_Count=1
'页面内容
'response.Write ("<div class='divBooklistC1'>")
n=0
Do While Not rs.eof
	If rs("authorID")<>"" Then
		authorID=rs("authorID")
	Else
		authorID=11
	End If

	Set rs2=server.CreateObject("adodb.recordset")
	rs2.open "select * from pp_Members where id="&authorID,conn
	Set rs3=server.CreateObject("adodb.recordset")
	rs3.open "select top 1 * from pp_NewsReply where newsID="&rs("id")&" order by AddTime desc",conn
	If rs3.eof Then
		replyName="no info"
		replyTime="no time"
	Else
		replyTime=rs3("AddTime")
		Set rs4=server.CreateObject("adodb.recordset")
		rs4.open "select top 1 * from pp_Members where id="&rs3("authorID")&" order by AddTime desc",conn
		replyName=rs4("MemName")
		rs4.close
		Set rs4=Nothing
	End If
	
			if StrLen(Removehtml(rs("NewsName")))<=50 then
		        NewsName=Removehtml(rs("NewsName"))
			  else 
			     NewsName=StrLeft(Removehtml(Removehtml(rs("NewsName"))),49)
			   end if
	Response.Write("<tr class='divBbsListContent'><td class='divBbsListHeadTd1'><a href='annouceread.asp?id="&rs("id")&"'>"&NewsName&"</a></td><td class='divBbsListHeadTd2'><p>"&rs2("MemName")&"</p><p>"&rs("AddTime")&"</p></td><td class='divBbsListHeadTd3'>66/711</td><td class='divBbsListHeadTd4'><p>"&replyName&"</p><p>"&replyTime&"<p></td></tr>")
	 
	'response.Write ("<div class='divBooklistC1L'><div class='divBooklistC1LImg'><a href='produceview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'><img src='"& replace(rs("smallpic"),"../","")&"'/></a></div><div class='divBooklistC1LC'><a href='produceview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'>"&ProductName&"</a></div></div>")
	rs2.close
	Set rs2=Nothing
	rs3.close
	Set rs3=Nothing
	rs.movenext
	If rs.eof Then
		'response.Write ("</div>")
	Else
		If n Mod 5 = 0 Then
			If n Mod 10 = 0 Then
			Else
			'response.Write ("</div><div class='divBooklistC1'>")
			End If
		Else
		End If
		
	End If

  
row_count=row_count+1
if n>=MaxPerPage then exit do
'rs.movenext
loop

rs.close
Response.write("</table>")
response.write plist_bottom
end if
end Function
'论坛阅读页,返回主贴
Function bbsReadMain()
id=Trim(Request.QueryString("id"))
page=Trim(Request.QueryString("page"))
If page<>"" Then
	If page=1 Then
		page=""
	End If
Else
End If
	If page<>"" Then
	Else
		Set rs=Server.CreateObject("ADODB.RecordSet")
		rs.open "select * from pp_News where id="&id,conn
		If rs("authorID")<>"" Then
			Set rs2=Server.CreateObject("ADODB.RecordSet")
			rs2.open "select * from pp_Members where id="&rs("authorID"),conn
		Else
			Set rs2=Server.CreateObject("ADODB.RecordSet")
			rs2.open "select * from pp_Members where id=11",conn
		End If

		If rs.eof Then
			Response.Write("no info")
		Else
			Response.Write("<div class='divBbsReadHead'><div class='divBbsReadHeadL'><p>回复：<span>19</span> 人气：<span>345</span></p></div><div class='divBbsReadHeadR'><p>"&rs("NewsName")&"</p></div></div>")

			Response.Write("<div class='divBbsBox'><div class='divBbsBoxL'><div class='divUsername'><p>"&rs2("MemName")&"</p></div><div class='divUserface'><img src='"&rs2("sculpture")&"'/></div><div class='divUserContact'><a class='divUserAddFriend' href='#'></a><a class='divUserSendMess' href='#'></a></div><div class='divUserInfo'><p>用户积分:"&rs2("Integral")&"</p><p>用户书币:"&rs2("money")&"</p><p>帐号创建时间:<br/>"&rs2("AddTime")&"</p></div></div><div class='divBbsBoxR'><div class='divBbsBoxRH'><p>用户发表于"&rs("AddTime")&"</p></div><div class='divBbsBoxContent'><p class='divBbsBoxContentT'>"&rs("NewsName")&"</p><div class='divBbsBoxContentC'>"&rs("Content")&"</div></div><div class='divBbsBoxRBottom'><div class='divBbsBoxRBottomL'>"&rs2("signature")&"</div><div class='divBbsBoxRBottomR'></div></div></div></div>")
		End If
			rs.close
			Set rs=Nothing
			rs2.close
			Set rs2=Nothing
	End If
End Function
'论坛阅读页,返回reply表(分页)
function bbsReadPage()

 dim rs,sql,page,sid,pid
 pid=Request.QueryString("pid")
 sid=Request.QueryString("sid")
page=Trim(Request.QueryString("Page"))
id=Trim(Request.QueryString("id"))
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
  sql="select * from pp_NewsReply where  ViewFlag and instr(sortpath,0)>0 order by AddTime desc"
  else
  sql="select * from pp_NewsReply where  ViewFlag and instr(sortpath,"&sid&")>0 order by AddTime desc"
  end if
else
   if id<>"" then
  sql="select * from pp_NewsReply where newsID="&id&" order by AddTime desc"
  else
  sql="select * from pp_NewsReply where  ViewFlag and instr(sortpath,193)>0 order by AddTime desc"
  end If
end if
   rs.open sql,conn,1,1
If rs.Eof And rs.bof Then


response.write"<Div style='margin-top:20px;text-align:center;font-size:12px;color:#606060;'>暂无回复！</DIV>"
PageCount1=1
Totalnumber=0
Else

Maxperpage=10
rs.Pagesize=MaxperPage
PageCount1=Rs.PageCount
rs.Move  (CurrentPage-1)*MaxperPage
Totalnumber=rs.RecordCount
N=0

'plist_bottom=plist_bottom&"<div class='divBooklistPage'>"
'plist_bottom=plist_bottom&" <b style='font-size:12px;font-weight:normal;color:#707070;'>共有"&Totalnumber&"条&nbsp;显示第"&CurrentPage&"页&nbsp;总"&PageCount1&"页</b> &nbsp;"
Pageno=CurrentPage

'改样式

plist_bottom=plist_bottom&"<div class='divCredentiallistPage'>"
If cint(Pageno)>1 Then
	if sortid<>"" then
	plist_bottom=plist_bottom&"<a class='divBooklistPageBtnL' href='bbsread.asp?sortid="&sortid&"&sortpath="&sortpath&"&id="&id&"' title='index'>"
	else
	plist_bottom=plist_bottom&"<a class='divBooklistPageBtnL' href='bbsread.asp?id="&id&"' title=""index"">"
	end If
Else
	plist_bottom=plist_bottom&"<a class='divBooklistPageBtnL' href='bbsread.asp?id="&id&"' title=""index"">"
End If
plist_bottom=plist_bottom&" <img src='img/button_l_gray.jpg'/></a>"

If Cint(Pageno)>1 Then
	if sortid<>"" then
	plist_bottom=plist_bottom&"<a class='divBooklistPageInt' href='bbsread.asp?page="&Pageno-1&"&sortid="&sortid&"&sortpath="&sortpath&"&id="&id&"' title=""Previous"">"
	else
	plist_bottom=plist_bottom&"<a class='divBooklistPageInt' href='bbsread.asp?page="&Pageno-1&"&id="&id&"' title=""Previous"">"
	end If
	plist_bottom=plist_bottom&(CurrentPage-1)&"</a>"
End If

plist_bottom=plist_bottom&"<a class='divBooklistPageIntCurrent' href='#'>"&CurrentPage&"</a>"
If Cint(Pageno)< PageCount1 Then
	if sortid<>"" then
	plist_bottom=plist_bottom&"<a class='divBooklistPageInt' href='bbsread.asp?page="&Pageno+1&"&sortid="&sortid&"&sortpath="&sortpath&"&id="&id&"' title=""Next"">"
	else
	plist_bottom=plist_bottom&"<a class='divBooklistPageInt' href='bbsread.asp?page="&Pageno+1&"&id="&id&"' title=""Next"">"
	End If
	plist_bottom=plist_bottom&(CurrentPage+1)&"</a>"
End If

If Cint(Pageno)< Pagecount1 Then
	if sortid<>"" then
	plist_bottom=plist_bottom&"<a href='bbsread.asp?page="&PageCount1&"&sortid="&sortid&"&sortpath="&sortpath&"&id="&id&"' title=""Last"">"
	else
	plist_bottom=plist_bottom&"<a class='divBooklistPageBtnR' href='bbsread.asp?page="&PageCount1&"&id="&id&"' title=""Last"">"
	End If
Else
	plist_bottom=plist_bottom&"<a class='divBooklistPageBtnR' title=""Last"">"
End If
plist_bottom=plist_bottom&"<img src='img/button_r_orange.jpg'/></a>"
plist_bottom=plist_bottom&"</div>"


Row_Count=1
'页面内容
'response.Write ("<div class='divBooklistC1'>")
n=0
Do While Not rs.eof
	Set rs2=Server.CreateObject("ADODB.RecordSet")
	rs2.open "select * from pp_Members where id="&rs("authorID"),conn

	Response.Write("<div class='divBbsBox'><div class='divBbsBoxL'><div class='divUsername'><p>"&rs2("MemName")&"</p></div><div class='divUserface'><img src='"&rs2("sculpture")&"'/></div><div class='divUserContact'><a class='divUserAddFriend' href='#'></a><a class='divUserSendMess' href='#'></a></div><div class='divUserInfo'><p>用户积分:"&rs2("Integral")&"</p><p>帐号创建时间:<br/>"&rs2("AddTime")&"</p></div></div><div class='divBbsBoxR'><div class='divBbsBoxRH'><p>用户发表于"&rs("AddTime")&"</p></div><div class='divBbsBoxContent'><p class='divBbsBoxContentT'>"&rs("ReplyName")&"</p><div class='divBbsBoxContentC'>"&rs("Content")&"</div></div><div class='divBbsBoxRBottom'><div class='divBbsBoxRBottomL'>"&rs2("signature")&"</div><div class='divBbsBoxRBottomR'></div></div></div></div>")
	 
	'response.Write ("<div class='divBooklistC1L'><div class='divBooklistC1LImg'><a href='produceview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'><img src='"& replace(rs("smallpic"),"../","")&"'/></a></div><div class='divBooklistC1LC'><a href='produceview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'>"&ProductName&"</a></div></div>")
	rs2.close
	Set rs2=Nothing

	rs.movenext

	If rs.eof Then
		'response.Write ("</div>")
	Else
		If n Mod 5 = 0 Then
			If n Mod 10 = 0 Then
			Else
			'response.Write ("</div><div class='divBooklistC1'>")
			End If
		Else
		End If
		
	End If
  
row_count=row_count+1
if n>=MaxPerPage then exit do
'rs.movenext
loop

rs.close
'Response.write("</table>")
response.write plist_bottom
end if
end Function

'论坛添加帖子
Function bbsAdd()
	If IsEmpty(request.Form("nameBbsAddSubmit"))=False Then
		NewsName=request.Form("NewsName")
		sortID=request.Form("sortID")
		Content=request.Form("Content")
		BigPic=request.Form("Pro_Pic")
		Set rs=server.CreateObject("adodb.recordset")
		rs.open "Select * from pp_News where id=0",conn,1,3
		Set rs3=server.CreateObject("adodb.recordset")
		rs3.open "Select * from pp_Members where MemName='"&Session("memName")&"'",conn,1,3
		rs.addnew
		
		If rs.eof Then
			response.Write("<script type='text/javascript' language='javascript'>alert('请重新添加');</script>")
		Else
			'response.Write("<script type='text/javascript' language='javascript'>alert('"&sortID&"');</script>")
			
			Set rs2=server.CreateObject("adodb.recordset")
			rs2.open "Select * from pp_NewsSort where instr(SortPath,'"&sortID&"')>0",conn,1,3
			rs("authorID")=rs3("id")
			rs("NewsName")=NewsName
			rs("SortID")=sortID
			If BigPic<>"" Then
				rs("BigPic")=BigPic
			Else
				If sortID=195 Then
					rs("BigPic")="img/bbs_ad2.jpg"
				Else
					If sortID=196 Then
						rs("BigPic")="img/bbs_ad3.jpg"
					Else
						rs("BigPic")="img/bbs_ad3-09.jpg"
					End If
				End If
			End If
			rs("Content")=content
			rs("SortPath")=rs2("SortPath")
			rs("ViewFlag")=-1
			rs("enViewFlag")=-1
			rs("AddTime")=now()
			rs.update

			money=rs3("money")
			rs3("money")=money+10
			integral=rs3("Integral")
			rs3("Integral")=integral+10
			rs3.update
			response.Write("<script type='text/javascript' language='javascript'>alert('添加成功,书币+10,经验+10');location.href='bbslist.asp';</script>")
		End If
	End If
	rs.close
	Set rs=Nothing
	rs2.close
	Set rs2=Nothing
	rs3.close
	Set rs3=Nothing
End Function

Function searchSortId()
	If request.queryString("pid")<>"" Then
		pid=CInt(request.queryString("pid"))
	Else
		newsid=request.queryString("newsid")
		If newsid<>"" Then
			Set rs2=server.CreateObject("adodb.recordset")
			rs2.open "Select * from pp_News where id="&newsid,conn,1,3

			pid=rs2("SortID")
		Else
			pid=195
		End If
	End If
	Set rs=server.CreateObject("adodb.recordset")
	rs.open "Select * from pp_NewsSort where ParentID=193",conn,1,3
	If rs.eof Then
	Else
		Do While Not rs.eof
			If rs("id")=pid Then
				Response.Write("<option value='"&rs("id")&"' selected='selected'>"&rs("SortName")&"</option>")
			Else
				Response.Write("<option value='"&rs("id")&"'>"&rs("SortName")&"</option>")
			End If
		rs.movenext
		Loop
	End If
	rs.close
	Set rs=Nothing
	rs2.close
	Set rs2=Nothing
End Function
'回帖时查询
Function searchNewsname()
	newsid=request.queryString("newsid")
	Set rs=server.CreateObject("adodb.recordset")
	rs.open "Select * from pp_News where id="&newsid,conn,1,3
	If rs.eof Then
	Else
		Response.Write(rs("NewsName"))
	End If
	rs.close
	Set rs=Nothing
End Function

Function searchSortName()
	newsid=request.queryString("newsid")
	Set rs2=server.CreateObject("adodb.recordset")
	rs2.open "Select * from pp_News where id="&newsid,conn,1,3
	Set rs=server.CreateObject("adodb.recordset")
	rs.open "Select * from pp_NewsSort where id="&rs2("SortID"),conn,1,3
	If rs.eof Then
	Else
		Response.Write(rs("SortName"))
	End If
	rs.close
	Set rs=Nothing
	rs2.close
	Set rs2=Nothing
End Function

'论坛回复帖子
Function bbsReply()
	If IsEmpty(request.Form("nameBbsAddSubmit"))=False Then
		
		ReplyName=request.Form("ReplyName")
		newsID=request.queryString("newsID")
		Content=request.Form("Content")
		Set rs=server.CreateObject("adodb.recordset")
		rs.open "Select * from pp_NewsReply where id=0",conn,1,3
		rs.addnew
		
		Set rs3=server.CreateObject("adodb.recordset")
		rs3.open "Select * from pp_Members where MemName='"&Session("memName")&"'",conn,1,3
		authorID=rs3("id")
		If rs.eof Then
			response.Write("<script type='text/javascript' language='javascript'>alert('请重新添加');</script>")
		Else
			'response.Write("<script type='text/javascript' language='javascript'>alert('"&sortID&"');</script>")
			
			'Set rs2=server.CreateObject("adodb.recordset")
			'rs2.open "Select * from pp_NewsSort where instr(SortPath,'"&sortID&"')>0",conn,1,3
			rs("authorID")=authorID
			rs("ReplyName")=ReplyName
			rs("newsID")=newsID
			rs("Content")=content
			'rs("SortPath")=rs2("SortPath")
			'rs("ViewFlag")=-1
			'rs("enViewFlag")=-1
			rs("AddTime")=now()
			rs.update
			response.Write("<script type='text/javascript' language='javascript'>alert('修改成功');location.href='bbsread.asp?id="&newsID&"';</script>")
		End If
	End If
	rs.close
	Set rs=Nothing
	rs2.close
	Set rs2=Nothing
	rs3.close
	Set rs3=Nothing
End Function

'bbs登陆
Function wxjBbsLogin()
	If IsEmpty(request.Form("nameSubmit"))=False Then
		memname=request.Form("memname")
		password=md5(request.Form("password"))
		
		Set rs=server.CreateObject("adodb.recordset")
		rs.open "select * from pp_Members where MemName='"&memname&"'",conn,1,3
		'response.Write("<script type='text/javascript' language='javascript'>alert('1324');</script>")
		If rs.eof Then
			response.Write("<script type='text/javascript' language='javascript'>alert('用户名错误');</script>")
		Else
			If rs("Password")=password Then
				Session("memName")=memname
				Session("memGroup")=rs("GroupName")
				Integral=rs("Integral")
				money=rs("money")
				rs("Integral")=Integral+10
				rs("money")=money+10
				rs.update
				response.Write("<script type='text/javascript' language='javascript'>alert('欢迎你!"&Session("memName")&"');</script>")
			Else
				response.Write("<script type='text/javascript' language='javascript'>alert('用户名错误');</script>")
			End If
		End If
	End If
	rs.close
	Set rs=Nothing
End Function

'bbs注册
Function wxjBbsJoin()
	If IsEmpty(request.Form("nameJoinSubmit"))=False Then
		memname=request.Form("memname")
		password=md5(request.Form("password"))
		confirmpwd=md5(request.Form("confirmpwd"))
		GroupID="20082131627319724"
		Email=request.Form("Email")
		If confirmpwd=password Then
			Set rs=server.CreateObject("adodb.recordset")
			rs.open "select * from pp_Members where id=0",conn,1,3
			rs.addnew
			rs("MemName")=memname
			rs("Password")=password
			rs("GroupID")=GroupID
			rs("Integral")=10
			rs.update
			Session("memName")=memname
			response.Write("<script type='text/javascript' language='javascript'>alert('欢迎注册!"&Session("memName")&",你现在有10书币');</script>")
		Else
			response.Write("<script type='text/javascript' language='javascript'>alert('两次输入的密码错误');</script>")
		End If
	End If
	rs.close
	Set rs=Nothing
End Function



'修改用户详细资料
Function modifyMemInfo()
	If IsEmpty(request.Form("nameBbsAddSubmit"))=False Then
		email=request.Form("email")
		sex=request.Form("sex")
		sculpture=request.Form("Pro_Pic")
		mobile=request.Form("mobile")
		telephone=request.Form("telephone")
		homepage=request.Form("homepage")

		Set rs=server.CreateObject("adodb.recordset")
		rs.open "Select * from pp_Members where MemName='"&Session("memName")&"'",conn,1,3

		rs("Email")=email
		rs("Sex")=sex
		If sculpture<>"" Then
			rs("Sculpture")=sculpture
		End If
		rs("Mobile")=mobile
		rs("Telephone")=telephone
		rs("HomePage")=homepage

		rs.update
		response.Write("<script type='text/javascript' language='javascript'>alert('修改成功');location.href='bbsmeminfo.asp';</script>")
		
	End If
	rs.close
	Set rs=Nothing
End Function

Function wxjProFangDaJing()
  dim sid,pid
  sid=request.QueryString("sid")
  pid=request.QueryString("pid")
  id=request.QueryString("id")

  dim rs,sql
  set rs = server.createobject("adodb.recordset")
  if id="" then
  sql="select top 1 * from pp_cgal where ViewFlag and SortID=36 order by id asc"
  else
  sql="select * from pp_cgal where ViewFlag and id="&id&" order by id desc"
  end if
  rs.open sql,conn,1,3

  if rs.bof and rs.eof then
    response.write "<div>暫無相關信息</div>"
  else
      'dim BigPic
	 ' BigPic=rs("BigPic2")
	 
	 response.Write ("<div class='zoomybox'><a class='zoom' href='wxjs/wxjFangDaJing/images/lucyZoom.jpg'><img id='idProShowPic' src='"&rs("slidepic1")&"'/></a></div>")
	 
	  end if
  rs.close
  set rs=nothing
End Function
%>