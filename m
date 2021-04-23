From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 23 Apr 2021 10:43:22 +0300
Subject: [PATCH] soc: aspeed: fix a ternary sign expansion bug
In-Reply-To: <59596244622c4a15ac8cc0747332d0be@AcuMS.aculab.com>
References: <YIE90PSXsMTa2Y8n@mwanda>
 <59596244622c4a15ac8cc0747332d0be@AcuMS.aculab.com>
Message-ID: <20210423074322.GQ1959@kadam>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Apr 22, 2021 at 04:21:40PM +0000, David Laight wrote:
> From: Dan Carpenter
> > Sent: 22 April 2021 10:12
> > 
> > The intent here was to return negative error codes but it actually
> > returns positive values.  The problem is that type promotion with
> > ternary operations is quite complicated.
> > 
> > "ret" is an int.  "copied" is a u32.  And the snoop_file_read() function
> > returns long.  What happens is that "ret" is cast to u32 and becomes
> > positive then it's cast to long and it's still positive.
> > 
> > Fix this by removing the ternary so that "ret" is type promoted directly
> > to long.
> > 
> > Fixes: 3772e5da4454 ("drivers/misc: Aspeed LPC snoop output using misc chardev")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/soc/aspeed/aspeed-lpc-snoop.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > index 210455efb321..eceeaf8dfbeb 100644
> > --- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > @@ -94,8 +94,10 @@ static ssize_t snoop_file_read(struct file *file, char __user *buffer,
> >  			return -EINTR;
> >  	}
> >  	ret = kfifo_to_user(&chan->fifo, buffer, count, &copied);
> > +	if (ret)
> > +		return ret;
> > 
> > -	return ret ? ret : copied;
> > +	return copied;
> 
> I wonder if changing it to:
> 	return ret ? ret + 0L : copied;
> 
> Might make people think in the future and not convert it back
> as an 'optimisation'.

This is from a Smatch test that Aur?lien Aptel requested.  The test is
pretty good quality with few false positives so I will push it soon.

If someone converts it back then I expect the checker will catch it.

regards,
dan carepnter

