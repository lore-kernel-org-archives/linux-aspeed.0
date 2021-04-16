From: Tao Ren <rentao.bupt@gmail.com>
Date: Fri, 16 Apr 2021 11:25:59 -0700
Subject: [PATCH v2] watchdog: aspeed: fix integer overflow in set_timeout
 handler
In-Reply-To: <2771f72a-cc3c-54a5-cc2c-715ea61be6b7@roeck-us.net>
References: <20210416021337.18715-1-rentao.bupt@gmail.com>
 <2771f72a-cc3c-54a5-cc2c-715ea61be6b7@roeck-us.net>
Message-ID: <20210416182558.GA4816@taoren-ubuntu-R90MNF91>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Apr 15, 2021 at 10:07:32PM -0700, Guenter Roeck wrote:
> On 4/15/21 7:13 PM, rentao.bupt at gmail.com wrote:
> > From: Tao Ren <rentao.bupt@gmail.com>
> > 
> > Fix the time comparison (timeout vs. max_hw_heartbeat_ms) in set_timeout
> > handler to avoid potential integer overflow when the supplied timeout is
> > greater than aspeed's maximum allowed timeout (4294 seconds).
> > 
> 
> I think this is the wrong focus: What this fixes is the wrong hardware
> timeout calculation. Again, I think that the wrong calculation leads to
> the overflow should not be the focus of this patch, though it can of
> course be mentioned.
> 
> I'll leave it up to Wim to decide if he wants to apply the patch with the
> current explanation.
> 
> Thanks,
> Guenter

Sorry I didn't get your point correctly, and I guess it was because of
my lack of knowledge in timeout/max_hw_heartbeat_ms/worker (hopefully
my understanding is correct now :))

Let me drop this patch and send a new one with different subject and
description soon.


Cheers,

Tao
