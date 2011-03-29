use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Catalyst::Test', 'Weloveblog' }
BEGIN { use_ok 'Weloveblog::Controller::Blog' }
use ok 'Test::WWW::Mechanize::Catalyst' => 'Weloveblog';

ok( my $mech = Test::WWW::Mechanize::Catalyst->new, 'Created mech object' );
$mech->get_ok( 'http://localhost:3000/blog' );
$mech->title_is( "List of Blog" );

$mech->get_ok( 'http://localhost:3000/blog/new' );
$mech->title_is( "Create new blog" );

$mech->get_ok( 'http://localhost:3000/blog/3/view' );
$mech->title_is( "View blog" );

$mech->get_ok( 'http://localhost:3000/blog/3/edit' );
$mech->title_is( "Edit blog" );

$mech->get_ok( 'http://localhost:3000/blog/3/delete' );
$mech->title_is( "Delete blog" );

done_testing();
