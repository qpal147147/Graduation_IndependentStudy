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

//判斷是否登入
if(!empty($_SESSION['hasLogin']) || isset($_POST['account']) && isset($_POST['password'])){
	$staff = mysqli_query($conn,"SELECT * FROM Staff"); //員工表單
	if(!$staff){
		die("error");
	}

	$staffData = mysqli_fetch_assoc($staff); //員工資料列
	$staffAccount = $staffData['account']; //員工帳號
    $staffPassword = $staffData['password']; //員工密碼

	//判斷帳號密碼是否正確
	if(!empty($_SESSION['hasLogin']) || ($_POST['account'] == $staffAccount && $_POST['password'] == $staffPassword)){
		$_SESSION['hasLogin'] = 'Y';

		$sql = "SELECT * FROM proorder ORDER BY tablekey DESC"; //預設範圍資料
		$SETTime = mysqli_query($conn,"SELECT DISTINCT time FROM proorder"); //不重複搜尋資料、顯示有幾筆訂單
		$SETid = mysqli_query($conn,"SELECT DISTINCT id,CASE id 
									when '1號廠' THEN '1' 
									when '2號廠' THEN '2' 
									else '3' END AS '代號' 
									FROM proorder where state='處理中' ORDER BY `代號` ASC"); //不重複處理中id名稱

		$qString = "";//ESP8266 字串
		while($row = mysqli_fetch_assoc($SETid)){
			$qString .= $row['代號']; //串接字串
		}
		if($qString != "")$qString .= ":"; //結束符號

		if(isset($_GET['state'])){ //決定資料顯示範圍
			if($_GET['state'] == 1){ //全部顯示
				header('Location: Manager.php');
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

		//功能function
		//清除全部資料
		if(isset($_POST['allClear'])){
			$sql = "DELETE FROM proorder";
			$query = mysqli_query($conn, $sql);
			header('Location: Manager.php');
		}
		//清除選擇資料
		if(isset($_POST['selectClear'])){
			if(isset($_POST['checkbox'])){
				for($i=0;$i<$datanumber;$i++){ //搜尋出所選資料之主鍵
					$row = mysqli_fetch_assoc($result);
					for($j=0;$j<sizeof($_POST['checkbox']);$j++){
						if($i == $_POST['checkbox'][$j]){
							$searchKey[] = $row['tablekey'];  	//儲存主鍵
							$searchNumber[] = $row['number']; 	//儲存該數量
							$searchName[] = $row['name']; 		//儲存該名稱
						}
					}
				}
			}
			if(!empty($searchKey)){ //刪除主鍵所在列之資料
				for($i = 0;$i < sizeof($searchKey);$i++){
					$key = $searchKey[$i];
					$number = $searchNumber[$i];
					$name = $searchName[$i];

					$sql = "UPDATE stock SET number = number + $number WHERE name = '$name'"; //將沒送出的物品增加回去
					$query = mysqli_query($conn, $sql);

					$sql = "DELETE FROM proorder WHERE tablekey= $key"; //再刪除該筆資料
					$query = mysqli_query($conn, $sql);
				}
			}
			header('Location: Manager.php');
		}
		//清除一單資料
		if(isset($_POST['btn_clrList'])){
			for($i=0;$i<$datanumber;$i++){ //搜尋出所選資料之主鍵
				$row = mysqli_fetch_assoc($result);
				if(strtotime($row['time']) == $_POST['btn_clrList']){
					$searchKey[] = $row['tablekey'];  	//儲存主鍵
					$searchNumber[] = $row['number']; 	//儲存該數量
					$searchName[] = $row['name']; 		//儲存該名稱
				}
			}
				
			for($i = 0;$i < sizeof($searchKey);$i++){
				$key = $searchKey[$i];
				$number = $searchNumber[$i];
				$name = $searchName[$i];

				$sql = "SELECT * FROM proorder WHERE tablekey= $key AND state='已處理'";//檢查是否是已處理狀態
				$query = mysqli_query($conn, $sql);
				if(mysqli_num_rows($query) > 0){ //若搜尋到已處理狀態的數量>0則備份
					$sql = "INSERT INTO HistoricalOrder (id,name,number,time,sendTime,endTime,state)SELECT id,name,number,time,sendTime,endTime,state FROM proorder WHERE tablekey= $key";//備份到歷史訂單資料庫裡
					$query = mysqli_query($conn, $sql);
				}
				else{
					$sql = "UPDATE stock SET number = number + $number WHERE name = '$name'"; //將沒送出的物品增加回去
					$query = mysqli_query($conn, $sql);
				}
					
				$sql = "DELETE FROM proorder WHERE tablekey= $key";
				$query = mysqli_query($conn, $sql);
			}
			header('Location: Manager.php');
		}
		//選擇訂單狀態
		if(isset($_POST['decideState'])){
			for($i=0;$i<$datanumber;$i++){ //搜尋出所選資料之主鍵
				$row = mysqli_fetch_assoc($result);
				if(strtotime($row['time']) == $_POST['decideState']){
					$searchKey[] = $row['tablekey'];
				}
			}

			$orderState = "";
			if(isset($_POST['process'])){
				if($_POST['process'] == 'Unprocessed')$orderState = "待處理";
				else if($_POST['process'] == 'Processing')$orderState = "處理中";
				else $orderState = "已處理";
			}

			$stateTime = date('Y-m-d H:i:s');
			foreach($searchKey as $key){
				$sql = "UPDATE proorder SET state= '$orderState' WHERE tablekey= $key";//狀態更新
				$query = mysqli_query($conn, $sql);

				if($orderState == "處理中"){
						$sql = "UPDATE proorder SET sendTime='$stateTime' WHERE tablekey= $key";
						$query = mysqli_query($conn, $sql);

						$presrtTime = date('Y-m-d H:i:s',mktime(8,0,0,1,1,1970));//將已處理時間重製
						$sql = "UPDATE proorder SET endTime='$presrtTime' WHERE tablekey= $key";
						$query = mysqli_query($conn, $sql);
				}
				else if($orderState == "已處理"){
					$sql = "UPDATE proorder SET endTime='$stateTime' WHERE tablekey= $key";
					$query = mysqli_query($conn, $sql);

					//$sql = "INSERT INTO HistoricalOrder (id,name,number,time,sendTime,endTime,state)SELECT id,name,number,time,sendTime,endTime,state FROM proorder WHERE tablekey= $key";//備份到歷史訂單資料庫裡
					//$query = mysqli_query($conn, $sql);

					//$sql = "DELETE FROM proorder WHERE tablekey= $key";//刪除紀錄
					//$query = mysqli_query($conn, $sql);
				}
				else{
					$presrtTime = date('Y-m-d H:i:s',mktime(8,0,0,1,1,1970));
					$sql = "UPDATE proorder SET sendTime='$presrtTime' WHERE tablekey= $key";
					$query = mysqli_query($conn, $sql);
					$sql = "UPDATE proorder SET endTime='$presrtTime' WHERE tablekey= $key";
					$query = mysqli_query($conn, $sql);
				}
			}
			header('Location: Manager.php');
		}
		//儲存使用者輸入IP
		if(empty($_SESSION['IP']))$_SESSION['IP'] = "192.168.43.99";
		$userIP = $_SESSION['IP'];

		if(isset($_POST['UserIP'])){
			if(isset($_POST['IP'])){
				$userIP = $_SESSION['IP'] = $_POST['IP'];
				echo "<script type='text/javascript'>alert('已儲存IP位置!');</script>";//提示窗
				echo("<script>window.location = 'Manager.php';</script>");//跳轉頁面
			}
		}
	}
	else{
		mysqli_close($conn);
		echo "<script type='text/javascript'>alert('帳號或密碼錯誤!');</script>";
		echo("<script type='text/javascript'>window.location = 'loginManager.php';</script>");//跳轉頁面

	}
}
else{
	mysqli_close($conn);
	echo "<script type='text/javascript'>alert('請先登入!');</script>";
	echo("<script type='text/javascript'>window.location = 'loginManager.php';</script>");//跳轉頁面
}
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
		<title>管理訂單</title>
		<style>
			/*table, th, td {
				border: 1px black solid;
				border-collapse: collapse;
			}*/
			body{
				background-color: #f2f2f2;
			}
			.title{
				display:flex;
			}
			.LeftTitle{
				text-align:center;
				width:100%;
				margin-left: 20%;
			}
			.RightTitle{
				margin-right: 10%;
				text-align:center;
			}
			.LowerRight_slideTitle{
				background-color:black;
				color: white;
				width:35%;
				position:fixed;
				right:0;
				bottom:0px;
				text-align:center; 
				padding:5px;
			}
			.LowerRight_slideDIV{
				background-color:white;
				width:35%; 
				height:350px; 
				position:fixed; 
				right:0; 
				bottom:0; 
				display:none;
				text-align:center; 
				border:1px solid black
			}
			@media only screen and (max-width: 930px) {
  				/* phones */
  				.title {
   					display:inline-table;
  				}
				.LeftTitle{
					margin-left:0%;
				}
				.RightTitle{
					margin-right: 0%;
				}
				.Right_Img{
					width: 50%;
					height: 50%;
				}
			}
		</style>
		<script>
			//加載頁面完成後自動執行
			$(function(){
                setInterval(autoRefreshPosition,2000);//每秒自動更新
            });
			//ajax自動抓取資料
			var record;

            function autoRefreshPosition (){
                $.get("position.php", function(result){
				    if(result == 0){	//原點
						$('.pos').text("運送車目前在原點");
					   $('.posSrc').attr("src",'/style/image/ZeroNum.gif');
					}
					else if(result == 1){	//1號點
						$('.pos').text("運送車目前在" + result + "號點");
						$('.posSrc').attr("src",'/style/image/OneNum.gif');
					}
					else if(result == 2){	//2號點
						$('.pos').text("運送車目前在" + result + "號點");
						$('.posSrc').attr("src",'/style/image/TwoNum.gif');
					}
					else if(result == 3){	//3號點
						$('.pos').text("運送車目前在" + result + "號點");
						$('.posSrc').attr("src",'/style/image/ThreeNum.gif');
					}
					else if(result == 4){	//出發時
						$('.pos').text("移動中...");
						$('.posSrc').attr("src",'/style/image/ZeroToOne.gif');
					}
					else if(result == 5){	//停留在1~2之間
						if(result - record == 1){	//若某點沒停駛，表現流暢動畫效果
							$('.posSrc').attr("src",'/style/image/OneNum.gif');
							setTimeout(function(){
								$('.posSrc').attr("src",'/style/image/OneToTwo.gif');
							},1000);
						}
						else{
							$('.pos').text("移動中...");
							$('.posSrc').attr("src",'/style/image/OneToTwo.gif');
						}
					}
					else if(result == 6){	//停留在2~3之間
						if(result - record == 1){	//若某點沒停駛，表現流暢動畫效果
							$('.posSrc').attr("src",'/style/image/TwoNum.gif');
							setTimeout(function(){
								$('.posSrc').attr("src",'/style/image/TwoToThree.gif');
							},1000);
						}
						else{
							$('.pos').text("移動中...");
							$('.posSrc').attr("src",'/style/image/TwoToThree.gif');
						}
					}
					else if(result == 7){	//停留在3~0之間
						if(result - record == 1){	//若某點沒停駛，表現流暢動畫效果
							$('.posSrc').attr("src",'/style/image/ThreeNum.gif');
							setTimeout(function(){
								$('.posSrc').attr("src",'/style/image/ThreeToZero.gif');
							},1000);
						}
						else{
							$('.pos').text("移動中...");
							$('.posSrc').attr("src",'/style/image/ThreeToZero.gif');
						}
					}

					record = result;	//紀錄上一點值，判斷是否過站
                });
            }
			//控制網頁右下角展開圖
			$(document).ready(function(){	//頁面加載完畢
				$(".LowerRight_slideTitle").click(function(){	//點擊文字後觸發
					if(parseInt($(".LowerRight_slideTitle").css("bottom")) >0){		//若展開
						$(".LowerRight_slideDIV").slideToggle("slow");
						$(".LowerRight_slideTitle").animate({bottom:"0px"},"slow");
						$("#clickTitle").text("點擊展開");
						$("#clickImage").attr("src","/style/image/Up.png")
					}
					else{	//若收合
						$(".LowerRight_slideDIV").slideToggle("slow");
						$(".LowerRight_slideTitle").animate({bottom:"350px"},"slow");
						$("#clickTitle").text("點擊收合");
						$("#clickImage").attr("src","/style/image/Low.png")
					}
				});
			});
			/*function SelectAlert(){ //選擇框選擇提示
				alert(' "已處理"訂單將會刪除!');
			}
			function Click(){
				return confirm('確定刪除?');
			}*/
			
			//傳送位置至ESP8266
			<?php
				if(isset($_POST['transport'])){
					file_put_contents("position.txt",4);
					echo "$.get('http://' + '$userIP' + ':8888/q=' + '$qString',function(){
							
						});";
					echo "alert('已送出資料!');";
				}
			?>
		</script>
	</head>
	<body dir="ltr">
		<?php
			$SETDataNumber =  mysqli_num_rows($SETTime);//取得不重複資料數目
			echo "<div class='title'>
					<div class='LeftTitle'>
						<p>
							<h1>總共有" . $SETDataNumber . "筆訂單</h1>
						</p>
						<div>
							<button class='ui primary button' data-tooltip='將處理中的資料寄送到運送車' data-position='left center' data-inverted='' name='transport' type='submit' form='functionForm'>確定運送</buton>
						</div>

						<div>
							<div style='display:inline-block;'>
								<button class='ui primary button' name='UserIP' type='submit' form='functionForm'>設定IP</buton>
							</div>
							<div class='ui input focus' style='display:inline-block;'>
								<input  type='text' placeholder='$userIP' pattern='\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' title='請輸入正確的IP格式' name='IP' form='functionForm'>
							</div>
						</div>
					</div>

					<div class='RightTitle'>
						<h1 class='pos'>讀取中...</h1>
						<img class='posSrc Right_Img' src='/style/image/train.png' alt='Train Position Now' width='75%' height='75%'>
					</div>
				</div>";

			echo "<div style='float:right;'>
					<form  action='Manager.php' method='get'>
						<select style='padding:10px; border-radius:20px; border:2px black solid;' name=state onChange='this.form.submit()'>
							<option disabled selected value>選擇選項</option>
							<option  value='1'>全部檢視</option>
							<option  value='2'>待處理</option>
							<option  value='3'>處理中</option>
							<option value='4'>已處理</option>
						</select>
					</form> 
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
					echo 	"<select class='ui dropdown' name='process' form='functionForm'>
								<option disabled selected value>選擇選項</option> 
								<option value='Unprocessed'>待處理</option> 
								<option value='Processing'>處理中</option> 
								<option value='Processed'>已處理</option> 
							</select>";//選取狀態  onchange='if (this.selectedIndex == 3) SelectAlert()'
					echo 	"<button class='ui secondary button' data-tooltip='選擇左側訂單狀態' data-position='top left' data-inverted='' name='decideState' type='submit' value= $time form='functionForm' >確定</button>&emsp;";//決定狀態
					echo 	"<button class='ui red button' data-tooltip='將刪除此筆訂單' data-position='top left' data-inverted='' name ='btn_clrList' type='submit' value= $time form='functionForm'>刪除此單</button>&emsp;";//刪除一個訂單
					echo 	"<input class='ui red button' type='submit' value='選擇清除' name='selectClear' form='functionForm'>";//選擇刪除一筆資料
					echo 	"<table style='width:100%' class='ui unstackable selectable celled teal large table'>
								<thead>
									<tr>
										<th>選取框</th>
										<th>物品名稱</th>
										<th>數量</th>
									</tr>
								 </thead>
								 <tbody>
									<tr>
										<td> 
											<div class='ui toggle checkbox'>
												<input type='checkbox' name='checkbox[]' value=$i form='functionForm'>
												<label></label>
											</div>
										</td>
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
					echo 	"<select class='ui dropdown' name='process' form='functionForm'>
								<option disabled selected value>選擇選項</option> 
								<option value='Unprocessed'>待處理</option> 
								<option value='Processing'>處理中</option> 
								<option value='Processed'>已處理</option> 
							</select>";//選取狀態  onchange='if (this.selectedIndex == 3) SelectAlert()'
					echo 	"<button class='ui secondary button' data-tooltip='選擇左側訂單狀態' data-position='top left' data-inverted='' name='decideState' type='submit' value= $time form='functionForm' >確定</button>&emsp;";//決定狀態
					echo 	"<button class='ui red button' data-tooltip='將刪除此筆訂單' data-position='top left' data-inverted='' name ='btn_clrList' type='submit' value= $time form='functionForm'>刪除此單</button>&emsp;";//刪除一個訂單
					echo 	"<input class='ui red button' type='submit' value='選擇清除' name='selectClear' form='functionForm'>";//選擇刪除一筆資料
					echo 	"<table style='width:100%' class='ui unstackable selectable celled teal large table'>
								<thead>
									<tr>
										<th>選取框</th>
										<th>物品名稱</th>
										<th>數量</th>
									</tr>
								 </thead>
								 <tbody>
									<tr>
										<td> 
											<div class='ui toggle checkbox'>
												<input type='checkbox' name='checkbox[]' value=$i form='functionForm'>
												<label></label>
											</div>
										</td>
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
					echo 	"<select class='ui dropdown' name='process' form='functionForm'> 
								<option disabled selected value>選擇選項</option> 
								<option value='Unprocessed'>待處理</option> 
								<option value='Processing'>處理中</option> 
								<option value='Processed'>已處理</option> 
							</select>";//選取狀態
					echo 	"<button class='ui secondary button' data-tooltip='選擇左側訂單狀態' data-position='top left' data-inverted='' name='decideState' type='submit' value=$time form='functionForm'>確定</button>&emsp;";//決定狀態
					echo 	"<button class='ui red button' data-tooltip='將刪除此筆訂單' data-position='top left' data-inverted='' name ='btn_clrList' type='submit' value=$time form='functionForm'>刪除此單</button>&emsp;";//刪除一個訂單
					echo 	"<input class='ui red button' type='submit' value='選擇清除' name='selectClear' form='functionForm'>";//選擇刪除一筆資料
					echo 	"<table style='width:100%' class='ui unstackable selectable celled teal large table'>
								<thead>
									<tr>
										<th>選取框</th>
										<th>物品名稱</th>
										<th>數量</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>
											<div class='ui toggle checkbox'>
												<input type='checkbox' name='checkbox[]' value='$i' form='functionForm'>
												<label></label>
											</div>
										</td>
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
					echo 	"<select class='ui dropdown' name='process' form='functionForm'> 
								<option disabled selected value>選擇選項</option> 
								<option value='Unprocessed'>待處理</option> 
								<option value='Processing'>處理中</option> 
								<option value='Processed'>已處理</option> 
							</select>";//選取狀態
					echo 	"<button class='ui secondary button' data-tooltip='選擇左側訂單狀態' data-position='top left' data-inverted='' name='decideState' type='submit' value=$time form='functionForm'>確定</button>&emsp;";//決定狀態
					echo 	"<button class='ui red button' data-tooltip='將刪除此筆訂單' data-position='top left' data-inverted='' name ='btn_clrList' type='submit' value=$time form='functionForm'>刪除此單</button>&emsp;";//刪除一個訂單
					echo 	"<input class='ui red button' type='submit' value='選擇清除' name='selectClear' form='functionForm'>";//選擇刪除一筆資料
					echo 	"<table style='width:100%' class='ui unstackable selectable celled teal large table'>
								<thead>
									<tr>
										<th>選取框</th>
										<th>物品名稱</th>
										<th>數量</th>
									</tr>
								 </thead>
								 <tbody>
									<tr>
										<td>
											<div class='ui toggle checkbox'>
												<input type='checkbox' name='checkbox[]' value='$i' form='functionForm'>
												<label></label>
											</div>
										</td>
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
										<td>
											<div class='ui toggle checkbox'>
												<input type='checkbox' name='checkbox[]' value='$i' form='functionForm'>
												<label></label>
											</div>
										</td>
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
										<td>
											<div class='ui toggle checkbox'>
												<input type='checkbox' name='checkbox[]' value='$i' form='functionForm'>
												<label></label>
											</div>
										</td>
										<td>" . $row['name'] . "</td>
										<td>" . $row['number'] . "</td>";
				}
			}
		?>
		<p>
			<form action="Manager.php" method="post" id="functionForm" onsubmit="return confirm('是否進行此操作?');">
				<!--<input class="ui primary button" type="submit" value="全部清除" name="allClear">  危險功能，諸多bug-->
				<input class="ui primary button" type="submit" value="選擇清除" name="selectClear">
			</form>
		</p>

		<!-- 右下角展開圖 -->
		<div class="LowerRight_slideTitle">
			<span id="clickTitle">點擊展開</span>
			<img id="clickImage" style="vertical-align:middle; width:20px" src="/style/image/Up.png" alt="Indicator">
		</div>
		<div class="LowerRight_slideDIV">
			<h1 class='pos'>讀取中...</h1>
			<img class='posSrc' src="/style/image/train.png" alt="Train Position Now" width="75%" height="75%">
		</div>
	</body>
</html>
<?php
	mysqli_close($conn);
?>