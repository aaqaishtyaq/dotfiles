#!/usr/bin/gawk -f


# https://stackoverflow.com/questions/8653126/how-to-increment-version-number-in-a-shell-script

function inc(s,    a, len1, len2, len3, head, tail)
{
    split(s, a, ".")

    len1 = length(a)
    if(len1==0)
        return -1
    else if(len1==1)
        return s+1

    len2 = length(a[len1])
    len3 = length(a[len1]+1)

    head = join(a, 1, len1-1)
    tail = sprintf("%0*d", len2, (a[len1]+1)%(10^len2))

    if(len2==len3)
        return head "." tail
    else
        return inc(head) "." tail
}

function join(a, x, y,    s)
{
    for(i=x; i<y; i++)
        s = s a[i] "."
    return s a[y]
}
