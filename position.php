<?php

	if(isset($_POST['trainPosition'])){
		$value = $_POST['trainPosition'];
	
		file_put_contents("position.txt",$value);
	}
	else{
		$str = file_get_contents("position.txt");
		echo $str;
	}
?>