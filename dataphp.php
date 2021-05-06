<?php

$firstName = $_POST["firstName"];
$lastName = $_POST["lastName"];
$filePath = $_POST["filePath"];

$target_dir = $filePath;
if (!file_exists($target_dir)) {
    mkdir($target_dir, 0777, true);
}

$name = basename($_FILES["file"]["name"]);
$actual_name = pathinfo($name, PATHINFO_FILENAME);

$original_name = $actual_name;
$extension = pathinfo($name, PATHINFO_EXTENSION);

$i = 1;
while(file_exists($target_dir . "/" . $actual_name . "." . $extension))
{
    $actual_name = $original_name . $i;
    $name = $actual_name . "." . $extension;
    $i++;
}

$target_dir = $target_dir . "/" . basename($name);

if (move_uploaded_file($_FILES["file"]["tmp_name"], $target_dir)) {

    echo json_encode([
    "Message" => "The file ". basename( $_FILES["file"]["name"]). " has successfully been uploaded.",
    "Status" => "OK",
    ]);

}
else {
    echo json_encode([
    "Message" => "Sorry, there was an error uploading your file.",
    "Status" => "Error",
    "File" => basename($_FILES["file"]["name"])
    ]);

}

?>

