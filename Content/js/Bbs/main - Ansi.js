//������ҳ
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

//����С��
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
//������ǩ
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

//�����������ֳ��Ⱥ���
function shortText(){
	changeCharToolong("divBbsTextId",14);
	changeCharToolong("divNewsTopTextid",45);
}
//���Ƴ��Ⱥ���
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

//�û���ͷ�����ʺ�
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

//ע����֤
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
		sVal(outBox,"�û������Ȳ��ܴ���"+max+"��С��"+min);
	}else{
		sVal(outBox,"������ȷ");
	}
}
function checkSame(firstBox,outBox){
	var a2=gVal("userpass");
	var b2=gVal("ouserpass");
	if(a2!=b2){
		sVal("box_ouserpass","�����������벻һ��");
	}else{
		sVal("box_ouserpass","������ȷ");
	}
}
function checkEmail(firstBox,outBox){
	var a3=gVal(firstBox);
	if(a3.indexOf("@")==-1||(a3.indexOf(".com")==-1&&a3.indexOf(".cn")==-1)){
		sVal(outBox,"Email��ʽ����ȷ");
	}else{
		sVal(outBox,"������ȷ");
	}
}
function checkSubmit(){
	var a4=document.getElementById("agreement").checked;
	var b4=gInnerhtml("box_username")&&gInnerhtml("box_userpass")=="������ȷ"&&gInnerhtml("box_ouserpass")=="������ȷ";

	if(a4==false){
		alert("δ����ע��Э��");
		return false;
	}else if((gInnerhtml("box_username")=="������ȷ"&&gInnerhtml("box_userpass")=="������ȷ"&&gInnerhtml("box_ouserpass")=="������ȷ"&&gInnerhtml("box_question")=="������ȷ"&&gInnerhtml("box_answer")=="������ȷ"&&gInnerhtml("box_email")=="������ȷ")!=true){
		alert("����δ��������");
		return false;
	}
}

//��������input text���� �ƿ�����value
function clearInputText(nameObj){
	nameObj.value="";
}
function fixInputValue(nameObj,objValue){
	if(nameObj.value==""){
		nameObj.value=objValue;
	}
}