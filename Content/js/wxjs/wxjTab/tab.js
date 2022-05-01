	function setTab03Syn ( i )
	{
		selectTab03Syn(i);
	}
	
	function selectTab03Syn ( i )
	{
		switch(i){
			case 1:
			document.getElementById("index_center_con1").style.display="block";
			document.getElementById("index_center_con2").style.display="none";
			document.getElementById("index_center_con3").style.display="none";
			document.getElementById("font1").style.color="#000000";
			document.getElementById("font1").style.background="url('wxjs/wxjTab/images/m_proview_midmenu_bgh.png')";
			document.getElementById("font2").style.color="#ffffff";
			document.getElementById("font2").style.background="none";
			document.getElementById("font3").style.color="#ffffff";
			document.getElementById("font3").style.background="none";
			break;
			case 2:
			document.getElementById("index_center_con1").style.display="none";
			document.getElementById("index_center_con2").style.display="block";
			document.getElementById("index_center_con3").style.display="none";
			document.getElementById("font1").style.color="#ffffff";
			document.getElementById("font1").style.background="none";
			document.getElementById("font2").style.color="#000000";
			document.getElementById("font2").style.background = "url('wxjs/wxjTab/images/m_proview_midmenu_bgh.png')";
			document.getElementById("font3").style.color="#ffffff";
			document.getElementById("font3").style.background="none";
			break;
			case 3:
			document.getElementById("index_center_con1").style.display="none";
			document.getElementById("index_center_con2").style.display="none";
			document.getElementById("index_center_con3").style.display="block";
			document.getElementById("font1").style.color="#ffffff";
			document.getElementById("font1").style.background="none";
			document.getElementById("font2").style.color="#ffffff";
			document.getElementById("font2").style.background="none";
			document.getElementById("font3").style.color="#000000";
			document.getElementById("font3").style.background = "url('wxjs/wxjTab/images/m_proview_midmenu_bgh.png')";
			break;
		}
	}