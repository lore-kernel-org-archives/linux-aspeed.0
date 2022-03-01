From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 1 Mar 2022 08:52:31 +0300
Subject: [PATCH 1/6] drivers: usb: remove usage of list iterator past the
 loop body
In-Reply-To: <0be9de3920442df490f01b6fb1c42521c3de6190.camel@perches.com>
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
 <20220228110822.491923-2-jakobkoschel@gmail.com>
 <20220228112413.GA2812@kadam>
 <0be9de3920442df490f01b6fb1c42521c3de6190.camel@perches.com>
Message-ID: <20220301055231.GI2812@kadam>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 28, 2022 at 10:20:28AM -0800, Joe Perches wrote:
> On Mon, 2022-02-28 at 14:24 +0300, Dan Carpenter wrote:
> 
> > a multi-line indent gets curly braces for readability even though
> > it's not required by C.  And then both sides would get curly braces.
> 
> That's more your personal preference than a coding style guideline.
> 

It's a USB patch.  I thought Greg prefered it that way.  Greg has some
specific style things which he likes and I have adopted and some I
pretend not to see.

regards,
dan carpenter
