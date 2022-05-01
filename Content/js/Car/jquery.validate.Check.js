$(function(){
	jQuery.extend(jQuery.validator.messages,{
	required: "必填字段",
	remote: "请修正该字段",
	email: "请输入正确格式的电子邮件",
	url: "请输入合法的网址",
	date: "请输入合法的日期",
	dateISO: "请输入合法的日期 (ISO).",
	number: "请输入合法的数字",
	digits: "只能输入整数",
	creditcard: "请输入合法的信用卡号",
	equalTo: "请再次输入相同的值",
	accept: "请输入拥有合法后缀名的字符串",
	maxlength: jQuery.validator.format("最多 {0} 个字"),
	minlength: jQuery.validator.format("最少 {0} 个字"),
	rangelength: jQuery.validator.format("请输入一个长度介于 {0} 和 {1} 之间的字符串"),
	range: jQuery.validator.format("请输入一个介于 {0} 和 {1} 之间的值"),
	max: jQuery.validator.format("最大为 {0} "),
	min: jQuery.validator.format("最小为 {0} ")
	});
	
	jQuery.validator.addMethod("Isw",function(value, element){
		return this.optional(element) || /^\w+$/.test(value);
	},'只能包含英文字母、数字和下划线！');
	
	jQuery.validator.addMethod("CheckPics",function(value, element, param){
		var P=value.split(","),L=0;
		for(var i=0;i<P.length;i++){if(P[i]!='')L++;}
		return this.optional(element) || param>=L;
	},$.validator.format("最多上传{0}张图片！"));
	jQuery.validator.addMethod("CheckUserName",function(value, element){
		return this.optional(element) || /^[\u4e00-\u9fa5\w]+$/.test(value);
	},'只能包含中文字、英文字母、数字和下划线！');
	jQuery.validator.addMethod("CheckUserName1",function(value, element){
		return this.optional(element) || /^\w+$/.test(value);
	},"只能包含英文字母、数字和下划线！");
	jQuery.validator.addMethod("CheckUserName2", function(value, element){
		return this.optional(element) || !/^\d+$/.test(value);
	}, "不允许全数字注册！");  
	jQuery.validator.addMethod("No0", function(value, element){ 
		return this.optional(element) || parseFloat(value)!=0;       
	},"不能为0"); 
	jQuery.validator.addMethod("isChina",function(value, element){
		return this.optional(element) || /^[\u4e00-\u9fa5]+$/.test(value);
	},'只能是中文！');
	jQuery.validator.addMethod("CheckQQ", function(value, element){return this.optional(element) || /^[1-9][0-9]{4,}$/i.test(value);	}, "请正确填写您的QQ号码！"); 
	jQuery.validator.addMethod("CheckQQs", function(value, element)
	{
	    return this.optional(element) || /^[1-9][0-9]{4,}$/i.test(value);
		var p = value.split(",");   
		var qq = /^[1-9][0-9]{4,}$/i;   
		for(i=0;i++;i<p.length)
		{
		    if(!qq.test(p[i]))
		    {
		        return this.optional(element) || false;
		    }
		}
		return this.optional(element) || true;
	}, "请正确填写您的QQ号码(可用“,”分隔)！"); 
	jQuery.validator.addMethod("byteRangeLength",function(value, element, param){
		value = $.trim(value);
    	var length = value.length;
		$(element).val(value);
   		for(var i = 0; i < value.length; i++){if(value.charCodeAt(i) > 127){length++;}}
		return this.optional(element) || ( length >= param[0] && length <= param[1] );    
	},$.validator.format("请确保输入的值在{0}-{1}个字节之间(一个中文字算2个字节)！"));

	// 数字验证       
	jQuery.validator.addMethod("strnumber", function(value, element, param) {
		if(value==param[0])return true;
		if(!$.validator.methods.number.call(this,value,element))return false;
		return this.optional(element) || (parseFloat(value)>=param[1] && parseFloat(value)<=param[2]);  
	}, $.validator.format("请正确填写有效数字或“{0}”！"));  
	
	jQuery.validator.addMethod("comparenumber", function(value, element, param){
		if($("#"+param[0]).val()=='')return true;
		var N1=parseFloat(value);
		var N2=parseFloat($("#"+param[0]).val());
		if(param[1]>1){N1=Math.abs(N1);N2=Math.abs(N2);param[1]=param[1]-2}
		return this.optional(element) || (param[1]==0?N1>=N2:N1<=N2);
	});  
		
		
		
		
		
	// 手机号码验证
	jQuery.validator.addMethod("isMobile", function(value, element) {       
		var length = value.length;   
		var mobile = /^(((13[0-9]{1})|(15[0-9]{1}))+\d{8})$/;   
		return this.optional(element) || (mobile.test(value));      
	}, "请正确填写您的手机号码！");       
		 
	// 电话号码验证       
	jQuery.validator.addMethod("isTel", function(value, element) {       
		var tel = /^\d{3,4}-?\d{7,9}$/;    //电话号码格式010-12345678   
		return this.optional(element) || (tel.test(value));       
	}, "请正确填写您的电话号码！");
	
	// 联系电话(手机/电话皆可)验证
	jQuery.validator.addMethod("isPhone", function(value,element) {   
		var length = value.length;   
		var mobile = /^(((13[0-9]{1})|(15[0-9]{1}))+\d{8})$/;   
		var tel = /^((\d{3,4}-?\d{7,9})|(\d{3}-\d{3}-\d{4}))$/;
		return this.optional(element) || (tel.test(value) || mobile.test(value));   
	  
	}, "请正确填写您的联系电话(手机/电话皆可)！");   
	jQuery.validator.addMethod("isPhones", function(value,element) {   
		var p = value.split(",");   
		var mobile = /^(((13[0-9]{1})|(15[0-9]{1}))+\d{8})$/;   
		var tel = /^\d{3,4}-?\d{7,9}$/;
		for(i=0;i++;i<p.length)
		{
		    if(!tel.test(p[i]) && !mobile.test(p[i]))
		    {
		        return this.optional(element) || false;
		    }
		}
		return this.optional(element) || true;   
	}, "请正确填写您的联系电话(手机/电话皆可,可请用“,”分隔)！");
	jQuery.validator.addMethod("isTels", function(value,element) {   
		var p = value.split(",");   
		var tel = /^\d{3,4}-?\d{7,9}$/;
		for(i=0;i++;i<p.length)
		{
		    if(!tel.test(p[i]))
		    {
		        return this.optional(element) || false;
		    }
		}
		return this.optional(element) || true;   
	}, "请正确填写您的联系电话(可用“,”分隔)！");   
		 
	// 邮政编码验证
	jQuery.validator.addMethod("isZipCode", function(value, element) {       
	   var str = /^[0-9]{6}$/;       
		return this.optional(element) || (str.test(value));       
	}, "请正确填写您的邮政编码！"); 
	// 正负整数
	jQuery.validator.addMethod("Integer", function(value, element) {       
	   var str = /^\-?\d+$/;       
		return this.optional(element) || (str.test(value));
	}, "请填写正负整数！"); 
    //比较时间
	jQuery.validator.addMethod("endDate",function(value, element,param) {
		if( /^\d{4}[\/-]\d{1,2}[\/-]\d{1,2}$/.test(param[0]) )
		{
			var D1=new Date(Date.parse(param[0].replace(/\-/g, "/")));
			var D2=new Date(Date.parse(value.replace(/\-/g, "/")));
			return param[1]==0?(D1>=D2):(D1<=D2);
		}else{
			return this.optional(element);
		}
   }, "结束日期必须大于开始日期!");





    //判断是否是合法的域名
    function isdomain(a)
    {
	    var	str=a.split(".");
	    if(str.length==1)return false;
	    for (var i=0;i<str.length;i++)
	    {
	        if(str[i]=='')return false;
	        if (str[i].charAt(0)=='-' || str[i].charAt(str[i].length-1)=='-') return false;
	        if(/^([a-z]|-|\d)+$/i.test(str[i])==false)return false;
	    }
        var last = ",ac,ad,ae,aero,af,ag,ai,al,am,an,ao,aq,ar,arpa,as,asia,at,au,aw,ax,az,"
        +"ba,bb,bd,be,bf,bg,bh,bi,biz,bj,bm,bn,bo,br,bs,bt,bv,bw,by,bz,"
        +"ca,cat,cc,cd,cf,cg,ch,ci,ck,cl,cm,cn,co,com,coop,cr,cu,cv,cx,cy,cz,"
        +"de,dj,dk,dm,do,dz,"
        +"ec,edu,ee,eg,er,es,et,eu,"
        +"fi,fj,fk,fm,fo,fr,"
        +"ga,gb,gd,ge,gf,gg,gh,gi,gl,gm,gn,gov,gp,gq,gr,gs,gt,gu,gw,gy,"
        +"hk,hm,hn,hr,ht,hu,"
        +"id,ie,il,im,in,info,int,io,iq,ir,is,it,"
        +"je,jm,jo,jobs,jp,"
        +"ke,kg,kh,ki,km,kn,kp,kr,kw,ky,kz,"
        +"la,lb,lc,li,lk,lr,ls,lt,lu,lv,ly,"
        +"ma,mc,md,me,mg,mh,mil,mk,ml,mm,mn,mo,mobi,mp,mq,mr,ms,mt,mu,museum,mv,mw,mx,my,mz,"
        +"na,name,nc,ne,net,nf,ng,ni,nl,no,np,nr,nu,nz,"
        +"om,org,"
        +"pa,pe,pf,pg,ph,pk,pl,pm,pn,pr,pro,ps,pt,pw,py,"
        +"qa,"
        +"re,ro,rs,ru,rw,"
        +"sa,sb,sc,sd,se,sg,sh,si,sj,sk,sl,sm,sn,so,sr,st,su,sv,sy,sz,"
        +"tc,td,tel,tf,tg,th,tj,tk,tl,tm,tn,to,tp,tr,travel,tt,tv,tw,tz,"
        +"ua,ug,uk,um,us,uy,uz,"
        +"va,vc,ve,vg,vi,vn,vu,"
        +"wf,ws,"
        +"ye,yt,yu,"
        +"za,zm,zw,";
	    if(last.indexOf(','+str[str.length-1]+',')==-1)      //判断后缀是否在列表里
		        return false;
		return true;
     }

	jQuery.validator.addMethod("CheckDomain", function(value, element) {   
		return this.optional(element) || isdomain(value);
	}, "域名不合法！"); 
	
	$.validator.setDefaults(
	{
		//errorElement: "em",
		errorPlacement:function(error,element)
		{
			var ID = element.attr('box') || element.attr('id');
			error.removeClass().addClass("error").attr("for",element.attr('id'));
			if($("#box_"+ID).length==0)element.parent().append("<span id=\"box_"+ID+"\"></span>");
			if($("#box_"+ID +">label").size()==0)
			{
				$("#box_"+ID).append(error); 
			}else{
				var L=$("#box_"+ID +">label");
				if($.trim(L.html())=='' || L.attr("for")==element.attr('id'))
				{
					L.html(error.html());
					L.attr("for",element.attr('id'));
				}
				L.removeClass().addClass("error")
			}
		},
		success:function(label)
		{
			var Obj = $('#'+label.attr("for"));
			var ID = Obj.attr('box') || Obj.attr('id');
			if($.trim($("#box_"+ID).text())=='')$("#box_"+ID +">label").removeClass().addClass("success").html(' ');
		},
		focusInvalid: true, // 获得焦点时不验证 
		onkeyup: false //,debug: true
	});
});
