<!doctype>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <title>PHP Sprockets</title>

  <?php if($_SERVER['SERVER_NAME'] == '127.0.0.1') { ?>
    <link href="http://127.0.0.1:9292/assets/application-manifest.css" rel="stylesheet" type="text/css" />
  <?php  } else { ?>
    <link href="assets/compressed/application.min.css" rel="stylesheet" type="text/css" />
  <?php }  ?>

</head>
<body>

  <div id="main" role="main">
      <h1>Php Sprockets</h1>
      <div id="js"></div>
  </div>

  <?php if($_SERVER['SERVER_NAME'] == '127.0.0.1') {
    echo file_get_contents('http://127.0.0.1:9292/javascripts');
  } else { ?>
    <script src="assets/compressed/application.min.js"></script>
  <?php }?>

</body>
</html>
