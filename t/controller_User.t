use strict;
use warnings;
use Test::More;

use ok 'Test::WWW::Mechanize::Catalyst' => 'Weloveblog';

ok( my $mech = Test::WWW::Mechanize::Catalyst->new, 'Created mech object' );

#test for failed login
$mech->get_ok( 'http://localhost:3000/login');
$mech->field('username', 'user1');
$mech->field('password', 'pass1');
$mech->submit_form_ok();
$mech->content_contains('Invalid username or password');

#Test for successfully login
$mech->get_ok( 'http://localhost:3000/login');
$mech->field('username', 'user');
$mech->field('password', 'pass');
$mech->submit_form_ok();
$mech->title_like( qr/Dashboard for/i );

#Test for successfully logout
$mech->get_ok( 'http://localhost:3000/logout');
$mech->content_contains('Password');

done_testing();

