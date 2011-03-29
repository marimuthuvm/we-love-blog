package Weloveblog::Schema::Result::User;
use base qw/DBIx::Class::Core/;
use strict;
use warnings;



=head1 NAME

webgallery::Schema::Result::User

=cut

__PACKAGE__->table("users");

=head1 ACCESSORS

=head2 id

data_type: 'integer'
is_auto_increment: 1
is_nullable: 0
sequence: 'users_id_seq'

=head2 username

data_type: 'text'
is_nullable: 1

=head2 password

data_type: 'text'
is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    is_auto_increment => 1,
    is_nullable => 0,
    sequence => "users_id_seq",
  },
  "email" => {
      data_type => "VARCHAR",
      default_value => "",
      is_nullable => 0,
      size => 128
  },
  "username" => {
      data_type => "VARCHAR",
      default_value => "",
      is_nullable => 0,
      size => 128
  },
  "password" => {
      data_type => "VARCHAR",
      default_value => "",
      is_nullable => 0,
      size => 128
  },
  );
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 blogs_owner

Type: has_many

Related object: L<Weloveblog::Schema::Result::Content>

=cut

__PACKAGE__->has_many(
    "blogs_owner",
    "Weloveblog::Schema::Result::Content",
    { "foreign.user_id" => "self.id" },
);

1;

