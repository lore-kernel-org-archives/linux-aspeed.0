From: Stephen Boyd <sboyd@kernel.org>
Date: Fri, 06 Sep 2019 15:03:07 -0700
Subject: [PATCH 2/2] clk: Add support for AST2600 SoC
In-Reply-To: <CACPK8Xf3C36KMgDmmRtNFqVFHzZx81ko+=54PA4+d5xPitum3g@mail.gmail.com>
References: <20190816155806.22869-1-joel@jms.id.au>
 <20190816155806.22869-3-joel@jms.id.au>
 <20190816171441.3B8F720665@mail.kernel.org>
 <CACPK8Xf3C36KMgDmmRtNFqVFHzZx81ko+=54PA4+d5xPitum3g@mail.gmail.com>
Message-ID: <20190906220308.6C8742081B@mail.kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Quoting Joel Stanley (2019-08-18 19:03:54)
> On Fri, 16 Aug 2019 at 17:14, Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Joel Stanley (2019-08-16 08:58:06)
> > > +static const char * const vclk_parent_names[] = {
> >
> > Can you use the new way of specifying clk parents instead of just using
> > strings?
> 
> How does this work? I had a browse of the APIs in clk-provider.h and
> it appeared the functions all take char *s still.

Sorry I didn't reply earlier. I'm going to write a kernel-doc to
describe how to write a "modern" clk driver which should hopefully help
here.

The gist is that you can fill out a clk_parent_data array or a clk_hw
array and set the .name and .fw_name and .index in the clk_parent_data
array to indicate which clks to get from the DT node's "clocks" and
"clock-names" properties.

> 
> > > +       hw = clk_hw_register_fixed_factor(NULL, "ahb", "hpll", 0, 1, axi_div * ahb_div);

Take this one for example. If 'hpll' is actually a clk_hw pointer in
hand, then you could do something like:

	clk_hw_register_fixed_factor_parent_hw(NULL, "ahb", &hpll, 0, 1, axi_div * ahb_div);

And if it's something like a clock from DT you could do

	struct clk_parent_data pdata = {
		.name = "hpll",
		.fw_name = <clock-names string>,
		.index = <whatever clock index it is>
	};

	clk_hw_register_fixed_factor_parent_data(NULL, "ahb", &pdata, 0, 1, axi_div * ahb_div);

I haven't actually written the clk_hw_register_fixed_factor_*() APIs,
because I'm thinking that it would be better to register the pdata with
some more parameters so that the
clk_hw_register_fixed_factor_parent_data() API becomes more like:

	clk_hw_register_fixed_factor_parent_data(NULL, "ahb", "hpll",
		<clock-names string>, <whatever clock index it is>, 0, 1,
		axi_div * ahb_div);

Because there's only one parent. For the mux clk it will be a pointer to
parent_data because I don't see a way around it.

> >
> > There aren't checks for if these things fail. I guess it doesn't matter
> > and just let it fail hard?
> 
> I think that's sensible here. If the system has run out of memory this
> early on then there's not going to be much that works.
> 
> Thanks for the review. I've fixed all of the style issues you
> mentioned, but would appreciate some guidance on the parent API.
> 

Cool! Thanks.

