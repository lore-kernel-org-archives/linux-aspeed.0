From: Tao Ren <rentao.bupt@gmail.com>
Date: Thu, 17 Sep 2020 21:18:59 -0700
Subject: [PATCH] gpio: aspeed: fix ast2600 bank properties
In-Reply-To: <60f9f14a-c9be-45ac-b3a8-516ab73d9bee@www.fastmail.com>
References: <20200916204216.9423-1-rentao.bupt@gmail.com>
 <60f9f14a-c9be-45ac-b3a8-516ab73d9bee@www.fastmail.com>
Message-ID: <20200918041858.GA14246@taoren-ubuntu-R90MNF91>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Sep 17, 2020 at 08:42:27AM +0930, Andrew Jeffery wrote:
> 
> 
> On Thu, 17 Sep 2020, at 06:12, rentao.bupt at gmail.com wrote:
> > From: Tao Ren <rentao.bupt@gmail.com>
> > 
> > GPIO_U is mapped to the least significant byte of input/output mask, and
> > the byte in "output" mask should be 0 because GPIO_U is input only. All
> > the other bits need to be 1 because GPIO_V/W/X support both input and
> > output modes.
> > 
> > Similarly, GPIO_Y/Z are mapped to the 2 least significant bytes, and the
> > according bits need to be 1 because GPIO_Y/Z support both input and
> > output modes.
> > 
> > Fixes: ab4a85534c3e ("gpio: aspeed: Add in ast2600 details to Aspeed driver")
> > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> 
> Thanks Tao,
> 
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

Thanks Andrew for the quick review.

Cheers,

Tao
