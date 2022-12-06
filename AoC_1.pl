use strict;
use warnings;
use v5.10;

use List::Util qw(min max sum);

my $sum = 0;
my @individual_cal = ();

while(<STDIN>){
    chomp;
    if(m/[0-9]+/){
        $sum += $_;
    } elsif (m/^\s/){
        push @individual_cal, $sum;
        $sum = 0;
    }
}

# To consider last entries if no newline follows
if($sum != 0){
    push @individual_cal, $sum;
    $sum = 0;
}

# Q1
say max @individual_cal;

# Q2
my @sorted = sort {$b <=> $a} @individual_cal;
say sum @sorted[0..2];