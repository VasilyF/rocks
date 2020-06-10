<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Rocks</title>

    <link rel="stylesheet" href="../styles/general.css">
    <link rel="stylesheet" href="../styles/navigation.css">
    <link rel="stylesheet" href="../styles/dashboard.css">
</head>
<body>
    <?php include "common/header.php" ?>
    <?php include "common/navigation.php" ?>
    <main>
        <ul id="componentsContainer">
            <li class="component">
                <a href="../images/rocks-1.jpeg">
                    <img class="componentImage" src="../images/rocks-1.jpeg"
                         alt="You are strong">
                </a>
                <p class="componentLocation">Ravine Blvd, Oakwood MN</p>
                <p class="componentDescription">You are Strong</p>
            </li>
            <li class="component">
                <a href="../images/rocks-2.jpeg">
                    <img class="componentImage" src="../images/rocks-2.jpeg"
                         alt="We remember the people who show up in our darkest hour">
                </a>
                <p class="componentLocation">Holland Dr, Oakwood MN</p>
                <p class="componentDescription">Motivational rock</p>
            </li>
            <li class="component">
                <a href="../images/rocks-3.jpeg">
                    <img class="componentImage" src="../images/rocks-3.jpeg"
                         alt="You are not alone">
                </a>
                <p class="componentLocation">Burkley St, Port Russ MN</p>
                <p class="componentDescription">You are not alone, a really long description that does not fit within the boundary and would eventually be cropped with ellipses</p>
            </li>
        </ul>
    </main>
    <?php include "common/footer.php" ?>
</body>
</html>