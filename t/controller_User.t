use strict;
use warnings;
use Test::More;

use ok 'Test::WWW::Mechanize::Catalyst' => 'Weloveblog';

ok( my $mech = Test::WWW::Mechanize::Catalyst->new, 'Created mech object' );

$mech->get_ok( 'http://localhost:3000/user' );

$mech->get_ok( 'http://localhost:3000/login');
$mech->field('username', 'blogger');
$mech->field('password', 'mypw');
$mech->submit_form_ok();
$mech->content_contains('Logged in successful');

done_testing();

