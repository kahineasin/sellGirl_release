<%
'首页左侧三个图片链接
Function indexadleft()
	Set rs=server.CreateObject("adodb.recordset")
	rs.open "select * from pp_News where instr(SortPath,206) and ViewFlag",conn,1,3
	If rs.eof Then
		Response.write("no info")
	Else
		For i=0 To 2
		If rs.eof Then Exit For
		Response.write("<a style='display:block;padding:10px 39px 0px 10px;width:249px;height:116px;' href='"&rs("source")&"' target='_blank'><img style='width:249px;height:116px;' src='"&replace(rs("BigPic"),"../","")&"'/></a>")
		rs.movenext
		Next
	End If
	rs.close
	Set rs=nothing

End Function
'首页AD广告IMG
Function indexadimg()
	Set rs=server.CreateObject("adodb.recordset")
	rs.open "select * from pp_News where instr(SortPath,205) and ViewFlag",conn,1,3
	If rs.eof Then
		Response.write("no info")
	Else
		For i=0 To 4
		If rs.eof Then Exit For
		Response.write("<a href='"&rs("source")&"' target='_blank'><img src='"&rs("BigPic")&"' width='700' height='280' /><p>"&rs("NewsName")&"</p></a>")
		rs.movenext
		Next
	End If
	rs.close
	Set rs=nothing

End Function
'调用首页中间三个顺昌信息（图文）
Function sancangindexinfo()
	Set rs=server.CreateObject("adodb.recordset")
	rs.open "select * from pp_News where instr(SortPath,203)",conn,1,3
	If rs.eof Then
		Response.write("no info")
	Else
		For i=0 To 2
		If rs.eof Then Exit For
		Response.write("<div style='float:left;width:291px;height:311px;' class='divShowContent'><div style='margin:0 auto;width:291px;height:36px;'><a href='"&rs("source")&"'><img src='"&replace(rs("slidepic1"),"../","")&"'/></a></div><div style='margin:0 auto;width:291px;height:160px;'><a href='"&rs("source")&"'><img src='"&replace(rs("BigPic"),"../","")&"'/></a></div><div style='margin:0 auto;width:291px;height:28px;'><a class='divShowContentT' href='"&rs("source")&"'><h5>"&rs("NewsName")&"</h5></a></div><div style='margin:0 auto;width:291px;height:63px;'><a class='divShowContentP' href='"&rs("source")&"'><p>"&rs("Content")&"</p></a></div><div style='margin:0 auto;width:291px;height:22px;'><a class='divShowContentBtn' href='"&rs("source")&"'></a></div></div>")
		rs.movenext
		Next
	End If
	rs.close
	Set rs=nothing
End Function

'首页引用新闻页内容
Function indexshownews()


			Set rsNews=server.CreateObject("adodb.recordset")
			rsNews.open "select * from pp_News where instr(SortPath,156)",conn,1,3
			If rsNews.eof Then
				Response.write("<li><a href='#'>1.no info</a><font>2012-12-12</font></li>")
			Else
				For i=1 To 4
				If rsNews.eof Then Exit For
				if StrLen(Removehtml(rsNews("NewsName")))<=26 then
				 ProductName=Removehtml(rsNews("NewsName"))
				 else 
				 ProductName=StrLeft(Removehtml(Removehtml(rsNews("NewsName"))),25)
				end if
				Response.write("<li><a href='newsview.asp?sortid="&rsNews("sortid")&"&id="&rsNews("id")&"&sortpath="&request("sortpath")&"'>"&i&"."&ProductName&"</a></li>")
				rsNews.movenext
				Next
			End If
			rsNews.close
End Function

'首页引用新闻页内容,列表(带参数)
Function indexshowinfo(idinfo)

			Set rsNews=server.CreateObject("adodb.recordset")
			rsNews.open "select * from pp_News where instr(SortPath,"&idinfo&") order by AddTime desc",conn,1,3
			If rsNews.eof Then
				Response.write("<li><a href='#'>1.no info</a><font>2012-12-12</font></li>")
			Else
				For i=1 To 4
				If rsNews.eof Then Exit For
				if StrLen(Removehtml(rsNews("NewsName")))<=26 then
				 ProductName=Removehtml(rsNews("NewsName"))
				 else 
				 ProductName=StrLeft(Removehtml(Removehtml(rsNews("NewsName"))),25)
				end if
				Response.write("<li><a href='newsview.asp?sortid="&rsNews("sortid")&"&id="&rsNews("id")&"&sortpath="&request("sortpath")&"'>"&i&"."&ProductName&"</a></li>")
				rsNews.movenext
				Next
			End If
			rsNews.close
End Function
'首页引用新闻页内容,详细(带参数)
function wxjNewsView(idDefault)
dim rs,sql,sid
 sid=Trim(Request.QueryString("sid"))
set rs = server.createobject("adodb.recordset")
if sid<>"" then 
 sql="select top 1 * from pp_news where instr(sortpath,"&sid&")>0 order by id desc" 
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

'首页引用新闻页服务中心,详细(带参数)
function wxjServiceView(idDefault)
dim rs,sql,sid
 sid=Trim(Request.QueryString("sid"))
set rs = server.createobject("adodb.recordset")
if sid<>"" then 
 sql="select top 1 * from pp_news where instr(sortpath,"&sid&")>0 order by id desc" 
  else
 sql="select top 1 * from pp_news where instr(sortpath,"&idDefault&")>0 order by id desc"
  end if
  rs.open sql,conn,1,3
  if rs("content")<>"" then
  response.Write rs("enContent")
  else
   response.Write"更新中......"
end if
  rs.close
 set rs=nothing
end Function
'首页友情链接图片样式（即入驻品牌）
function flinkpic()
dim i
set rs = server.createobject("adodb.recordset")
  sql="select  * from pp_News where instr(sortpath,162)>0 and ViewFlag  order by id desc"
  rs.open sql,conn,1,3
	i=0
	If rs.eof Then
		Response.write("no info")
	Else
		For i=0 To 7
			If i=7 Or rs.eof Then Exit For
			Response.write("<a href='"&rs("source")&"' target='_blank'><img src='"&replace(rs("bigpic"),"../","")&"'/></a>")
			rs.movenext
			Next
		'Do While Not rs.eof
			'Response.write("<a href='"&rs("source")&"'><img src='"&replace(rs("bigpic"),"../","")&"'/></a>")
			
			'If (i+1) Mod 7=0 Then
				'Response.write("<hr/>")
			'End If
			'i=i+1
			'rs.movenext
		'Loop
	End If

     rs.close
 set rs=nothing

end function
'首页友情链接select样式
function selectflink()
dim i,n
set rs = server.createobject("adodb.recordset")
  sql="select  * from pp_News where instr(sortpath,163)>0 and ViewFlag  order by id desc"
  rs.open sql,conn,1,3
	If rs.eof Then
	Else
		Do While Not rs.eof
		Response.write("<option value='"&rs("source")&"'>"&rs("newsname")&"</option>")
		rs.movenext
		Loop
	End If
  
 
     rs.close
 set rs=nothing

End Function
'新闻左边栏切换
Function suncangnewsleftchange()
			if request.QueryString("sortid")=201 then
				call suncangaboutleft()	
				Exit Function
			End If
			if request.QueryString("sortid")=192 then
				call suncangfashioncleft()	
				Exit Function
			End If

			If request.QueryString("sortid")=197 Then
				call suncangbuyleft()
			Else
				call suncangnewsleft()
			end If
End Function
'顺昌百货页左边栏切换

Function suncangshopleftchange()

			If request.QueryString("sortid")=192 Or request.QueryString("sortid")=191 Then
				call suncangfashioncleft()

			Else
				'call suncangnewsleft()
				call suncangbuyleft()
				
			end If
End Function
'新闻展示页/百货详细页换左标题图
Function suncangnewslefttitle()
	If request.QueryString("sortid")=201 Then
		Response.write("<img src='img/about.jpg'/>")
		exit Function
	End If
	If request.QueryString("sortid")=192 Or request.QueryString("sortid")=191 Then
		Response.write("<img src='img/fashion.jpg'/>")
		exit Function
	End If
	If request.QueryString("sortid")=197 Then
		Response.write("<img src='img/buy_btn.jpg'/>")
	Else
		Response.write("<img src='img/news_btn.jpg'/>")
	End If
end Function
'获得banner图带参数
  function getbanner(banId)
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

'获得fashion首图
  function fashionbanner()
set rs = server.createobject("adodb.recordset")
  sql="select  * from pp_News where instr(sortpath,189)>0 and ViewFlag  order by id desc"
  rs.open sql,conn,1,3
  
   while not rs.eof
   
response.Write "<img src='"&replace(rs("bigpic"),"../","")&"' alt='"&rs("Source")&"' title='"&rs("content")&"'/>"

  rs.movenext
  wend
     rs.close
 set rs=nothing
end Function
'新闻详细页展示(不分页)
function suncangnewsview()
dim ID,content,numbers,pagenum,maxpage,requestpage,thispage,SortID
SortID=request.QueryString("SortID")
  ID=Request("ID")
  if ID="" or (not isnumeric(ID)) then
    response.write "<div align='center'>数据读取异常错误</div>"
  Else
	Set rs=server.CreateObject("adodb.recordset")
	rs.open "select * from pp_News where ID="&ID,conn,1,3
	If rs.eof Then
		Response.write("no info")
	Else
		Response.write("<div><p style='display:block;float:left;width:553px;height:28px;font-size:12px ;color:#606060;line-height:28px;'>"&rs("NewsName")&"</p><p style='height:28px;font-size:12px ;color:#606060;line-height:28px;'>"&rs("AddTime")&"</p></div><hr style='border-top:1px solid #d0d0d0;border-bottom:1px solid white;'/>"&Chr(13)&"<div style='margin-top:23px;width:676px;overflow:hidden;'>"&rs("Content")&"</div>")
		
	End If
  End If
End Function
'顺昌广场(关于我们中)展示
function suncangaboutviewnews()
  dim SortPath
      SortPath=Trim(request.QueryString("sid"))
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
		 datawhere="where ViewFlag and Instr(SortPath,201)>0 "
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
	'改样式
		if StrLen(Removehtml(rs("NewsName")))<=26 then
        ProductName=Removehtml(rs("NewsName"))
	  else 
	     ProductName=StrLeft(Removehtml(Removehtml(rs("NewsName"))),25)
	   end if
		if StrLen(Removehtml(rs("content")))<=180 then
			content=Removehtml(rs("content")) '去除html
		else 
			content=StrLeft(Removehtml(Removehtml(rs("content"))),250) '截取字长
		end if
   response.Write "<div class='main_line_left_shop_r_box'><div class='main_line_left_case_r_l'><a href='newsview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'><img style='margin-right:10px;float:left;width:332px;height:213px;' src='"& replace(rs("BigPic"),"../","")&"' width='300' height='280' border='0'/></a></div><div class='main_line_left_case_r_r'><div class='main_line_left_shop_r_r_tit'><a href='newsview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'>"&ProductName&"</a></div><div class='main_line_left_news_r_r_con'><p><a href='newsview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'>"&content&"</a></p></div></div><p class='main_line_left_shop_r_r_more'><a href='newsview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'>详细内容</a></p></div>"&Chr(13)
	'改样式

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

'顺昌广场(名店名品)展示
function suncangfashionviewnews()
  dim SortPath
      SortPath=Trim(request.QueryString("sid"))
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
		 datawhere="where ViewFlag and Instr(SortPath,192)>0 "
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
	'改样式
		if StrLen(Removehtml(rs("NewsName")))<=26 then
        ProductName=Removehtml(rs("NewsName"))
	  else 
	     ProductName=StrLeft(Removehtml(Removehtml(rs("NewsName"))),25)
	   end if
		if StrLen(Removehtml(rs("content")))<=180 then
			content=Removehtml(rs("content")) '去除html
		else 
			content=StrLeft(Removehtml(Removehtml(rs("content"))),250) '截取字长
		end if
   response.Write "<div class='main_line_left_shop_r_box'><div class='main_line_left_case_r_l'><a href='baihuoshopview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'><img style='margin-right:10px;float:left;width:332px;height:213px;' src='"& replace(rs("BigPic"),"../","")&"' width='300' height='280' border='0'/></a></div><div class='main_line_left_case_r_r'><div class='main_line_left_shop_r_r_tit'><a href='baihuoshopview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'>"&ProductName&"</a></div><div class='main_line_left_news_r_r_con'><p><a href='baihuoshopview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'>"&content&"</a></p></div></div><p class='main_line_left_shop_r_r_more'><a href='baihuoshopview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'>详细内容</a></p></div>"&Chr(13)
	'改样式

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
'顺昌百货(购物攻略中)页1
function suncangbuyshopview()
  dim SortPath
      SortPath=Trim(request.QueryString("sid"))
  dim idCount'记录总数
  dim pages'每页条数
      pages=6
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
		 datawhere="where ViewFlag and Instr(SortPath,197)>0 "
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
  
  if(idcount>0 and sqlid<>"") then'如果记录总数=0,则不处理
    '用in刷选本页所语言的数据,仅读取本页所需的数据,所以速度快
    sql="select * from ["& datafrom &"] where id in("& sqlid &") "&taxis
    set rs=server.createobject("adodb.recordset")
    rs.open sql,conn,0,1
    while not rs.eof '填充数据到表格
	Addtime=year(rs("AddTime"))&"-"&month(rs("AddTime"))&"-"&day(rs("AddTime"))
	'改样式
		if StrLen(Removehtml(rs("NewsName")))<=26 then
        ProductName=Removehtml(rs("NewsName"))
	  else 
	     ProductName=StrLeft(Removehtml(Removehtml(rs("NewsName"))),25)
	   end if
		if StrLen(Removehtml(rs("content")))<=180 then
			content=Removehtml(rs("content")) '去除html
		else 
			content=StrLeft(Removehtml(Removehtml(rs("content"))),250) '截取字长
		end If


   response.Write "<div style='margin:0 auto;width:682px;height:236px;' class='main_line_left_shop_r_box'><div style='float:left;width:345px;height:234px;' class='main_line_left_case_r_l'><a href='baihuoshopview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'><img style='margin-right:10px;float:left;width:332px;height:213px;' src='"& replace(rs("BigPic"),"../","")&"' width='300' height='280' border='0'/></a></div><div style='display:inline-block;width:335px;height:213px;' class='main_line_left_case_r_r'><div style='margin:0 auto;width:335px;height:21px;' class='main_line_left_shop_r_r_tit'><a href='baihuoshopview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'>"&ProductName&"</a></div><div style='margin:0 auto;width:335px;height:117px;' class='main_line_left_news_r_r_con'><p><a href='baihuoshopview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'>"&content&"</a></p></div><div style='margin:0 auto;width:335px;height:64px;'><p class='main_line_left_shop_r_r_more'><a href='baihuoshopview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'>详细内容</a></p></div></div></div>"&Chr(13)
	'改样式

	  rs.movenext
    wend
  else
    response.write "暂无相关信息"
	exit function
  end If
  Response.Write "<div style='clear:both;margin:0 auto;width:640px;height:47px;'>"
  Response.Write "<table style='font-size:12px;' width='98%' border='0' cellspacing='0' cellpadding='0' style='clear:both;'>"
  Response.Write "<tr style='height:30px;line-height:30px;padding-right:30px;'>" & vbCrLf
  Response.Write "<td colspan='2' align='right' style='color:#444444'>" & vbCrLf
  Response.Write "<div class='nav'></div>" & vbCrLf
  Response.Write "共计：<font color='#ff6600'>"&idcount&"</font>条记录&nbsp;页次：<font color='#ff6600'>"&page&"</font></strong>/"&pagec&"&nbsp;每页：<font color='#ff6600'>"&pages&"</font>条" & vbCrLf
  pagenmin=page-pagenc '计算页码开始值
  pagenmax=page+pagenc '计算页码结束值
  if(pagenmin<1) then pagenmin=1 '如果页码开始值小于1则=1
  if(page>1) then response.write ("<a href='"& myself &"Page=1'><font style='FONT-SIZE: 14px; FONT-FAMILY: Webdings'>9</font></a>&nbsp;") '如果页码大于1则显示(第一页)
  if(pagenmin>1) then response.write ("<a href='"& myself &"Page="& page-(pagenc*2+1) &"'><font style='FONT-SIZE: 14px; FONT-FAMILY: Webdings'>7</font></a>&nbsp;") '如果页码开始值大于1则显示(更前)
  if(pagenmax>pagec) then pagenmax=pagec '如果页码结束值大于总页数,则=总页数
  for i = pagenmin to pagenmax'循环输出页码
	if(i=page) then
	 ' response.write ("&nbsp;<font color='#ff6600'>第"& i &"頁</font>&nbsp;")
	else
	 ' response.write ("[<a href="& myself &"Page="& i &">"& i &"</a>]")
	end if
  next
  if(pagenmax<pagec) then response.write ("&nbsp;<a href='"& myself &"Page="& page+(pagenc*2+1) &"'><font style='FONT-SIZE: 14px; FONT-FAMILY: Webdings'>8</font></a>&nbsp;") '如果页码结束值小于总页数则显示(更后)
  if(page<pagec) then response.write ("<a href='"& myself &"Page="& pagec &"'><font style='FONT-SIZE: 14px; FONT-FAMILY: Webdings'>:</font></a>") '如果页码小于总页数则显示(最后页)	
  Response.Write "</td>" & vbCrLf
  Response.Write "</tr>" & vbCrLf
  Response.Write "</table>" & vbCrLf
  Response.Write "</div>"
  rs.close
  set rs=nothing
end function 
function suncangbuyviewnews()
  dim SortPath
      SortPath=Trim(request.QueryString("sid"))
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
		 datawhere="where ViewFlag and Instr(SortPath,197)>0 "
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
	'改样式
		if StrLen(Removehtml(rs("NewsName")))<=26 then
        ProductName=Removehtml(rs("NewsName"))
	  else 
	     ProductName=StrLeft(Removehtml(Removehtml(rs("NewsName"))),25)
	   end if
		if StrLen(Removehtml(rs("content")))<=180 then
			content=Removehtml(rs("content")) '去除html
		else 
			content=StrLeft(Removehtml(Removehtml(rs("content"))),250) '截取字长
		end if
   response.Write "<div class='main_line_left_shop_r_box'><div class='main_line_left_case_r_l'><a href='shopview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'><img style='margin-right:10px;float:left;width:332px;height:213px;' src='"& replace(rs("BigPic"),"../","")&"' width='300' height='280' border='0'/></a></div><div class='main_line_left_case_r_r'><div class='main_line_left_shop_r_r_tit'><a href='shopview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'>"&ProductName&"</a></div><div class='main_line_left_news_r_r_con'><p><a href='shopview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'>"&content&"</a></p></div></div><p class='main_line_left_shop_r_r_more'><a href='shopview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'>详细内容</a></p></div>"&Chr(13)
	'改样式

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
'产品详细(即名店名品)页展示(不分页)
function suncangproduceview()
dim ID,content,numbers,pagenum,maxpage,requestpage,thispage,SortID
SortID=request.QueryString("SortID")
  ID=Request("ID")
  if ID="" or (not isnumeric(ID)) then
    response.write "<div align='center'>数据读取异常错误</div>"
  Else
	Set rs=server.CreateObject("adodb.recordset")
	rs.open "select * from pp_Products where ID="&ID,conn,1,3
	If rs.eof Then
		Response.write("no info")
	Else
	'新增4图展示
		Response.write("<div class='slide'><div class='pic'>")
	'改循环
		stringPic="slidepic"
		countPic=0
		For j=1 To 5
			savePic=stringPic&CStr(j)
			If rs(savePic)<>"" Then
				countPic=countPic+1
			End If
		Next
		For i=1 To countPic
				savePic2=stringPic&CStr(i)
				If i=1 Then
				Response.write("<a style='display:block;' href='#'><img src='"&rs(savePic2)&"'/></a>") '刚打开页面显示
				Else
				Response.write("<a href='#'><img src='"&rs(savePic2)&"'/></a>")
				End If

		Next
		Response.write("</div><div class='thumb'>")
		For i=1 To countPic
			Response.write("<a href='#'><img src='"&rs(savePic2)&"'/></a>")
		Next

	'改循环结束


		'Response.write("<a href='#'><img src='"&rs("slidepic1")&"'/></a>")
		'Response.write("<a href='#'><img src='"&rs("slidepic2")&"'/></a>")
		'Response.write("<a href='#'><img src='"&rs("slidepic3")&"'/></a>")
		'Response.write("<a href='#'><img src='"&rs("slidepic4")&"'/></a>")
		'Response.write("<a href='#'><img src='"&rs("slidepic5")&"'/></a>")


		
		Response.write("</div></div>")
	'新增4图展示结束
		Response.write(""&Chr(13)&"<div class='divShopDetail'><div class='divShopDetailC'>"&rs("Content")&"</div><hr style='width:95%;border-top:1px solid #d0d0d0;border-bottom:1px solid white;'/><div class='divShopDetailBottom'><p style='display:block;float:left;width:553px;height:28px;font-size:12px ;color:#606060;line-height:28px;'>"&rs("ProductName")&"</p><p style='height:28px;font-size:12px ;color:#606060;line-height:28px;'>"&rs("AddTime")&"</p></div></div>")
		
	End If
  End If
End Function
'连锁门店(cgal表)页展示(不分页)
function suncangcgalview()
dim ID,content,numbers,pagenum,maxpage,requestpage,thispage,SortID
SortID=request.QueryString("SortID")
  ID=Request("ID")
  if ID="" or (not isnumeric(ID)) then
    response.write "<div align='center'>数据读取异常错误</div>"
  Else
	Set rs=server.CreateObject("adodb.recordset")
	rs.open "select * from pp_cgal where ID="&ID,conn,1,3
	If rs.eof Then
		Response.write("no info")
	Else
	'新增4图展示
		Response.write("<div class='slide'><div class='pic'>")
	'改循环
		stringPic="slidepic"
		countPic=0
		For j=1 To 5
			savePic=stringPic&CStr(j)
			If rs(savePic)<>"" Then
				countPic=countPic+1
			End If
		Next
		For i=1 To countPic
				savePic2=stringPic&CStr(i)
				If i=1 Then
				Response.write("<a style='display:block;' href='#'><img src='"&rs(savePic2)&"'/></a>") '刚打开页面显示
				Else
				Response.write("<a href='#'><img src='"&rs(savePic2)&"'/></a>")
				End If

		Next
		Response.write("</div><div class='thumb'>")
		For i=1 To countPic
			Response.write("<a href='#'><img src='"&rs(savePic2)&"'/></a>")
		Next

	'改循环结束
		

		'Response.write("<a href='#'><img src='"&rs("slidepic1")&"'/></a>")
		'Response.write("<a href='#'><img src='"&rs("slidepic2")&"'/></a>")
		'Response.write("<a href='#'><img src='"&rs("slidepic3")&"'/></a>")
		'Response.write("<a href='#'><img src='"&rs("slidepic4")&"'/></a>")
		'Response.write("<a href='#'><img src='"&rs("slidepic5")&"'/></a>")

		Response.write("</div></div>")
	'新增4图展示结束
		Response.write(""&Chr(13)&"<div class='divShopDetail'><div class='divShopDetailC'>"&rs("Content")&"</div><hr style='width:95%;border-top:1px solid #d0d0d0;border-bottom:1px solid white;'/><div class='divShopDetailBottom'><p style='display:block;float:left;width:553px;height:28px;font-size:12px ;color:#606060;line-height:28px;'>"&rs("ProductName")&"</p><p style='height:28px;font-size:12px ;color:#606060;line-height:28px;'>"&rs("AddTime")&"</p></div></div>")
		
	End If
  End If
End Function

'百货展示页详细,查询NEWS表(不分页)
function suncangbuyshopview2()
dim ID,content,numbers,pagenum,maxpage,requestpage,thispage,SortID
'SortID=request.QueryString("SortID")
  ID=Request.QueryString("id")
  if ID="" or (not isnumeric(ID)) then
    response.write "<div align='center'>数据读取异常错误</div>"
  Else
	Set rs=server.CreateObject("adodb.recordset")
	rs.open "select * from pp_News where ID="&ID,conn,1,3
	If rs.eof Then
		Response.write("no info")
	Else
	'新增4图展示
		Response.write("<div class='slide'><div class='pic'>")
	'改循环

		stringPic="slidepic"
		countPic=0
		For j=1 To 5
			savePic=stringPic&CStr(j)
			If rs(savePic)<>"" Then
				countPic=countPic+1
			End If
		Next
		For i=1 To countPic
				savePic2=stringPic&CStr(i)
				If i=1 Then
				Response.write("<a style='display:block;' href='#'><img src='"&rs(savePic2)&"'/></a>") '刚打开页面显示
				Else
				Response.write("<a href='#'><img src='"&rs(savePic2)&"'/></a>")
				End If

		Next
		Response.write("</div><div class='thumb'>")
		For i=1 To countPic
			Response.write("<a href='#'><img src='"&rs(savePic2)&"'/></a>")
		Next

	'改循环结束
		

		'Response.write("<a href='#'><img src='"&rs("slidepic1")&"'/></a>")
		'Response.write("<a href='#'><img src='"&rs("slidepic2")&"'/></a>")
		'Response.write("<a href='#'><img src='"&rs("slidepic3")&"'/></a>")
		'Response.write("<a href='#'><img src='"&rs("slidepic4")&"'/></a>")
		'Response.write("<a href='#'><img src='"&rs("slidepic5")&"'/></a>")
		
		Response.write("</div></div>")
	'新增4图展示结束
		Response.write(""&Chr(13)&"<div class='divShopDetail'><div class='divShopDetailC'>"&rs("Content")&"</div><hr style='width:95%;border-top:1px solid #d0d0d0;border-bottom:1px solid white;'/><div class='divShopDetailBottom'><p style='display:block;float:left;width:553px;height:28px;font-size:12px ;color:#606060;line-height:28px;'>"&rs("NewsName")&"</p><p style='height:28px;font-size:12px ;color:#606060;line-height:28px;'>"&rs("AddTime")&"</p></div></div>")
		
	End If
  End If
End Function
	
'产品展示页(分页)
function suncangproduct()


 dim rs,sql,page,sid,pid
 pid=Request.QueryString("pid")
 sid=Request.QueryString("id")
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

plist_bottom=plist_bottom&"<table class='divProPage'><tr><td><div style='padding-left:152px;'>"
plist_bottom=plist_bottom&" <b style='font-size:12px;font-weight:normal;color:#707070;'>共有"&Totalnumber&"条&nbsp;显示第"&CurrentPage&"页&nbsp;总"&PageCount1&"页</b> &nbsp;"
Pageno=CurrentPage
If cint(Pageno)>1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href='produce.asp?sortid="&sortid&"&sortpath="&sortpath&"'title=""index"">"
else
plist_bottom=plist_bottom&"<a href='produce.asp' title=""index"">"
end if
End If
plist_bottom=plist_bottom&" 首&nbsp;&nbsp;页 </a>&nbsp;"
If Cint(Pageno)>1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href=produce.asp?page="&Pageno-1&"&sortid="&sortid&"&sortpath="&sortpath&" title=""Previous"">"
else
plist_bottom=plist_bottom&"<a href=produce.asp?page="&Pageno-1&" title=""Previous"">"
end if
End If
plist_bottom=plist_bottom&"[ 上一页 ]</a>&nbsp;"
If Cint(Pageno)< PageCount1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href=produce.asp?page="&Pageno+1&"&sortid="&sortid&"&sortpath="&sortpath&" title=""Next"">"
else
plist_bottom=plist_bottom&"<a href=produce.asp?page="&Pageno+1&" title=""Next"">"
End If
End If
plist_bottom=plist_bottom&"[ 下一页 ]</a>&nbsp;"
If Cint(Pageno)< Pagecount1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href='produce.asp?page="&PageCount1&"&sortid="&sortid&"&sortpath="&sortpath&"' title=""Last"">"
else
plist_bottom=plist_bottom&"<a href='produce.asp?page="&PageCount1&"' title=""Last"">"
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
   
   response.Write "<div style='margin:0 auto;width:682px;height:236px;' class='main_line_left_shop_r_box'><div style='float:left;width:345px;height:234px;' class='main_line_left_case_r_l'><a href='produceview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'><img style='margin-right:10px;float:left;width:332px;height:213px;' src='"& replace(rs("smallpic"),"../","")&"' width='300' height='280' border='0'/></a></div><div style='display:inline-block;width:335px;height:213px;' class='main_line_left_case_r_r'><div style='margin:0 auto;width:335px;height:21px;' class='main_line_left_shop_r_r_tit'><a href='produceview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'>"&ProductName&"</a></div><div style='margin:0 auto;width:335px;height:117px;' class='main_line_left_shop_r_r_con'><p><a href='produceview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'>"&content&"</a></p></div><div style='margin:0 auto;width:335px;height:64px;'><p class='main_line_left_shop_r_r_more'><a href='produceview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'>详细内容</a></p></div></div></div>"&Chr(13)
  
  
row_count=row_count+1
if n>=MaxPerPage then exit do
rs.movenext
loop

rs.close
response.write plist_bottom
end if
end Function
'名店名品页面展示
function suncangcase_p() 

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

plist_bottom=plist_bottom&"<table style='font-size:12px;font-weight:normal;color:#707070;' width='990px' hight='100px'><tr><td><div style='padding-left:152px;'>"
plist_bottom=plist_bottom&" <b style='font-size:12px;font-weight:normal;color:#707070;'>共有"&Totalnubmer&"条&nbsp;显示第"&CurrentPage&"页&nbsp;总"&PageCount1&"页</b> &nbsp;"
Pageno=CurrentPage
If cint(Pageno)>1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a style='font-size:12px;font-weight:normal;color:#707070;' href='case.asp?sortid="&sortid&"&sortpath="&sortpath&"'title=""index"">"
else
plist_bottom=plist_bottom&"<a style='font-size:12px;font-weight:normal;color:#707070;' href='case.asp' title=""index"">"
end if
End If
plist_bottom=plist_bottom&" 首&nbsp;&nbsp;页 </a>&nbsp;"
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
   
   response.Write "<div class='main_line_left_shop_r_box'><div class='main_line_left_case_r_l'><a href='newsview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'><img style='margin-right:10px;float:left;width:332px;height:213px;' src='"& replace(rs("smallpic"),"../","")&"' width='300' height='280' border='0'/></a></div><div class='main_line_left_case_r_r'><div class='main_line_left_shop_r_r_tit'><a href='newsview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'>"&ProductName&"</a></div><div class='main_line_left_shop_r_r_con'><p><a href='newsview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'>"&content&"</a></p></div></div><p class='main_line_left_shop_r_r_more'><a href='newsview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'>详细内容</a></p></div>"&Chr(13)
  
  
row_count=row_count+1
if n>=MaxPerPage then exit do
rs.movenext
loop

rs.close
response.write plist_bottom
end if
end Function

'连锁门店页面展示backup2
function suncangcgal_p_backup2() 

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
	  Else
	  
	  sql="select * from pp_cgal where  ViewFlag and instr(sortpath,3)>0 order by Sequence asc"
	  end if
end if
   rs.open sql,conn,1,3
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

plist_bottom=plist_bottom&"<table style='font-size:12px;font-weight:normal;color:#707070;' width='990px' hight='100px'><tr><td><div style='padding-left:152px;'>"
plist_bottom=plist_bottom&" <b style='font-size:12px;font-weight:normal;color:#707070;'>共有"&Totalnubmer&"条&nbsp;显示第"&CurrentPage&"页&nbsp;总"&PageCount1&"页</b> &nbsp;"
Pageno=CurrentPage
If cint(Pageno)>1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a style='font-size:12px;font-weight:normal;color:#707070;' href='case.asp?sortid="&sortid&"&sortpath="&sortpath&"'title=""index"">"
else
plist_bottom=plist_bottom&"<a style='font-size:12px;font-weight:normal;color:#707070;' href='case.asp' title=""index"">"
end if
End If
plist_bottom=plist_bottom&" 首&nbsp;&nbsp;页 </a>&nbsp;"
If Cint(Pageno)>1 Then
if sortid<>"" Then

plist_bottom=plist_bottom&"<a href=shopview.asp?page="&Pageno-1&"&sortid="&sortid&"&sortpath="&sortpath&" title=""Previous"">"
else
plist_bottom=plist_bottom&"<a href=shopview.asp?page="&Pageno-1&" title=""Previous"">"
end if
End If
plist_bottom=plist_bottom&"[ 上一页 ]</a>&nbsp;"
If Cint(Pageno)< PageCount1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href=shopview.asp?page="&Pageno+1&"&sortid="&sortid&"&sortpath="&sortpath&" title=""Next"">"
else
plist_bottom=plist_bottom&"<a href=shopview.asp?page="&Pageno+1&" title=""Next"">"
End If
End If
plist_bottom=plist_bottom&"[ 下一页 ]</a>&nbsp;"
If Cint(Pageno)< Pagecount1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href='shopview.asp?page="&PageCount1&"&sortid="&sortid&"&sortpath="&sortpath&"' title=""Last"">"
else
plist_bottom=plist_bottom&"<a href='shopview.asp?page="&PageCount1&"' title=""Last"">"
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

'下面报错,原因不明

	' if StrLen(Removehtml(rs("ProductName")))<=26 then
      '  ProductName=Removehtml(rs("ProductName"))
	 ' else 
	 '    ProductName=StrLeft(Removehtml(Removehtml(rs("ProductName"))),25)
	 '  end if
	   
	  ' if StrLen(Removehtml(rs("content")))<=180 then
     '   content=Removehtml(rs("content"))
	 ' else 
	'     content=StrLeft(Removehtml(Removehtml(rs("content"))),179)
	 '  end if
   
'改样式
	'Response.write("<img src='img/shop_show0.jpg'/><div class='shopShowT'>fdafdaf</div>")

'改样式

   response.Write "<div class='main_line_left_shop_r_box'><div class='main_line_left_case_r_l'><a href='shopview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'><img style='margin-right:10px;float:left;width:332px;height:213px;' src='"& replace(rs("smallpic"),"../","")&"' width='300' height='280' border='0'/></a></div><div class='main_line_left_case_r_r'><div class='main_line_left_shop_r_r_tit'><a href='shopview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'>"&ProductName&"</a></div><div class='main_line_left_shop_r_r_con'><p><a href='shopview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'>"&content&"</a></p></div></div><p class='main_line_left_shop_r_r_more'><a href='shopview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'>详细内容</a></p></div>"&Chr(13)
  
  
row_count=row_count+1
if n>=MaxPerPage then exit do
rs.movenext
loop

rs.close
response.write plist_bottom
end if
end Function

'连锁门店页面展示
function suncangcgal_p() 

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
	  Else
	  
	  sql="select * from pp_cgal where  ViewFlag and instr(sortpath,3)>0 order by Sequence asc"
	  end if
end if
   rs.open sql,conn,1,3
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

plist_bottom=plist_bottom&"<div style='clear:both;margin:0 auto;width:655px;height:100px;'><table class='divProPage'><tr><td><div style='padding-left:152px;'>"
plist_bottom=plist_bottom&" <b style='font-size:12px;font-weight:normal;color:#707070;'>共有"&Totalnumber&"条&nbsp;显示第"&CurrentPage&"页&nbsp;总"&PageCount1&"页</b> &nbsp;"
Pageno=CurrentPage
If cint(Pageno)>1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a style='font-size:12px;font-weight:normal;color:#707070;' href='case.asp?sortid="&sortid&"&sortpath="&sortpath&"'title=""index"">"
else
plist_bottom=plist_bottom&"<a style='font-size:12px;font-weight:normal;color:#707070;' href='case.asp' title=""index"">"
end if
End If
plist_bottom=plist_bottom&" 首&nbsp;&nbsp;页 </a>&nbsp;"
If Cint(Pageno)>1 Then
if sortid<>"" Then

plist_bottom=plist_bottom&"<a href=shopview.asp?page="&Pageno-1&"&sortid="&sortid&"&sortpath="&sortpath&" title=""Previous"">"
else
plist_bottom=plist_bottom&"<a href=shopview.asp?page="&Pageno-1&" title=""Previous"">"
end if
End If
plist_bottom=plist_bottom&"[ 上一页 ]</a>&nbsp;"
If Cint(Pageno)< PageCount1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href=shopview.asp?page="&Pageno+1&"&sortid="&sortid&"&sortpath="&sortpath&" title=""Next"">"
else
plist_bottom=plist_bottom&"<a href=shopview.asp?page="&Pageno+1&" title=""Next"">"
End If
End If
plist_bottom=plist_bottom&"[ 下一页 ]</a>&nbsp;"
If Cint(Pageno)< Pagecount1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href='shopview.asp?page="&PageCount1&"&sortid="&sortid&"&sortpath="&sortpath&"' title=""Last"">"
else
plist_bottom=plist_bottom&"<a href='shopview.asp?page="&PageCount1&"' title=""Last"">"
End If
End If
plist_bottom=plist_bottom&"[ 末页 ]</a>"
plist_bottom=plist_bottom&"</div></td></tr></table></div>"


Row_Count=1
do while not rs.eof
N=N+1
	      if n=3 and n=6 then
   response.write"<br>"
   end if

'下面报错,原因不明

	 if StrLen(Removehtml(rs("ProductName")))<=26 then
        ProductName=Removehtml(rs("ProductName"))
	  else 
	     ProductName=StrLeft(Removehtml(Removehtml(rs("ProductName"))),25)
	   end if
	   If rs("content")<>"" Then
		   if StrLen(Removehtml(rs("content")))<=180 then
			content=Removehtml(rs("content"))
		  else 
			 content=StrLeft(Removehtml(Removehtml(rs("content"))),179)
		   end if
	   End If
'改样式
	'Response.write("<img src='img/shop_show0.jpg'/><div class='shopShowT'>fdafdaf</div>")

'改样式

   response.Write "<div class='main_line_left_shop_store_r_box' style='float:left;width:681px;height:106px;'><div style='float:left;width:104px;height:90px;'><a style='width:103px;height:104px;' href='shopview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'><img src='"&rs("SmallPic")&"'/></a></div><div style='display:inline-block;width:567px;height:104px;' class='main_line_left_shop_store_r_box_t'><div style='margin:0 auto;width:565px;height:23px;'><div style='float:left;width:430px;height:21px;font-size:12px;'>"&ProductName&"</div><div style='display:inline-block;margin:0 auto;width:132px;height:21px;'><font>"&rs("AddTime")&"</font></div></div><div style='clear:both;width:580px;height:81px;' class='main_line_left_shop_store_r_box_c'><p><a href='shopview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'>"&Content&"[详细进入]</a></p></div></div></div>"&Chr(13)
  
  
row_count=row_count+1
if n>=MaxPerPage then exit do
rs.movenext
loop

rs.close
response.write plist_bottom
end if
end Function
'连锁门店页面展示backup
function suncangcgal_p_backup() 

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
	  Else
	  
	  sql="select * from pp_cgal where  ViewFlag and instr(sortpath,3)>0 order by Sequence asc"
	  end if
end if
   rs.open sql,conn,1,3
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

plist_bottom=plist_bottom&"<table style='font-size:12px;font-weight:normal;color:#707070;' width='990px' hight='100px'><tr><td><div style='padding-left:152px;'>"
plist_bottom=plist_bottom&" <b style='font-size:12px;font-weight:normal;color:#707070;'>共有"&Totalnubmer&"条&nbsp;显示第"&CurrentPage&"页&nbsp;总"&PageCount1&"页</b> &nbsp;"
Pageno=CurrentPage
If cint(Pageno)>1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a style='font-size:12px;font-weight:normal;color:#707070;' href='case.asp?sortid="&sortid&"&sortpath="&sortpath&"'title=""index"">"
else
plist_bottom=plist_bottom&"<a style='font-size:12px;font-weight:normal;color:#707070;' href='case.asp' title=""index"">"
end if
End If
plist_bottom=plist_bottom&" 首&nbsp;&nbsp;页 </a>&nbsp;"
If Cint(Pageno)>1 Then
if sortid<>"" Then

plist_bottom=plist_bottom&"<a href=shopview.asp?page="&Pageno-1&"&sortid="&sortid&"&sortpath="&sortpath&" title=""Previous"">"
else
plist_bottom=plist_bottom&"<a href=shopview.asp?page="&Pageno-1&" title=""Previous"">"
end if
End If
plist_bottom=plist_bottom&"[ 上一页 ]</a>&nbsp;"
If Cint(Pageno)< PageCount1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href=shopview.asp?page="&Pageno+1&"&sortid="&sortid&"&sortpath="&sortpath&" title=""Next"">"
else
plist_bottom=plist_bottom&"<a href=shopview.asp?page="&Pageno+1&" title=""Next"">"
End If
End If
plist_bottom=plist_bottom&"[ 下一页 ]</a>&nbsp;"
If Cint(Pageno)< Pagecount1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href='shopview.asp?page="&PageCount1&"&sortid="&sortid&"&sortpath="&sortpath&"' title=""Last"">"
else
plist_bottom=plist_bottom&"<a href='shopview.asp?page="&PageCount1&"' title=""Last"">"
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

'下面报错,原因不明

	' if StrLen(Removehtml(rs("ProductName")))<=26 then
      '  ProductName=Removehtml(rs("ProductName"))
	 ' else 
	 '    ProductName=StrLeft(Removehtml(Removehtml(rs("ProductName"))),25)
	 '  end if
	   
	  ' if StrLen(Removehtml(rs("content")))<=180 then
     '   content=Removehtml(rs("content"))
	 ' else 
	'     content=StrLeft(Removehtml(Removehtml(rs("content"))),179)
	 '  end if
   
'改样式
	'Response.write("<img src='img/shop_show0.jpg'/><div class='shopShowT'>fdafdaf</div>")

'改样式

   response.Write "<div class='main_line_left_shop_r_box'><div class='main_line_left_case_r_l'><a href='newsview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'><img style='margin-right:10px;float:left;width:332px;height:213px;' src='"& replace(rs("smallpic"),"../","")&"' width='300' height='280' border='0'/></a></div><div class='main_line_left_case_r_r'><div class='main_line_left_shop_r_r_tit'><a href='newsview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'>"&ProductName&"</a></div><div class='main_line_left_shop_r_r_con'><p><a href='newsview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'>"&content&"</a></p></div></div><p class='main_line_left_shop_r_r_more'><a href='newsview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'>详细内容</a></p></div>"&Chr(13)
  
  
row_count=row_count+1
if n>=MaxPerPage then exit do
rs.movenext
loop

rs.close
response.write plist_bottom
end if
end Function
'新闻2分页显示
function suncangnews2()

  dim SortPath
      SortPath=Trim(request.QueryString("id"))
  dim idCount'记录总数
  dim pages'每页条数
      pages=6
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
		 datawhere="where ViewFlag and Instr(SortPath,157)>0 "
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
	'改样式
		if StrLen(Removehtml(rs("NewsName")))<=26 then
        ProductName=Removehtml(rs("NewsName"))
	  else 
	     ProductName=StrLeft(Removehtml(Removehtml(rs("NewsName"))),25)
	   end if
		if StrLen(Removehtml(rs("content")))<=180 then
			content=Removehtml(rs("content")) '去除html
		else 
			content=StrLeft(Removehtml(Removehtml(rs("content"))),250) '截取字长
		end if
   response.Write "<div class='main_line_left_shop_r_box'><div class='main_line_left_case_r_l'><a href='newsview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'><img style='margin-right:10px;float:left;width:332px;height:213px;' src='"& replace(rs("BigPic"),"../","")&"' width='300' height='280' border='0'/></a></div><div class='main_line_left_case_r_r'><div class='main_line_left_shop_r_r_tit'><a href='newsview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'>"&ProductName&"</a></div><div class='main_line_left_news_r_r_con'><p><a href='newsview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'>"&content&"</a></p></div></div><p class='main_line_left_shop_r_r_more'><a href='newsview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'>详细内容</a></p></div>"&Chr(13)
	'改样式

	  rs.movenext
    wend
  else
    response.write "<tr><td align='center'>暂无相关信息</td></tr></table>"
	exit function
  end if
  Response.Write "<table class='divProPage'><tr style='height:30px;line-height:30px;'>" & vbCrLf
  Response.Write "<td style='padding-left:400px;' colspan='2' align='left' style='color:#444444'>" & vbCrLf
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
'新闻页1展示
Function newsshow0()
	getSortId=request.querystring("id")
	Set rs=server.CreateObject("adodb.recordset")
	rs.open "select * from pp_NewsSort where ParentID=156",conn,1,3
	If rs.eof Then
		Response.write("no info")
	Else
		Do While Not rs.eof
		Response.write("<div class='divNewsShow'><h3>"&rs("SortName")&"</h3><img src='img/news_pic.jpg'/>"&Chr(13)&"<ul>")
		
		

			Set rsNews=server.CreateObject("adodb.recordset")
			rsNews.open "select * from pp_News where instr(SortPath,"&rs("ID")&")",conn,1,3
			If rsNews.eof Then
				Response.write("<li><a href='#'>1.no info</a><font>2012-12-12</font></li>")
			Else
				For i=1 To 4
				If rsNews.eof Then Exit For
				Response.write("<li><a href='newsview.asp?sortid="&rsNews("sortid")&"&id="&rsNews("id")&"&sortpath="&request("sortpath")&"'>"&i&"."&rsNews("NewsName")&"</a><font>2012-12-12</font></li>")
				rsNews.movenext
				Next
			End If
			rsNews.close
		Response.write("</ul></div>")
		rs.movenext
		Loop
	End If
	rs.close
End Function
'fashion页展示backup3
function fashion_p_backup3() 

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

Maxperpage=9
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
plist_bottom=plist_bottom&"<a href='fashion.asp?sortid="&sortid&"&sortpath="&sortpath&"'title=""index"">"
else
plist_bottom=plist_bottom&"<a href='fashion.asp'title=""index"">"
end if
End If
plist_bottom=plist_bottom&"[ 首页 ]</a>&nbsp;"
If Cint(Pageno)>1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href=fashion.asp?page="&Pageno-1&"&sortid="&sortid&"&sortpath="&sortpath&" title=""Previous"">"
else
plist_bottom=plist_bottom&"<a href=fashion.asp?page="&Pageno-1&" title=""Previous"">"
end if
End If
plist_bottom=plist_bottom&"[ 上一页 ]</a>&nbsp;"
If Cint(Pageno)< PageCount1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href=fashion.asp?page="&Pageno+1&"&sortid="&sortid&"&sortpath="&sortpath&" title=""Next"">"
else
plist_bottom=plist_bottom&"<a href=fashion.asp?page="&Pageno+1&" title=""Next"">"
End If
End If
plist_bottom=plist_bottom&"[ 下一页 ]</a>&nbsp;"
If Cint(Pageno)< Pagecount1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href='fashion.asp?page="&PageCount1&"&sortid="&sortid&"&sortpath="&sortpath&"' title=""Last"">"
else
plist_bottom=plist_bottom&"<a href='fashion.asp?page="&PageCount1&"' title=""Last"">"
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
   
   response.Write "<div class='divBoxRShowWin'><img src='"& replace(rs("smallpic"),"../","")&"'/><h5>"&ProductName&"</h5><p><a href='newsview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'>"&content&"</a></p><input type='buttton'/></div>"
  
  
row_count=row_count+1
if n>=MaxPerPage then exit do
rs.movenext
loop

rs.close
response.write plist_bottom
end if
end Function

'fashion页展示
function fashionview() 

 dim rs,sql,page,sid,pid
 pid=Request.QueryString("pid")
 sid=Request.QueryString("sid")
 id=Request.QueryString("id")
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
  sql="select * from pp_News where  ViewFlag and instr(sortpath,3)>0 order by AddTime asc"
  else
  sql="select * from pp_News where  ViewFlag and instr(sortpath,"&sid&")>0 order by AddTime asc"
  end if
else
   if pid<>"" then
  sql="select * from pp_News where  ViewFlag and Instr(SortPath,'"&pid&"')>0 order by AddTime asc"
  Else
	If id<>"" Then
	 sql="select * from pp_News where  ViewFlag and instr(sortpath,"&id&")>0 order by AddTime asc"
	Else
	 sql="select * from pp_News where  ViewFlag and instr(sortpath,191)>0 order by AddTime asc"
	End If
  end if
end if
   rs.open sql,conn,1,1
If rs.Eof And rs.bof Then


response.write"<Div style='margin-top:20px;text-align:center'>暂无信息！</DIV>"
PageCount1=1
Totalnumber=0
Else

Maxperpage=9
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
plist_bottom=plist_bottom&"<a href='fashion.asp?sortid="&sortid&"&sortpath="&sortpath&"'title=""index"">"
else
plist_bottom=plist_bottom&"<a href='fashion.asp'title=""index"">"
end if
End If
plist_bottom=plist_bottom&"[ 首页 ]</a>&nbsp;"
If Cint(Pageno)>1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href=fashion.asp?page="&Pageno-1&"&sortid="&sortid&"&sortpath="&sortpath&" title=""Previous"">"
else
plist_bottom=plist_bottom&"<a href=fashion.asp?page="&Pageno-1&" title=""Previous"">"
end if
End If
plist_bottom=plist_bottom&"[ 上一页 ]</a>&nbsp;"
If Cint(Pageno)< PageCount1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href=fashion.asp?page="&Pageno+1&"&sortid="&sortid&"&sortpath="&sortpath&" title=""Next"">"
else
plist_bottom=plist_bottom&"<a href=fashion.asp?page="&Pageno+1&" title=""Next"">"
End If
End If
plist_bottom=plist_bottom&"[ 下一页 ]</a>&nbsp;"
If Cint(Pageno)< Pagecount1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href='fashion.asp?page="&PageCount1&"&sortid="&sortid&"&sortpath="&sortpath&"' title=""Last"">"
else
plist_bottom=plist_bottom&"<a href='fashion.asp?page="&PageCount1&"' title=""Last"">"
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

	 if StrLen(Removehtml(rs("NewsName")))<=26 then
        ProductName=Removehtml(rs("NewsName"))
	  else 
	     ProductName=StrLeft(Removehtml(Removehtml(rs("NewsName"))),25)
	   end if
	   
	   if StrLen(Removehtml(rs("content")))<=180 then
        content=Removehtml(rs("content"))
	  else 
	     content=StrLeft(Removehtml(Removehtml(rs("content"))),179)
	   end if
   
   'response.Write "<div class='divBoxRShowWin'><img src='"& replace(rs("BigPic"),"../","")&"'/><h5>"&NewsName&"</h5><p><a href='newsview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'>"&content&"</a></p><input type='buttton'/></div>"
   response.Write content
  
  
row_count=row_count+1
if n>=MaxPerPage then exit do
rs.movenext
loop

rs.close
'response.write plist_bottom	'写页码
end if
end Function

'fashion页展示,xiugai
function fashion_p() 

 dim rs,sql,page,sid,pid
 pid=Request.QueryString("pid")
 sid=Request.QueryString("sid")
 id=Request.QueryString("id")
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
  sql="select * from pp_News where  ViewFlag and instr(sortpath,3)>0 order by AddTime asc"
  else
  sql="select * from pp_News where  ViewFlag and instr(sortpath,"&sid&")>0 order by AddTime asc"
  end if
else
   if pid<>"" then
  sql="select * from pp_News where  ViewFlag and Instr(SortPath,"&id&")>0 order by AddTime asc"
  else
  sql="select * from pp_News where  ViewFlag and instr(sortpath,191)>0 order by AddTime asc"
  end if
  end if
   rs.open sql,conn,1,1
If rs.Eof And rs.bof Then


response.write"<Div style='margin-top:20px;text-align:center'>暂无信息！</DIV>"
PageCount1=1
Totalnumber=0
Else

Maxperpage=9
rs.Pagesize=MaxperPage
PageCount1=Rs.PageCount
rs.Move  (CurrentPage-1)*MaxperPage
Totalnumber=rs.RecordCount
N=0

plist_bottom=plist_bottom&"<table class='divProPage'><tr><td><div style='padding-left:400px;'>"
plist_bottom=plist_bottom&"[ <b>"&CurrentPage&"</b>/<b>"&PageCount1&"</b> ]&nbsp;"
Pageno=CurrentPage
If cint(Pageno)>1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href='fashion.asp?sortid="&sortid&"&sortpath="&sortpath&"'title=""index"">"
else
plist_bottom=plist_bottom&"<a href='fashion.asp'title=""index"">"
end if
End If
plist_bottom=plist_bottom&"[ 首页 ]</a>&nbsp;"
If Cint(Pageno)>1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href=fashion.asp?page="&Pageno-1&"&sortid="&sortid&"&sortpath="&sortpath&" title=""Previous"">"
else
plist_bottom=plist_bottom&"<a href=fashion.asp?page="&Pageno-1&" title=""Previous"">"
end if
End If
plist_bottom=plist_bottom&"[ 上一页 ]</a>&nbsp;"
If Cint(Pageno)< PageCount1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href=fashion.asp?page="&Pageno+1&"&sortid="&sortid&"&sortpath="&sortpath&" title=""Next"">"
else
plist_bottom=plist_bottom&"<a href=fashion.asp?page="&Pageno+1&" title=""Next"">"
End If
End If
plist_bottom=plist_bottom&"[ 下一页 ]</a>&nbsp;"
If Cint(Pageno)< Pagecount1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href='fashion.asp?page="&PageCount1&"&sortid="&sortid&"&sortpath="&sortpath&"' title=""Last"">"
else
plist_bottom=plist_bottom&"<a href='fashion.asp?page="&PageCount1&"' title=""Last"">"
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

	 if StrLen(Removehtml(rs("NewsName")))<=26 then
        NewsName=Removehtml(rs("NewsName"))
	  else 
	     NewsName=StrLeft(Removehtml(Removehtml(rs("NewsName"))),25)
	   end if
	   
	   if StrLen(Removehtml(rs("content")))<=180 then
        content=Removehtml(rs("content"))
	  else 
	     content=StrLeft(Removehtml(Removehtml(rs("content"))),179)
	   end if
   
   response.Write "<div class='divBoxRShowWin'><a href='baihuoshopview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'><img src='"& replace(rs("BigPic"),"../","")&"'/></a><h5 style='margin-top:7px;'>"&NewsName&"</h5><p><a href='baihuoshopview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'>"&content&"</a></p><a class='divBoxRShowWinMore' href='baihuoshopview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'/></a></div>"
  
  
row_count=row_count+1
if n>=MaxPerPage then exit do
rs.movenext
loop

rs.close
response.write plist_bottom
end if
end Function
'fashion页展示backup2
function fashion_p_backup2() 

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

Maxperpage=9
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
plist_bottom=plist_bottom&"<a href='fashion.asp?sortid="&sortid&"&sortpath="&sortpath&"'title=""index"">"
else
plist_bottom=plist_bottom&"<a href='fashion.asp'title=""index"">"
end if
End If
plist_bottom=plist_bottom&"[ 首页 ]</a>&nbsp;"
If Cint(Pageno)>1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href=fashion.asp?page="&Pageno-1&"&sortid="&sortid&"&sortpath="&sortpath&" title=""Previous"">"
else
plist_bottom=plist_bottom&"<a href=fashion.asp?page="&Pageno-1&" title=""Previous"">"
end if
End If
plist_bottom=plist_bottom&"[ 上一页 ]</a>&nbsp;"
If Cint(Pageno)< PageCount1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href=fashion.asp?page="&Pageno+1&"&sortid="&sortid&"&sortpath="&sortpath&" title=""Next"">"
else
plist_bottom=plist_bottom&"<a href=fashion.asp?page="&Pageno+1&" title=""Next"">"
End If
End If
plist_bottom=plist_bottom&"[ 下一页 ]</a>&nbsp;"
If Cint(Pageno)< Pagecount1 Then
if sortid<>"" then
plist_bottom=plist_bottom&"<a href='fashion.asp?page="&PageCount1&"&sortid="&sortid&"&sortpath="&sortpath&"' title=""Last"">"
else
plist_bottom=plist_bottom&"<a href='fashion.asp?page="&PageCount1&"' title=""Last"">"
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
   
   response.Write "<div class='divBoxRShowWin'><img src='"& replace(rs("smallpic"),"../","")&"'/><h5>"&ProductName&"</h5><p><a href='newsview.asp?sortid="&rs("sortid")&"&id="&rs("id")&"&sortpath="&request("sortpath")&"'>"&content&"</a></p><input type='buttton'/></div>"
  
  
row_count=row_count+1
if n>=MaxPerPage then exit do
rs.movenext
loop

rs.close
response.write plist_bottom
end if
end Function
'顺昌购物攻略类正文
function suncangbuy()
dim rs,sql
dim id
      id=Trim(request.QueryString("id"))
set rs = server.createobject("adodb.recordset")
if id<>"" then
   sql="select * from pp_News where sortid="&id 
 else
  sql="select * from pp_News where id=725" 
  end if
  rs.open sql,conn,1,3
 
  response.Write rs("content")
     rs.close 

 set rs=nothing

end Function

function suncangabout()
dim rs,sql,id
 id=Trim(Request.QueryString("id"))
set rs = server.createobject("adodb.recordset")
if id<>"" then 
 sql="select * from pp_News where id="&id 
  else
 sql="select * from pp_News where id=57 " 
  end if
  rs.open sql,conn,1,3
  if rs("content")<>"" then
  response.Write rs("content")
  else
   response.Write"Data update......"
end if
  rs.close
 set rs=nothing
end Function

'服务中心正文
function suncangserver()
dim rs,sql
dim id
      id=Trim(request.QueryString("id"))
set rs = server.createobject("adodb.recordset")
if id<>"" then
   sql="select * from pp_News where ViewFlag and sortid="&id 
 else
  sql="select * from pp_News where ViewFlag and sortid=149" 
  end if
  rs.open sql,conn,1,3
 
  response.Write rs("content")
     rs.close 

 set rs=nothing

end Function

'顺昌联系我们类正文
function suncangcontact()
dim rs,sql
dim id
      id=Trim(request.QueryString("id"))
set rs = server.createobject("adodb.recordset")
if id<>"" then
   sql="select * from pp_News where sortid="&id 
 else
  sql="select * from pp_News where id=719" 
  end if
  rs.open sql,conn,1,3
 
  response.Write rs("content")
     rs.close 

 set rs=nothing

end Function

function suncangabout()
dim rs,sql,id
 id=Trim(Request.QueryString("id"))
set rs = server.createobject("adodb.recordset")
if id<>"" then 
 sql="select * from pp_News where id="&id 
  else
 sql="select * from pp_News where id=57 " 
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

'产品页即名店名品左边栏
 function suncangproductleft()
set rs = server.createobject("adodb.recordset")
  sql="select  * from pp_productsort where parentID=0 and ViewFlag  order by id asc"
  rs.open sql,conn,1,3
  Dim getSortId
	getSortId=Trim(request.querystring("id"))
	If getSortId="" Then
		while not rs.eof
			If rs("id")=270 Then
			  response.Write "<li class='divContactSel'><a href='produce.asp?id="&rs("id")&"'><div class=''>"&rs("sortname")&"</div></a></li>"
			Else
				response.Write "<li class='divContactNor'><a href='produce.asp?id="&rs("id")&"'><div class=''>"&rs("sortname")&"</div></a></li>"
			End If
		
		rs.movenext
		Wend
	Else
		while not rs.eof
			If rs("id")=CInt(getSortId) Then
			  response.Write "<li class='divContactSel'><a href='produce.asp?id="&rs("id")&"'><div class=''>"&rs("sortname")&"</div></a></li>"
			Else
				response.Write "<li class='divContactNor'><a href='produce.asp?id="&rs("id")&"'><div class=''>"&rs("sortname")&"</div></a></li>"
			End If
		
		rs.movenext
		Wend
	End If
	  'response.Write "<li><a href='netword.asp'><div class='m_leftbox_li_bg'>联系网络</div></a></li>"
     rs.close
 set rs=nothing

end Function
'名


'新闻信息左边栏
 function suncangnewsleft()
set rs = server.createobject("adodb.recordset")
  sql="select  * from pp_NewsSort where parentID=156 and ViewFlag  order by id asc"
  rs.open sql,conn,1,3
  Dim getSortId
	getSortId=Trim(request.querystring("id"))

	If getSortId="" Then
		while not rs.eof
			If rs("id")=157 Then
			  response.Write "<li class='divContactSel'><a href='news1.asp?id="&rs("id")&"'><div class=''>"&rs("sortname")&"</div></a></li>"
			Else
				response.Write "<li class='divContactNor'><a href='news1.asp?id="&rs("id")&"'><div class=''>"&rs("sortname")&"</div></a></li>"
			End If
		
		rs.movenext
		Wend
	Else
		while not rs.eof
			If rs("id")=CInt(getSortId) Then
			  response.Write "<li class='divContactSel'><a href='news1.asp?id="&rs("id")&"'><div class=''>"&rs("sortname")&"</div></a></li>"
			Else
				response.Write "<li class='divContactNor'><a href='news1.asp?id="&rs("id")&"'><div class=''>"&rs("sortname")&"</div></a></li>"
			End If
		
		rs.movenext
		Wend
	End If
	  'response.Write "<li><a href='netword.asp'><div class='m_leftbox_li_bg'>联系网络</div></a></li>"
     rs.close
 set rs=nothing

end Function

'联系我们左边栏
 function suncangcleft()
set rs = server.createobject("adodb.recordset")
  sql="select  * from pp_NewsSort where parentID=184 and ViewFlag  order by id asc"
  rs.open sql,conn,1,3
  Dim getSortId
	getSortId=Trim(request.querystring("id"))
	If getSortId="" Then
		while not rs.eof
			If rs("id")=185 Then
			  response.Write "<li class='divContactSel'><a href='contact.asp?id="&rs("id")&"'><div class=''>"&rs("sortname")&"</div></a></li>"
			Else
				response.Write "<li class='divContactNor'><a href='contact.asp?id="&rs("id")&"'><div class=''>"&rs("sortname")&"</div></a></li>"
			End If
		
		rs.movenext
		Wend
	Else
		while not rs.eof
			If rs("id")=CInt(getSortId) Then
			  response.Write "<li class='divContactSel'><a href='contact.asp?id="&rs("id")&"'><div class=''>"&rs("sortname")&"</div></a></li>"
			Else
				response.Write "<li class='divContactNor'><a href='contact.asp?id="&rs("id")&"'><div class=''>"&rs("sortname")&"</div></a></li>"
			End If
		
		rs.movenext
		Wend
	End If
	  'response.Write "<li><a href='netword.asp'><div class='m_leftbox_li_bg'>联系网络</div></a></li>"
     rs.close
 set rs=nothing

end Function
'时尚荟萃左边栏
 function suncangfashioncleft()
set rs = server.createobject("adodb.recordset")
  sql="select  * from pp_NewsSort where parentID=190 and ViewFlag  order by id asc"
  rs.open sql,conn,1,3
  Dim getSortId
	getSortId=Trim(request.querystring("id"))
	If getSortId="" Then
		while not rs.eof
			If rs("id")=191 Then
			  response.Write "<li class='divContactSel'><a href='fashion.asp?id="&rs("id")&"'><div class=''>"&rs("sortname")&"</div></a></li>"
			Else
				response.Write "<li class='divContactNor'><a href='fashion.asp?id="&rs("id")&"&pid=192'><div class=''>"&rs("sortname")&"</div></a></li>"
			End If
		
		rs.movenext
		Wend
	Else
		while not rs.eof
			If rs("id")=192 Then
				If rs("id")=CInt(getSortId) Then
				  response.Write "<li class='divContactSel'><a href='fashion.asp?id="&rs("id")&"&pid=192'><div class=''>"&rs("sortname")&"</div></a></li>"
				Else
					response.Write "<li class='divContactNor'><a href='fashion.asp?id="&rs("id")&"&pid=192'><div class=''>"&rs("sortname")&"</div></a></li>"
				End If
			Else
				If rs("id")=CInt(getSortId) Then
				  response.Write "<li class='divContactSel'><a href='fashion.asp?id="&rs("id")&"'><div class=''>"&rs("sortname")&"</div></a></li>"
				Else
					response.Write "<li class='divContactNor'><a href='fashion.asp?id="&rs("id")&"'><div class=''>"&rs("sortname")&"</div></a></li>"
				End If
			End If
		
		rs.movenext
		Wend
	End If
	  'response.Write "<li><a href='netword.asp'><div class='m_leftbox_li_bg'>联系网络</div></a></li>"
     rs.close
 set rs=nothing


end Function
'不知哪里调用了的左边栏
 function suncangcaseleft()
set rs = server.createobject("adodb.recordset")
  sql="select  * from pp_cgalsort where parentID=3 and ViewFlag  order by id asc"
  rs.open sql,conn,1,3
  Dim getSortId
	getSortId=Trim(request.querystring("id"))
	If getSortId="" Then
		while not rs.eof
			If rs("id")=36 Then
			  response.Write "<li class='divContactSel'><a href='shop.asp?id="&rs("id")&"'><div class=''>"&rs("sortname")&"</div></a></li>"
			Else
				response.Write "<li class='divContactNor'><a href='shop.asp?id="&rs("id")&"'><div class=''>"&rs("sortname")&"</div></a></li>"
			End If
		
		rs.movenext
		Wend
	Else
		while not rs.eof
			If rs("id")=CInt(getSortId) Then
			  response.Write "<li class='divContactSel'><a href='shop.asp?id="&rs("id")&"'><div class=''>"&rs("sortname")&"</div></a></li>"
			Else
				response.Write "<li class='divContactNor'><a href='shop.asp?id="&rs("id")&"'><div class=''>"&rs("sortname")&"</div></a></li>"
			End If
		
		rs.movenext
		Wend
	End If
	  'response.Write "<li><a href='netword.asp'><div class='m_leftbox_li_bg'>联系网络</div></a></li>"
     rs.close
 set rs=nothing

end Function
'连锁门店左边栏
 function suncangcgalleft()
set rs = server.createobject("adodb.recordset")
  sql="select  * from pp_cgalsort where parentID=3 and ViewFlag  order by id asc"
  rs.open sql,conn,1,3
  Dim getSortId,sid,pid
	getSortId=Trim(request.querystring("id"))
	sid=request.querystring("sid")
	saveSid=CInt(sid)
	pid=request.querystring("pid")
	savePid=CInt(pid)
	If getSortId="" Then
		getSortId=36
	End If

		while not rs.eof
			If rs("id")=savePid Then
				response.Write "<li class='divContactSel'><a href='shop.asp?pid="&rs("id")&"'><div class=''>"&rs("sortname")&"</div></a></li>"
			Else
				response.Write "<li class='divContactBigNor'><a href='shop.asp?pid="&rs("id")&"'><div class=''>"&rs("sortname")&"</div></a></li>"
			End If
				set rsSearchSmall = server.createobject("adodb.recordset")
				  sql="select  * from pp_cgalsort where parentID="&rs("id")&" and ViewFlag  order by id asc"
				  rsSearchSmall.open sql,conn,1,3
				  If rsSearchSmall.eof Then
				  Else
					Do While Not rsSearchSmall.eof
						If rsSearchSmall("id")=saveSid Then
							response.Write "<li class='divContactSel'><a href='shop.asp?sid="&rsSearchSmall("id")&"'><div>"&rsSearchSmall("sortname")&"</div></a></li>"
						Else
							response.Write "<li class='divContactSmallNor'><a href='shop.asp?sid="&rsSearchSmall("id")&"'><div>"&rsSearchSmall("sortname")&"</div></a></li>"
						End If
						rsSearchSmall.movenext
					Loop
					rsSearchSmall.close
				  End If
			'If rs("id")=CInt(getSortId) Then
			'  response.Write "<li class='divContactSel'><a href='shop.asp?id="&rs("id")&"'><div class=''>"&rs("sortname")&"</div></a></li>"
			'Else
		'		response.Write "<li class='divContactNor'><a href='shop.asp?id="&rs("id")&"'><div class=''>"&rs("sortname")&"</div></a></li>"
			'End If
		
		rs.movenext
		Wend

	  'response.Write "<li><a href='netword.asp'><div class='m_leftbox_li_bg'>联系网络</div></a></li>"
     rs.close
 set rs=nothing

end Function

'购物攻略左边栏
 function suncangbuyleft()
set rs = server.createobject("adodb.recordset")
  sql="select  * from pp_NewsSort where parentID=193 and ViewFlag  order by id asc"
  rs.open sql,conn,1,3
  Dim getSortId
	getSortId=Trim(request.querystring("id"))
	If getSortId="" Then
		while not rs.eof
			If rs("id")=194 Then
			  response.Write "<li class='divContactSel'><a href='buy.asp?id="&rs("id")&"'><div class=''>"&rs("sortname")&"</div></a></li>"
			Else
				response.Write "<li class='divContactNor'><a href='buy.asp?id="&rs("id")&"&sid="&rs("id")&"'><div class=''>"&rs("sortname")&"</div></a></li>"
			End If
		
		rs.movenext
		Wend
	Else
		while not rs.eof
			If rs("id")=197 Or rs("id")=199 Or rs("id")=207 Then
				If rs("id")=CInt(getSortId) Then
				  response.Write "<li class='divContactSel'><a href='buy.asp?id="&rs("id")&"&sid="&rs("id")&"'><div class=''>"&rs("sortname")&"</div></a></li>"
				Else
					response.Write "<li class='divContactNor'><a href='buy.asp?id="&rs("id")&"&sid="&rs("id")&"'><div class=''>"&rs("sortname")&"</div></a></li>"
				End If
			Else
				If rs("id")=CInt(getSortId) Then
				  response.Write "<li class='divContactSel'><a href='buy.asp?id="&rs("id")&"'><div class=''>"&rs("sortname")&"</div></a></li>"
				Else
					response.Write "<li class='divContactNor'><a href='buy.asp?id="&rs("id")&"'><div class=''>"&rs("sortname")&"</div></a></li>"
				End If
			End If
		
		rs.movenext
		Wend
	End If
	  'response.Write "<li><a href='netword.asp'><div class='m_leftbox_li_bg'>联系网络</div></a></li>"
     rs.close
 set rs=nothing

end Function
'服务中心左边栏
 function suncangserverleft()
set rs = server.createobject("adodb.recordset")
  sql="select  * from pp_NewsSort where parentID=137 and ViewFlag  order by id asc"
  rs.open sql,conn,1,3
  Dim getSortId
	getSortId=Trim(request.querystring("id"))
	If getSortId="" Then
		while not rs.eof
			If rs("id")=149 Then
			  response.Write "<li class='divContactSel'><a href='server.asp?id="&rs("id")&"'><div class=''>"&rs("sortname")&"</div></a></li>"
			Else
				response.Write "<li class='divContactNor'><a href='server.asp?id="&rs("id")&"'><div class=''>"&rs("sortname")&"</div></a></li>"
			End If
		
		rs.movenext
		Wend
	Else
		while not rs.eof
			If rs("id")=CInt(getSortId) Then
			  response.Write "<li class='divContactSel'><a href='server.asp?id="&rs("id")&"'><div class=''>"&rs("sortname")&"</div></a></li>"
			Else
				response.Write "<li class='divContactNor'><a href='server.asp?id="&rs("id")&"'><div class=''>"&rs("sortname")&"</div></a></li>"
			End If
		
		rs.movenext
		Wend
	End If
	  'response.Write "<li><a href='netword.asp'><div class='m_leftbox_li_bg'>联系网络</div></a></li>"
     rs.close
 set rs=nothing

end Function
'关于我们生成左边栏
 function suncangaboutleft()
set rs = server.createobject("adodb.recordset")
  sql="select  * from pp_About where ViewFlag  order by id asc"
  rs.open sql,conn,1,3
  Dim getSortId
	getSortId=Trim(request.querystring("id"))
	If getSortId="" Then
		while not rs.eof
			If rs("id")=56 Then
				If rs("id")=53 Then	'判断是否当前选择
					response.Write "<li class='divContactSel'><a href='about.asp?id="&rs("id")&"&pid=201'><div class=''>"&rs("AboutName")&"</div></a></li>"
				 ' response.Write "<li class='divContactSel'><a href='about.asp?id=56&pid=201'><div class=''>"&rs("AboutName")&"</div></a></li>"
				Else
					response.Write "<li class='divContactNor'><a href='about.asp?id="&rs("id")&"&pid=201'><div class=''>"&rs("AboutName")&"</div></a></li>"
					'response.Write "<li class='divContactNor'><a href='about.asp?id=56&pid=201'><div class=''>"&rs("AboutName")&"</div></a></li>"
				End If
			'  response.Write "<li class='divContactNor'><a href='about.asp?id="&rs("id")&"&pid=201'><div class=''>"&rs("AboutName")&"</div></a></li>"
			Else
				If rs("id")=53 Then	'判断是否当前选择
					response.Write "<li class='divContactSel'><a href='about.asp?id="&rs("id")&"'><div class=''>"&rs("AboutName")&"</div></a></li>"
				 ' response.Write "<li class='divContactSel'><a href='about.asp?id=56&pid=201'><div class=''>"&rs("AboutName")&"</div></a></li>"
				Else
					response.Write "<li class='divContactNor'><a href='about.asp?id="&rs("id")&"'><div class=''>"&rs("AboutName")&"</div></a></li>"
					'response.Write "<li class='divContactNor'><a href='about.asp?id=56&pid=201'><div class=''>"&rs("AboutName")&"</div></a></li>"
				End If
				'response.Write "<li class='divContactNor'><a href='about.asp?id="&rs("id")&"'><div class=''>"&rs("AboutName")&"</div></a></li>"
			End If
		
		rs.movenext
		Wend
	Else
		while not rs.eof
			If rs("id")=56 Then
				If rs("id")=CInt(getSortId) Then	'判断是否当前选择
				  response.Write "<li class='divContactSel'><a href='about.asp?id=56&pid=201'><div class=''>"&rs("AboutName")&"</div></a></li>"
				Else
					response.Write "<li class='divContactNor'><a href='about.asp?id=56&pid=201'><div class=''>"&rs("AboutName")&"</div></a></li>"
				End If
			Else
				If rs("id")=CInt(getSortId) Then
				  response.Write "<li class='divContactSel'><a href='about.asp?id="&rs("id")&"'><div class=''>"&rs("AboutName")&"</div></a></li>"
				Else
					response.Write "<li class='divContactNor'><a href='about.asp?id="&rs("id")&"'><div class=''>"&rs("AboutName")&"</div></a></li>"
				End If
			End If

		
		rs.movenext
		Wend
	End If
	  'response.Write "<li><a href='netword.asp'><div class='m_leftbox_li_bg'>联系网络</div></a></li>"
     rs.close
 set rs=nothing

end Function
'baihuoshopview生成当前位置

function suncangpdanqian()
dim rs,sql,sid,sortid
sid=Trim(Request.QueryString("sortid"))
set rs = server.createobject("adodb.recordset")

 if sid<>"" then 
 sql="select * from pp_NewsSort where id="&sid
   rs.open sql,conn,1,1
  
  response.Write rs("sortname")

 else

  response.Write "所有产品"
 end if

     rs.close
 set rs=nothing

end function
'新闻1页生成当前位置
function suncangnewsdanqian()
dim rs,sql,sid
sid=Trim(Request.QueryString("id"))
set rs = server.createobject("adodb.recordset")

 if sid<>"" then 
 sql="select * from pp_NewsSort where ID="&sid
   rs.open sql,conn,1,1
  
  response.Write rs("sortname")

 else

  response.Write "新闻中心"
 end if

     rs.close
 set rs=nothing

end Function
'详细新闻页生成当前位置
function suncangnewsdanqian()
dim rs,sql,sid
sid=Trim(Request.QueryString("SortID"))
set rs = server.createobject("adodb.recordset")

 if sid<>"" then 
 sql="select * from pp_NewsSort where ID="&sid
   rs.open sql,conn,1,1
  
  response.Write rs("sortname")

 else

  response.Write "新闻中心"
 end if

     rs.close
 set rs=nothing

end function
'服务中心生成当前位置
function fashionserverdanqian()
dim rs,sql,SortPath
SortPath=Trim(Request.QueryString("id"))
set rs = server.createobject("adodb.recordset")
 if SortPath<>"" then 
 sql="select * from pp_NewsSort where  id="&SortPath 

  rs.open sql,conn,1,3
 
  response.Write rs("sortname")
     rs.close 
 else
 response.Write "服务中心"
  end if
 set rs=nothing
end Function
'关于我们生成当前位置
'function aboutdanqian()
'dim rs,sql,id
' id=Trim(Request.QueryString("id"))
'set rs = server.createobject("adodb.recordset")
' if id<>"" then 
' sql="select * from pp_About where id="&id 
'  else
' sql="select * from pp_About where id=53 " 
'  end if
 ' rs.open sql,conn,1,3
  
'   while not rs.eof
'  response.Write rs("aboutname")
 ' rs.movenext
 ' wend
 '    rs.close
 'set rs=nothing

'end Function
'生成当前位置，带参数
Function getdangqian(defaultId)
	dim rs,sql,SortPath
	
	SortPath=Trim(Request.QueryString("id"))
	set rs = server.createobject("adodb.recordset")
	 if SortPath<>"" then 
	 sql="select * from pp_NewsSort where  id="&SortPath 

	  rs.open sql,conn,1,3
	 
	  response.Write rs("sortname")
		 rs.close 
	 else
		 sql="select * from pp_NewsSort where  id="&defaultId

	  rs.open sql,conn,1,3
	 
	  response.Write rs("sortname")
		rs.close 
	  end if
	 set rs=nothing
End Function
'名店名品生成当前位置
function prodanqian()
dim rs,sql,SortPath
SortPath=Trim(Request.QueryString("id"))
set rs = server.createobject("adodb.recordset")
 if SortPath<>"" then 
 sql="select * from pp_ProductSort where  id="&SortPath 

  rs.open sql,conn,1,3
 
  response.Write rs("sortname")
     rs.close 
 else
 response.Write "名店名品"
  end if
 set rs=nothing
end function
'连锁门店生成当前位置
function suncangshopdanqian()
dim rs,sql,SortPath
SortPath=Trim(Request.QueryString("id"))
set rs = server.createobject("adodb.recordset")
 if SortPath<>"" then 
 sql="select * from pp_NewsSort where  id="&SortPath 

  rs.open sql,conn,1,3
 
  response.Write rs("sortname")
     rs.close 
 else
 response.Write "连锁门店"
  end if
 set rs=nothing
end function
'购物攻略生成当前位置
function suncangbuydanqian()
dim rs,sql,SortPath
SortPath=Trim(Request.QueryString("id"))
set rs = server.createobject("adodb.recordset")
 if SortPath<>"" then 
 sql="select * from pp_NewsSort where  id="&SortPath 

  rs.open sql,conn,1,3
 
  response.Write rs("sortname")
     rs.close 
 else
 response.Write "购物攻略"
  end if
 set rs=nothing
end function
'时尚荟萃生成当前位置
function suncangfashiondanqian()
dim rs,sql,SortPath
SortPath=Trim(Request.QueryString("id"))
set rs = server.createobject("adodb.recordset")
 if SortPath<>"" then 
 sql="select * from pp_NewsSort where  id="&SortPath 

  rs.open sql,conn,1,3
 
  response.Write rs("sortname")
     rs.close 
 else
 response.Write "时尚荟萃"
  end if
 set rs=nothing
end function
%>

