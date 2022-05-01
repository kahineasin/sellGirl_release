/**
* by wxj 
**/
$.extend($.fn.validatebox.defaults.rules, {
    CHS: {
        validator: function (value, param) {
            return /^[\u0391-\uFFE5]+$/.test(value);
        },
        message: '请输入汉字'
    },
    ZIP: {
        validator: function (value, param) {
            return /^[1-9]\d{5}$/.test(value);
        },
        message: '邮政编码不存在'
    },
    QQ: {
        validator: function (value, param) {
            return /^[1-9]\d{4,10}$/.test(value);
        },
        message: 'QQ号码不正确'
    },
    mobile: {
        validator: function (value, param) {
            return /^((\(\d{2,3}\))|(\d{3}\-))?13\d{9}$/.test(value);
        },
        message: '手机号码不正确'
    },
    loginName: {
        validator: function (value, param) {
            return /^[\u0391-\uFFE5\w]+$/.test(value);
        },
        message: '登录名称只允许汉字、英文字母、数字及下划线。'
    },
    safepass: {
        validator: function (value, param) {
            return safePassword(value);
        },
        message: '密码由字母和数字组成，至少6位'
    },
    equalTo: {
        validator: function (value, param) {
            return value == $(param[0]).val();
        },
        message: '两次输入的字符不一致'
    },
    number: {
        validator: function (value, param) {
            return /^\d+$/.test(value);
        },
        message: '请输入数字'
    },
    idcard: {
        validator: function (value, param) {
            return idCard(value);
        },
        message: '请输入正确的身份证号码'
    },
    regexRemote: {
        validator: function (value, param) {
            var _2c = {};
            if (param.length > 3) {
                var reg = param[3].test(value);
                if (!reg) {
                    return false;
                }
            }
            //_2c[_2b[1]] = _2a;
            //var _2d = $.ajax({ url: _2b[0], dataType: "json", data: _2c, async: false, cache: false, type: "post" }).responseText;
            //return _2d == "true";
            var data = param[2];
            data[param[1]] = value;
            //var result = $.ajax({ url: param[0], dataType: "json", data: data, async: false, cache: false, type: "post" }).responseText;
            //return result=='true';
            var success = true;
            var result;
            $.ajax({
                url: param[0],
                dataType: "json",
                data: data,
                async: false,
                cache: false,
                type: "post",
                success: function (d) {
                    result = d;
                }
            });
            this.message = result.text;
            success = result.success;
            return success;
        },
        message: '字段重复'
    }
});