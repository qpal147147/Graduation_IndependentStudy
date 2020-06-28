<?php
	session_start();
	
	$nameArray = array("齒輪","釘子","軸承","電晶體","彈簧");
	date_default_timezone_set("Asia/Taipei");//設定時區
	$time = date("Y-m-d H:i:s");
	
	if(isset($_POST["num"])&&isset($_POST["id"])){
		for($i = 0;$i<sizeof($nameArray);$i++){
			$array["cart"][] = array(
			"id" => $_POST["id"],
			"name" => $nameArray[$i],
			"number" => $_POST["num"][$i],
			"time" => $time
			);
		}
	}
	else{
		die("您尚未訂購物品!");
	}
	
	$_SESSION['Scart'] = $array['cart'];
	
	/*foreach($array["cart"] as $key){
		echo "id= " . $key["id"] . "<br>";
		echo "name= " . $key["name"] . "<br>";
		echo "number= " . $key["number"] . "<br>";
	}*/
?>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" href="/style/css/milligram.css"><!--引入外部css-->
        <title>預覽表單</title>
		<style>
			body{
				background-color: #f2f2f2;
				background-image: url("/style/image/train.png");
				background-repeat: no-repeat;
				background-attachment:fixed;
				background-position:center 200%;
			}
			input[type=button],button{
				font-size: 1.4rem;
				height:4.5rem;
				line-height:4.5rem;
				padding:0 2rem;
			}
		</style>
	</head>
	
	<body dir="ltr">
		<div style="background-color: rgba(255, 255, 255, 0.8);padding:10px;">
			<table style="width:100%">
				<h2 style="text-align: center;">
					<p>
						<b>您的位置:<?php echo $_POST["id"]?></b>
					</p>
				</h2>
				<tr>
					<th>物品名稱</th>
					<th>數量</th>
					<th>訂購時間</th>
				</tr>
				<?php
					foreach($array['cart'] as $key){
						echo "<tr>";
						if($key["number"] != 0){
							echo "<td>" . $key["name"] . "</td>";
							echo "<td>" . $key["number"] . "</td>";
							echo "<td>" . $key["time"] . "</td>";
						}
						echo "</tr>";
					}
				?>
			</table>
		</div>
		<p>
			<input type="button" value="關閉視窗" onclick="window.close()">
			<a href="Session.php" onclick= "return confirm('確定送出?')"><button>確定送出</button></a>
		</p>
	</body>
</html>