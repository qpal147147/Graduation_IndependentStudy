<?php
session_start();

$servername = "localhost";
$username = "u882696006_datauser";
$password = "datapass";
$dbname = "u882696006_project";
date_default_timezone_set("Asia/Taipei");//設定時區
// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname);
// Check connection
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

$sql = "SELECT * FROM proorder ORDER BY tablekey DESC"; //預設範圍資料
$SETTime = mysqli_query($conn,"SELECT DISTINCT time FROM proorder"); //不重複搜尋資料、顯示有幾筆訂單
$SETid = mysqli_query($conn,"SELECT DISTINCT id,CASE id 
							when '1號廠' THEN '1' 
							when '2號廠' THEN '2' 
							else '3' END AS '代號' 
							FROM proorder where state='處理中' ORDER BY `代號` ASC"); //不重複處理中id名稱


if(isset($_GET['state'])){ //決定資料顯示範圍
	if($_GET['state'] == 1){ //全部顯示
		header('Location: viewOrder.php');
	}
	else if($_GET['state'] == 2){ //只顯示待處理
		$sql = "SELECT * FROM proorder where state = '待處理' ORDER BY tablekey DESC";
		$SETTime = mysqli_query($conn,"SELECT DISTINCT time FROM proorder where state = '待處理'");
	}
	else if($_GET['state'] == 3){ //只顯示處理中
		$sql = "SELECT * FROM proorder where state = '處理中' ORDER BY tablekey DESC";
		$SETTime = mysqli_query($conn,"SELECT DISTINCT time FROM proorder where state = '處理中'");
	}
	else{ //只顯示已處理
		$sql = "SELECT * FROM proorder where state = '已處理' ORDER BY tablekey DESC";
		$SETTime = mysqli_query($conn,"SELECT DISTINCT time FROM proorder where state = '已處理'");
	}
}

$result = mysqli_query($conn,$sql); //倒序顯示
if(!$result){
	die("error");
}

$datanumber = mysqli_num_rows($result); //全部訂單資料總數

?>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta http-equiv="refresh" content="90"><!--90秒刷新一次頁面-->
		<link rel="stylesheet" href="/style/css/semantic.css"><!--引入外部css-->
		<script src="/style/js/semantic.js"></script><!--引入外部js-->
		<script src ="/style/js/jquery-3.4.1.min.js"></script><!-- jquery -->
		<title>檢視訂單</title>
		<style>
			/*table, th, td {
				border: 1px black solid;
				border-collapse: collapse;
			}*/
			body{
				background-color: #f2f2f2;
			}
		</style>
		<script>//Client方法
			function SelectAlert(){ //選擇框選擇提示
				alert(' "已處理"訂單將會刪除!');
			}
			function Click(){
				return confirm('確定刪除?');
			}
		</script>
	</head>
	<body dir="ltr">
		<?php
			$SETDataNumber =  mysqli_num_rows($SETTime);//取得不重複資料數目
			echo "<button class='ui primary button' onclick='history.back()'>回上頁</button>";
			echo "<div>
					<p>
						<h1 style='text-align:center;'>總共有" . $SETDataNumber . "筆訂單</h1>
					</p>

					<div style='text-align:right;'>
						<form  action='viewOrder.php' method='get'>
							<select style='padding:10px; border-radius:20px; border:2px black solid;' name = state onChange='this.form.submit()'>
								<option disabled selected value>選擇選項</option>
								<option  value='1'>全部檢視</option>
								<option  value='2'>待處理</option>
								<option  value='3'>處理中</option>
								<option value='4'>已處理</option>
							</select>
						</form> 
					</div>
				</div>"; //選擇資料所選擇的範圍
			$time; //設置時間變數
			$sendTime = "";
			$endTime = "";
			for($i = 0;$i<$datanumber;$i++){ //循環每個資料
				$row = mysqli_fetch_assoc($result); //將每列資料取出來

				//設置狀態字體顏色
				$color = "black";
				if($row['state'] == "待處理")$color = "red";
				else if($row['state'] == "處理中")$color = "orange";
				else $color="green";

				//訂單資料
				if($datanumber == 1){ //如果是第一筆也是最後一筆
					$time = strtotime($row['time']); //儲存時間
					echo "<div>
							<h2>位置:" . $row['id'] ."&emsp;時間:" . date("Y-m-d / H:i:s",$time) . "&emsp;&emsp;" . "<span style='color:$color'>狀態:" . $row['state'] . "</span></h2>
							<h3>送貨時間:" . (strtotime($row['sendTime']) == 0?  '' : date("Y-m-d / H:i:s",strtotime($row['sendTime'])))  . "</h3>
						 	<h3>送達時間:" . (strtotime($row['endTime']) == 0?  '' : date("Y-m-d / H:i:s",strtotime($row['endTime']))) . "</h3>";//顯示訂單狀況
					echo 	"<table style='width:100%;' class='ui unstackable selectable celled teal large table'>
								<thead>
									<tr>
										<th>物品名稱</th>
										<th>數量</th>
									</tr>
								 </thead>
								 <tbody>
									<tr>
										<td>" . $row['name'] . "</td>
										<td>" . $row['number'] . "</td>
									</tr>
								</tbody>
							</table>
						</div>";
				}
				else if($i == 0){ //如果資料為第一筆但不為最後一筆
					$time = strtotime($row['time']); //儲存時間
					echo "<div>
							<h2>位置:" . $row['id'] ."&emsp;時間:" . date("Y-m-d / H:i:s",$time) . "&emsp;&emsp;" . "<span style='color:$color'>狀態:" . $row['state'] . "</span></h2>
							<h3>送貨時間:" . (strtotime($row['sendTime']) == 0?  '' : date("Y-m-d / H:i:s",strtotime($row['sendTime'])))  . "</h3>
						 	<h3>送達時間:" . (strtotime($row['endTime']) == 0?  '' : date("Y-m-d / H:i:s",strtotime($row['endTime']))) . "</h3>";//顯示訂單狀況
					echo 	"<table style='width:100%;' class='ui unstackable selectable celled teal large table'>
								<thead>
									<tr>
										<th>物品名稱</th>
										<th>數量</th>
									</tr>
								 </thead>
								 <tbody>
									<tr>
										<td>" . $row['name'] . "</td>
										<td>" . $row['number'] . "</td>";
				}
				else if(($time != strtotime($row['time'])) && ($i != $datanumber-1)){ //如果時間不一樣且不為最後一筆
					$time = strtotime($row['time']); //儲存時間
					echo 			"</tr>
								</tbody>
							</table>
						</div>";

					echo "<div>
							<h2>位置:" . $row['id'] ."&emsp;時間:" . date("Y-m-d / H:i:s",$time) . "&emsp;&emsp;" . "<span style='color:$color'>狀態:" . $row['state'] . "</span></h2>
							<h3>送貨時間:" . (strtotime($row['sendTime']) == 0?  '' : date("Y-m-d / H:i:s",strtotime($row['sendTime'])))  . "</h3>
					 		<h3>送達時間:" . (strtotime($row['endTime']) == 0?  '' : date("Y-m-d / H:i:s",strtotime($row['endTime']))) . "</h3>";//顯示訂單狀況
					echo 	"<table style='width:100%;' class='ui unstackable selectable celled teal large table'>
								<thead>
									<tr>
										<th>物品名稱</th>
										<th>數量</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>" . $row['name'] . "</td>
										<td>" . $row['number'] . "</td>";
				}
				else if(($time != strtotime($row['time'])) && ($i == $datanumber-1)){ //如果時間不一樣且為最後一筆
					$time = strtotime($row['time']); //儲存時間
					echo 			"</tr>
								</tbody>
						 	</table>
						</div>";

					echo "<div>
							<h2>位置:" . $row['id'] ."&emsp;時間:" . date("Y-m-d / H:i:s",$time) . "&emsp;&emsp;" . "<span style='color:$color'>狀態:" . $row['state'] . "</span></h2>
						 	<h3>送貨時間:" . (strtotime($row['sendTime']) == 0?  '' : date("Y-m-d / H:i:s",strtotime($row['sendTime'])))  . "</h3>
						 	<h3>送達時間:" . (strtotime($row['endTime']) == 0?  '' : date("Y-m-d / H:i:s",strtotime($row['endTime']))) . "</h3>";//顯示訂單狀況
					echo 	"<table style='width:100%;' class='ui unstackable selectable celled teal large table'>
								<thead>
									<tr>
										<th>物品名稱</th>
										<th>數量</th>
									</tr>
								 </thead>
								 <tbody>
									<tr>
										<td>" . $row['name'] . "</td>
										<td>" . $row['number'] . "</td>
									</tr>
								</tbody>
						 	</table>
						</div>";
				}
				else if ($i == $datanumber-1){ //如果時間一樣且為最後一筆
					echo 			"</tr>
								</tbody>
								<tbody>
									<tr>
										<td>" . $row['name'] . "</td>
										<td>" . $row['number'] . "</td>
									</tr>
								</tbody>
						 	</table>
						</div>";
				}
				else{ //如果時間一樣且不為最後一筆
					echo 			"</tr>
								</tbody>
								<tbody>
									<tr>
										<td>" . $row['name'] . "</td>
										<td>" . $row['number'] . "</td>";
				}
			}
		?>
	</body>
</html>
<?php
	mysqli_close($conn);
?>