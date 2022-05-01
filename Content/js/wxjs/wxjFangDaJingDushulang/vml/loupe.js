/**
 * loupe.js 1.32 (21-Mar-2009)
 * (c) by Christian Effenberger 
 * All Rights Reserved
 * Source: loupe.netzgesta.de
 * Distributed under Netzgestade Software License Agreement
 * http://www.netzgesta.de/cvi/LICENSE.txt
 * License permits free of charge
 * use on non-commercial and 
 * private web sites only
 * IE only version
**/

// the path to "loupe.png", "lens.png" and "icon.png" 
// must be set before loading "loupe.js" !

if(typeof loupePath=="undefined") var loupePath = "vml/";

var tmp = navigator.appName == 'Microsoft Internet Explorer' && navigator.userAgent.indexOf('Opera') < 1 ? 1 : 0;
if(tmp) var isIE = document.namespaces ? 1 : 0;
    
if(isIE) {
	if(document.namespaces['v']==null) {
		var e=["shape","shapetype","group","background","path","formulas","handles","fill","stroke","shadow","textbox","textpath","imagedata","line","polyline","curve","roundrect","oval","rect","arc","image"],s=document.createStyleSheet(); 
		for(var i=0; i<e.length; i++) {s.addRule("v\\:"+e[i],"behavior: url(#default#VML);");} document.namespaces.add("v","urn:schemas-microsoft-com:vml");
	} 
}

var imgreso = new Image;  

function roundTo(val,dig) {
	var num = val;
	if(val > 8191 && val < 10485) {
		val = val-5000;
		num = Math.round(val*Math.pow(10,dig))/Math.pow(10,dig);
		num = num+5000;
	}else {
		num = Math.round(val*Math.pow(10,dig))/Math.pow(10,dig);
	}
	return num;
}

function LoupeMouseDown(event) {
	if (!event) event = window.event;
	document.body.div = this;
	this.inDrag = true;
	if(event.pageX) {
		this.startX = event.pageX;
		this.startY = event.pageY;
	}else if (event.clientX) {
		this.startX = event.clientX;
		this.startY = event.clientY;
	}else {
		return;
	}
}

function LoupeMouseUp() {
	if(this.inDrag) {
		this.inDrag = false;
		document.body.div = null;
	}
}

function LoupePosition() {
	var image = document.getElementById(this.iName);
	var fill = document.getElementById(this.iName+"_Pos");
	var left = Math.max(this.xMin,Math.min(this.xMax,Math.round(this.xPos-this.width/2)));
	var top = Math.max(this.yMin,Math.min(this.yMax,Math.round(this.yPos-this.height/2)));
	var xSrc = Math.round(Math.min((left-this.xMin)*this.xMulti,this.cWidth-this.size));
	var ySrc = Math.round(Math.min((top-this.yMin)*this.yMulti,this.cHeight-this.size));
	var xf = -(xSrc/(this.size+1)); var yf = -(ySrc/(this.size+1));
	if(document.documentMode==8) {fill.position=xf+','+yf;}else {fill.setAttribute('position', xf+','+yf);}
	this.style.left = left + "px"; this.style.top = top + "px";
}

function LoupeDrag(event) {
	if(!event) event = window.event;
	var div = this.div; 
	if(div && div.inDrag) {
		var eventX; var eventY;
		if (event.pageX) {
			eventX = event.pageX;
			eventY = event.pageY;
		}else if (event.clientX) {
			eventX = event.clientX;
			eventY = event.clientY;
		}else {
			return;
		}
		div.xPos += eventX-div.startX;
		div.yPos += eventY-div.startY;
		div.startX = eventX;
		div.startY = eventY;
		div.position();
	}
}

function toggleLoupeVisibility() {
	var obj = document.getElementById(this.id + "Loupe");
	if(obj.style.visibility=='hidden'||obj.style.visibility=='') {
		obj.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='" + loupePath + "loupe.png',sizingMethod='scale')";
		obj.style.visibility = 'visible';
	}else {	
		obj.style.filter = "alpha(opacity=0)";
		obj.style.visibility = 'hidden';
	}
}
				
function createLoupe(imgname,display,xpos,ypos,ch) {
	var size = 205; var image = document.getElementById(imgname);
	if(image) image.style.cursor = 'default'; 
	if(image && image.width>=size && image.height>=size) {
		image.style.msInterpolationMode="bicubic";
		image.setAttribute("alt", ""); image.alt="";
		var width = 300; var height = 250; 
		var radius = size/2; var toggle;
		var xoff = 8; var yoff = 6; 
		var iconw = 40; var iconh = 32;
		var object = image.parentNode;
		object.style.position = 'relative';
		if(!document.getElementById(imgname + "_")) {
			var toggle = document.createElement("div");
			toggle.id = imgname + "_";
			toggle.title = "switch Loupe on/off";
			toggle.width = iconw; toggle.height = iconh;
			toggle.left = image.width-iconw; 
			toggle.top = image.height-iconh;
			toggle.style.position = 'absolute';
			toggle.style.height = iconh+'px'; 
			toggle.style.width = iconw+'px';
			toggle.style.left = image.width-iconw + 'px';
			toggle.style.top = image.height-iconh + 'px';
			toggle.style.cursor = 'pointer';
			toggle.style.zindex = 9990;	
			toggle.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='" + loupePath + "icon.png')";
			toggle.onclick = toggleLoupeVisibility;
			object.appendChild(toggle);
		}		
		if(!document.getElementById(imgname + "_Loupe")) {
			var div = document.createElement("div");
			div.id = imgname + "_Loupe";
			div.width = width; div.height = height;
			div.left = 0; div.top = 0;
			var tmp = new Image; tmp.src = image.src;
			var xfac = roundTo(tmp.width/image.width,4);
			var yfac = roundTo(tmp.height/image.height,4);
			div.cWidth = tmp.width; 
			div.cHeight = tmp.height;
			delete tmp;
			div.xMulti = xfac;
			div.yMulti = yfac;
			if(xpos!=null||ypos!=null) {
				var x = Math.round(xpos!=null?Math.max(1,Math.min(xpos,div.cWidth)):1); 
				var y = Math.round(ypos!=null?Math.max(1,Math.min(ypos,div.cHeight)):1); 
				div.xPos = ((width/2)-radius-xoff)+(x/xfac); 
				div.yPos = ((height/2)-radius-yoff)+(y/yfac);
			}else {
				div.xPos = width/2; 
				div.yPos = height/2;
			}
			div.crossHair = (ch!=1?false:true); 
			div.iName = imgname; 
			div.iWidth = image.width; 
			div.iHeight = image.height;
			div.size = size;
			div.radius = radius;
			div.xOff = xoff; 
			div.yOff = yoff;
			div.xMin = -(radius+xoff)+(radius/xfac); 
			div.yMin = -(radius+yoff)+(radius/yfac); 
			div.xMax = image.width-(radius+xoff)-(radius/xfac); 
			div.yMax = image.height-(radius+yoff)-(radius/yfac); 
			div.style.width = width+'px';
			div.style.height = height+'px';
			div.style.position = 'absolute';
			div.style.visibility = (display?'visible':'hidden');
			div.style.left = 0+'px';
			div.style.top = 0+'px';
			div.style.cursor = 'move';
			div.style.zindex = 9997;
			div.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='" + loupePath + "loupe.png',sizingMethod='scale')";
			div.onmousedown = LoupeMouseDown;
			div.onmouseup = LoupeMouseUp;
			document.body.onmousemove = LoupeDrag;
			div.position = LoupePosition;
			object.appendChild(div);
			if(!document.getElementById(imgname + "_Grab")) {
	        	var vml = document.createElement('v:oval');
	        	vml.id = imgname + "_Grab";
				vml.setAttribute('filled', 'true');
				vml.setAttribute('fillcolor', '#ffffff');
				vml.setAttribute('stroked', 'false');
				vml.setAttribute('strokeweight', '0');
				vml.style.position = 'absolute';
				vml.style.left = xoff-1;
				vml.style.top = yoff-1;
				vml.style.width = size+1;
				vml.style.height = size+1;
				vml.style.zindex = 9998;
				var fil = document.createElement('v:fill');
	        	fil.id = imgname + "_Pos";
				fil.setAttribute('alignshape', 'false');
				fil.setAttribute('position', '0,0');
				fil.setAttribute('type', 'tile');
				fil.setAttribute('src', image.src);
				vml.appendChild(fil);
				div.appendChild(vml);
			}
			if(!document.getElementById(imgname + "_Lens")) {
				var len = document.createElement("div");
				len.id = imgname + "_Lens";
				len.width = size; len.height = size;
				len.left = xoff; len.top = yoff;
				len.style.position = 'absolute';
				len.style.width = size+'px';
				len.style.height = size+'px';
				/* len.style.visibility = (display?'visible':'hidden'); */
				len.style.left = xoff+'px';
				len.style.top = yoff+'px';
				len.style.zindex = 9999;
				len.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='" + loupePath + "lens.png',sizingMethod='scale')";
				div.appendChild(len);
			}
			div.position();
		}		
	}
}		
					
function initLoupe(id,display,xpos,ypos,ch) {
	if(isIE && imgreso.src.match(/loupe.png$/) && imgreso.width==300 && imgreso.height==250) {
			createLoupe(id,display,xpos,ypos,ch);
	}else {
		imgreso.onload = function() {
			if((isIE && imgreso.complete==true) || (isIE && imgreso.width==300 && imgreso.height==250)) {
				createLoupe(id,display,xpos,ypos,ch);
			}
		}
		imgreso.src = loupePath + "loupe.png";
	}
}