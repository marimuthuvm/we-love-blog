package Weloveblog::Schema::ResultSet::Content;

use strict;
use warnings;
use parent qw/Weloveblog::Schema::Base::ResultSet/;

=head1 NAME

Weloveblog::Schema::ResultSet::Content - resultset methods for content

=head1 METHODS


=head2 list_page

list entry

=cut

sub list_page {
    my ( $self, $page, $rows) = @_;
    return $self->search({},
        {
            order_by => { -desc => 'created'},
            page => $page || 1,
            rows => $rows || 10,
        },
    );
}

=head1 AUTHOR

Yo!!!,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;

