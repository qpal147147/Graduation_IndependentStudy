<?php
	session_start();

	$servername = "localhost";
	$username = "u882696006_datauser";
	$password = "datapass";
	$dbname = "u882696006_project";

	// Create connection
	$conn = mysqli_connect($servername, $username, $password, $dbname);
	// Check connection
	if (!$conn) {
		die("Connection failed: " . mysqli_connect_error());
	}
	
	$product = mysqli_query($conn,"SELECT * FROM stock");//查詢剩餘量

//	$sql = "DELETE FROM proorder"; //刪除語法
	//sava DB
	if(!empty($_SESSION['Scart'])){	
		foreach($_SESSION['Scart'] as $key){
			$row = mysqli_fetch_assoc($product);


			if($key["number"] != 0){
				$id = $key['id'];
				$name = $key['name'];
				$number = $key['number'];
				$time = $key['time'];

				if($number <= $row['number']){//若訂購數量小於剩餘量
					$sql = "INSERT INTO proorder (id, name, number,time)
					VALUES ('$id', '$name', '$number','$time')"; //存入資料

					if(!(mysqli_query($conn, $sql))){
						echo "Error: " . $sql . "<br>" . mysqli_error($conn);
					}

					$stock = "UPDATE stock SET number = number - '$number' WHERE name = '$name'"; //減少倉庫庫存

					if(!(mysqli_query($conn, $stock))){
						echo "Error: " . $stock . "<br>" . mysqli_error($conn);
					}
				}
				else{
					echo "<script type='text/javascript'>alert('訂購失敗!\\n訂購量超過剩餘數量\\n點擊\"確定\"後將關閉視窗');</script>";//提示窗，多/跳脫字元
					echo "<script type='text/javascript'>window.close();</script>";//關閉視窗
				}
			}
		}
		echo "<h1>訂單已送出!</h1>";
	}
	else {
		echo "<h1>請勿重新載入頁面!</h1>";
	}
	
	mysqli_close($conn);
	session_destroy();//清空session
?>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" href="/style/css/milligram.css"><!--引入外部css-->
		<title>訂料頁面</title>
		<style>
			body{
				background-color: #f2f2f2;
				background-image: url("/style/image/train.png");
				background-repeat: no-repeat;
				background-attachment:fixed;
				background-position:center;
			}
		</style>
		<script>
			var i = 4;
			function timer(){
				var myVar = setInterval(closeWindow, 1000);
			}

			function closeWindow(){
				if(i == 0) window.close();
				document.getElementById("EndSecond").innerHTML = i;
   				i -=1;
			}
		</script>
	</head>
    <body>
		<h4><span id="EndSecond">5</span>秒後將關閉本頁面!</h4>
		<script>timer();</script><!--關閉視窗-->
    </body>
</html>
