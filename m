From: Miaoqian Lin <linmq006@gmail.com>
Date: Mon, 4 Apr 2022 23:25:38 +0800
Subject: [PATCH] serial: 8250_aspeed_vuart: Fix potential NULL
 dereference in aspeed_vuart_probe
In-Reply-To: <YksEnnyJDoL+fE5d@kroah.com>
References: <20220404143842.16960-1-linmq006@gmail.com>
 <YksEnnyJDoL+fE5d@kroah.com>
Message-ID: <20220404152538.GA35@VICKYMQLIN-NB1.localdomain>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Apr 04, 2022 at 04:45:50PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Apr 04, 2022 at 02:38:40PM +0000, Miaoqian Lin wrote:
> > platform_get_resource() may fail and return NULL, so we should
> > better check it's return value to avoid a NULL pointer dereference.
> > 
> > Fixes: 54da3e381c2b ("serial: 8250_aspeed_vuart: use UPF_IOREMAP to set up register mapping")
> > Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> > ---
> >  drivers/tty/serial/8250/8250_aspeed_vuart.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> > index 93fe10c680fb..9d2a7856784f 100644
> > --- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
> > +++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> > @@ -429,6 +429,8 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
> >  	timer_setup(&vuart->unthrottle_timer, aspeed_vuart_unthrottle_exp, 0);
> >  
> >  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (!res)
> > +		return -EINVAL;
> 
> How did you test this change was correct?

Hi,

   I look into the implementation of platform_get_resource(),
and do cross-check the usages of it in the codebase, especially
the usages in other probe function. 
And I go through some simliar bugfix commits in the revision history??
add check for return value of platform_get_resource() in probe
functions?to learn the way to fix this kind of bugs. 
But sorry I don't have the corresponding device for running test.

