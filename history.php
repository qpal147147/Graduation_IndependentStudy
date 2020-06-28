<?php
    session_start();

    //連結資料庫
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

    //判斷是否有登入過以及是否有填寫欄位
    if(!empty($_SESSION['login']) || (isset($_POST['account']) && isset($_POST['password']))){ 
        $staff = mysqli_query($conn,"SELECT * FROM Staff"); //查詢員工資料
        $staffData = mysqli_fetch_assoc($staff); //員工資料列

        $staffAccount = $staffData['account']; //員工帳號
        $staffPassword = $staffData['password']; //員工密碼

        //判斷是否有登入過以及帳號密碼是否正確
        if(!empty($_SESSION['login']) || ($_POST['account'] == $staffAccount && $_POST['password'] == $staffPassword)){
            $_SESSION['login'] = 'Y'; //登入成功則紀錄為已登入


            date_default_timezone_set("Asia/Taipei");//設定時區

            $startDate = date('Y-m-d',strtotime("2019-01-01"));//設定預設搜尋日期
            $endDate = date('Y-m-d');//顯示用
            $nextDay = date('Y-m-d',strtotime("$endDate +1 day"));//搜索範圍 + 1Day

            //使用者選擇日期
            if(isset($_GET['startDate']) && isset($_GET['endDate'])){
                $startDate = $_GET['startDate'];

                $endDate = $_GET['endDate'];
                $nextDay = date('Y-m-d',strtotime("$endDate +1 day"));
            }
            //選擇月份
            $LineChartYear = '2019';//折線圖預設查詢年分
            if(isset($_GET['year']) && isset($_GET['month'])){
                $val = $_GET['year'] . $_GET['month'];
                $LineChartYear = $_GET['year'];//使用者所選年分
                $nextMonth =  date('Y-m-d',strtotime("$val + 1 month"));

                $startDate = date('Y-m-d',strtotime("$val"));
                $nextDay = $nextMonth;
            }
            //搜索指定範圍日期資料
            $result = mysqli_query($conn,"SELECT * FROM HistoricalOrder WHERE time >= '$startDate' AND time <= '$nextDay'");

            if(!$result){
                die("error");
            }
        }
        else{
            mysqli_close($conn);//關閉連線
            if(!empty($_SESSION['login'])) session_destroy();//清空session
            echo "<script type='text/javascript'>alert('帳號或密碼錯誤!');</script>";//提示窗
		    echo("<script>window.location = 'loginHistory.php';</script>");//跳轉頁面
        } 
    }
    else{
        mysqli_close($conn);//關閉連線
        echo "<script type='text/javascript'>alert('請先登入!');</script>";//提示窗
		echo("<script>window.location = 'loginHistory.php';</script>");//跳轉頁面
    }
?>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="/style/css/semantic.css"><!--引入外部css-->
        <script src="/style/js/echarts.min.js"></script><!-- 引入 echarts.js -->

        <title>歷史訂單</title>

        <!--<style>
			table, th, td {
				border: 1px black solid;
				border-collapse: collapse;
			}
		</style> -->
    </head>
    <body>
        <p>
            <form class="ui form" action="history.php" method="GET">
                <div class="inline field">
                    <label>選擇開始日期:</label>
                    <input type="date" name="startDate" value="<?php echo $startDate; ?>">&emsp;

                    <label>選擇結束日期:</label>
                    <input type="date" name="endDate" value="<?php echo $endDate; ?>">
                    <input class='ui secondary button' type="submit" value="送出">
                </div>
            </form>
        </p>
        <p>
            <form class="ui form" action="history.php" method="GET">
                <div class="inline field">
                    <label>選擇年分:</label>
                    <select name="year">
                        <option selected disabled value>選擇選項</option>
                        <option value="2018">2018</option>
                        <option value="2019">2019</option>
                        <option value="2020">2020</option>
                    </select>

                    <label>選擇月份:</label>
                    <select name="month">
                        <option selected disabled value>選擇選項</option>
                        <option value="0101">一月</option>
                        <option value="0201">二月</option>
                        <option value="0301">三月</option>
                        <option value="0401">四月</option>
                        <option value="0501">五月</option>
                        <option value="0601">六月</option>
                        <option value="0701">七月</option>
                        <option value="0801">八月</option>
                        <option value="0901">九月</option>
                        <option value="1001">十月</option>
                        <option value="1101">十一月</option>
                        <option value="1201">十二月</option>
                    </select>

                    <input class='ui secondary button' type="submit" value="送出">
                </div>
            </form>
        </p>
        <?php
            $dataNumber = mysqli_num_rows($result);
            $gear = $nail = $bearing = $transistor = $spring = 0;
            
        /*  for($i = 0;$i<$dataNumber;$i++){
                $row = mysqli_fetch_assoc($result);
                if($row['name'] == '齒輪')$gear += $row['number'];
                else if($row['name'] == '釘子')$nail += $row['number'];
                else if($row['name'] == '軸承')$bearing += $row['number'];
                else if($row['name'] == '電晶體')$transistor += $row['number'];
                else $spring += $row['number'];
            }
        */
        /*  $collection =  mysqli_query($conn,"SELECT name,sum(number) AS SingleSum from HistoricalOrder WHERE time >= '$startDate' AND time <= '$nextDay' group by name");//將所有數量總合並以名稱分組且設定時間為條件
            while($row = mysqli_fetch_assoc($collection)){
                if($row['name']=='齒輪')$gear = $row['SingleSum'];
                else if($row['name']=='釘子')$nail = $row['SingleSum'];
                else if($row['name']=='軸承')$bearing = $row['SingleSum'];
                else if($row['name']=='電晶體')$transistor = $row['SingleSum'];
                else $spring = $row['SingleSum'];
            }
        */
            //長條圖
            $collection =  mysqli_query($conn,"SELECT id, 
                                                sum(CASE name WHEN '齒輪' THEN number ELSE 0 END) AS '齒輪',
                                                sum(CASE name WHEN '釘子' THEN number ELSE 0 END) AS '釘子',
                                                sum(CASE name WHEN '軸承' THEN number ELSE 0 END) AS '軸承',
                                                sum(CASE name WHEN '電晶體' THEN number ELSE 0 END) AS '電晶體',
                                                sum(CASE name WHEN '彈簧' THEN number ELSE 0 END) AS '彈簧' 
                                                from HistoricalOrder WHERE time >= '$startDate' AND time <= '$nextDay' group by id"
                            );//以id為主並個別總合，最後以id分組

            $RowArray = array();//創建陣列
            while($row = mysqli_fetch_array($collection)){//將結果存入變數
                $RowArray[] = $row;//放進陣列方便操作
                $gear += $row['齒輪'];
                $nail += $row['釘子'];
                $bearing += $row['軸承'];
                $transistor += $row['電晶體'];
                $spring += $row['彈簧'];
            }
            
            if(!isset($RowArray[0])){   //如果沒有任何一筆訂單，代表陣列未定義
                $RowArray = array_merge(array(0 => array('齒輪' => 0,'釘子' => 0,'軸承' => 0,'電晶體' => 0,'彈簧' =>0)),$RowArray);
                $RowArray = array_merge(array(1 => array('齒輪' => 0,'釘子' => 0,'軸承' => 0,'電晶體' => 0,'彈簧' =>0)),$RowArray);
                $RowArray = array_merge(array(2 => array('齒輪' => 0,'釘子' => 0,'軸承' => 0,'電晶體' => 0,'彈簧' =>0)),$RowArray);
            }
            else if($RowArray[0]['id'] == '3號廠'){  //若有資料，先判斷避免RowArray第一個不是1號位置
                $RowArray = array_merge(array(0 => array('齒輪' => 0,'釘子' => 0,'軸承' => 0,'電晶體' => 0,'彈簧' =>0)),$RowArray);
                $RowArray = array_merge(array(1 => array('齒輪' => 0,'釘子' => 0,'軸承' => 0,'電晶體' => 0,'彈簧' =>0)),$RowArray);
            }
            //and other exception，no try

            //折線圖
            $AnnualLineChar = mysqli_query($conn,"SELECT name,
                                                 IFNULL(sum(case when month(time) = 1 then number end), 0) AS '一月'
                                                ,IFNULL(sum(case when month(time) = 2 then number end), 0) AS '二月'
                                                ,IFNULL(sum(case when month(time) = 3 then number end), 0) AS '三月'
                                                ,IFNULL(sum(case when month(time) = 4 then number end), 0) AS '四月'
                                                ,IFNULL(sum(case when month(time) = 5 then number end), 0) AS '五月'
                                                ,IFNULL(sum(case when month(time) = 6 then number end), 0) AS '六月'
                                                ,IFNULL(sum(case when month(time) = 7 then number end), 0) AS '七月'
                                                ,IFNULL(sum(case when month(time) = 8 then number end), 0) AS '八月'
                                                ,IFNULL(sum(case when month(time) = 9 then number end), 0) AS '九月'
                                                ,IFNULL(sum(case when month(time) = 10 then number end), 0) AS '十月'
                                                ,IFNULL(sum(case when month(time) = 11 then number end), 0) AS '十一月'
                                                ,IFNULL(sum(case when month(time) = 12 then number end), 0) AS '十二月'
                                                from HistoricalOrder WHERE YEAR(time) = '$LineChartYear' group by name"
                                );//每月份總銷售量

            $AnnualArray = array();//創建陣列
            while($row = mysqli_fetch_assoc($AnnualLineChar)){//將結果存入變數
                $AnnualArray[] = $row;//放進陣列方便操作
            }     
        ?>
            <div>
                <div id="Histogram" style="width: 50%;height:400px;float:left;"></div><!--設置一個圖表容器放置圖表-->
                <div id="MonthTable" style="width: 50%;height:400px;float:right;"></div><!--設置一個容器放置圖表-->
            </div>
            <script type="text/javascript">
                //初始化圖表
                var pix_1 = echarts.init(document.getElementById('Histogram'));
                var pix_2 = echarts.init(document.getElementById('MonthTable'));

                //柱狀圖
                var option_1 = {
                    title: {
                        text: '<?php echo $startDate .'至\n'. $endDate . '需求量'?>'//標題訂購量一覽
                    },
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: {
                            type: 'shadow'
                        }
                    },
                    legend: {},
                    dataset: {
                            //設定數據組
                        source: [
                            ['product', '總訂購量','1號廠', '2號廠', '3號廠'],
                            ['齒輪', <?php echo $gear; ?>, <?php echo $RowArray[0]['齒輪'] ?? 0; ?>, <?php echo $RowArray[1]['齒輪'] ?? 0; ?>, <?php echo $RowArray[2]['齒輪'] ?? 0; ?>],
                            ['釘子', <?php echo $nail; ?>, <?php echo $RowArray[0]['釘子'] ?? 0; ?>, <?php echo $RowArray[1]['釘子'] ?? 0; ?>, <?php echo $RowArray[2]['釘子'] ?? 0; ?>],
                            ['軸承', <?php echo $bearing; ?>, <?php echo $RowArray[0]['軸承'] ?? 0; ?>, <?php echo $RowArray[1]['軸承'] ?? 0; ?>, <?php echo $RowArray[2]['軸承'] ?? 0; ?>],
                            ['電晶體', <?php echo $transistor; ?>, <?php echo $RowArray[0]['電晶體'] ?? 0; ?>, <?php echo $RowArray[1]['電晶體'] ?? 0; ?>, <?php echo $RowArray[2]['電晶體'] ?? 0; ?>],
                            ['彈簧', <?php echo $spring; ?>, <?php echo $RowArray[0]['彈簧'] ?? 0; ?>, <?php echo $RowArray[1]['彈簧'] ?? 0; ?>, <?php echo $RowArray[2]['彈簧'] ?? 0; ?>]
                        ]
                    },
                    xAxis: {
                        type: 'category',
                        splitLine:{
                            show:'true',
                        },
                        axisLabel:{
                            fontStyle:'italic',//字形
                            fontWeight:'bolder',//字體
                            fontSize:15//字體大小
                        }
                    },
                    yAxis: {},
                    dataZoom: [
                        {type: 'inside'},//區域內縮放
                        {type: 'slider'}//滑動條縮放
                    ],
                    series: [
                        {type: 'bar'},//柱狀圖類型
                        {type: 'bar'},
                        {type: 'bar'},
                        {type: 'bar'}
                    ]
                };

                //月份銷售圖
                var option_2 = {
                    title: {
                        text: '<?php echo $LineChartYear . '年月銷售量'; ?>'
                    },
                    tooltip : {
                        trigger: 'axis',
                    },
                    legend: {
                        data:['齒輪','釘子','軸承','電晶體','彈簧']
                    },
                    toolbox: {
                        show: true,
                        feature: {
                            magicType: {show: true, type: ['stack', 'tiled']},
                        }
                    },
                    grid: {
                        left: '3%',
                        right: '4%',
                        bottom: '3%',
                        containLabel: true
                    },
                    xAxis : [
                        {
                            type : 'category',
                            boundaryGap : false,
                            data : ['一月','二月','三月','四月','五月','六月','七月','八月','九月','十月','十一月','十二月']
                        }
                    ],
                    yAxis : [
                        {
                            type : 'value'
                        }
                    ],
                    dataZoom: [
                        {type: 'inside'},//區域內縮放
                    ],
                    series : [
                        {
                            name:'<?php echo $AnnualArray[0]['name'] ?? '軸承'; ?>',
                            type:'line',
                            symbol:'rect',
                            symbolSize: 10,
                            data:[<?php echo ($AnnualArray[0]['一月'] ?? 0) . ',' . 
                                             ($AnnualArray[0]['二月'] ?? 0) . ',' . 
                                             ($AnnualArray[0]['三月'] ?? 0) . ',' . 
                                             ($AnnualArray[0]['四月'] ?? 0) . ',' . 
                                             ($AnnualArray[0]['五月'] ?? 0) . ',' . 
                                             ($AnnualArray[0]['六月'] ?? 0) . ',' . 
                                             ($AnnualArray[0]['七月'] ?? 0) . ',' . 
                                             ($AnnualArray[0]['八月'] ?? 0) . ',' . 
                                             ($AnnualArray[0]['九月'] ?? 0) . ',' . 
                                             ($AnnualArray[0]['十月'] ?? 0) . ',' . 
                                             ($AnnualArray[0]['十一月'] ?? 0) . ',' . 
                                             ($AnnualArray[0]['十二月'] ?? 0); 
                                ?>]
                        },
                        {
                            name:'<?php echo $AnnualArray[1]['name'] ?? '電晶體'; ?>',
                            type:'line',
                            symbol:'triangle',
                            symbolSize: 10,
                            data:[<?php echo ($AnnualArray[1]['一月'] ?? 0) . ',' . 
                                             ($AnnualArray[1]['二月'] ?? 0) . ',' . 
                                             ($AnnualArray[1]['三月'] ?? 0) . ',' . 
                                             ($AnnualArray[1]['四月'] ?? 0) . ',' . 
                                             ($AnnualArray[1]['五月'] ?? 0) . ',' . 
                                             ($AnnualArray[1]['六月'] ?? 0) . ',' . 
                                             ($AnnualArray[1]['七月'] ?? 0) . ',' . 
                                             ($AnnualArray[1]['八月'] ?? 0) . ',' . 
                                             ($AnnualArray[1]['九月'] ?? 0) . ',' . 
                                             ($AnnualArray[1]['十月'] ?? 0) . ',' . 
                                             ($AnnualArray[1]['十一月'] ?? 0) . ',' . 
                                             ($AnnualArray[1]['十二月'] ?? 0); 
                                ?>]
                        },
                        {
                            name:'<?php echo $AnnualArray[2]['name'] ?? '齒輪'; ?>',
                            type:'line',
                            symbol:'diamond',
                            symbolSize: 10,
                            data:[<?php echo ($AnnualArray[2]['一月'] ?? 0) . ',' . 
                                             ($AnnualArray[2]['二月'] ?? 0) . ',' . 
                                             ($AnnualArray[2]['三月'] ?? 0) . ',' . 
                                             ($AnnualArray[2]['四月'] ?? 0) . ',' . 
                                             ($AnnualArray[2]['五月'] ?? 0) . ',' . 
                                             ($AnnualArray[2]['六月'] ?? 0) . ',' . 
                                             ($AnnualArray[2]['七月'] ?? 0) . ',' . 
                                             ($AnnualArray[2]['八月'] ?? 0) . ',' . 
                                             ($AnnualArray[2]['九月'] ?? 0) . ',' . 
                                             ($AnnualArray[2]['十月'] ?? 0) . ',' . 
                                             ($AnnualArray[2]['十一月'] ?? 0) . ',' . 
                                             ($AnnualArray[2]['十二月'] ?? 0); 
                                ?>]
                        },
                        {
                            name:'<?php echo $AnnualArray[3]['name'] ?? '釘子'; ?>',
                            type:'line',
                            symbol:'pin',
                            symbolSize: 10,
                            data:[<?php echo ($AnnualArray[3]['一月'] ?? 0) . ',' . 
                                             ($AnnualArray[3]['二月'] ?? 0) . ',' . 
                                             ($AnnualArray[3]['三月'] ?? 0) . ',' . 
                                             ($AnnualArray[3]['四月'] ?? 0) . ',' . 
                                             ($AnnualArray[3]['五月'] ?? 0) . ',' . 
                                             ($AnnualArray[3]['六月'] ?? 0) . ',' . 
                                             ($AnnualArray[3]['七月'] ?? 0) . ',' . 
                                             ($AnnualArray[3]['八月'] ?? 0) . ',' . 
                                             ($AnnualArray[3]['九月'] ?? 0) . ',' . 
                                             ($AnnualArray[3]['十月'] ?? 0) . ',' . 
                                             ($AnnualArray[3]['十一月'] ?? 0) . ',' . 
                                             ($AnnualArray[3]['十二月'] ?? 0); 
                                ?>]
                        },
                        {
                            name:'<?php echo $AnnualArray[4]['name'] ?? '彈簧'; ?>',
                            type:'line',
                            symbol:'arrow',
                            symbolSize: 10,
                            data:[<?php echo ($AnnualArray[4]['一月'] ?? 0) . ',' . 
                                             ($AnnualArray[4]['二月'] ?? 0) . ',' . 
                                             ($AnnualArray[4]['三月'] ?? 0) . ',' . 
                                             ($AnnualArray[4]['四月'] ?? 0) . ',' . 
                                             ($AnnualArray[4]['五月'] ?? 0) . ',' . 
                                             ($AnnualArray[4]['六月'] ?? 0) . ',' . 
                                             ($AnnualArray[4]['七月'] ?? 0) . ',' . 
                                             ($AnnualArray[4]['八月'] ?? 0) . ',' . 
                                             ($AnnualArray[4]['九月'] ?? 0) . ',' . 
                                             ($AnnualArray[4]['十月'] ?? 0) . ',' . 
                                             ($AnnualArray[4]['十一月'] ?? 0) . ',' . 
                                             ($AnnualArray[4]['十二月'] ?? 0); 
                                ?>]
                        }
                    ]
                };

                //啟用圖表
                pix_1.setOption(option_1);
                pix_2.setOption(option_2);
                //偵測螢幕大小改變圖表大小
                /*window.onresize = function () {
                    pix_1.resize();
                }*/

            </script>
            <div class="ui horizontal divider">訂單 </div>

        <?php    
            $SETTime = mysqli_query($conn,"SELECT DISTINCT time FROM HistoricalOrder WHERE time >= '$startDate' AND time <= '$nextDay'");//不重複搜尋範圍內資料
			$SETDataNumber =  mysqli_num_rows($SETTime);
            echo "<div style='text-align:center;'>
                    <p>
                        <h1>總共有" . $SETDataNumber . "筆訂單</h1>
                    </p>
                </div>";

            $result = mysqli_query($conn,"SELECT * FROM HistoricalOrder WHERE time >= '$startDate' AND time <= '$nextDay'");//重新搜尋一次範圍內資料
            $time; //設置時間變數
            for($i = 0;$i<$dataNumber;$i++){ //循環每個資料
                $row = mysqli_fetch_assoc($result); //將每列資料取出來
                if($dataNumber == 1){ //如果是第一筆也是最後一筆
					$time = strtotime($row['time']); //儲存時間
					echo "<div>
							<h2>位置:" . $row['id'] ."&emsp;時間:" . date("Y-m-d / H:i:s",$time) . "</h2>
							<h3>送貨時間:" . (strtotime($row['sendTime']) == 0?  '' : date("Y-m-d / H:i:s",strtotime($row['sendTime'])))  . "</h3>
						 	<h3>送達時間:" . (strtotime($row['endTime']) == 0?  '' : date("Y-m-d / H:i:s",strtotime($row['endTime']))) . "</h3>";//顯示訂單狀況
                    echo 	"<table style='width:100%' class='ui unstackable selectable celled teal large table'>
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
                            <h2>位置:" . $row['id'] ."&emsp;時間:" . date("Y-m-d / H:i:s",$time) . "</h2>
					        <h3>送貨時間:" . (strtotime($row['sendTime']) == 0?  '' : date("Y-m-d / H:i:s",strtotime($row['sendTime'])))  . "</h3>
					        <h3>送達時間:" . (strtotime($row['endTime']) == 0?  '' : date("Y-m-d / H:i:s",strtotime($row['endTime']))) . "</h3>";//顯示訂單狀況
                    echo    "<table style='width:100%' class='ui unstackable selectable celled teal large table'>
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
				else if(($time != strtotime($row['time'])) && ($i != $dataNumber-1)){ //如果時間不一樣且不為最後一筆
					$time = strtotime($row['time']); //儲存時間
                    echo            "</tr>
                                </tbody>
                            </table>
                        </div>";

                    echo "<div>
                            <h2>位置:" . $row['id'] ."&emsp;時間:" . date("Y-m-d / H:i:s",$time) . "</h2>
					        <h3>送貨時間:" . (strtotime($row['sendTime']) == 0?  '' : date("Y-m-d / H:i:s",strtotime($row['sendTime'])))  . "</h3>
					        <h3>送達時間:" . (strtotime($row['endTime']) == 0?  '' : date("Y-m-d / H:i:s",strtotime($row['endTime']))) . "</h3>";//顯示訂單狀況
                    echo    "<table style='width:100%' class='ui unstackable selectable celled teal large table'>
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
				else if(($time != strtotime($row['time'])) && ($i == $dataNumber-1)){ //如果時間不一樣且為最後一筆
					$time = strtotime($row['time']); //儲存時間
                    echo            "</tr>
                                </tbody>
                            </table>
                        </div>";

                    echo "<div>
                            <h2>位置:" . $row['id'] ."&emsp;時間:" . date("Y-m-d / H:i:s",$time) . "</h2>
					        <h3>送貨時間:" . (strtotime($row['sendTime']) == 0?  '' : date("Y-m-d / H:i:s",strtotime($row['sendTime'])))  . "</h3>
					        <h3>送達時間:" . (strtotime($row['endTime']) == 0?  '' : date("Y-m-d / H:i:s",strtotime($row['endTime']))) . "</h3>";//顯示訂單狀況
                    echo    "<table style='width:100%' class='ui unstackable selectable celled teal large table'>
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
				else if ($i == $dataNumber-1){ //如果時間一樣且為最後一筆
                    echo            "</tr>
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
                    echo            "</tr>
                                </tbody>
                                <tbody>
                                    <tr>
                                        <td>" . $row['name'] . "</td>
                                        <td>" . $row['number'] . "</td>";
				}
            }

            mysqli_close($conn);//關閉連線
        ?>
    </body>
</html>