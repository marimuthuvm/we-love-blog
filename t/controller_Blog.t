use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Catalyst::Test', 'Weloveblog' }
BEGIN { use_ok 'Weloveblog::Controller::Blog' }
use ok 'Test::WWW::Mechanize::Catalyst' => 'Weloveblog';

ok( my $mech = Test::WWW::Mechanize::Catalyst->new, 'Created mech object' );
$mech->get_ok( 'http://localhost:3000/blog' );
$mech->title_is( 'List of Blog' );

#Call all prevent page without login
$mech->get_ok( 'http://localhost:3000/blog/new' );
$mech->title_is( 'Login' );
$mech->get_ok( 'http://localhost:3000/blog/3/edit' );
$mech->title_is( "Login" );
$mech->get_ok( 'http://localhost:3000/blog/3/delete' );
$mech->title_is( "Login" );

#Loging in
$mech->get_ok( 'http://localhost:3000/login');
$mech->field('username', 'user');
$mech->field('password', 'pass');
$mech->submit_form_ok();

#Create blog
$mech->get_ok( 'http://localhost:3000/blog/new' );
$mech->title_is( 'Create new blog' );
$mech->field('title', 'Title test 111 abc');
$mech->field('content', 'Body test 111 abc');
$mech->submit_form_ok();
$mech->content_contains('Title test 111 abc');

#View blog
$mech->get_ok( 'http://localhost:3000/dashboard' );
$mech->title_like( qr/Dashboard for/i );
my $link;
my $link_url;
#find latest blog entry
ok($link = $mech->find_link( text => 'Title test 111 abc'));
$mech->follow_link( text => 'Title test 111 abc');
$mech->title_is( "View blog" );

#submit comment
$mech->field('name', 'Comment::Name abc');
$mech->field('comment', 'Comment::Body abc');
$mech->submit_form_ok();

#ater submit comment , redirect to view blog page
$mech->title_is( "View blog" );
$mech->content_contains('Comment::Body abc');

#Edit blog
$link_url = $link->url();
$link_url =~ s/view/edit/g;
$mech->get_ok( 'http://localhost:3000/dashboard' );
$mech->follow_link( text => 'Edit', url => $link_url );
$mech->title_is('Edit blog');
$mech->field('title', 'Title test edit 222 xyz');
$mech->field('content', 'Body test edit 222 xyz');
$mech->submit_form_ok();
$mech->find_link( text => 'Title test edit 222 xyz');


#Deleted blog
ok($link = $mech->find_link( text => 'Title test edit 222 xyz'));
$link_url = $link->url();
$link_url =~ s/view/delete/g;
$mech->get_ok( 'http://localhost:3000/dashboard' );
$mech->follow_link( text => 'Delete', url => $link_url );
$mech->title_is( "Delete blog" );
$mech->submit_form_ok();
$mech->content_unlike( qr/Title test edit 222 xyz/i );

done_testing();
