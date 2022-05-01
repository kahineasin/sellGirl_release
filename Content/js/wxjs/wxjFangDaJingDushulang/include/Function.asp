<%

function advs(adid)
  dim rs,sql,i,ProductName,NewFlag
  set rs = server.createobject("adodb.recordset")
  sql="select * from pp_ADs where  ViewFlag  and id="&adid&" order by id desc"
  rs.open sql,conn,1,1
  if rs.bof and rs.eof then
    response.write "<div  align=center>暂无广告信息</div>"
  else
  if rs("fiewFlag")=0 then
  response.write"<div  align=center><a href='"&rs("Adurl")&"'><img src='"&rs("BigPic")&"' width='"&rs("ADsWidth")&"' height='"&rs("ADsHeight")&"' border='0' ></a></div>"
  else 
  response.write"<div  align=center><object classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000' codebase='http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0' width='"&rs("ADsWidth")&"' height='"&rs("ADsHeight")&"'>"
  response.write"<param name='movie' value='"&rs("BigPic")&"'>"
  response.write"<param name='quality' value='high'>"
  response.write"<param name='wmode' value='transparent' />"
  response.write"<embed src='"&rs("BigPic")&"' quality='high' pluginspage='http://www.macromedia.com/go/getflashplayer' type='application/x-shockwave-flash' width='"&rs("ADsWidth")&"' height='"&rs("ADsHeight")&"'></embed>"
  response.write"</object></div>"
  end if
  end if
  rs.close
  set rs=nothing
end function
function replaceText(str)
	dim regEx
	set regEx=New RegExp
	regEx.Pattern="<[^>]*>"
	regEx.Ignorecase=True
	regEx.Global=True
	replaceText=regEx.Replace(str,"")
End function
function cutstr(str,strlen)
if str<>"" then
	If len(replaceText(str))>strlen Then
		str=replace(str,"<P>","@p@")
		str=replace(str,"</P>","@1p@")
		str=replace(str,"<BR>","@BR@")
		str=left(replaceText(str),strlen)&"…"
		str=replace(str,"@p@","<p>")
		str=replace(str,"@1p@","</p>")
		str=replace(str,"@BR@","<br>")
	End If
end if
	cutstr=str
End function
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

function StrReplace(Str)'表单存入替换字符
  if Str="" or isnull(Str) then 
    StrReplace=""
    exit function 
  else
    StrReplace=replace(str," ","&nbsp;") '"&nbsp;"
    StrReplace=replace(StrReplace,chr(13),"&lt;br&gt;")'"<br>"
    StrReplace=replace(StrReplace,"<","&lt;")' "&lt;"
    StrReplace=replace(StrReplace,">","&gt;")' "&gt;"
  end if
end function

function ReStrReplace(Str)'写入表单替换字符
  if Str="" or isnull(Str) then 
    ReStrReplace=""
    exit function 
  else
    ReStrReplace=replace(Str,"&nbsp;"," ") '"&nbsp;"
    ReStrReplace=replace(ReStrReplace,"<br>",chr(13))'"<br>"
    ReStrReplace=replace(ReStrReplace,"&lt;br&gt;",chr(13))'"<br>"
    ReStrReplace=replace(ReStrReplace,"&lt;","<")' "&lt;"
    ReStrReplace=replace(ReStrReplace,"&gt;",">")' "&gt;"
  end if
end function

function HtmlStrReplace(Str)'写入Html网页替换字符
  if Str="" or isnull(Str) then 
    HtmlStrReplace=""
    exit function 
  else
    HtmlStrReplace=replace(Str,"&lt;br&gt;","<br>")'"<br>"
  end if
end function

function ViewNoRight(GroupID,Exclusive)
  dim rs,sql,GroupLevel
  set rs = server.createobject("adodb.recordset")
  sql="select GroupLevel from pp_MemGroup where GroupID='"&GroupID&"'"
  rs.open sql,conn,1,1
  GroupLevel=rs("GroupLevel")
  rs.close
  set rs=nothing
  ViewNoRight=true
  if session("GroupLevel")="" then session("GroupLevel")=0
  select case Exclusive
    case ">="
      if not session("GroupLevel") >= GroupLevel then
	    ViewNoRight=false
	  end if
    case "="
      if not session("GroupLevel") = GroupLevel then
	    ViewNoRight=false
      end if
  end select
end function

Function GetUrl()
  GetUrl="http://"&Request.ServerVariables("SERVER_NAME")&Request.ServerVariables("URL")
  If Request.ServerVariables("QUERY_STRING")<>"" Then GetURL=GetUrl&"?"& Request.ServerVariables("QUERY_STRING")
End Function

function HtmlSmallPic(GroupID,PicPath,Exclusive)
  dim rs,sql,GroupLevel
  set rs = server.createobject("adodb.recordset")
  sql="select GroupLevel from pp_MemGroup where GroupID='"&GroupID&"'"
  rs.open sql,conn,1,1
  GroupLevel=rs("GroupLevel")
  rs.close
  set rs=nothing
  HtmlSmallPic=PicPath
  if session("GroupLevel")="" then session("GroupLevel")=0
  select case Exclusive
    case ">="
      if not session("GroupLevel") >= GroupLevel then HtmlSmallPic="../Images/NoRight.jpg"
    case "="
      if not session("GroupLevel") = GroupLevel then HtmlSmallPic="../Images/NoRight.jpg"
  end select
  if HtmlSmallPic="" or isnull(HtmlSmallPic) then HtmlSmallPic="../Images/NoPicture.jpg"
end function

function IsValidMemName(memname)
  dim i, c
  IsValidMemName = true
  if not (3<=len(memname) and len(memname)<=16) then
    IsValidMemName = false
    exit function
  end if  
  for i = 1 to Len(memname)
    c = Mid(memname, i, 1)
    if InStr("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-", c) <= 0 and not IsNumeric(c) then
      IsValidMemName = false
      exit function
    end if
  next
end function

function IsValidEmail(email)
  dim names, name, i, c
  IsValidEmail = true
  names = Split(email, "@")
  if UBound(names) <> 1 then
    IsValidEmail = false
    exit function
  end if
  for each name in names
	if Len(name) <= 0 then
	  IsValidEmail = false
      exit function
    end if
    for i = 1 to Len(name)
      c = Mid(name, i, 1)
      if InStr("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-.", c) <= 0 and not IsNumeric(c) then
        IsValidEmail = false
        exit function
      end if
	next
	if Left(name, 1) = "." or Right(name, 1) = "." then
      IsValidEmail = false
      exit function
    end if
  next
  if InStr(names(1), ".") <= 0 then
    IsValidEmail = false
    exit function
  end if
  i = Len(names(1)) - InStrRev(names(1), ".")
  if i <> 2 and i <> 3 then
    IsValidEmail = false
    exit function
  end if
  if InStr(email, "..") > 0 then
    IsValidEmail = false
  end if
end function

'================================================
'函数名：FormatDate
'作　用：格式化日期
'参　数：DateAndTime            (原日期和时间)
'       Format                 (新日期格式)
'返回值：格式化后的日期
'================================================
Function FormatDate(DateAndTime, Format)
  On Error Resume Next
  Dim yy,y, m, d, h, mi, s, strDateTime
  FormatDate = DateAndTime
  If Not IsNumeric(Format) Then Exit Function
  If Not IsDate(DateAndTime) Then Exit Function
  yy = CStr(Year(DateAndTime))
  y = Mid(CStr(Year(DateAndTime)),3)
  m = CStr(Month(DateAndTime))
  If Len(m) = 1 Then m = "0" & m
  d = CStr(Day(DateAndTime))
  If Len(d) = 1 Then d = "0" & d
  h = CStr(Hour(DateAndTime))
  If Len(h) = 1 Then h = "0" & h
  mi = CStr(Minute(DateAndTime))
  If Len(mi) = 1 Then mi = "0" & mi
  s = CStr(Second(DateAndTime))
  If Len(s) = 1 Then s = "0" & s
   
  Select Case Format
  Case "1"
    strDateTime = y & "-" & m & "-" & d & " " & h & ":" & mi & ":" & s
  Case "2"
    strDateTime = yy & m & d & h & mi & s
    '返回12位 直到秒 的时间字符串
  Case "3"
    strDateTime = yy & m & d & h & mi    
    '返回12位 直到分 的时间字符串
  Case "4"
    strDateTime = yy & "年" & m & "月" & d & "日"
  Case "5"
    strDateTime = m & "-" & d
  Case "6"
    strDateTime = m & "/" & d
  Case "7"
    strDateTime = m & "月" & d & "日"
  Case "8"
    strDateTime = y & "年" & m & "月"
  Case "9"
    strDateTime = y & "-" & m
  Case "10"
    strDateTime = y & "/" & m
  Case "11"
    strDateTime = y & "-" & m & "-" & d
  Case "12"
    strDateTime = y & "/" & m & "/" & d
  Case "13"
    strDateTime = yy & "." & m & "." & d
  Case Else
    strDateTime = DateAndTime
  End Select
  FormatDate = strDateTime
End Function

function WriteMsg(Message)
  response.write "<table width='400' border='0' align='center' cellpadding='1' cellspacing='1' bgcolor='#666666'>" &_
                 "  <tr>" &_
                 "    <td bgcolor='#FFFFFF'>" &_
                 "    <table width='100%' border='0' cellpadding='0' cellspacing='0' bgcolor='#000000'><tr>" &_
                 "      <td align='center' style='font-family:Arial;font-size:16px;color:#FFFFFF;font-weight:bold'>MESSAGE</td>" &_
                 "    </tr></table>" &_
                 "    </td>" &_
                 "  </tr>" &_
                 "  <tr>" &_
                 "    <td bgcolor='#FFFFFF' >" &_
                 "    <table width='100%' border='0' cellspacing='0' cellpadding='4'>" &_
                 "      <tr>" &_
                 "        <td bgcolor='#FFFFFF' style='font-family:Arial;font-size:12px;line-height:18px;color:#333333;'>" &_
				 Message &_
                 "        </td>" &_
                 "      </tr>" &_
                 "    </table>" &_
                 "	  </td>" &_
                 "	</tr>" &_
                 "</table>" &_
                 "<div align='center'>" &_
                 "<br>" &_
                 "<a href='javascript:history.back()' style='font-size:12px;'><font color=#666666>返 回</font></a>" &_
                 "</div>"
end function



















'****************************************************
'过程名：WriteErrMsg
'作  用：显示错误提示信息
'参  数：无
'****************************************************
sub WriteErrMsg()
	dim strErr
	strErr=strErr & "<html><head><title>错误信息_桂林在线</title><META HTTP-EQUIV='Content-Type' CONTENT='text/html; charset=utf-8' />" & vbcrlf
	strErr=strErr & "<link href='style.css' rel='stylesheet' type='text/css'></head><body>" & vbcrlf
	strErr=strErr & "<table cellpadding=2 cellspacing=2 border=0 width=400 class='border' align=center>" & vbcrlf
	strErr=strErr & "  <tr align='center'><td height='20' class='title'><strong>错误信息</strong></td></tr>" & vbcrlf
	strErr=strErr & "  <tr><td height='100' class='tdbg' valign='top'><b>产生错误的可能原因：</b><br>" & errmsg &"</td></tr>" & vbcrlf
	strErr=strErr & "  <tr align='center'><td class='title'><a href='javascript:history.go(-1)'>【返回】</a></td></tr>" & vbcrlf
	strErr=strErr & "</table>" & vbcrlf
	strErr=strErr & "</body></html>" & vbcrlf
	response.write strErr
end sub

'****************************************************
'过程名：WriteSuccessMsg
'作  用：显示成功提示信息
'参  数：无
'****************************************************
sub WriteSuccessMsg(SuccessMsg)
	dim strSuccess
	strSuccess=strSuccess & "<html><head><title>成功信息_桂林在线</title><META HTTP-EQUIV='Content-Type' CONTENT='text/html; charset=utf-8' />" & vbcrlf
	strSuccess=strSuccess & "<link href='style.css' rel='stylesheet' type='text/css'></head><body>" & vbcrlf
	strSuccess=strSuccess & "<table cellpadding=2 cellspacing=2 border=0 width=400 class='border' align=center>" & vbcrlf
	strSuccess=strSuccess & "  <tr align='center'><td height='20' class='title'><strong>恭喜你！</strong></td></tr>" & vbcrlf
	strSuccess=strSuccess & "  <tr><td height='100' class='tdbg' valign='top'><br>" & SuccessMsg &"</td></tr>" & vbcrlf
	strSuccess=strSuccess & "  <tr align='center'><td class='title'><a href='javascript:history.go(-1)'>【返回】</a></td></tr>" & vbcrlf
	strSuccess=strSuccess & "</table>" & vbcrlf
	strSuccess=strSuccess & "</body></html>" & vbcrlf
	response.write strSuccess
end sub

function getFileExtName(fileName)
    dim pos
    pos=instrrev(filename,".")
    if pos>0 then 
        getFileExtName=mid(fileName,pos+1)
    else
        getFileExtName=""
    end if
end function 


'==================================================
'过程名：MenuJS
'作  用：生成下拉菜单相关的JS代码
'参  数：无
'==================================================
sub MenuJS()
	response.write "<script type='text/javascript' language='JavaScript1.2' src='../Script/Southidcmenu.js'></script>"
end sub

dim pNum,pNum2
pNum=1
pNum2=0
'=================================================
'过程名：ShowRootClass_Menu
'作  用：显示一级栏目（下拉菜单效果）
'参  数：Language     -----语言    1-中文  2-英文   
'=================================================
sub ShowRootClass_Menu(Language)
	response.write "<script type='text/javascript' language='JavaScript1.2'>" & vbcrlf & "<!--" & vbcrlf
	response.write "stm_bm(['uueoehr',400,'','background=../images/blank.gif',0,'','',0,0,0,0,0,1,0,0]);" & vbcrlf
	response.write "stm_bp('p0',[0,4,0,0,2,2,0,0,100,'',-2,'',-2,90,0,0,'#000000','transparent','',3,0,0,'#000000']);" & vbcrlf
	response.write "stm_ai('p0i0',[0,'','','',-1,-1,0,'','_self','','','','',0,0,0,'','',0,0,0,0,1,'#f1f2ee',1,'#cccccc',1,'','',3,3,0,0,'#fffff7','#000000','#000000','#FFFFFF','','',0,0]);" & vbcrlf
	if Language=1 then
	response.write "stm_aix('p0i1','p0i0',[1,'<span class=menu_txt>网站首页</span>','','',-1,-1,0,'main.asp ','_self','main.asp','','','',0,0,0,'','',0,0,0,0,1,'#f1f2ee',1,'#cccccc',1,'','',3,3,0,0,'#fffff7','#ff0000','#ffffff','#ffffff','','']);" & vbcrlf
	else
	response.write "stm_aix('p0i1','p0i0',[1,'<span class=menu_txt>Home</SPAN>','','',-1,-1,0,'main.asp ','_self','main.asp','','','',0,0,0,'','',0,0,0,0,1,'#f1f2ee',1,'#cccccc',1,'','',3,3,0,0,'#fffff7','#ff0000','#FFFFFF','#FFFFFF','','']);" & vbcrlf 
	end if 
	response.write "stm_aix('p0i2','p0i0',[0,'|','','',-1,-1,0,'','_self','','','','',0,0,0,'','',0,0,0,0,1,'#f1f2ee',1,'#cccccc',1,'','',3,3,0,0,'#fffff7','#000000','#FFFFFF','#FFFFFF','','',0,0]);" & vbcrlf

	dim sqlRoot,rsRoot,j
	if Language=1 then
	  sqlRoot="select ClassID,ClassName,Depth,NextID,LinkUrl,Child,Readme From MenuClass"
	else
	  sqlRoot="select ClassID,ClassName,Depth,NextID,LinkUrl,Child,Readme From EnMenuClass"
	end if  
	sqlRoot= sqlRoot & " where Depth=0 and ShowOnTop=True order by RootID"
	Set rsRoot= Server.CreateObject("ADODB.Recordset")
	rsRoot.open sqlRoot,conn,1,1
	if not(rsRoot.bof and rsRoot.eof) then 
		j=3
		do while not rsRoot.eof
			if rsRoot(4)<>"" then
				response.write "stm_aix('p0i"&j&"','p0i0',[1,'<span class=menu_txt>" & rsRoot(1) & "</span>','','',-1,-1,0,'" & rsRoot(4) & "','_self','" & rsRoot(4) & "','" & rsRoot(6) & "','','',0,0,0,'','',0,0,0,0,1,'#f1f2ee',1,'#cccccc',1,'','',3,3,0,0,'#fffff7','#ff0000','#FFFFFF','#cc0000','','']);" & vbcrlf							
			end if
			if rsRoot(5)>0 then
			    if Language=1 then
				  call GetClassMenu(rsRoot(0),0,1)
				else
				  call GetClassMenu(rsRoot(0),0,2) 
				end if   
			end if
			j=j+1
			response.write "stm_aix('p0i2','p0i0',[0,'|','','',-1,-1,0,'','_self','','','','',0,0,0,'','',0,0,0,0,1,'#f1f2ee',1,'#cccccc',1,'','',3,3,0,0,'#fffff7','#000000','#FFFFFF','#FFFFFF','','',0,0]);" & vbcrlf 			
			j=j+1
			rsRoot.movenext
		loop
	end if
	rsRoot.close
	set rsRoot=nothing
	response.write "stm_em();" & vbcrlf
	response.write "//-->" & vbcrlf & "</script>" & vbcrlf	
end sub

sub GetClassMenu(ID,ShowType,Language)
	dim sqlClass,rsClass,k
	'1,4,0,4,2,3,6,7,100前4个数字控制菜单位置和大小
	if pNum=1 then
		response.write "stm_bp('p" & pNum & "',[0,4,0,4,2,3,6,7,100,'progid:DXImageTransform.Microsoft.Fade(overlap=.5,enabled=0,Duration=0.43)',-2,'',-2,67,2,3,'#999999','#EBEBEB','',3,1,1,'#aca899']);" & vbcrlf
	else
		if ShowType=0 then
			response.write "stm_bpx('p" & pNum & "','p" & pNum2 & "',[1,4,0,0,2,3,6]);" & vbcrlf
		else
			response.write "stm_bpx('p" & pNum & "','p" & pNum2 & "',[1,2,-2,-3,2,3,0]);" & vbcrlf
		end if
	end if
	
	k=0
	if Language=1 then
	 sqlClass="select ClassID,ClassName,Depth,NextID,LinkUrl,Child,Readme From MenuClass"
	else
	   sqlClass="select ClassID,ClassName,Depth,NextID,LinkUrl,Child,Readme From EnMenuClass"
	end if   
	sqlClass= sqlClass & " where ParentID=" & ID & " order by OrderID asc"
	Set rsClass= Server.CreateObject("ADODB.Recordset")
	rsClass.open sqlClass,conn,1,1
	do while not rsClass.eof
		if rsClass(4)<>"" then
			if rsClass(5)>0 then
				response.write "stm_aix('p"&pNum&"i"&k&"','p"&pNum2&"i0',[0,'<span class=menu_txt>" & rsClass(1) & "</span>','','',-1,-1,0,'" & rsClass(4) & "','_self','" & rsClass(4) & "','" & rsClass(6) & "','','',6,0,0,'images/arrow_r.gif','images/arrow_w.gif',7,7,0,0,1,'#FFFFFF',0,'#cccccc',0,'','',3,3,0,0,'#fffff7','#f52087','#f52087','#cc0000','']);" & vbcrlf
				pNum=pNum+1
				pNum2=pNum2+1
				if Language=1 then
				  call GetClassMenu(rsClass(0),1,1)
				else
				  call GetClassMenu(rsClass(0),1,2) 
				end if   
			else
				response.write "stm_aix('p"&pNum&"i"&k&"','p"&pNum2&"i0',[0,'" & rsClass(1) & "','','',-1,-1,0,'" & rsClass(4) & "','_self','" & rsClass(4) & "','" & rsClass(6) & "','','',0,0,0,'','',0,0,0,0,1,'#f1f2ee',1,'#FFFFFF',0,'','',3,3,0,0,'#fffff7','#ff0000','#000000','#cc0000','']);" & vbcrlf
			end if			
		end if
		k=k+1
		rsClass.movenext
	loop
	rsClass.close
	set rsClass=nothing
	response.write "stm_ep();" & vbcrlf	
end sub







'**************************************************
'函数名：Admin_ShowClass_Option
'作  用：用作菜单管理
'参  数：ShowType     ----显示类型
'        CurrentID    -----当前ID
'        Language     -----语言
'**************************************************

sub Admin_ShowClass_Option(ShowType,CurrentID,Language)
	if ShowType=0 then
	    response.write "<option value='0'"
		if CurrentID=0 then response.write " selected"
		response.write ">无（作为一级栏目）</option>"
	end if
	dim rsClass,sqlClass,strTemp,tmpDepth,i
	dim arrShowLine(20)
	for i=0 to ubound(arrShowLine)
		arrShowLine(i)=False
	next
	sqlClass="Select * From MenuClass order by RootID,OrderID"
	set rsClass=server.CreateObject("adodb.recordset")
	rsClass.open sqlClass,conn,1,1
	if rsClass.bof and rsClass.bof then
		response.write "<option value=''>请先添加栏目</option>"
	else
		do while not rsClass.eof
			tmpDepth=rsClass("Depth")
			if rsClass("NextID")>0 then
				arrShowLine(tmpDepth)=True
			else
				arrShowLine(tmpDepth)=False
			end if
			if ShowType=1 then
				if rsClass("LinkUrl")<>"" then
					strTemp="<option value=''"
				else
					strTemp="<option value='" & rsClass("ClassID") & "'"
				end if
				strTemp=strTemp & "style='background-color:#ff0000'"
		
			elseif ShowType=2 then
				if rsClass("LinkUrl")<>"" then
					strTemp="<option value=''"
				else
					strTemp="<option value='" & rsClass("ClassID") & "'"
				end if
			  strTemp=strTemp & "style='background-color:#ff0000'"
	
			elseif ShowType=3 then
				if rsClass("Child")>0 then
					strTemp="<option value=''"
				elseif rsClass("LinkUrl")<>"" then
					strTemp="<option value='0'"
				else
					strTemp="<option value='" & rsClass("ClassID") & "'"
				end if			
				strTemp=strTemp & "style='background-color:#ff0000'"

			elseif ShowType=4 then
				if rsClass("Child")>0 then
					strTemp="<option value=''"
				elseif rsClass("LinkUrl")<>"" then
					strTemp="<option value='0'"				
				else
					strTemp="<option value='" & rsClass("ClassID") & "'"
				end if
			else
				strTemp="<option value='" & rsClass("ClassID") & "'"
			end if		
			strTemp=strTemp & ">"			
			if tmpDepth>0 then
				for i=1 to tmpDepth
					strTemp=strTemp & "&nbsp;&nbsp;"
					if i=tmpDepth then
						if rsClass("NextID")>0 then
							strTemp=strTemp & "├&nbsp;"
						else
							strTemp=strTemp & "└&nbsp;"
						end if
					else
						if arrShowLine(i)=True then
							strTemp=strTemp & "│"
						else
							strTemp=strTemp & "&nbsp;"
						end if
					end if
				next
			end if
			if Language=1 then
			  strTemp=strTemp & rsClass("ClassNameEn")
			else
			  strTemp=strTemp & rsClass("ClassName")
			end if    
			if rsClass("LinkUrl")<>"" then
				strTemp=strTemp & "(外)"
			end if
			strTemp=strTemp & "</option>"
			response.write strTemp
			rsClass.movenext
		loop
	end if
	rsClass.close
	set rsClass=nothing
end sub
%>
