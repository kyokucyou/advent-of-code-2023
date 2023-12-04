#!/usr/bin/perl

use strict;

my (@numbers, @symbols);
my $lineno = 0;
while (<>) {
    chomp;
    while (/(\d+)|(\*)/g) {
        if ($1) {
            push @numbers, [
                $lineno,
                pos() - length($1) - 1,
                pos,
                int $1
            ];
        } else {
            push @{$symbols[$lineno]}, pos() - 1;
        }
    }
    ++$lineno;
}
my $sum = 0;
for my $i (0 .. $#symbols) {
    for my $sym (@{$symbols[$i]}) {
        my @adjacent;
        for my $n (@numbers) {
            my ($line, $start, $end, $num) = @$n;
            next unless abs($line - $i) <= 1 && $start <= $sym <= $end;
            push @adjacent, $num;
        }
        $sum += $adjacent[0] * $adjacent[1] if $#adjacent == 1;
    }
}
print "$sum\n";
