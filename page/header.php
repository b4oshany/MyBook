<?php
    require_once "__autoload.php";
    use modules\mybook\user\User;
    use configs\Websets;
    Websets::startDatabase();
    $user = new User();
    $user->start_session();
?>
<div class="navbar-wrapper">
    <div class="navbar navbar-inverse navbar-static-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="."><?php echo Websets::$website_name; ?></a>
        </div>
        <div class="navbar-collapse collapse" style="height: 1px;">
          <ul class="nav navbar-nav">
            <li class="active"><a href="home"><?php echo $user->getUserBy("first_name"); ?></a></li>
            <?php if($path != "cpanel"){ ?>
            <li><a href="about">About</a></li>
            <li><a href="Friends">Friend</a></li>     
            <?php } ?>                
            <?php if($user->is_admin()){ ?>
              <li><a href="cpanel">Control Panel</a></li>              
            <?php } ?>
           <!-- <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown <b class="caret"></b></a>
              <ul class="dropdown-menu">
                <li><a href="#">Action</a></li>
                <li><a href="#">Another action</a></li>
                <li><a href="#">Something else here</a></li>
                <li class="divider"></li>
                <li class="dropdown-header">Nav header</li>
                <li><a href="#">Separated link</a></li>
                <li><a href="#">One more separated link</a></li>
              </ul>
            </li>-->
        </div>
      </div>
    </div>
</div>