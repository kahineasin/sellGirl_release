alert("1234");
function ZteMenu(id) {
	this.z_index = 50;
	this.eventSource = [];
	this.eventResult = [];
	this.menuId = id;

}

ZteMenu.prototype.init = function() {
	var w = document.getElementById(this.menuId);
	var ulArray = w.getElementsByTagName('ul');
	for (i = 0; i < ulArray.length; i++) {
		var p = ulArray[i].parentNode;
		this.eventSource[i] = p;
		this.eventResult[i] = ulArray[i];
		p.onmouseover = new Function(this.menuId + '.st(' + i + ',true)');
		p.onmouseout = new Function(this.menuId + '.st(' + i + ')');
	}
}

ZteMenu.prototype.st = function(i, flag) {
	var s = this.eventSource[i];
	var r = this.eventResult[i];
	// var p = h.getElementsByTagName('a')[0];
	if (flag) {
		// p.className+=' '+a;
		r.style.display = 'block';
		r.style.overflow = 'visible';
		r.style.zIndex = this.z_index;
	} else {
		// p.className=p.className.replace(a,'');
		r.style.display = 'none';
		r.style.overflow = 'hidden';
	}
}
