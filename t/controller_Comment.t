use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Catalyst::Test', 'Weloveblog' }
BEGIN { use_ok 'Weloveblog::Controller::Blog' }

use ok 'Test::WWW::Mechanize::Catalyst' => 'Weloveblog';
ok( my $mech = Test::WWW::Mechanize::Catalyst->new, 'Created mech object' );

my $link;
my $link_url;

#open blog lis page
$mech->get_ok( 'http://localhost:3000/blog');
#find any blog link
ok($link = $mech->find_link( url_regex => qr/view/i ));
$link_url = $link->url();
#open view blog page
$mech->follow_link( url=> $link_url);
$mech->title_is( "View blog" );

#submit content
$mech->field('name', 'Comment::Name abc');
$mech->field('comment', 'Comment::Body abc');
$mech->submit_form_ok();

#ater submit comment , redirect to view blog page
$mech->title_is( "View blog" );
$mech->content_contains('Comment::Body abc');

done_testing();
