From: David Laight <David.Laight@ACULAB.COM>
Date: Fri, 23 Apr 2021 10:54:59 +0000
Subject: [PATCH] soc: aspeed: fix a ternary sign expansion bug
In-Reply-To: <877dktuvmz.fsf@osv.gnss.ru>
References: <YIE90PSXsMTa2Y8n@mwanda>
 <59596244622c4a15ac8cc0747332d0be@AcuMS.aculab.com>
 <877dktuvmz.fsf@osv.gnss.ru>
Message-ID: <265e2d3accc74c89b5bab22eadb43808@AcuMS.aculab.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Sergey Organov
> Sent: 23 April 2021 11:46
> 
> David Laight <David.Laight@ACULAB.COM> writes:
> 
> > From: Dan Carpenter
> >> Sent: 22 April 2021 10:12
> >>
> >> The intent here was to return negative error codes but it actually
> >> returns positive values.  The problem is that type promotion with
> >> ternary operations is quite complicated.
> >>
> >> "ret" is an int.  "copied" is a u32.  And the snoop_file_read() function
> >> returns long.  What happens is that "ret" is cast to u32 and becomes
> >> positive then it's cast to long and it's still positive.
> >>
> >> Fix this by removing the ternary so that "ret" is type promoted directly
> >> to long.
> >>
> >> Fixes: 3772e5da4454 ("drivers/misc: Aspeed LPC snoop output using misc chardev")
> >> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> >> ---
> >>  drivers/soc/aspeed/aspeed-lpc-snoop.c | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> >> index 210455efb321..eceeaf8dfbeb 100644
> >> --- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> >> +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> >> @@ -94,8 +94,10 @@ static ssize_t snoop_file_read(struct file *file, char __user *buffer,
> >>  			return -EINTR;
> >>  	}
> >>  	ret = kfifo_to_user(&chan->fifo, buffer, count, &copied);
> >> +	if (ret)
> >> +		return ret;
> >>
> >> -	return ret ? ret : copied;
> >> +	return copied;
> >
> > I wonder if changing it to:
> > 	return ret ? ret + 0L : copied;
> >
> > Might make people think in the future and not convert it back
> > as an 'optimisation'.
> 
> It rather made me think: "what the heck is going on here?!"
> 
> Shouldn't it better be:
> 
>  	return ret ? ret : (long)copied;
> 
> or even:
> 
>         return ret ?: (long)copied;

Or change the return type to int ?

The problem is that ?: doesn't behave the way most people expect.
The two possible values have to be converted to the same type.

Together with the broken decision of the original ANSI C committee
to change from K&R's 'sign preserving' to 'value preserving'
integer promotions causes grief here and elsewhere.
(Not no mention breaking existing code!)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

