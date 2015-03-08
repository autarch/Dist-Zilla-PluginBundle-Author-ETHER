use strict;
use warnings;
package Dist::Zilla::MintingProfile::Author::ETHER;
# ABSTRACT: Mint distributions like ETHER does
# vim: set ts=8 sts=4 sw=4 tw=78 et :

our $VERSION = '0.090';

use Moose;
with 'Dist::Zilla::Role::MintingProfile';
use File::ShareDir;
use Path::Class;        # sadly, we still need to use Path::Class :(
use Carp;
use namespace::autoclean;

sub profile_dir
{
    my ($self, $profile_name) = @_;

    die 'minting requires perl 5.014' unless $] >= 5.013002;

    my $dist_name = '{{ $dist->name }}';
    my $profile_dir = dir( File::ShareDir::dist_dir($dist_name) )
                      ->subdir( 'profiles', $profile_name );

    return $profile_dir if -d $profile_dir;

    confess "Can't find profile $profile_name via $self: it should be in $profile_dir";
}

__PACKAGE__->meta->make_immutable;
__END__

=pod

=head1 SYNOPSIS

    dzil new -P Author::ETHER -p github Foo::Bar

or:

    #!/bin/bash
    newdist() {
        local dist=$1
        local module=`perl -we"print q{$dist} =~ s/-/::/r"`
        pushd ~/git
        dzil new -P Author::ETHER -p github $module
        cd $dist
    }
    newdist Foo-Bar

=head1 DESCRIPTION

The new distribution is packaged with L<Dist::Zilla> using
L<Dist::Zilla::PluginBundle::Author::ETHER>.

Profiles available are:

=begin :list

* C<github>

Creates a distribution hosted on L<github|http://github.com>, with hooks to determine the
module version and other metadata from git. Issue tracking is disabled, as RT
is selected as the bugtracker in the distribution's metadata (via the plugin
bundle).

You will be prompted to create a repository on github immediately; if you
decline, you must create one manually before you do your first C<push>.

* C<default>

Presently the same as C<github>. Available since version 0.087.

=end :list

=head1 SUPPORT

=for stopwords irc

Bugs may be submitted through L<the RT bug tracker|https://rt.cpan.org/Public/Dist/Display.html?Name=Dist-Zilla-PluginBundle-Author-ETHER>
(or L<bug-Dist-Zilla-PluginBundle-Author-ETHER@rt.cpan.org|mailto:bug-Dist-Zilla-PluginBundle-Author-ETHER@rt.cpan.org>).
I am also usually active on irc, as 'ether' at C<irc.perl.org>.

=cut
