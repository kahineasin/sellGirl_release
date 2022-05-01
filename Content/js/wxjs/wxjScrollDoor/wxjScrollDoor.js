//alert("a");

//function $(divName) {
//    return document.getElementById(divName);
//}

function changeTab(thisTab, tabNum) {
    //	alert("b");
    if (thisTab.className == "active") return;
    //	alert("c");
    var tabList = document.getElementById("tTitle").getElementsByTagName("li");
    for (i = 0; i < tabList.length; i++) {
        if (i == tabNum) {
            thisTab.className = "active";
            document.getElementById("textArea_" + i).style.display = "block";
        } else {
            tabList[i].className = "normal";
            document.getElementById("textArea_" + i).style.display = "none";
        }
    }
}