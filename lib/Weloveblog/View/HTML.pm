package Weloveblog::View::HTML;

use strict;
use warnings;

use base 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.html',
    render_die => 1,
);

=head1 NAME

Weloveblog::View::HTML - TT View for Weloveblog

=head1 DESCRIPTION

TT View for Weloveblog.

=head1 SEE ALSO

L<Weloveblog>

=head1 AUTHOR

Nitipit Nontasuwan

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
