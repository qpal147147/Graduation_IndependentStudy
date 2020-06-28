<?php
    session_start();
    if(!empty($_SESSION['hasLogin'])) unset($_SESSION['hasLogin']);
?>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link rel="stylesheet" type="text/css" href="/style/css/semantic.css">

        <title>Login</title>

        <style type="text/css">
            body{
				background-color: #f2f2f2;
			}
            .LoginWindow{
                width:30%;
                margin:0px auto;
                transform: translateY(50%);
            }
            @media only screen and (max-width: 768px) {
  				/* phones */
  				.LoginWindow{
                    width:100%;
                }
			}
        </style>
    </head>
    <body>
        <div class="LoginWindow">
            <h1 class="ui blue image header">
                <img src="/style/image/order.png" class="image">
                <div class="content">
                管理訂單系統
                </div>
            </h1>

            <form  class="ui segment form" action='Manager.php' method="post">
                <div class="field">
                    <label>帳號:</label>
                    <input type="text" name="account" placeholder="Account" required="required">
                </div>
                <div class="field">
                    <label>密碼</label>
                    <input type="password" name="password" placeholder="Password" required="required">
                </div>
                <input class="fluid brown ui button" type="submit" value="送出" required="required">
            </form>
        </div>
    </body>
</html>