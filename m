From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Fri, 17 Feb 2023 17:43:04 +0800
Subject: [PATCH 2/4] i3c: dw: Add platform operations
In-Reply-To: <9b374250-3afc-6277-d1c6-0dac1c682bca@sifive.com>
References: <cover.1676532146.git.jk@codeconstruct.com.au>
	 <eb90bc9ee9f72efc2012abce3e4e50186552e194.1676532146.git.jk@codeconstruct.com.au>
	 <9b374250-3afc-6277-d1c6-0dac1c682bca@sifive.com>
Message-ID: <578ac18169e21c13445d29d3c99de04e9fc6888e.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Ben,

Thanks for taking a look at the patch. My responses inline (just
re-ordered, simple stuff first)

> > ? struct dw_i3c_i2c_dev_data {
> > @@ -612,6 +623,12 @@ static int dw_i3c_master_bus_init(struct i3c_master_controller *m)
> > ????????u32 thld_ctrl;
> > ????????int ret;
> > ? 
> > +???????if (master->platform_ops && master->platform_ops->init) {
> > +???????????????ret = master->platform_ops->init(master);
> > +???????????????if (ret)
> > +???????????????????????return ret;
> > +???????}
> 
> I'd rather have a "default" set of ops than have all this checking for
> NULL pointers all over the place.

Yep, that's a better structure, changed for v2.

> > @@ -1181,6 +1205,18 @@ static int dw_i3c_probe(struct platform_device *pdev)
> > ????????master->maxdevs = ret >> 16;
> > ????????master->free_pos = GENMASK(master->maxdevs - 1, 0);
> > ? 
> > +???????/* match any platform-specific ops */
> > +???????match = of_match_node(dw_i3c_master_of_match, pdev->dev.of_node);
> > +???????if (match && match->data)
> > +???????????????master->platform_ops = match->data;
> 
> I'm sure there's a of_device_get_match_data() which would have
> both removed hte need to move the match table around and the
> call to of_match_node().

That's the one I was looking for! Thanks for the pointer, I have updated
in v2.

> > @@ -241,6 +241,17 @@ struct dw_i3c_master {
> > ????????char version[5];
> > ????????char type[5];
> > ????????u8 addrs[MAX_DEVS];
> > +
> > +???????/* platform-specific data */
> > +???????const struct dw_i3c_platform_ops *platform_ops;
> > +???????union {
> > +???????} pdata;
> > +
> > +};
> > +
> > +struct dw_i3c_platform_ops {
> > +???????int (*probe)(struct dw_i3c_master *i3c, struct platform_device *pdev);
> > +???????int (*init)(struct dw_i3c_master *i3c);
> > ? };
> 
> Given the comment below having this and the main probe defined in a 
> header so users can just call in and we don't have to change the
> main code here every time someone comes up with their own
> special way of handing this?

I'm not sure I 100% understand the intention here - is it that we'd
split the platform-specific code into entirely new drivers, and have
those call into dw_i3c_probe() (presumably doing a bit of custom init
either before or after that call)?

If so: I think the platform support should stay fairly minimal, so I'm
not sure that warrants a new driver for each instance. In the ast2600
case it's just a couple of extra reg writes in the i3c init path. I'd be
reluctant to split that out completely at this stage - but if this does
grow, we can certainly reconsider.

Also, I'd like to allow for the case where the platform-specific parts
may access the fields of struct dw_i3c_master; with this approach we
don't need to expose that struct outside of the single driver.

Cheers,


Jeremy
