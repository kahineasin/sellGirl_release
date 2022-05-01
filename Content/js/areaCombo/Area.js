/**
 *  省,市,县 3级联动js
 * @author  
 * @date    2015-10-10
 * @version Ver 0.0.1
 */
function initComplexArea(a, k, h, p, q, z, d, b, l, nameAsValue) {//nameAsValue{Bool}为了解决以地区中文提交的问题--wxj20170908
    var f = initComplexArea.arguments;
    var m = document.getElementById(a);//省
    var o = document.getElementById(k);//市下拉框
    var n = document.getElementById(h);//区县
    var e = 0;
    var c = 0;
    //
    var arr = d+""+b;//代表市的数组编号
    var dbl = d+""+b + ""+l;//代表区的数组编号

    if (p != undefined) {
        if (d != undefined) {
            d = parseInt(d);
        }
        else {
            d = 0;
        }
        if (b != undefined) {
            b = parseInt(b);
        }
        else {
            b = 0;
        }
        if (l != undefined) {
            l = parseInt(l);
        }
        else {
            l = 0
        }
        n[0] = new Option("请选择 ", 0);
        for (e = 0; e < p.length; e++) {
            if (p[e] == undefined) {
                continue;
            }
            if (f[7]) {  
                if (f[7] == true) {
                    if (e == 0) {
                        continue
                    }
                }
            }
            //m[c] = new Option(p[e], e);
            m[c] = new Option(p[e], nameAsValue ? p[e] : e);//--wxj20170908
            if (d == e) {
                m[c].selected = true;//为省一级赋默认值
            }
            c++
        }
        o[0] = new Option("请选择 ", 0);//为市一级赋“请选择”初始值
        if (q[d] != undefined) {
        	//o[0] = new Option("请选择 ", 0);
            c = 0; for (e = 0; e < q[d].length; e++) {
                if (q[d][e] == undefined) { continue }
                if (f[7]) {
                    if ((f[7] == true) && (d != 71) && (d != 81) && (d != 82)) {
                        if ((e % 100) == 0) { continue }
                    }
                } o[c] = new Option(q[d][e], e);//alert(q[d][e])为市一级赋默认值
                if (arr == e) { o[c].selected = true;} c++
            }
        }
        
        /*为第三级列表赋默认值 */
        if (z[arr] != undefined) {
            c = 0; for (e = 0; e < z[arr].length; e++) {
                if (z[arr][e] == undefined) { continue }
                if (f[7]) {
                    if ((f[7] == true) && (d != 71) && (d != 81) && (d != 82)) {
                        if ((e % 100) == 0) { continue }
                    }
                } n[c] = new Option(z[arr][e], e);
                if (dbl == e) { n[c].selected = true } c++
            }
        }
        //编辑时如果两级把第三级隐藏
        if (d == 11 || d == 12 || d == 31 || d == 71 || d == 50 || d == 81 || d == 82) {
            if ($("#" + h + "_div"))
            { $("#" + h + "_div").hide();}
        }
        
    }

    //原版在视图监听,似乎写在这里更好--wxj20170908
    $(m).on('change', function () {
        changeComplexProvince(this.value, sub_array, k, h, nameAsValue);
    });
    $(o).on('change', function () {
        changeCity(this.value, h, h, nameAsValue);//原版这么写,但第四个参数好像是没用的
    });
}
function getProvinceValue(name) {
    for (var i = 0; i < area_array.length; i++) {
        if (area_array[i] == name) { return i }
    }
}
function getCityValue(name) {
    for (var i = 0; i < l_arr.length; i++) {
        if (l_arr[i] == name) { return i }
    }
}
//改变省下拉框事件
function changeComplexProvince(f, k, e, d, nameAsValue) {//f:省,k:sub_array,e:市的domid,d:县的domid
    if (nameAsValue === true) { f = getProvinceValue(f) }//--wxj20170908

    var c = changeComplexProvince.arguments; var h = document.getElementById(e);
    var g = document.getElementById(d); var b = 0; var a = 0; removeOptions(h); f = parseInt(f);

    h[0] = new Option("请选择 ", 0);//改变时第2 个下拉框显示"请选择"
    
    if (k[f] != undefined) {
        for (b = 0; b < k[f].length; b++) {
            if (k[f][b] == undefined) { continue }
            if (c[3]) { if ((c[3] == true) && (f != 71) && (f != 81) && (f != 82)) { if ((b % 100) == 0) { continue } } }
            //h[a] = new Option(k[f][b], b);
            h[a] = new Option(k[f][b],nameAsValue? k[f][b]:b);//--wxj20170908
            a++
        }
    }
    removeOptions(g); g[0] = new Option("请选择 ", 0);
    if (f == 11 || f == 12 || f == 31 || f == 71 || f == 50 || f == 81 || f == 82) {
        if ($("#" + d + "_div"))
        { $("#" + d + "_div").hide();}
    }
    else {
        if ($("#" + d + "_div")) { $("#" + d + "_div").show(); }
    }
}
//改变市下拉框事件
function changeCity(c, a, t, nameAsValue) {
    if (nameAsValue === true) { c = getCityValue(c) }//--wxj20170908

    l_arr[4401]

	var ProvincenNum=$("#seachprov").val();
	if ( ProvincenNum== 11 || ProvincenNum == 12 || ProvincenNum == 31 || ProvincenNum == 71 || ProvincenNum == 50 || ProvincenNum == 81 	|| ProvincenNum == 82) {
		 return;
	}

    $("#" + a).html('<option value="0" >请选择</option>');
    $("#" + a).unbind("change");
    c = parseInt(c); 
    var _d = sub_arr[c];
    var str = "";     
    str += "<option value='0' >请选择</option>";
    if (_d) {//修复原版选中山市后无内容报错的问题
        for (var i = c * 100; i < _d.length; i++) {
            if (_d[i] == undefined) continue;
            str += "<option value='" + (nameAsValue?_d[i]:i) + "' >" + _d[i] + "</option>";
        }
    }
    $("#" + a).html(str);
    
}

//移除option选项
function removeOptions(c) {
    if ((c != undefined) && (c.options != undefined)) {
        var a = c.options.length;
        for (var b = 0; b < a; b++) {
            c.options[0] = null;
        }
    }
}
