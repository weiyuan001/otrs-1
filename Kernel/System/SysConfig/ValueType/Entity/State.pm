# --
# Copyright (C) 2001-2017 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::SysConfig::ValueType::Entity::State;

use strict;
use warnings;

use Kernel::System::VariableCheck qw(:all);

use base qw(Kernel::System::SysConfig::ValueType::Entity);

our @ObjectDependencies = (
    'Kernel::System::State',
    'Kernel::System::Web::Request',
);

=head1 NAME

Kernel::System::SysConfig::ValueType::Entity::State - System configuration state entity type backend.

=head1 PUBLIC INTERFACE

=head2 new()

Create an object. Do not use it directly, instead use:

    use Kernel::System::ObjectManager;
    local $Kernel::OM = Kernel::System::ObjectManager->new();
    my $EntityTypeObject = $Kernel::OM->Get('Kernel::System::SysConfig::ValueType::Entity::State');

=cut

sub new {
    my ( $Type, %Param ) = @_;

    # Allocate new hash for object.
    my $Self = {};
    bless( $Self, $Type );

    return $Self;
}

sub EntityValueList {
    my ( $Self, %Param ) = @_;

    my %States = $Kernel::OM->Get('Kernel::System::State')->StateList(
        Valid  => 1,
        UserID => 1,
    );

    my @Result;

    for my $ID ( sort keys %States ) {
        push @Result, $States{$ID};
    }

    return @Result;
}

sub EntityLookupFromWebRequest {
    my ( $Self, %Param ) = @_;

    my $StateID = $Kernel::OM->Get('Kernel::System::Web::Request')->GetParam( Param => 'ID' ) // '';

    return if !$StateID;

    return $Kernel::OM->Get('Kernel::System::State')->StateLookup( StateID => $StateID );
}

1;

=head1 TERMS AND CONDITIONS

This software is part of the OTRS project (L<http://otrs.org/>).

This software comes with ABSOLUTELY NO WARRANTY. For details, see
the enclosed file COPYING for license information (AGPL). If you
did not receive this file, see L<http://www.gnu.org/licenses/agpl.txt>.

=cut