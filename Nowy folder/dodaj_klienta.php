<!DOCTYPE html>
<html lang="pl">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Meow</title>
</head>

<body>
    <form action="dodaj_klienta" method="post">
        <label>Imię klienta: </label>
        <input type="text" name="imie" required><br><br>
        <label>Nazwisko klienta: </label>
        <input type="text" name="nazwisko" required><br><br>
        <label>Ulica klienta: </label>
        <input type="text" name="ulica" required><br><br>
        <label>Numer domu klienta: </label>
        <input type="text" name="numer_dom" required><br><br>
        <label>Miasto klienta: </label>
        <input type="text" name="miasto" required><br><br>
        <label>Kod pocztowy klienta: </label>
        <input type="text" name="kod" required><br><br>
        <label>Telefon klienta: </label>
        <input type="text" name="telefon" required><br><br>
        <label>Email klienta: </label>
        <input type="text" name="email" required><br><br>
        <label>Płeć klienta: </label>
        <select name="pleć" required>
            <option>K</option>
            <option>M</option>
        </select><br><br>
        
        <input type="submit" name="dodaj" value="Dodaj klienta">
        <?php
            require_once "connect.php";
            if(isset($_POST['dodaj'])) {
                $imie = $_POST['imie'];
                $nazwisko = $_POST['nazwisko'];
                $ulica = $_POST['ulica'];
                $numer_dom = $_POST['numer_dom'];
                $miasto = $_POST['miasto'];
                $kod = $_POST['kod'];
                $telefon = $_POST['telefon'];
                $email = $_POST['email'];
                $plec = $_POST['plec'];

                if(!empty('$imie') && !empty('$nazwisko') && !empty('$ulica') && !empty('$numer_dom') && !empty('$miasto') && !empty('$kod') && !empty('$telefon') && !empty('$email') && !empty('$plec')) {
                    $klient_dodaj = "INSERT INTO klienci(
                        id_klienta,
                        imie_klienta,
                        nazwisko_klienta,
                        ulica_klienta,
                        numer_domu_klienta,
                        miasto_klienta,
                        kod_klienta,
                        telefon_klienta,
                        email_klienta,
                        plec) VALUES('$imie', '$nazwisko', '$ulica', '$numer_dom', '$miasto', '$kod', '$telefon', '$email', '$plec')";
                        mysqli_query($connect, $klient_dodaj);
                        echo 'Kowalski opcje';
                } else {
                echo 'uzupełnij wszystkie pola';
            };
            };
            mysqli_close($connect);
        ?>
    </form>
</body>

</html>