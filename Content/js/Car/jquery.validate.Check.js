$(function(){
	jQuery.extend(jQuery.validator.messages,{
	required: "�����ֶ�",
	remote: "���������ֶ�",
	email: "��������ȷ��ʽ�ĵ����ʼ�",
	url: "������Ϸ�����ַ",
	date: "������Ϸ�������",
	dateISO: "������Ϸ������� (ISO).",
	number: "������Ϸ�������",
	digits: "ֻ����������",
	creditcard: "������Ϸ������ÿ���",
	equalTo: "���ٴ�������ͬ��ֵ",
	accept: "������ӵ�кϷ���׺�����ַ���",
	maxlength: jQuery.validator.format("��� {0} ����"),
	minlength: jQuery.validator.format("���� {0} ����"),
	rangelength: jQuery.validator.format("������һ�����Ƚ��� {0} �� {1} ֮����ַ���"),
	range: jQuery.validator.format("������һ������ {0} �� {1} ֮���ֵ"),
	max: jQuery.validator.format("���Ϊ {0} "),
	min: jQuery.validator.format("��СΪ {0} ")
	});
	
	jQuery.validator.addMethod("Isw",function(value, element){
		return this.optional(element) || /^\w+$/.test(value);
	},'ֻ�ܰ���Ӣ����ĸ�����ֺ��»��ߣ�');
	
	jQuery.validator.addMethod("CheckPics",function(value, element, param){
		var P=value.split(","),L=0;
		for(var i=0;i<P.length;i++){if(P[i]!='')L++;}
		return this.optional(element) || param>=L;
	},$.validator.format("����ϴ�{0}��ͼƬ��"));
	jQuery.validator.addMethod("CheckUserName",function(value, element){
		return this.optional(element) || /^[\u4e00-\u9fa5\w]+$/.test(value);
	},'ֻ�ܰ��������֡�Ӣ����ĸ�����ֺ��»��ߣ�');
	jQuery.validator.addMethod("CheckUserName1",function(value, element){
		return this.optional(element) || /^\w+$/.test(value);
	},"ֻ�ܰ���Ӣ����ĸ�����ֺ��»��ߣ�");
	jQuery.validator.addMethod("CheckUserName2", function(value, element){
		return this.optional(element) || !/^\d+$/.test(value);
	}, "������ȫ����ע�ᣡ");  
	jQuery.validator.addMethod("No0", function(value, element){ 
		return this.optional(element) || parseFloat(value)!=0;       
	},"����Ϊ0"); 
	jQuery.validator.addMethod("isChina",function(value, element){
		return this.optional(element) || /^[\u4e00-\u9fa5]+$/.test(value);
	},'ֻ�������ģ�');
	jQuery.validator.addMethod("CheckQQ", function(value, element){return this.optional(element) || /^[1-9][0-9]{4,}$/i.test(value);	}, "����ȷ��д����QQ���룡"); 
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
	}, "����ȷ��д����QQ����(���á�,���ָ�)��"); 
	jQuery.validator.addMethod("byteRangeLength",function(value, element, param){
		value = $.trim(value);
    	var length = value.length;
		$(element).val(value);
   		for(var i = 0; i < value.length; i++){if(value.charCodeAt(i) > 127){length++;}}
		return this.optional(element) || ( length >= param[0] && length <= param[1] );    
	},$.validator.format("��ȷ�������ֵ��{0}-{1}���ֽ�֮��(һ����������2���ֽ�)��"));

	// ������֤       
	jQuery.validator.addMethod("strnumber", function(value, element, param) {
		if(value==param[0])return true;
		if(!$.validator.methods.number.call(this,value,element))return false;
		return this.optional(element) || (parseFloat(value)>=param[1] && parseFloat(value)<=param[2]);  
	}, $.validator.format("����ȷ��д��Ч���ֻ�{0}����"));  
	
	jQuery.validator.addMethod("comparenumber", function(value, element, param){
		if($("#"+param[0]).val()=='')return true;
		var N1=parseFloat(value);
		var N2=parseFloat($("#"+param[0]).val());
		if(param[1]>1){N1=Math.abs(N1);N2=Math.abs(N2);param[1]=param[1]-2}
		return this.optional(element) || (param[1]==0?N1>=N2:N1<=N2);
	});  
		
		
		
		
		
	// �ֻ�������֤
	jQuery.validator.addMethod("isMobile", function(value, element) {       
		var length = value.length;   
		var mobile = /^(((13[0-9]{1})|(15[0-9]{1}))+\d{8})$/;   
		return this.optional(element) || (mobile.test(value));      
	}, "����ȷ��д�����ֻ����룡");       
		 
	// �绰������֤       
	jQuery.validator.addMethod("isTel", function(value, element) {       
		var tel = /^\d{3,4}-?\d{7,9}$/;    //�绰�����ʽ010-12345678   
		return this.optional(element) || (tel.test(value));       
	}, "����ȷ��д���ĵ绰���룡");
	
	// ��ϵ�绰(�ֻ�/�绰�Կ�)��֤
	jQuery.validator.addMethod("isPhone", function(value,element) {   
		var length = value.length;   
		var mobile = /^(((13[0-9]{1})|(15[0-9]{1}))+\d{8})$/;   
		var tel = /^((\d{3,4}-?\d{7,9})|(\d{3}-\d{3}-\d{4}))$/;
		return this.optional(element) || (tel.test(value) || mobile.test(value));   
	  
	}, "����ȷ��д������ϵ�绰(�ֻ�/�绰�Կ�)��");   
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
	}, "����ȷ��д������ϵ�绰(�ֻ�/�绰�Կ�,�����á�,���ָ�)��");
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
	}, "����ȷ��д������ϵ�绰(���á�,���ָ�)��");   
		 
	// ����������֤
	jQuery.validator.addMethod("isZipCode", function(value, element) {       
	   var str = /^[0-9]{6}$/;       
		return this.optional(element) || (str.test(value));       
	}, "����ȷ��д�����������룡"); 
	// ��������
	jQuery.validator.addMethod("Integer", function(value, element) {       
	   var str = /^\-?\d+$/;       
		return this.optional(element) || (str.test(value));
	}, "����д����������"); 
    //�Ƚ�ʱ��
	jQuery.validator.addMethod("endDate",function(value, element,param) {
		if( /^\d{4}[\/-]\d{1,2}[\/-]\d{1,2}$/.test(param[0]) )
		{
			var D1=new Date(Date.parse(param[0].replace(/\-/g, "/")));
			var D2=new Date(Date.parse(value.replace(/\-/g, "/")));
			return param[1]==0?(D1>=D2):(D1<=D2);
		}else{
			return this.optional(element);
		}
   }, "�������ڱ�����ڿ�ʼ����!");





    //�ж��Ƿ��ǺϷ�������
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
	    if(last.indexOf(','+str[str.length-1]+',')==-1)      //�жϺ�׺�Ƿ����б���
		        return false;
		return true;
     }

	jQuery.validator.addMethod("CheckDomain", function(value, element) {   
		return this.optional(element) || isdomain(value);
	}, "�������Ϸ���"); 
	
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
		focusInvalid: true, // ��ý���ʱ����֤ 
		onkeyup: false //,debug: true
	});
});
