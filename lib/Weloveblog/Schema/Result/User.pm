package Weloveblog::Schema::Result::User;
use base qw/DBIx::Class::Core/;
use strict;
use warnings;


__PACKAGE__->table('user');
__PACKAGE__->add_columns(
	userid   => { data_type => 'INTEGER', is_nullable => 0, },
    username => { data_type => 'VARCHAR', is_nullable => 0, size => 255, },
    password => { data_type => 'VARCHAR', is_nullable => 0, size => 255, },
);
__PACKAGE__->set_primary_key('userid');

1;

