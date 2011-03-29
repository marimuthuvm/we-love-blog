package Weloveblog::Controller::Dashboard;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

Weloveblog::Controller::Dashboard - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    $c->forward('/user/validate_user');
    $c->stash(contents => [$c->model('DB::Content')->all]);
    $c->stash(template => 'template/dashboard/index.tt');
}

=head1 NAME

Weloveblog::Controller::Dashboard - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub post :Local :Args(0) {
    my ( $self, $c ) = @_;
    
    $c->stash(template => 'template/form/content.tt');

    if($c->req->method eq 'POST'){
    	my $title = $c->req->param('title');
    	my $content = $c->req->param('content');
    	$c->model('DB::Content')->create({
    		user_id => $c->user->id,
    		title  => $title,
    		content => $content,
        });
    }else{
    	$c->stash(
    	   message => 'Get',
    	);
    };
}


=head1 AUTHOR

Yo!!!,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

