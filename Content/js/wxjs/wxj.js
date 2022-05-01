function userInfoHidden(hideNo){
	for (i=1;i<3;i++ )
	{
		if(i==hideNo){
			document.getElementById("idBbsMemInfoBoxRHidden"+i).style.display="block";
		}else{
			document.getElementById("idBbsMemInfoBoxRHidden"+i).style.display="none";
		}
	}

}