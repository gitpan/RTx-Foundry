# $File: //depot/RT/rt/lib/RT/CustomField_Local.pm $ $Author: autrijus $
# $Revision: #10 $ $Change: 5491 $ $DateTime: 2003/04/28 09:06:47 $

use strict;
no warnings qw(redefine);

use vars qw(@TYPES %TYPES);

# Enumerate all valid types for this custom field
push @TYPES, (
    'SelectResolution',	# loc
    'SelectVersion',	# loc
);

# Populate a hash of types of easier validation
for (@TYPES) { $TYPES{$_} = 1};

1;
