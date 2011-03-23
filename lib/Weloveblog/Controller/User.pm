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


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Weloveblog::Controller::User in User.');
}

=head2 index

=cut

sub login :Global {
    my ( $self, $c ) = @_;
    
    my $user = $c->request->params->{'username'};
    my $pass = $c->request->params->{'password'};
    
    sub check {
		my ($user, $pass) = @_;
		if(($user eq 'blogger') && ($pass eq 'mypw')){
			return 1;
		}
		else{
			return 0;
		}
    };
    
    $c->stash(template => 'template/user/login.html');

    if($c->request->method eq 'POST'){
    	if(check($user, $pass)){
    		$c->stash(result => 'Logged in successful')
    	}
    }
    else{
    	$c->stash(result => 'Not post');
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
