#!/usr/bin/perl

use strict;

my (@numbers, @symbols);
my $lineno = 0;
while (<>) {
    chomp;
    while (/(\d+)|([^.\d])/g) {
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
for (@numbers) {
    my ($line, $start, $end, $num) = @$_;
    for my $i ($line - 1, $line, $line + 1) {
        next unless 0 <= $i < $lineno;
        for (@{$symbols[$i]}) {
            $sum += $num if $start <= $_ <= $end;
        }
    }
}
print "$sum\n";
