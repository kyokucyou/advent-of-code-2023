#!/usr/bin/perl

use strict;

my @hands;
while (<>) {
    my ($hand, $bid) = /\w+/g;
    $hand =~ y/J2-9TQKA/a-m/;
    my $dominant = do {
        my %freq;
        ++$freq{substr $hand, $_, 1} for 0 .. length($hand) - 1;
        my @keys = grep { $_ ne 'a' }
                   sort { $freq{$b} <=> $freq{$a} }
                   keys %freq;
        $keys[0] or 'a'
    };
    my $orig = $hand;
    $hand =~ s/a/$dominant/g;
    $hand = join '', sort { $a cmp $b } split //, $hand;
    my $strength;
    $hand =~ /
                                                              .*?
        (.)\1{4}                        (?{ $strength = 7 }) |.*?
        (.)\2{3}                        (?{ $strength = 6 }) |.*?
        (?:(.)\3(.)\4{2}|(.)\5{2}(.)\6) (?{ $strength = 5 }) |.*?
        (.)\7{2}                        (?{ $strength = 4 }) |.*?
        (.)\8.*?(.)\9                   (?{ $strength = 3 }) |.*?
        (.)\10                          (?{ $strength = 2 }) |
                                        (?{ $strength = 1 })
    /x;
    push @hands, [$orig, int $bid, $strength];
}
@hands = sort { $a->[2] <=> $b->[2] or $a->[0] cmp $b->[0] } @hands;
my $total = 0;
for my $i (0 .. $#hands) {
    $total += ($i + 1) * $hands[$i][1];
}
print "$total\n";
