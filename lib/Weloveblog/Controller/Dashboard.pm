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

    if (!$c->user_exists) {
            # Dump a log message to the development server debug output
            $c->log->debug('***User not found, forwarding to /login');
            # Redirect the user to the login page
            $c->response->redirect($c->uri_for('/login'));
            # Return 0 to cancel 'post-auto' processing and prevent use of application
            return 0;
    }
    else {
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

