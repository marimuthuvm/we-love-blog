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
    if($c->forward('/user/validate_user')) {
    	$c->stash(title    => 'Dashboard for : '.$c->user->username);
        $c->stash(contents => [$c->model('DB::Content')->all]);
        $c->stash(template => 'template/dashboard/index.tt');
    }
}


=head1 AUTHOR

Yo!!!,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

