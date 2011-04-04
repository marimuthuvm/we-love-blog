package Weloveblog::Controller::User;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

Weloveblog::Controller::User - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 login

=cut

sub login :Global {
    my ( $self, $c ) = @_;
    
    my $username = $c->request->params->{'username'};
    my $password = $c->request->params->{'password'};
       
    $c->stash(title => 'Login');
    $c->stash(template => 'template/user/login.tt');
    
    if ($c->req->method eq 'POST') {
    	# Attempt to log the user in
		if ($c->authenticate({ username => $username,password => $password  } )) {
			# If successful, then let them use the application
			$c->response->redirect('/dashboard');
		} 
		else {
			# Set an error message
			$c->stash(error_msg => 'Invalid username or password.@ip:'.$c->request->address);
		}
    }
}

=head2 logout

=cut        

sub logout :Global {
    my ( $self, $c ) = @_;
    $c->logout;
    # Send the user to the login page
    $c->response->redirect($c->uri_for('/login'));
}

=head2 validate_user

Standard 404 error page

=cut

sub validate_user :Private {
    my ($self, $c) = @_;
    if (!$c->user_exists) {
        # Dump a log message to the development server debug output
        $c->log->debug('***User not found, forwarding to /login');
        # Redirect the user to the login page
        $c->response->redirect($c->uri_for('/login'));
        # Return 0 to cancel 'post-auto' processing and prevent use of application
        return 0;
    }
    else {
        return 1;
    }
}

=head1 AUTHOR

Nitipit Nontasuwan

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
