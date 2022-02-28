From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 28 Feb 2022 16:18:44 +0300
Subject: [PATCH 1/6] drivers: usb: remove usage of list iterator past the
 loop body
In-Reply-To: <E31E215E-C409-40B8-8452-57E70C91484C@gmail.com>
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
 <20220228110822.491923-2-jakobkoschel@gmail.com>
 <20220228112413.GA2812@kadam>
 <E31E215E-C409-40B8-8452-57E70C91484C@gmail.com>
Message-ID: <20220228131844.GD2812@kadam>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 28, 2022 at 01:03:36PM +0100, Jakob Koschel wrote:
> >> @@ -954,7 +957,6 @@ net2272_dequeue(struct usb_ep *_ep, struct usb_request *_req)
> >> 		dev_dbg(ep->dev->dev, "unlink (%s) pio\n", _ep->name);
> >> 		net2272_done(ep, req, -ECONNRESET);
> >> 	}
> >> -	req = NULL;
> > 
> > Another unrelated change.  These are all good changes but send them as
> > separate patches.
> 
> You are referring to the req = NULL, right?

Yes.

> 
> I've changed the use of 'req' in the same function and assumed that I can
> just remove the unnecessary statement. But if it's better to do separately
> I'll do that.
> 

These are all changes which made me pause during my review to figure out
why they were necessary.  The line between what is a related part of a
patch is a bit vague and some maintainers will ask you to add or subtract
from a patch depending on their individual tastes.  I don't really have
an exact answer, but I felt like this patch needs to be subtracted from.

Especially if there is a whole chunk of the patch which can be removed,
then to me, that obviously should be in a different patch.

regards,
dan carpenter

