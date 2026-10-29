<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>autka - szukanie</title>
</head>
<body>
    <form action="" method="POST">
        <input type="text" name="miasta" id="miasta">
            
        <button type="submit" name="dodaj" id="dodaj">szukaj</button>
    </form>

    <table border="1">
        <tr>
            <th>imie</th>
            <th>nazwisko</th>
            <th>firma</th>
            <th>ulica</th>
            <th>numer</th>
            <th>miasto</th>
            <th>kod</th>
            <th>nip</th>
            <th>telefon</th>
        </tr>
        
        <?php
            require_once 'connect.php';
        
            if(isset($_POST['dodaj'])){
                $assoc = $_POST['miasta'];
                if(!empty($assoc)){
                    $query2 = "SELECT * from klienci where klienci.miasto = '$assoc';";
                    $exec2 = mysqli_query($connect, $query2);
                    while($result2 = mysqli_fetch_row($exec2)){
                        echo "<tr><td>$result2[1]</td><td>$result2[2]</td><td>$result2[3]</td><td>$result2[4]</td><td>$result2[5]</td><td>$result2[6]</td><td>$result2[7]</td><td>$result2[8]</td><td>$result2[9]</td></tr>";
                    }
                }
                else echo 'puste pole';
            }
        
        ?>
    </table>
</body>
</html>