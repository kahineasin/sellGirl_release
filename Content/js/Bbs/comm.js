var userAgent = navigator.userAgent.toLowerCase();
var is_opera = userAgent.indexOf('opera') != -1 && opera.version();
var is_moz = (navigator.product == 'Gecko') && userAgent.substr(userAgent.indexOf('firefox') + 8, 3);
var is_ie = (userAgent.indexOf('msie') != -1 && !is_opera) && userAgent.substr(userAgent.indexOf('msie') + 5, 3);

function isUndefined(variable) {
	return typeof variable == 'undefined' ? true : false;
}
function findtags(parentobj, tag) {
	if(!isUndefined(parentobj.getElementsByTagName)) {
		return parentobj.getElementsByTagName(tag);
	} else if(parentobj.all && parentobj.all.tags) {
		return parentobj.all.tags(tag);
	} else {
		return null;
	}
}
function in_array(needle, haystack) {
	if(typeof needle == 'string' || typeof needle == 'number') {
		for(var i in haystack) {
			if(haystack[i] == needle) {
					return true;
			}
		}
	}
	return false;
}


function setcookie(cookieName, cookieValue, seconds, path, domain, secure) {
	var expires = new Date();
	expires.setTime(expires.getTime() + seconds);
	document.cookie = escape(cookieName) + '=' + escape(cookieValue)
		+ (expires ? '; expires=' + expires.toLocaleString() : '')
		+ (path ? '; path=' + path : '/')
		+ (domain ? '; domain=' + domain : '')
		+ (secure ? '; secure' : '');
}
function doane(event) {
	e = event ? event : window.event;
	if(is_ie) {
		e.returnValue = false;
		e.cancelBubble = true;
	} else if(e) {
		e.stopPropagation();
		e.preventDefault();
	}
}
function replyToFloor(floor,poster, postid,posttoid)
{
	if ($('title'))
	{
		/*start by lcd 2011-10-24  游客不显示发送邮件
		if($('emailnotify')){
			if(poster=="游客"){
				$('emailnotify').getParent().setStyle('display','none');
			}else{
				$('emailnotify').getParent().setStyle('display','');
			}
			$('emailnotify').setStyle('checked','false');
		}
		end by lcd*/
		$('postform').postid.value = postid;
		$('title').value = '回复 ' + floor + '楼 ' + poster + ' 的帖子';
		$('isnewpost').value=1;
		$('posttoid').value=posttoid;
		//tinyMCE.execCommand('mceInsertContent',true,'');
		//tinyMCE.execCommand('mceFocus',false,'message');
		KE.focus();
		scrollTo(0,document.body.scrollHeight);
	}
}
function getQueryString(queryname) {
    var qKeys = {};
    var re = /[?&]([^=]+)(?:=([^&]*))?/g;
    var matchInfo;
    while(matchInfo = re.exec(location.search)){
	    qKeys[matchInfo[1]] = matchInfo[2];
    }
    return typeof(qKeys[queryname])=='undefined'?'':qKeys[queryname];
}
function ShowFormatBytesStr(bytes) {
	if(bytes > 1073741824) {
		document.write((Math.round((bytes/1073741824)*100)/100).toString()+' G');
	} else if(bytes > 1048576) {
		document.write((Math.round((bytes/1048576)*100)/100).toString()+' M');
	} else if(bytes > 1024) {
		document.write((Math.round((bytes/1024)*100)/100).toString()+' K');
	} else {
		document.write(bytes.toString()+' Bytes');
	}
}
function fetchOffset(obj) {
	var left_offset = obj.offsetLeft;
	var top_offset = obj.offsetTop;
	while((obj = obj.offsetParent) != null) {
		left_offset += obj.offsetLeft;
		top_offset += obj.offsetTop;
	}
	return { 'left' : left_offset, 'top' : top_offset };
}
function insertVedio( auto_url, msgid ) {
	var swf_id = "";
	
	if(auto_url.substr(0, 7).toLowerCase() != "http://") {
		auto_url = "http://" + auto_url;
	}
	
	var pat = /^(http:\/\/)[a-z0-9][-a-z0-9]{0,62}(\.[a-z0-9][-a-z0-9]{0,62})+\.?/ig;
			
	var domain = "";
	var shorttag = "";
			
	domain = auto_url.match(pat);
	if( domain == null || domain == "") {
		alert("你插入的网址有问题");
		return false;
	}
	domain = domain[0].toLowerCase();
	
	//debug(domain);
	try {
		// Youku
		if(domain.indexOf("youku") != -1) {
			pat = /^(http:\/\/v.youku.com\/v_show\/id_)([_\-a-z0-9]+)(\.html)?/i;
			swf_id = auto_url.match(pat)[2];
			shorttag = "youku";
			//debug(swf_id[1]);
		}
		
		// Ku6
		else if(domain.indexOf("ku6") != -1) {
			pat = /^(http:\/\/v.ku6.com\/special\/show_)([0-9]+\/)([_\-a-z0-9]+)(\.html)?/i;
			swf_id = auto_url.match(pat)[3];
			shorttag = "ku6";
		}
		
		//Tudou
		else if(domain.indexOf("tudou") != -1) {
			pat = /^(http:\/\/www.tudou.com\/programs\/view\/)([_\-a-z0-9]+)(\/)?/i;
			swf_id = auto_url.match(pat)[2];
			shorttag = "tudou";
		}
		
		//QQ Video
		else if(domain.indexOf("qq") != -1) {
			pat = /^(http:\/\/video.qq.com\/v1\/videopl\?v=)([_\-a-z0-9]+)/i;
			swf_id = auto_url.match(pat)[2];
			shorttag = "qq";
		}
		
		//Youtube
		else if(domain.indexOf("youtube") != -1) {
			pat = /^(http:\/\/www.youtube.com\/watch\?v=)([_\-a-z0-9]+)/i;
			swf_id = auto_url.match(pat)[2];
			shorttag = "youtube";
		}
		
		//Sina Video
		else if(domain.indexOf("sina") != -1) {
			pat = /^(http:\/\/video.sina.com.cn\/v\/b\/)([_0-9]+)-([_0-9]+).html/i;
			swf_id = auto_url.match(pat)[2];
			shorttag = "sina";
		}
		
		//Sohu Video
		else if(domain.indexOf("sohu") != -1) {
			pat = /^(http:\/\/share.vrs.sohu.com\/)([0-9]+)\/v.swf/i;
			swf_id = auto_url.match(pat)[2];
			shorttag = "sohu";
			//http://share.vrs.sohu.com/337888/v.swf
		}
		
		//Vimeo
		else if(domain.indexOf("vimeo") != -1) {
			pat = /^(http:\/\/)(www.)?(vimeo.com\/)([0-9]+)/i;
			swf_id = auto_url.match(pat)[4];
			shorttag = "vimeo";
		}
		
		//Mofile
		else if(domain.indexOf("mofile") != -1) {
			pat = /^(http:\/\/)(www.)?(mofile.com\/)([a-z0-9]+)(\/)?/i;
			swf_id = auto_url.match(pat)[4];
			shorttag = "mofile";
		}
		
	} catch(e) {
	}
	
	if(swf_id == "" || shorttag == "") {
		alert("视频链接错误");
	} else {
		//alert(shorttag+"||"+swf_id);
		//tinyMCE.execCommand('mceInsertContent',true,'[vedio]' + shorttag +"|"+ swf_id + '[/vedio]');
		KE.insertHtml('[vedio]' + shorttag +"|"+ swf_id + '[/vedio]');
		/*tagtext = "[" + shorttag + " id=\"" + swf_id + "\"";
		if (auto_width > 0) {
			tagtext += (" w=\"" + auto_width + "\"");
		}
		if (auto_height > 0) {
			tagtext += (" h=\"" + auto_height + "\"");
		}
		tagtext += "]";*/
	}
}
function MinPhotoSize(actual, maxvalue) {
	return Math.min(actual, maxvalue) + "px";
}

function ShowFormatBytesStr(bytes) {
	if(bytes > 1073741824) {
		document.write((Math.round((bytes/1073741824)*100)/100).toString()+' G');
	} else if(bytes > 1048576) {
		document.write((Math.round((bytes/1048576)*100)/100).toString()+' M');
	} else if(bytes > 1024) {
		document.write((Math.round((bytes/1024)*100)/100).toString()+' K');
	} else {
		document.write(bytes.toString()+' Bytes');
	}
}

function MouseCursor(obj) {
	if (is_ie)
		obj.style.cursor = 'hand';
	else
		obj.style.cursor = 'pointer';
}

function convertdate(strdate) {
	strdate = strdate.replace(/-/ig,'/');
	var d = new Date(strdate);
	var now = new Date();
	var result;

	if (d.getYear() == now.getYear() && d.getMonth() == now.getMonth()) {
		var xday = now.getDate() - d.getDate();

		switch (xday) {
			case 0:
				result = "今天 " + d.format("hh") + ":" + d.format("mm");
				break;
			case 1:
				result = "昨天 " + d.format("hh") + ":" + d.format("mm");
				break;
			case 2:
				result = "前天 " + d.format("hh") + ":" + d.format("mm");
				break;
			default:
				result = d.format("yyyy-MM-dd hh:mm");
				break;		
		}
	} else {
		result = d.format("yyyy-MM-dd hh:mm");
	}
	
	return result;
}

function convertdate2(strdate)
{
	strdate = strdate.replace(/-/ig,'/');
	var d = new Date(strdate);
	var now = new Date();
	var result = now - d;
	if (now.getYear() == d.getYear() && now.getMonth() == d.getMonth() && now.getDate() - d.getDate() > 0){
		result = convertdate(strdate);
	} else if (now.getYear() == d.getYear() && now.getMonth() == d.getMonth() && now.getDate() == d.getDate() && now.getHours() - d.getHours() > 0){
		result = convertdate(strdate);
	} else if (now.getYear() == d.getYear() && now.getMonth() == d.getMonth() && now.getDate() == d.getDate() && now.getHours() == d.getHours() && now.getMinutes() - d.getMinutes() > 0){
		result = (now.getMinutes() - d.getMinutes()) + " 分钟前"
	} else if (now.getYear() == d.getYear() && now.getMonth() == d.getMonth() && now.getDate() == d.getDate() && now.getHours() == d.getHours() && now.getMinutes() == d.getMinutes() && now.getSeconds() - d.getSeconds()> 0){
		result = (now.getSeconds() - d.getSeconds()) + " 秒前"
	} else {
		result = d.format("yyyy-MM-dd hh:mm");
	}
	return result;

}

Date.prototype.format = function(format) {
	var o = {
	"M+" : this.getMonth()+1, //month
	"d+" : this.getDate(),    //day
	"h+" : this.getHours(),   //hour
	"m+" : this.getMinutes(), //minute
	"s+" : this.getSeconds(), //second
	"q+" : Math.floor((this.getMonth()+3)/3),  //quarter
	"S" : this.getMilliseconds() //millisecond
	};
	if(/(y+)/.test(format)) {
		format = format.replace(RegExp.$1,
			(this.getFullYear() + "").substr(4 - RegExp.$1.length));
	}
	for(var k in o) {
		if(new RegExp("("+ k +")").test(format))
			format = format.replace(RegExp.$1,
				RegExp.$1.length==1 ? o[k] : ("00"+ o[k]).substr((""+ o[k]).length));
	}
	return format;
}

function findobj(n, d) {
	var p, i, x;
	if(!d) d = document;
	if((p = n.indexOf("?"))>0 && parent.frames.length) {
		d = parent.frames[n.substring(p + 1)].document;
		n = n.substring(0, p);
	}
	if(x != d[n] && d.all) x = d.all[n];
	for(i = 0; !x && i < d.forms.length; i++) x = d.forms[i][n];
	for(i = 0; !x && d.layers && i < d.layers.length; i++) x = findobj(n, d.layers[i].document);
	if(!x && document.getElementById) x = document.getElementById(n);
	return x;
}


function expandoptions(id) {
	var a = document.getElementById(id);
	if(a.style.display=='')
	{
		a.style.display='none';
	}
	else
	{
		a.style.display='';
	}
	return false;
}

function cloneObj(oClone, oParent, count) {
	if (!is_ie) {
		if(oParent.childNodes.length < count +3) {
			var newNode = oClone.cloneNode(true);
			oParent.appendChild(newNode);
			
			return newNode;
		} 
	} else {
		if(oParent.childNodes.length < count) {
			var newNode = oClone.cloneNode(true);
			oParent.appendChild(newNode);
			
			return newNode;
		} 
	}
	
	return false;	
}

function delObj(oParent, count) { 
	if(oParent.childNodes.length > count) {
		oParent.removeChild(oParent.lastChild);
		return true;
	}
	return false;
}

function cloneObj_1(oClone, oParent, i, count, msgtext) {
	var tempcount = 1;
	for(k=0;k<oParent['childNodes'].length;k++){
		if (oParent['childNodes'][k].tagName){
			if (oParent['childNodes'][k].id == oClone.id){
				tempcount ++;
			}
		}
	}

	if(tempcount <= count) {
		for(;i>0;i--) {
			newNode = oClone.cloneNode(true);
			oParent.appendChild(newNode);
		}
	} else {
		alert(msgtext);
	}
}

function clonePoll(maxpoll){
	var aaabbb=$('polloptions');
	var newNode = cloneObj(document.getElementById("divPollItem"), document.getElementById("polloptions") ,parseInt(maxpoll));
	//alert(parseInt(maxpoll));
	if(!newNode){
		alert('投票项不能多于 ' + maxpoll + ' 个');
	}
	var inputs = findtags(newNode, 'input');
	var attach;
	for(i in inputs) {
	    inputs[i].value="";
		if(inputs[i].name == 'pollitemid') {
			
			inputs[i].id = "pollitemid";
		}
	}
}

function delOjb_1(oParent, count, msgtext) {
	var tempcount = 0;
	for(k=0;k<oParent['childNodes'].length;k++){
		if (oParent['childNodes'][k].tagName){
				tempcount ++;
		}
	}
	
	if(tempcount > count) {
		oParent.removeChild(oParent.lastChild);
	} else {
		alert(msgtext);
	}
}

//选择或取消选反列表中全部记录

function checkall(form, prefix, checkall) {
	var checkall = checkall ? checkall : 'chkall';
	for(var i = 0; i < form.elements.length; i++) {
		var e = form.elements[i];
		if(e.name != checkall && (!prefix || (prefix && e.name.match(prefix)))) {
			e.checked = form.elements[checkall].checked;
		}
	}
}

//显示主题图标
function showicons(icons,iconscount,iconscolcount){
	var row=null;
	var col=null;
	var img=null;
	var rowIndex=0;
	var colIndex=0;
	var iCount = 0;
	
	if(typeof(iconscount) == 'undefined') {
		var iconscount = 0;
	}
	
	if(typeof(iconscolcount) == 'undefined') {
		var iconscolcount = 0;
	}
	

	try{

		var icons_container = findobj('iconsdiv');
		var iconstable = document.createElement('table');
				iconstable.cellPadding="2";
				iconstable.cellSpacing="0";
				iconstable.border=0;
				//iconstable.className="altbg1";
				
				iconstable.style.border="0px";
				
				iconstable.id="topiciconstable";
				
		if (!icons.length){
			iCount = 0;
		}
		else{
			iCount = icons.length
		}
		
		if (iconscount > 0 ){
			if (iCount > iconscount){
				iCount = iconscount			
			}
		}
		
		iCount = iCount + 1;
		if (iconscolcount <1){
			iconscolcount = parseInt((iCount + 1) / 2)
		}

		
		var temp_iCount = 1;
		
		row=iconstable.insertRow(-1);		
		col=row.insertCell(-1);
		col.vAlign="middle";
		col.align = "left";
		col.width = "49";
		col.innerHTML = '<input type="radio" id="icon_0" name="iconid" value="0"> <label for="icon_0">无</label>';
		
		colIndex++;
		
		for(i=0;i<icons.length;i++)
		{
		
			if (icons[i]){
				temp_iCount ++;
				if (temp_iCount>iCount){
					break;
				}
				
				if (colIndex>=iconscolcount || colIndex<1){
					row=iconstable.insertRow(-1);		
					colIndex=0;
					
				}
				col=row.insertCell(-1);
				col.vAlign="middle";
				col.align = "left";
				col.width = "49";
				col.innerHTML = '<input type="radio" id="icon_' + icons[i][0] + '" name="iconid" value="' + icons[i][0] + '"> <img src="images/posticons/' + icons[i][1] + '" width="19" height="19" />';
/* 
				input = document.createElement('input');
				input.type = "radio";
				input.value = icons[i][0];
				input.id = "icon_" + icons[i][0];
				input.name = "iconid";
				col.appendChild(input);
				
				img=document.createElement('img');
				img.src="images/posticons/" + icons[i][1];
				img.alt=smilies[i][1];
				img.border=0;
				col.appendChild(img);
 */	
				colIndex++;
				
			}
		}
		
		for (i=colIndex;i<iconscolcount;i++) {
			if (row!=null){
				col=row.insertCell(-1);
				col.vAlign="top";
				col.innerHTML="&nbsp;";
			}
		}
		
		icons_container.appendChild(iconstable);
		
	}
	catch(e){
		alert(e.message);
	}
}


function toggle_collapse(objname) {
	obj = findobj(objname);
	img = findobj(objname+"_img");
	collapsed = getcookie("discuz_collapse");
	cookie_start = collapsed ? collapsed.indexOf(objname) : -1;
	cookie_end = cookie_start + objname.length + 1;
	if(obj.style.display == "none") {
		obj.style.display = "";
		img_re = new RegExp("_yes\\.gif$");
		img.src = img.src.replace(img_re, '_no.gif');
		if(cookie_start != -1) collapsed = collapsed.substring(0, cookie_start) + collapsed.substring(cookie_end, collapsed.length);
	} else {
		obj.style.display = "none";
		img_re = new RegExp("_no\\.gif$");
		img.src = img.src.replace(img_re, '_yes.gif');
		if(cookie_start == -1) collapsed = collapsed + objname + " ";
	}

	expires = new Date();
	expires.setTime(expires.getTime() + (collapsed ? 86400 * 30 : -(86400 * 30 * 1000)));
	document.cookie = "discuz_collapse=" + escape(collapsed) + "; expires=" + expires.toGMTString() + "; path=/";
}


function getpageurl(url,value){
	return url.replace(/\$page/ig,value);	
}

///
///
function getpagenumbers(extname, recordcount,pagesize,mode,title, topicid, page, url, aspxrewrite ){
	var pagecount = 0;
	var pagenumbers = "";
	if (recordcount<=pagesize || pagesize <= 0){
		return;
	}
	if (!mode){
		mode = 0;
	}
	switch(mode){
		case 0:
			/*
				   <script language="javascript">getpagenumbers({topic[replis]},{config.tpp});</script> 
			*/
			recordcount ++;		//帖子数自动加1(主题帖)
			pagecount = parseInt(Math.ceil(recordcount*1.0/pagesize*1.0));
			pagenumbers = "[&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + title;
			for (i=1;i<=pagecount;i++){
				if (i>5){
					pagenumbers = pagenumbers + "...";
					i=pagecount;
				}
				pagenumbers = pagenumbers + "<a href=\"showtopic.action?topicid=" + topicid + "&page=" + i + "\">" + i + "</a>";
			}
			pagenumbers += "]";
			break;
		case 1:
		
			/*
				   <script language="javascript">getpagenumbers({topiccount},{config.tpp},1,'{request[page]}',"showforum-{forumid}-$page.action");</script> 
			*/
			
			pagecount = parseInt(Math.ceil(recordcount*1.0/pagesize*1.0));
			if (page=="" || page<=0){
				page = 1;
			}
			page=parseInt(page);
			pagenumbers += '<div class="p_bar">\n';
			pagenumbers += '	<span class="p_total">&nbsp;' + recordcount + '&nbsp;</span>\n';
			pagenumbers += '	<span class="p_pages">&nbsp;' + page + ' / ' + pagecount + '&nbsp;</span>';
			if (page <= 1) {
				pagenumbers += '	<span title="上一页" class="p_redirect">&lsaquo;&lsaquo;</span>\n';
			} else {
				pagenumbers += '	<a href="' + getpageurl(url,page-1) + '" class="p_redirect">&lsaquo;&lsaquo;</a>\n';
			}
			if (page != 1) pagenumbers += '	<a href="' + getpageurl(url,1) + '" class="p_num">1</a>\n';
			if (page >= 5) pagenumbers += '<span class="p_num">...</span>\n';
			if (pagecount > page + 2) {
				var endPage = page + 2;
			} else {
				var endPage = pagecount;
			}
			
			for (var i = page - 2; i <= endPage; i++) {
				if (i > 0) {
					if (i == page) {
						pagenumbers += '<span class="p_curpage">' + i + '</span>';
					} else {
						if (i != 1 && i != pagecount) {
							pagenumbers += '<a href="' + getpageurl(url,i) + '" class="p_num">' + i + '</a>';
						}
					}
				}
			}
			if ((page + 3) < pagecount) pagenumbers += '<span class="p_num">...</span>\n';
			if (page != pagecount) pagenumbers += '<a href="' + getpageurl(url,pagecount) + '" class="p_num">' + pagecount + '</a>';
			
		
			if (page >= pagecount) {
				pagenumbers += '<span class="p_redirect">&rsaquo;&rsaquo;</span>';
			} else {
				pagenumbers += '<a href="' + getpageurl(url,pagecount) + '" class="p_num">&rsaquo;&rsaquo;</a>';
			}
			
			pagenumbers += '<span class="p_num"><input name="gopage" type="text" class="p_input" id="gopage" onKeyDown="if(event.keyCode==13) {window.location=\'' + getpageurl(url,"\'+this.value + \'") + '\';}" size="4" maxlength="9" value="转到" onmouseover="this.select();" /></span>';
			pagenumbers += '</div>';
			break;
	}
	document.write(pagenumbers);
}

function showPopupText(event) {	
	if(event.srcElement) o = event.srcElement; else o = event.target;
	if (!o) return;
	MouseX = event.clientX;
	MouseY = event.clientY;
	if(o.alt != null && o.alt!="") { o.pop = o.alt;o.alt = "" }
	if(o.title != null && o.title != ""){ o.pop = o.title;o.title = "" }
	if(o.pop != sPop) {
		sPop = o.pop;
		if(sPop == null || sPop == "") {
			document.getElementById("popLayer").style.visibility = "hidden";
		} else {
			if(o.dyclass != null) popStyle = o.dyclass; else popStyle = "cPopText";
			document.getElementById("popLayer").style.visibility = "visible";
			showIt();
		}
	}
}

function showIt() {
	document.getElementById("popLayer").className = popStyle;
	document.getElementById("popLayer").innerHTML = sPop.replace(/<(.*)>/g,"&lt;$1&gt;").replace(/\n/g,"<br>");;
	popWidth = document.getElementById("popLayer").clientWidth;
	popHeight = document.getElementById("popLayer").clientHeight;
	if(MouseX + 12 + popWidth > document.body.clientWidth) popLeftAdjust = -popWidth - 24; else popLeftAdjust = 0;
	if(MouseY + 12 + popHeight > document.body.clientHeight) popTopAdjust = -popHeight - 24; else popTopAdjust = 0;
	document.getElementById("popLayer").style.left = MouseX + 12 + document.body.scrollLeft + popLeftAdjust;
	document.getElementById("popLayer").style.top = MouseY + 12 + document.body.scrollTop + popTopAdjust;
}

