use strict;
use warnings;
use Test::More;

use ok 'Test::WWW::Mechanize::Catalyst' => 'Weloveblog';

ok( my $mech = Test::WWW::Mechanize::Catalyst->new, 'Created mech object' );

#Call logout first to clear any session.
$mech->get_ok( 'http://localhost:3000/logout' );
#Get to dash board without any authentication
$mech->get_ok( 'http://localhost:3000/dashboard' );
$mech->content_contains('Password');

#Get to dash board from login page
$mech->get_ok( 'http://localhost:3000/login');
$mech->field('username', 'user');
$mech->field('password', 'pass');
$mech->submit_form_ok();
$mech->title_like( qr/Dashboard for/i );

done_testing();
