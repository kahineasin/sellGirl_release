var wid
var jq=jQuery.noConflict();
jq(function(){
		jq("#product_float").hover(function(){
			jq(this).animate({left:0},{queue:false});
		},function(){
			jq(this).animate({left:-155},{queue:false});
		});
			
		//jq("a").attr("onFocus","this.blur()");
		
		jq(".m_leftbox_li_bg").bind("click",function(){
			jq(".m_leftbox_li_bg").css("background","none");
			jq(".m_leftbox_li_bg").css("color","#ffffff");
			jq(this).css("background","url('images/li_bg.jpg')");
			jq(this).css("color","#222222");
		});
		jq(".m_leftbox_li_bg").mouseover(function(){
			jq(".m_leftbox_li_bg").css("background","none");
			jq(".m_leftbox_li_bg").css("color","#ffffff");
			jq(this).css("background","url('images/li_bg.jpg')");
			jq(this).css("color","#222222");
		});
		
		jq(".top_right_m_li").mouseover(function(){
			jq(this).css("background","url('images/menu_hover.jpg') bottom no-repeat")
			jq(".top_right_m_ul").css("display","none");
			jq(this).children(".top_right_m_ul").css("display","block");
			wid=jq(this).children(".top_right_m_ul").find("li").length;
			wid=wid*90;
			jq(".top_right_m_ul").css("width",wid);
		});
		jq(".top_right_m_li").mouseout(function(){
			jq(".top_right_m_li").css("background","none")
			jq(this).css("background","url('images/menu_hover.jpg') bottom no-repeat")
		});
		
		
	//滚动1111111111111111111111111111111111	  
		  var ll=0;
		  var wli,zt,ct;
		  var ww=85; //图片宽度+间距
		  var nn=3; //可见的图片数量
		  	function zdw(){
				if(ll==wli){
		  			jq("#jqscc").animate({left:0});
					ll=0;
				}
				else{
		  			ll=ll-ww;
		  			jq("#jqscc").animate({left:ll});	
				}
				zt=setTimeout(zdw,5000);
				//alert(wli);
				//alert(ll);
			};
			
	
				wli=jq("#jqscc").children("ul").find("li").length;
				var widd=wli*ww;
				wli=-((wli*ww)-(ww*nn));
				jq("#jqscc").css("width",widd);
				
			  setTimeout(zdw,5000);
				jq("#jqslb").bind("click",function(){ 
					clearTimeout(zt); 
					clearTimeout(ct);
					if(ll==0){
						jq("#jqscc").animate({left:"0px"});
						ct=setTimeout(zdw,5000);
					}
					else{  
						ll=ll+ww;
						jq("#jqscc").animate({left:ll});
						ct=setTimeout(zdw,5000);
					}
				});
			  
				jq("#jqsrb").bind("click",function(){
					clearTimeout(zt);
					clearTimeout(ct);
					if(ll==wli){
						jq("#jqscc").animate({left:0});
						ll=0;
						ct=setTimeout(zdw,5000);
					}
					else{
						ll=ll-ww;
						jq("#jqscc").animate({left:ll});	
						ct=setTimeout(zdw,5000);
					}
					//alert(ll);
					//alert(wli);
				});
			
			
		//滚动2222222222222222222222222222222222222222
			var lls=0;
		  var wlis,zts,cts;
		  var wws=93; //图片宽度+间距
		  var nns=7; //可见的图片数量
		  var lds=2; //滚动数量
		  
				wlis=jq("#jqsccs").children("ul").find("li").length;
				var wids=wlis*wws;
				wlis=-((wlis*wws)-(wws*nns));
				jq("#jqsccs").css("width",wids);
				wws=wws*lds;
				
		  	function zdws(){
				if(lls<wlis){
		  			jq("#jqsccs").animate({left:0});
					lls=0;
				}
				else{
		  			lls=lls-wws;
		  			jq("#jqsccs").animate({left:lls});	
				}
				zts=setTimeout(zdws,5000);
				//alert(wlis);
				//alert(lls);
			};
				
			  setTimeout(zdws,5000);
				jq("#jqslbs").bind("click",function(){ 
					clearTimeout(zts); 
					clearTimeout(cts);
					if(lls>=0){
						jq("#jqsccs").animate({left:"0px"});
						cts=setTimeout(zdws,5000);
					}
					else{  
						lls=lls+wws;
						jq("#jqsccs").animate({left:lls});
						cts=setTimeout(zdws,5000);
					}
				});
			  
				jq("#jqsrbs").bind("click",function(){
					clearTimeout(zts);
					clearTimeout(cts);
					if(lls<wlis){
						jq("#jqsccs").animate({left:0});
						lls=0;
						cts=setTimeout(zdws,5000);
					}
					else{
						lls=lls-wws;
						jq("#jqsccs").animate({left:lls});	
						cts=setTimeout(zdws,5000);
					}
					//alert(lls);
					//alert(wlis);
				});
				
				
		jq("#jqscc ul li a img").bind("click",function(){
			var pimg=jq(this).attr("src");
			
			jq("#m_main_line_r_prov_box_t_r img").attr("src",pimg);
		});
		
		//首页pro展示
		var sid,pts,pte;
		var n=0;
		var m=1;
		function zsl(){
				if (n>3){
					n=1
				}
				else{
				n=n+1;
				}
				sid="#p"+n;
				jq("#index_main_box_r_pro_con ul li").animate({width:"33"},{queue:false});
				jq(sid).animate({width:"363"},{queue:false});
				
				jq(".index_main_box_r_pro_con_li_l").css("background","url(images/index_pro_li_bg.png)");
				jq(".index_main_box_r_pro_con_li_l a").css("color","#666666");
				jq(".index_main_box_r_pro_con_li_l_b").css("color","#666666");
				jq(".index_main_box_r_pro_con_box_cur").css("display","none");
				jq(sid).children(".index_main_box_r_pro_con_box").children(".index_main_box_r_pro_con_li_l").css("background","url(images/index_pro_li_bgh.png)");
				
				
				jq(sid).children(".index_main_box_r_pro_con_box").children(".index_main_box_r_pro_con_li_l").children(".index_main_box_r_pro_con_li_l_t").children("a").css("color","#ffffff");
				jq(sid).children(".index_main_box_r_pro_con_box").children(".index_main_box_r_pro_con_li_l").children(".index_main_box_r_pro_con_li_l_b").css("color","#ffffff");
				jq(".index_main_box_r_pro_con_box").children(".index_main_box_r_pro_con_li_r").animate({width:"0"},{queue:false});
				jq(sid).children(".index_main_box_r_pro_con_box").children(".index_main_box_r_pro_con_li_r").animate({width:"330"},{queue:false});
				
				
				jq(sid).children(".index_main_box_r_pro_con_box").children(".index_main_box_r_pro_con_box_cur").css("display","block");
				if (m==1){
					pts=setTimeout(zsl,2000);
				}
				else{
					clearTimeout(pts);
				}
		};
		
		pts=setTimeout(zsl,10);
		
		jq("#index_main_box_r_pro_con ul li").hover(function(){
				n=parseInt(jq(this).attr("mun"));
				
				jq("#index_main_box_r_pro_con ul li").animate({width:"33"},{queue:false});
				jq(this).animate({width:"363"},{queue:false});
				
				jq(".index_main_box_r_pro_con_li_l").css("background","url(images/index_pro_li_bg.png)");
				jq(".index_main_box_r_pro_con_li_l a").css("color","#666666");
				jq(".index_main_box_r_pro_con_li_l_b").css("color","#666666");
				jq(".index_main_box_r_pro_con_box_cur").css("display","none");
				jq(this).children(".index_main_box_r_pro_con_box").children(".index_main_box_r_pro_con_li_l").css("background","url(images/index_pro_li_bgh.png)");
				jq(this).children(".index_main_box_r_pro_con_box").children(".index_main_box_r_pro_con_li_l").children(".index_main_box_r_pro_con_li_l_t").children("a").css("color","#ffffff");
				jq(this).children(".index_main_box_r_pro_con_box").children(".index_main_box_r_pro_con_li_l").children(".index_main_box_r_pro_con_li_l_b").css("color","#ffffff");
				jq(".index_main_box_r_pro_con_box").children(".index_main_box_r_pro_con_li_r").animate({width:"0"},{queue:false});
				jq(this).children(".index_main_box_r_pro_con_box").children(".index_main_box_r_pro_con_li_r").animate({width:"330"},{queue:false});
				jq(this).children(".index_main_box_r_pro_con_box").children(".index_main_box_r_pro_con_box_cur").css("display","block");
				m=0;
				clearTimeout(pts);
			},function(){	
				m=1;
				pts=setTimeout(zsl,500);
				jq("#index_main_box_r_pro_con ul li").animate({width:"33"},{queue:false});
				jq(this).animate({width:"363"},{queue:false});
		});
		
		
		jq("#jqsccde ul li a").bind("click",function(){
			var acon=jq(this).attr("acon");
			var ayear=jq(this).html();
			
			jq("#m_main_line_r_about_de_con_r").html(acon);
			jq("#m_main_line_r_about_de_con_l_mun").html(ayear);
		});
		
		function pageWidth(){ 
			if(jq.browser.msie){ 
				return document.compatMode == "CSS1Compat"? document.documentElement.clientWidth : 
				document.body.clientWidth; 
			}else{ 
				return self.innerWidth; 
			} 
		};
		var jwidth=pageWidth();
		var jswidth=-(1440-jwidth)/2;
		var jswidth=jswidth+"px";
		jq("#join_top_box").css("width",jwidth);
		var jsbgcon="url(images/change/join_tobg.jpg) "+jswidth+" 0px no-repeat"
		jq("#join_top_box").css("background",jsbgcon);
		//alert(jsbgcon);
		
		
		/*************pro_left_float****************/
		jq(".top_right_m_uls").animate({height:"0"},{queue:false});
		
		jq(".top_right_m_lis").bind("click",function(){
			
			//jq(this).children(".top_right_m_li_a").css("color","#cd4126");
													
													
			wid=jq(this).children(".top_right_m_uls").find("li").length;
			wid=wid*24;
			dheight=jq(this).children(".top_right_m_uls").css("height");
			if(dheight=="0px"){
				jq(".top_right_m_uls").animate({height:"0"},{queue:false});
				jq(this).children(".top_right_m_uls").animate({height:wid});

			}
			else{
				jq(this).children(".top_right_m_uls").animate({height:"0"});
			}
		});
		
		var mid,hmun,hid
		hmun=jq("#index_main_box_l").find(".index_main_img").length;
		//mid=jq(".index_main_img").attr("mid"); 
		mid=1;
		function httimg(){
			if (mid<hmun+1){
				//var id = this.id.replace('a', '');
				jq("#m" + mid).fadeOut(1000,function(){
				jq("#m" + mid).css("z-index","-1");
				jq("#m" + (mid+1)).css("display","none");
				});
				
				if (mid==hmun){
					mid=1
					jq("#m" + mid).css("display","none");
					jq("#m" + mid).fadeIn(2000);
					jq("#m" + mid).css("z-index","1");
				}
				else{
					mid=mid+1
					jq("#m" + mid).css("display","none");
					jq("#m" + mid).fadeIn(2000);
					jq("#m" + mid).css("z-index","1");
				}
			}	
			setTimeout(httimg,5000);
		};
		setTimeout(httimg,50);
});