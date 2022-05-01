<!--#include file="lockipfun.asp"-->
<%
dim un_ip,rs_ip
un_ip=0

stop_ip= Request.ServerVariables("HTTP_X_FORWARDED_FOR") 
If stop_ip="" Then  stop_ip= Request.ServerVariables("REMOTE_ADDR")
call fiship(stop_ip)

if un_ip=0 then

    set rs_ip=conn.execute("select viw From pp_stopip where viw<>0 and ("&fishcip(stop_ip)&" between oneip and endip)",0,1)
	if not rs_ip.eof then

	        if rs_ip("viw")=1 then Response.write"对不起,您的IP已被锁定.如有疑问,请联系我们!<br>"
			response.Write("你当前的IP地址为："&stop_ip)

              rs_ip.close
	      set rs_ip=nothing
	Response.end
	end if

end if
%>