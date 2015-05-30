//set the email and password.
function setting(email,pass) {
        if(email==="")
            return "信箱為空！";
        else if(pass==="")
            return "密碼為空！";
        else {
            addAccount(email,pass);
            return "設定完成！";
        }
}
//reset the email and password.
function reset() {
    db.transaction(
        function(tx) {
            // Create the database if it doesn't already exist
            tx.executeSql('CREATE TABLE IF NOT EXISTS account(email TEXT, password TEXT)');
            //delete the acccounts table.
            var accounts = tx.executeSql("DELETE * FROM accounts");
            return "重新設定成功！";
        })
}
//using XMLHttpRequest post email and password to login automatically.
function autoLogin(email,password) {
        var url = new Array;
        if(email==="") {
            console.log("email empty!")
        }
        else if(password==="") {
            console.log("password empty!")
        }
        else {
            //do httprequest post data to the login url.
            var result = httpGet("https://google.com.tw");
            var data = "";
            if(result==="need_auth") {
                url[0] = "http://10.1.230.254:1000/fgtauth?";
                url[1] = "http://www.gstatic.com/generate_204";
                data = "username=your-school-email&password=your-pwd&4Tredir=http://google.com.tw&magic=";
                httpPost(url,data,"need_auth");
            }
            else if(result==="need_auth2") {
                url[0] = "";
                url[1] = "";
            }
            else {
                return result;
            }
        }
}
//add email and password
//object openDatabaseSync(string name, string version, string description, int estimated_size, jsobject callback(db))
//LocalStorage ref: http://doc.qt.io/qt-5/qtquick-localstorage-qmlmodule.html
function addAccount(email,password) {
            var db = connectDB();
            db.transaction(
                function(tx) {
                    // Create the database if it doesn't already exist
                    tx.executeSql('CREATE TABLE IF NOT EXISTS account(email TEXT, password TEXT)');
                    //check the acccounts table row length
                    var accounts = tx.executeSql("SELECt * FROM accounts");
                    if(accounts.rows.length!==0) {
                        return "帳號只能設定一組！";
                    }
                    else {
                        // Add (another) account row
                        //tx.executeSql("SQL syntax.", Array())
                        tx.executeSql('INSERT INTO account VALUES(?, ?)', [email , password ]);
                        return "帳號設定成功！";
                    }
                })
}
/*
    get accounts about email and password.When components are loaded completely, it will set the email's textField
    and password's textField
*/
function getAccounts() {
    var db = connectDB();
    var result = new Array;
    db.transaction(
        function(tx) {
             tx.executeSql('CREATE TABLE IF NOT EXISTS account(email TEXT, password TEXT)');
            var accounts = tx.executeSql("SELECt * FROM account");
            for(var acc_count = 0; acc_count < accounts.rows.length; acc_count++) {
                result[0] = rs.rows.item(i).email;
                result[1] = rs.rows.item(i).password;
            }

        });
    return result;
}

//initial DB connection.
function connectDB() {
    var db = LocalStorage.openDatabaseSync("accountDB", "1.0", "The Example QML SQL!", 1000000);
    return db;
}

//using XMLHttpRequest create function called http_get
function httpGet(url) {
    var doc = new XMLHttpRequest();
    doc.open("GET", url);
    doc.onreadystatechange = function() {
        if (doc.readyState === XMLHttpRequest.DONE) {
            var web_page = doc.responseText;

            if(web_page.indexOf("台東大學無線網路驗證系統")===0) {
                return "need_auth";
            }
            else if(web_page.indexOf("USERNAME")===0) {
                return "need_auth2";
            }

            else {
                    return "已經正在上網或是不在學校網域內！";
            }
        }
     }
    doc.setRequestHeader("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8");
    doc.setRequestHeader("User-Agent", "Mozilla/5.0 (X11; Linux i686 (x86_64)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.81 Safari/537.36");
    doc.send();
}

function httpPost(url,data,type) {
    if(type==="need_auth") {


    }
}
