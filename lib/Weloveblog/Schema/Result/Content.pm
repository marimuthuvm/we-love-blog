package Weloveblog::Schema::Result::Content;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Weloveblog::Schema::Result::Content

=cut

__PACKAGE__->table("contents");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 title

  data_type: 'varchar'
  is_nullable: 0
  size: 150

=head2 content

  data_type: 'text'
  is_nullable: 1

=head2 created

  data_type: 'datetime'
  is_nullable: 1

=head2 modified

  data_type: 'datetime'
  is_nullable: 1

=head2 active

  data_type: 'bool'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "title",
  { data_type => "varchar", is_nullable => 0, size => 150 },
  "content",
  { data_type => "text", is_nullable => 1 },
  "created",
  { data_type => "datetime", is_nullable => 1 },
  "modified",
  { data_type => "datetime", is_nullable => 1 },
  "active",
  { data_type => "bool", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 user

Type: belongs_to

Related object: L<Weloveblog::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "Weloveblog::Schema::Result::User",
  { id => "user_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-03-25 15:18:52
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:f7A0tF1vJPlpSAxGhPJVpQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
