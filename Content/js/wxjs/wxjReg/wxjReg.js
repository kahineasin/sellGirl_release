//Ajax Start
function Ajax_GetXMLHttpRequest() {
	if (window.ActiveXObject) {
		return new ActiveXObject("Microsoft.XMLHTTP");
	} 
	else if (window.XMLHttpRequest) {
		return new XMLHttpRequest();
	}
}
function Ajax_CallBack(FormName,ID,URL){
	var x = Ajax_GetXMLHttpRequest();
	var ID = document.getElementById(ID);
	x.open("POST",URL);
	x.setRequestHeader("REFERER", location.href);
	x.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	x.onreadystatechange = function(){if(x.readyState == 4 && x.status == 200 && ID){ID.innerHTML=x.responseText;}}
	var encodedData=""
	if (document.forms.length > 0 && FormName) {
		var form = document.forms[FormName];
		for (var i = 0; i < form.length; ++i) {
			var element = form.elements[i];
			if (element.name) {
				var elementValue = null;
				if (element.nodeName == "INPUT") {
					var inputType = element.getAttribute("TYPE").toUpperCase();
					if (inputType == "TEXT" || inputType == "PASSWORD" || inputType == "HIDDEN") {
						elementValue = escape(element.value);
					} else if (inputType == "CHECKBOX" || inputType == "RADIO") {
						if (element.checked) {
							elementValue = escape(element.value);
						}
					}
				} else if (element.nodeName == "SELECT" || element.nodeName == "TEXTAREA") {
					elementValue = escape(element.value);
				}
				if (elementValue) {
					if(encodedData==""){
						encodedData = element.name + "=" + encodeURIComponent(elementValue);
					}
					else{
						encodedData += "&" + element.name + "=" + encodeURIComponent(elementValue);
					}
				}
			}
		}

	}
	x.send(encodedData);
}
//Ajax End




function ShowCheckResult(ObjectID, Message, ImageName) {
	obj = document.getElementById(ObjectID);
	obj.style.display = '';
	obj.innerHTML = '<img src="wxjs/wxjReg/images/check_'+ImageName+'.gif" align="absmiddle" />&nbsp;' + Message;
}

function CheckUserName(UserName) {
	if(UserName.length > 10 || UserName.length < 5) {
		ShowCheckResult("CheckUserName","您输入的用户名长度应该在5--10字节范围内","error");
		document.form.submit.disabled=true; //不能提交
		return;
	}
	else
	{
		ShowCheckResult("CheckUserName", "","right");
		document.form.submit.disabled=false; //能提交
		}
	Ajax_CallBack(false,"CheckUserName","check.asp?UserName=" + escape(UserName));
}

function CheckUserPass(UserPass) {
	if (UserPass.length < 6){
		ShowCheckResult("CheckUserPass", "密码必须至少包含 6 个字符","error");
		document.form.submit.disabled=true; //不能提交
		return;
	}

	ShowCheckResult("CheckUserPass", "","right");

}

function CheckUserPass2(UserPass2) {
	if (UserPass2 != document.form.password.value){
		ShowCheckResult("CheckUserPass2", "您 2 次输入的密码不相同","error");
		document.form.submit.disabled=true; //不能提交
		return;
	}
		else
	{
		document.form.submit.disabled=false; //能提交
		}
	if (UserPass2 != ''){
		ShowCheckResult("CheckUserPass2", "","right");
	}
}

function CheckMail(Mail) {
	if(Mail.indexOf("@") == -1 || Mail.indexOf(".") == -1) {
		ShowCheckResult("CheckMail", "您没有输入Email或输入有误","error");
		document.form.submit.disabled=true; //不能提交
		return;
	}
		else
	{   ShowCheckResult("CheckMail", "","right");
		document.form.submit.disabled=false; //能提交
		}
	Ajax_CallBack(false,"CheckMail","check.asp?Mail=" + Mail);
}

function CheckVerifyCode(VerifyCode) {
	var patrn=/^\d+$/;		//纯数字
	if(!patrn.exec(VerifyCode)) {
		ShowCheckResult("CheckVerifyCode", "您没有输入验证码或输入有误。","error");
		document.form.submit.disabled=true; //不能提交
		return;
	}

	Ajax_CallBack(false,"CheckVerifyCode","check.asp?VerifyCode=" + VerifyCode);

}




function isctype(character){
 if (character>=48 && character<=57) //数字
  return 1;
 if (character>=65 && character<=90) //大写字母
  return 2;
 if (character>=97 && character<=122) //小写
  return 4;
 else
  return 8; //特殊字符
}

function bitTotal(num){
 modes=0;
 for (i=0;i<4;i++){
  if (num & 1) modes++;
  num>>>=1;
 }
 return modes;
}

function checkStrong(sPW){
 Modes=0;
 for (i=0;i<sPW.length;i++){
  Modes|=isctype(sPW.charCodeAt(i));
 }
 return bitTotal(Modes);
}

function EvalPwd(pwd){
 O_color="#F1F1F1";
 L_color="#3BB878";
 M_color="#3BB878";
 H_color="#3BB878";
 if (pwd.length<6){
  Lcolor=Mcolor=Hcolor=O_color;
 }
 else{
  S_level=checkStrong(pwd);
  switch(S_level)  {
   case 0:
    Lcolor=Mcolor=Hcolor=O_color;
   case 1:
    Lcolor=L_color;
    Mcolor=Hcolor=O_color;
    break;
   case 2:
    Lcolor=Mcolor=M_color;
    Hcolor=O_color;
    break;
   default:
    Lcolor=Mcolor=Hcolor=H_color;
    }
  }
 document.getElementById("iWeak").style.background=Lcolor;
 document.getElementById("iMedium").style.background=Mcolor;
 document.getElementById("iStrong").style.background=Hcolor;
 return;
}

function nosubmit() {
	document.form.submit.disabled=true;
  }