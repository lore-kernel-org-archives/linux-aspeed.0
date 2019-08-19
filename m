From: Joel Stanley <joel@jms.id.au>
Date: Mon, 19 Aug 2019 02:03:54 +0000
Subject: [PATCH 2/2] clk: Add support for AST2600 SoC
In-Reply-To: <20190816171441.3B8F720665@mail.kernel.org>
References: <20190816155806.22869-1-joel@jms.id.au>
 <20190816155806.22869-3-joel@jms.id.au>
 <20190816171441.3B8F720665@mail.kernel.org>
Message-ID: <CACPK8Xf3C36KMgDmmRtNFqVFHzZx81ko+=54PA4+d5xPitum3g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 16 Aug 2019 at 17:14, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Joel Stanley (2019-08-16 08:58:06)
> > diff --git a/drivers/clk/clk-ast2600.c b/drivers/clk/clk-ast2600.c
> > new file mode 100644
> > index 000000000000..083d5299238c
> > --- /dev/null
> > +++ b/drivers/clk/clk-ast2600.c
> > @@ -0,0 +1,701 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +// Copyright IBM Corp
> > +// Copyright ASPEED Technology
> > +
> [...]
> > +#define ASPEED_DPLL_PARAM              0x260
> > +
> > +#define ASPEED_G6_STRAP1               0x500
> > +
> > +/* Globally visible clocks */
> > +static DEFINE_SPINLOCK(aspeed_clk_lock);
>
> I guess we can be guaranteed that the two drivers aren't compiled into
> the same image? Otherwise this will alias with clk-aspeed.c and make
> kallsyms annoying to use.

I will change the name.

>
> > +
> > +/* Keeps track of all clocks */
> > +static struct clk_hw_onecell_data *aspeed_g6_clk_data;
> > +
> > +static void __iomem *scu_g6_base;
> > +
> > +static const struct aspeed_gate_data aspeed_g6_gates[] = {
> > +       /*                                  clk rst  name               parent   flags */
> > +       [ASPEED_CLK_GATE_MCLK]          = {  0, -1, "mclk-gate",        "mpll",  CLK_IS_CRITICAL }, /* SDRAM */
>
> Please document CLK_IS_CRITICAL usage. I guess it's memory so never turn
> it off?

Yes.

I added some comments and removed some uses that I didn't know the
reason for. We can add them back later if required, with the
reasoning.

> > +static const char * const vclk_parent_names[] = {
>
> Can you use the new way of specifying clk parents instead of just using
> strings?

How does this work? I had a browse of the APIs in clk-provider.h and
it appeared the functions all take char *s still.

> > +       hw = clk_hw_register_fixed_factor(NULL, "ahb", "hpll", 0, 1, axi_div * ahb_div);
>
> There aren't checks for if these things fail. I guess it doesn't matter
> and just let it fail hard?

I think that's sensible here. If the system has run out of memory this
early on then there's not going to be much that works.

Thanks for the review. I've fixed all of the style issues you
mentioned, but would appreciate some guidance on the parent API.

Cheers,

Joel
