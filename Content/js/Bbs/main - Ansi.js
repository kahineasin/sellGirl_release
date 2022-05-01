//返回首页
function goToDefaultPage(){
	location.href="../default.asp";
}

function userButtonChange(nameObj){
	//alert("1");
	nameObj.style.border="2px "+"solid";
	nameObj.style.borderColor="#7bc509";
	nameObj.style.width="73px";
	nameObj.style.height="28px";
	//var buttonC=
}
function userButtonChangeBack(nameObj){
	nameObj.style.border="1px "+"solid";
	nameObj.style.borderColor="b0b0b0";
	nameObj.style.width="75px";
	nameObj.style.height="30px";
}

//热门小区
function changeHothouse(nameObj,num){
	//alert("2");
	//var nameSpan=document.getElementById("divHothouseNoId").getElementsByTagName("span");
	//var nameP=document.getElementById("divHothouseNoId").getElementsByTagName("p");
	//var nameEm = document.getElementById("divHothouseNoId").getElementsByTagName("em");
    var nameSpan = $("#divHothouseNoId").find("span");
    var nameP = $("#divHothouseNoId").find("p");
    var nameEm = $("#divHothouseNoId").find("em");
	//alert(nameSpan);
	var b=nameSpan.length;
	for(i=0;i<nameSpan.length;i++){
		if(i==num){
			nameSpan[i].className="divHothouseNoActive";
			nameP[i].className="divHothouseNoActiveP";
			nameEm[i].className="divHothouseNoVisible";
		}else{
			nameSpan[i].className="normal";
			nameP[i].className="normal";
			nameEm[i].className="divHothouseNoHidden";
		}
	}
}
//搜索标签
function searchButtonTab(nameObj,num){
	var nameP=document.getElementById("divSearchTopId").getElementsByTagName("p");
	//alert("nameP");
	for(i=0;i<nameP.length;i++){
		if(i==num){
			nameP[i].className="divSearchTopActive";
		}else{
			nameP[i].className="divSearchTopNormal";
		}
	}
}

//调用限制文字长度函数
function shortText(){
	changeCharToolong("divBbsTextId",14);
	changeCharToolong("divNewsTopTextid",45);
}
//限制长度函数
function changeCharToolong(divId,shortNum){
    //var strSpan = document.getElementById(divId).getElementsByTagName("span");
    //var strSpan = document.getElementById(divId).$("span");
    var strSpan = $('#'+divId).find("span");
	var valueSpan=new Array();
	var valueSpanShort=new Array();
	for(i=0;i<strSpan.length;i++){
		valueSpan[i]=strSpan[i].innerHTML;
		
		if(valueSpan[i].length>(shortNum+1)){
			valueSpanShort=valueSpan[i].slice(0,shortNum);
			strSpan[i].innerHTML=valueSpanShort+"...";
		}
	}
}

//用户无头像用问号
function checkUserface(){
    //var strFace = document.getElementById("divNewjoinImgId").getElementsByTagName("img");
    var strFace = $("#divNewjoinImgId").find("img");
	var srcFace=new Array();
	for(i=0;i<strFace.length;i++){
		srcFace[i]=strFace[i].src;
		if(srcFace[i].indexOf("jpg")==-1&&srcFace[i].indexOf("png")==-1){
			strFace[i].src="/content/images/bbs/indeximg/face_0.png";
		}
	}
	
}

//注册验证
function gVal(a){
	return document.getElementById(a).value;
}
function gInnerhtml(a5){
	return document.getElementById(a5).innerHTML;
}
function sVal(b,c){
	document.getElementById(b).innerHTML=c;
}
function checkLong(min,max,inBox,outBox){
	var b1=gVal(inBox);
	if(b1.length<min||b1.length>max){
		sVal(outBox,"用户名长度不能大于"+max+"或小于"+min);
	}else{
		sVal(outBox,"输入正确");
	}
}
function checkSame(firstBox,outBox){
	var a2=gVal("userpass");
	var b2=gVal("ouserpass");
	if(a2!=b2){
		sVal("box_ouserpass","两次输入密码不一致");
	}else{
		sVal("box_ouserpass","输入正确");
	}
}
function checkEmail(firstBox,outBox){
	var a3=gVal(firstBox);
	if(a3.indexOf("@")==-1||(a3.indexOf(".com")==-1&&a3.indexOf(".cn")==-1)){
		sVal(outBox,"Email格式不正确");
	}else{
		sVal(outBox,"输入正确");
	}
}
function checkSubmit(){
	var a4=document.getElementById("agreement").checked;
	var b4=gInnerhtml("box_username")&&gInnerhtml("box_userpass")=="输入正确"&&gInnerhtml("box_ouserpass")=="输入正确";

	if(a4==false){
		alert("未接受注册协议");
		return false;
	}else if((gInnerhtml("box_username")=="输入正确"&&gInnerhtml("box_userpass")=="输入正确"&&gInnerhtml("box_ouserpass")=="输入正确"&&gInnerhtml("box_question")=="输入正确"&&gInnerhtml("box_answer")=="输入正确"&&gInnerhtml("box_email")=="输入正确")!=true){
		alert("资料未输入完整");
		return false;
	}
}

//鼠标点击清空input text内容 移开重填value
function clearInputText(nameObj){
	nameObj.value="";
}
function fixInputValue(nameObj,objValue){
	if(nameObj.value==""){
		nameObj.value=objValue;
	}
}