From: David Laight <David.Laight@ACULAB.COM>
Date: Fri, 23 Apr 2021 14:55:29 +0000
Subject: AW: [PATCH] soc: aspeed: fix a ternary sign expansion bug
In-Reply-To: <878s59rrn0.fsf@osv.gnss.ru>
References: <YIE90PSXsMTa2Y8n@mwanda>
 <59596244622c4a15ac8cc0747332d0be@AcuMS.aculab.com>
 <877dktuvmz.fsf@osv.gnss.ru>
 <265e2d3accc74c89b5bab22eadb43808@AcuMS.aculab.com>
 <ebe4a1a6dd0748e28e6ca19aec20223e@bfs.de> <878s59rrn0.fsf@osv.gnss.ru>
Message-ID: <635275613c384fe381df4ae4ac30f380@AcuMS.aculab.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Sergey Organov
> Sent: 23 April 2021 15:40
> 
> Walter Harms <wharms@bfs.de> writes:
> 
> > as indepentent observer,
> > i would go for Dans solution:
> >
> > ret = kfifo_to_user();
> > /* if an error occurs just return */
> > if (ret)
> >    return ret;
> >
> > /* otherwise return the copied number of bytes */
> >
> > return copied;
> >
> > there is no need for any deeper language knowledge,
> 
> Yep, but this is not idiomatic C, so one looking at this code would
> tend to convert it back to ternary, and the actual problem here is that
> the type of 'copied' does not match the return type of the function.

Actually changing the type of 'ret' to ssize_t is probably
the safest change.

That works until someone tries to optimise out 'ret' by doing:

	return kfifo_to_user(...) ?: count;

Or rattle through and remove the 'pass by reference' 'count'
parameter from kfifo_to_user() in favour of returning the
value the callers want.

I need to stop looking at this code :-)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

