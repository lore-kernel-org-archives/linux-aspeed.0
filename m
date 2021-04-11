From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 12 Apr 2021 08:30:26 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_v2_10/21]_ipmi:_kcs=5Fbmc:_Turn_the_driver_data-str?=
 =?UTF-8?Q?uctures_inside-out?=
In-Reply-To: <YHCqR8/nZFB1HRgX@packtop>
References: <20210319062752.145730-1-andrew@aj.id.au>
 <20210319062752.145730-10-andrew@aj.id.au> <YG/Ql9z9X/mtOSvl@packtop>
 <ea34ee69-a266-4737-8450-4695d2d0fbd4@www.fastmail.com>
 <YG/zVv4XOo1HoLd1@packtop> <YHCqR8/nZFB1HRgX@packtop>
Message-ID: <e99e2e45-7810-4a24-a519-5204acee04ea@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Sat, 10 Apr 2021, at 04:56, Zev Weiss wrote:
> On Fri, Apr 09, 2021 at 01:25:26AM CDT, Zev Weiss wrote:
> >On Fri, Apr 09, 2021 at 12:59:09AM CDT, Andrew Jeffery wrote:
> >>On Fri, 9 Apr 2021, at 13:27, Zev Weiss wrote:
> >>>On Fri, Mar 19, 2021 at 01:27:41AM CDT, Andrew Jeffery wrote:
> >>>>-struct kcs_bmc *kcs_bmc_ipmi_alloc(struct device *dev, int sizeof_priv, u32 channel);
> >>>>-struct kcs_bmc *kcs_bmc_ipmi_alloc(struct device *dev, int sizeof_priv, u32 channel)
> >>>>+int kcs_bmc_ipmi_attach_cdev(struct kcs_bmc *kcs_bmc);
> >>>
> >>>Errant declaration again?
> >>
> >>As previously explained.
> >>
> >
> >This one seems like a slightly different category, because...
> >
> >>>
> >>>>+int kcs_bmc_ipmi_attach_cdev(struct kcs_bmc *kcs_bmc)
> >
> >...it's immediately followed by the definition of the very same function
> >that it just declared, so I can't see how its presence or absence could
> >make any functional difference to anything.  (So perhaps I should have
> >said "redundant" instead of "errant...again".)

This is is a small hack to fend off warnings from -Wmissing-declarations.

> >
> >It's fairly trivial of course given that it's gone by the end of the
> >series, but as long as there's going to be another iteration anyway it
> >seems like we might as well tidy it up?
> >
> 
> Oh, and otherwise:
> 
> Reviewed-by: Zev Weiss <zweiss@equinix.com>

Thanks.

Andrew
