package Weloveblog::Controller::Blog;
use Moose;
use namespace::autoclean;
use strict;
use warnings;


BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

Weloveblog::Controller::Blog - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 base

Base function

=cut

sub base : Chained('/') PathPart('blog') CaptureArgs(0) { }

=head2 root

Temporary fiunction for list blog::  /blog,  May be insteaded with rootdirectory later

=cut

sub root :Chained("base") :PathPart("") :Args(0) {
    my ($self, $c) = @_;
    my $page = $c->request->params->{'page'} || 1;
    my $rows = $c->request->params->{'rows'} || 10;
    $c->stash(total    => $c->model('DB::Content')->count());
    $c->stash(rows     => $rows);
    $c->stash(current  => $page);
    $c->stash(entries  => [$c->model('DB::Content')->list_page($page,$rows)]);
    $c->stash(title    => 'List of Blog');
    $c->stash(template => 'template/blog/list.tt');
}

=head2 load_blog

Load blog data

=cut

sub load_blog : Chained('base') PathPart('') CaptureArgs(1) {
    my ($self, $c, $id) = @_;
    my $entry = $c->model('DB::Content')->find($id);

    if ( $entry ) {
        $c->stash(entry => $entry );
    } 
    else {
        $c->stash(template  => 'template/blog/view.tt');
        $c->stash(title     => 'No such blog found');
        $c->stash(error_msg => "No such blog found" );
        $c->detach;        
    }
}

=head2 view

View blog

=cut

sub view : Chained('load_blog') PathPart('view') Args(0) {
    my ($self, $c) = @_;
    $c->stash(title    => 'View blog');
    $c->stash(template => 'template/blog/view.tt');
}

=head2 create

Create new blog

=cut

sub create : Chained('base') PathPart('new') Args(0) {
    my ( $self, $c ) = @_;
    $c->forward('/user/validate_user');
    $c->stash(template => 'template/blog/post.tt');    
    if($c->req->method eq 'POST') {
        my $title   = $c->req->param('title');
        my $content = $c->req->param('content');
        $c->model('DB::Content')->create({
            user_id => $c->user->id,
            title   => $title,
            content => $content,
        });
        $c->response->redirect($c->uri_for('/dashboard'));
    }
    else {
    	$c->stash(button_label => 'Create', title => 'Create new blog');
    };
}

=head2 edit

Edit blog data

=cut

sub edit : Chained('load_blog') PathPart('edit') Args(0) {
    my ( $self, $c ) = @_;
    $c->forward('/user/validate_user');
        
    if($c->req->method eq 'POST') {
        my $title   = $c->req->param('title');
        my $content = $c->req->param('content');
        $c->stash->{entry}->update({ title => $title,
        	                       content => $content 
        });
        $c->response->redirect($c->uri_for('/dashboard'));
    }
    else {
        $c->stash(title        => 'Edit blog');
        $c->stash(button_label => 'Edit');
        $c->stash(template     => 'template/blog/post.tt');
    };   
}

=head2 delete

Delete blog entry

=cut

sub delete : Chained('load_blog') PathPart('delete') Args(0) {
    my ( $self, $c ) = @_;
    $c->forward('/user/validate_user');
        
    if($c->req->method eq 'POST') {
        $c->stash->{entry}->delete;
        $c->response->redirect($c->uri_for('/dashboard'));
    }
    else {
        $c->stash(title    => 'Delete blog');
        $c->stash(template => 'template/blog/delete.tt');
    }; 
}

=head2 delete_comment

delete comment

=cut

sub delete_comment : Chained('load_blog') PathPart('delete_comment') Args(1) {
    my ( $self, $c, $id ) = @_;
    $c->forward('/user/validate_user');
    my $content_id = $c->stash->{entry}->id;
    my $comment    = $c->model('DB::Comment')->find($id); 
    if ( $comment) {
        $comment->delete;
    } 
    $c->response->redirect($c->uri_for('/blog/'.$content_id.'/view'));
}

=head2 new_comment

Create  new comment

=cut

sub new_comment : Chained('load_blog') PathPart('new_comment') Args(0) {
    my ( $self, $c ) = @_;
    my $content_id = $c->stash->{entry}->id;
    if($c->req->method eq 'POST') {        
        $c->model('DB::Comment')->create({
            name       => $c->req->param('name'),
            content_id => $content_id,
            comment    => $c->req->param('comment'),         
        });
        $c->response->redirect($c->uri_for('/blog/'.$content_id.'/view'));
    }
    else {
        # Dump a log message to the development server debug output
        $c->log->debug('***There are someone who trying to post comment by Get method***');
        #redirect to blog view page
        $c->response->redirect($c->uri_for('/blog/'.$content_id.'/view'));
    };
}

=head1 AUTHOR

Yo!!!,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

