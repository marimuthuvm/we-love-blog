#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  weloveblog_deploy.pl
#
#        USAGE:  ./weloveblog_deploy.pl  
#
#  DESCRIPTION:  
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  YOUR NAME (), 
#      COMPANY:  
#      VERSION:  1.0
#      CREATED:  03/24/2011 10:26:44 AM
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;
use Weloveblog::Schema;

my $DSN = 'dbi:SQLite:weloveblog.db';
my $schema = Weloveblog::Schema->connect($DSN);
$schema->deploy;

