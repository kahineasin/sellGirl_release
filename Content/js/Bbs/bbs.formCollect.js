/*
* 表单收集
*/
var bbs = bbs || {};
bbs.formCollect = bbs.formCollect || {};

//如果收集的表单不是用于导入,那么收集下拉的text比value要更直观有用
bbs.formCollect.nameAsValue = function (exceptDoms) {
    var options = $('option');
    for (var i = 0; i < options.length; i++) {
        if (options[i].innerHTML.indexOf("请选择") < 0 && options[i].value !== -1 && options[i].value !== '') {
            //if (!exceptDoms) {
                options[i].value = options[i].innerHTML;
            //} else {
                //var parent = $(options[i]).parent();
                //var me = $(options[i]);
                //if (exceptDoms != me && exceptDoms != parent) { options[i].value = options[i].innerHTML; }
            //}
        }
    }
};