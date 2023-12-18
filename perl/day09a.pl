#!/usr/bin/perl

use strict;

sub extrapolate {
    my $seq = shift;
    return 0 unless grep { $_ != 0 } @$seq;
    my @delta;
    my $old = $seq->[0];
    for my $i (1 .. $seq->$#*) {
        push @delta, $seq->[$i] - $old;
        $old = $seq->[$i];
    }
    extrapolate(\@delta) + $seq->[$seq->$#*];
}

my $total = 0;
while (<>) {
    my @seq = map int, split /\s+/;
    $total += extrapolate(\@seq);
}
print "$total\n";
