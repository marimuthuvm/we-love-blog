package Weloveblog::Controller::Blog;
use Moose;
use namespace::autoclean;

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
    $c->stash(entries => [$c->model('DB::Content')->all]);
    #$c->stash(entries => [$c->model('DB')->resultset('Content')]);
    $c->stash(title=> 'List of Blog');
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
        $c->stash(template => 'template/blog/view.tt');
        $c->stash(title=> 'No such blog found');
        $c->stash( error_msg => "No such blog found" );
        $c->detach;        
    }
}

=head2 view

View blog

=cut

sub view : Chained('load_blog') PathPart('view') Args(0) {
    my ($self, $c) = @_;
    $c->stash(title=> 'View blog');
    $c->stash(template => 'template/blog/view.tt');
}

=head2 create

Create new blog

=cut

sub create : Chained('blog') PathPart('new') Args(0) {
    my ( $self, $c ) = @_;    
    $c->stash(template => 'template/form/content.tt');    
    if($c->req->method eq 'POST') {
        my $title = $c->req->param('title');
        my $content = $c->req->param('content');
        $c->model('DB::Content')->create({
            user_id => $c->user->id,
            title  => $title,
            content => $content,
        });
    }
    else {
        $c->stash( message => 'Get');
        $c->stash(title=> 'Create new blog');
    };
}

=head2 edit

Edit blog data

=cut

sub edit : Chained('load_blog') PathPart('edit') Args(0) {
    my ($self, $c) = @_;
    $c->stash(title=> 'Edit blog');
    $c->stash(template => 'template/blog/edit.tt');
}

=head2 delete

Delete blog entry

=cut

sub delete : Chained('load_blog') PathPart('delete') Args(0) {
    my ($self, $c) = @_;
    $c->stash(title=> 'Delete blog');
    $c->stash(template => 'template/blog/edit.tt');
}


=head1 AUTHOR

Yo!!!,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;
