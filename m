From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 27 May 2021 12:34:38 +0930
Subject: [PATCH v1 4/4] gpio: gpio-aspeed-sgpio: Add AST2600 sgpio support
In-Reply-To: <20210527023455.GA9971@aspeedtech.com>
References: <20210526094609.14068-1-steven_lee@aspeedtech.com>
 <20210526094609.14068-5-steven_lee@aspeedtech.com>
 <0826dc6a-1c76-4301-985e-7885eb0e151d@www.fastmail.com>
 <20210527023455.GA9971@aspeedtech.com>
Message-ID: <3a9513fa-bdd2-45c9-bb4a-18ae3953d28a@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 27 May 2021, at 12:04, Steven Lee wrote:
> The 05/27/2021 09:26, Andrew Jeffery wrote:
> > Hi Steven,
> > 
> > On Wed, 26 May 2021, at 19:16, Steven Lee wrote:
> > >  	struct aspeed_sgpio *gpio = gpiochip_get_data(gc);
> > > -	const struct aspeed_sgpio_bank *bank = to_bank(offset);
> > >  	unsigned long flags;
> > >  	enum aspeed_sgpio_reg reg;
> > >  	int rc = 0;
> > >  
> > >  	spin_lock_irqsave(&gpio->lock, flags);
> > >  
> > > -	reg = aspeed_sgpio_is_input(offset) ? reg_val : reg_rdata;
> > > -	rc = !!(ioread32(bank_reg(gpio, bank, reg)) & GPIO_BIT(offset));
> > > +	reg = aspeed_sgpio_is_input(offset, gpio->max_ngpios) ? reg_val : 
> > > reg_rdata;
> > 
> > We should just pass gpio here (i.e. make aspeed_sgpio_is_input take a 
> > 'const struct aspeed_sgpio *' parameter), rather than open-coding 
> > gpio->max_ngpios. This approach will make it easier to refactor the 
> > implementation in the future (if necessary).
> > 
> 
> I will rewrite the function to use aspeed_sgpio struct.


> > >  	struct aspeed_sgpio *gpio = gpiochip_get_data(gc);
> > > -	const struct aspeed_sgpio_bank *bank = to_bank(offset);
> > >  	void __iomem *addr_r, *addr_w;
> > >  	u32 reg = 0;
> > >  
> > > -	if (aspeed_sgpio_is_input(offset))
> > > +	if (aspeed_sgpio_is_input(offset, gpio->max_ngpios))
> > >  		return -EINVAL;
> > >  
> > >  	/* Since this is an output, read the cached value from rdata, then
> > > @@ -209,9 +214,9 @@ static int sgpio_set_value(struct gpio_chip *gc, 
> > > unsigned int offset, int val)
> > >  	reg = ioread32(addr_r);
> > >  
> > >  	if (val)
> > > -		reg |= GPIO_BIT(offset);
> > > +		reg |= GPIO_BIT(offset % gpio->max_ngpios);
> > 
> > Pass gpio through GPIO_BIT() too.
> > 
> 
> I don't understand this comment.
> Could you describe more?

Oh, sure, what I was suggesting was to make a similar change to 
GPIO_BIT() as I suggested for aspeed_sgpio_is_input() above.

Hope that helps.

Andrew
