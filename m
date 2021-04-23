From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 23 Apr 2021 18:24:59 +0300
Subject: AW: [PATCH] soc: aspeed: fix a ternary sign expansion bug
In-Reply-To: <878s59rrn0.fsf@osv.gnss.ru>
References: <YIE90PSXsMTa2Y8n@mwanda>
 <59596244622c4a15ac8cc0747332d0be@AcuMS.aculab.com>
 <877dktuvmz.fsf@osv.gnss.ru>
 <265e2d3accc74c89b5bab22eadb43808@AcuMS.aculab.com>
 <ebe4a1a6dd0748e28e6ca19aec20223e@bfs.de>
 <878s59rrn0.fsf@osv.gnss.ru>
Message-ID: <20210423152459.GU1959@kadam>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Apr 23, 2021 at 05:40:19PM +0300, Sergey Organov wrote:
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
>

I help maintain drivers/staging.  I would hope that no one would send us
a patch like this because it's not a checkpatch or CodingStyle violation.
But people have sent us these before and Greg NAKs them because he
doesn't like ternaries.  I NAK them because I like my success path kept
separate from the failure path.  I want the success path indented one
tab and the failure path indented two tabs.  I like when code is written
ploddingly, without fanciness, or combining multiple things on one line.

Using a ternary in this context seems to me like it falls under the
anti-pattern of "making the last call in a function weird".  A lot of
times people change from failure handling to success handling for the
last function call.

	err = one();
	if (err)
		goto fail;
	err = two();
	if (err)
		goto fail;
	err = three();
	if (!err)
		return 0;
goto fail:
	print("failed!\n");

It seems crazy, but people do this all the time!  It's fine to do:

	return three();

There are some maintainers who insist that it should be:

	err = three();
	if (err)
		return err;
	return 0;

I don't go as far as that.  But I also do like when I can glance at the
function and there is a giant "return 0;" at the bottom.

Anyway, if people change it back to ternary then the kbuild bot will
send them a warning message and they'll learn about an odd quirk in C's
type promotion rules.

regards,
dan carpenter
