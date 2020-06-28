<?php
	$servername = "localhost";
	$username = "u882696006_datauser";
	$password = "datapass";
	$dbname = "u882696006_project";

	// Create connection
	$con = mysqli_connect($servername, $username, $password, $dbname);
	// Check connection
	if (!$con) {
		die("Connection failed: " . mysqli_connect_error());
	}
			
	$name = $_GET['name'];
	$sql = "SELECT * FROM stock WHERE name = '" . $name . "'";
			
	$result = mysqli_query($con,$sql);
	while($row = mysqli_fetch_array($result)) {
		echo $row['number'];
	}
			
	mysqli_close($con);
?>
