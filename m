From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Tue, 23 Aug 2022 10:51:09 +0000
Subject: [PATCH] pinctrl: aspeed: Force to disable the function's signal
In-Reply-To: <6845561a-cb33-4939-a760-2a5722134851@www.fastmail.com>
References: <20220818101839.28860-1-billy_tsai@aspeedtech.com>
 <6845561a-cb33-4939-a760-2a5722134851@www.fastmail.com>
Message-ID: <E0E8F46E-145A-4180-8AAA-788150F0C44A@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


Hi Andrew,

On 2022/8/19, 8:40 AM, "Andrew Jeffery" <andrew@aj.id.au> wrote:

    > Hi Billy,

    On Thu, 18 Aug 2022, at 19:48, Billy Tsai wrote:
    > > When the driver want to disable the signal of the function, it doesn't
    > > need to query the state of the mux function's signal on a pin. The
    > > condition below will miss the disable of the signal:
    > > Ball | Default | P0 Signal | P0 Expression               | Other
    > > -----+---------+-----------+-----------------------------+----------
    > >  E21   GPIOG0    SD2CLK      SCU4B4[16]=1 & SCU450[1]=1    GPIOG0
    > > -----+---------+-----------+-----------------------------+----------
    > >  B22   GPIOG1    SD2CMD      SCU4B4[17]=1 & SCU450[1]=1    GPIOG1
    > > -----+---------+-----------+-----------------------------+----------
    > > Assume the register status like below:
    > > SCU4B4[16] == 1 & SCU4B4[17] == 1 & SCU450[1]==1
    > > After the driver set the Ball E21 to the GPIOG0:
    > > SCU4B4[16] == 0 & SCU4B4[17] == 1 & SCU450[1]==0
    > > When the driver want to set the Ball B22 to the GPIOG1, the condition of
    > > the SD2CMD will be false causing SCU4B4[17] not to be cleared.
    > >
    > > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
    > > ---
    > >  drivers/pinctrl/aspeed/pinctrl-aspeed.c | 11 +----------
    > >  1 file changed, 1 insertion(+), 10 deletions(-)
    > >
    > > diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed.c 
    > > b/drivers/pinctrl/aspeed/pinctrl-aspeed.c
    > > index 83d47ff1cea8..a30912a92f05 100644
    > > --- a/drivers/pinctrl/aspeed/pinctrl-aspeed.c
    > > +++ b/drivers/pinctrl/aspeed/pinctrl-aspeed.c
    > > @@ -92,19 +92,10 @@ static int aspeed_sig_expr_enable(struct 
    > > aspeed_pinmux_data *ctx,
    > >  static int aspeed_sig_expr_disable(struct aspeed_pinmux_data *ctx,
    > >  				   const struct aspeed_sig_expr *expr)
    > >  {
    > > -	int ret;
    > > -
    > >  	pr_debug("Disabling signal %s for %s\n", expr->signal,
    > >  		 expr->function);
    > > 
    > > -	ret = aspeed_sig_expr_eval(ctx, expr, true);
    > > -	if (ret < 0)
    > > -		return ret;
    > > -
    > > -	if (ret)
    > > -		return aspeed_sig_expr_set(ctx, expr, false);
    > > -
    > > -	return 0;
    > > +	return aspeed_sig_expr_set(ctx, expr, false);

    > Okay, maybe I was short-circuiting things in a way that wasn't quite 
    > right. However, I'm a little nervous that we'll end up whacking state 
    > that we can't restore and give ourselves mux-request ordering problems. 
    > The Aspeed pin controllers are such a complex sea of state. Hopefully 
    > we get away without needing to fix the theory behind the driver's 
    > implementation.

    > This code is common to the 2400, 2500 and 2600, have you tested the 
    > patch on platforms for each to get coverage for the various pin state 
    > expressions we have?

I think that we just need to make sure that the logic of the driver is the same as the Aspeed
Datasheet table 5.1 => Revert all settings of the higher priority function and apply the
the setting of the current function, then the pinmux will belong to that function.
I have confirmed the design logic with our designer and it can adapt to 2400 and 2500.
This concept also covers the original driver logic which invalidates the condition of the higher
priority function.

    > I also wonder if we can write kunit tests to build some confidence with 
    > the expected SCU bit state patterns for a given set of desired mux 
    > states. Is this something you've looked at (it would be handy if kunit 
    > can intercept regmap accesses)?

I didn't look at it.

Billy

    > Andrew


