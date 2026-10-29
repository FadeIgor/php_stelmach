<?php

//wczytanie połączenia z bazą
require_once "connect.php";

//zadanie 1 Aktualna ilosc ryb w bazie
$query1 = "SELECT * FROM ryby";
$exec1 = mysqli_query($connect,$query1);
$result1 = mysqli_num_rows($exec1);

echo "Aktualna ilosc ryb w bazie wynosi: ".$result1."<br>";

//zadanie 2 Aktualna ilosc lowisk w bazie
$query2 = "SELECT COUNT(*) FROM lowisko";
$exec2 = mysqli_query($connect,$query2);
$result2 = mysqli_fetch_row($exec2);
echo "Aktualna ilosc lowisk w bazie wynosi: ".$result2[0]."<br>";

//zadanie 3 Tabela z rybami
$query3 = "SELECT * FROM ryby";
$exec3 = mysqli_query($connect,$query3);

echo "<table border = 1><th>lp</th><th>nazwa</th><th>wystepowanie</th>";

while($result3 = mysqli_fetch_row($exec3)){
    echo "<tr>
            <td>".$result3[0]."</td>
            <td>".$result3[1]."</td>
            <td>".$result3[2]."</td>
          </tr>";
}
echo '</table>';

//zadanie 4 Tabela z łowiskami
$query4 = "SELECT * FROM lowisko";
$exec4 = mysqli_query($connect,$query4);

echo "<ol>";

while($result4 = mysqli_fetch_assoc($exec4)){
    echo "<li>".$result4['akwen'].", który znajduje się w województwie: ".$result4['wojewodztwo']."</li>";
}

echo "</ol>";


//zamknięcie połaczenia z bazą
mysqli_close($connect);

?>