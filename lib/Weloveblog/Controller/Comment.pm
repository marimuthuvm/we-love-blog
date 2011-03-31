package Weloveblog::Controller::Comment;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

Weloveblog::Controller::Comment - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 base

Base function

=cut

sub base : Chained('/') PathPart('comment') CaptureArgs(0) { }

=head2 load_blog

Load comment data
Rigth now, for  capture id fro delete only,In future It will be easy for edit implemented

=cut

sub load_blog : Chained('base') PathPart('') CaptureArgs(1) {
    my ($self, $c, $id) = @_;
    my $comment = $c->model('DB::Comment')->find($id);  
    if ( $comment) {
        $c->stash(comment => $comment );
    } 
    else {
        $c->response->redirect($c->uri_for('/blog/'.$c->stash->content_id.'/view'));             
    }
}

=head2 create

Create new comment

=cut

sub create : Chained('base') PathPart('new') Args(0) {
    my ( $self, $c ) = @_;
    my $content_id = $c->req->param('content_id');
    if($c->req->method eq 'POST') {        
        $c->model('DB::Comment')->create({
            name  => $c->req->param('name'),
            content_id => $content_id,
            comment => $c->req->param('comment'),         
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

=head2 delete

Delete comment
Rigth now, This function use get to sumit value,It will be change to use POST method later

=cut

sub delete : Chained('load_blog') PathPart('delete') Args(0) {
    my ( $self, $c ) = @_;
    $c->forward('/user/validate_user');
    my $content_id = $c->stash->{comment}->content_id;
    #These group of code will be change to use POST method later
    $c->stash->{comment}->delete;
    $c->response->redirect($c->uri_for('/blog/'.$content_id.'/view'));
}

=head1 AUTHOR

Yo!!!,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

