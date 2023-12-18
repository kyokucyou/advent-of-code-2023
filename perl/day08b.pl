#!/usr/bin/perl

use strict;

sub lcm {
    my ($a, $b) = @_;
    my $prod = $a * $b;
    ($a, $b) = ($b, $a % $b) while $b != 0;
    $prod / $a
}

my ($seq, %nodes);
$/ = '';
while (<>) {
    if ($. == 1) {
        s/[^LR]+//g;
        $seq = $_;
    } else {
        while (/(\w{3})\W+(\w{3})\W+(\w{3})/g) {
            $nodes{$1} = [$2, $3];
        }
    }
}
my @cur = grep /A$/, keys %nodes;
my @steps;
for my $node (@cur) {
    my $steps = 0;
    do {
        $node = $nodes{$node}[substr(
            $seq,
            $steps % length $seq,
            1
        ) eq 'L' ? 0 : 1];
        ++$steps;
    } until $node =~ /Z$/;
    push @steps, $steps;
}
my $lcm = 1;
$lcm = lcm($lcm, $_) for @steps;
print "$lcm\n";
