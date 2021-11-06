From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Date: Sat, 6 Nov 2021 10:02:55 +0000
Subject: [PATCH 04/10] mmc: Add invert flag for clock phase signedness
In-Reply-To: <5a235916-f250-48ac-b931-6ec2c5c2ea5d@www.fastmail.com>
References: <20210922103116.30652-1-chin-ting_kuo@aspeedtech.com>
 <20210922103116.30652-5-chin-ting_kuo@aspeedtech.com>
 <5a235916-f250-48ac-b931-6ec2c5c2ea5d@www.fastmail.com>
Message-ID: <HK0PR06MB27861518CA84A9DC8D204AC1B28F9@HK0PR06MB2786.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Andrew,

> -----Original Message-----
> From: Andrew Jeffery <andrew@aj.id.au>
> Sent: Tuesday, October 26, 2021 8:53 AM
> Subject: Re: [PATCH 04/10] mmc: Add invert flag for clock phase signedness
> 
> On Wed, 22 Sep 2021, at 20:01, Chin-Ting Kuo wrote:
> > The clock phase degree may be between -360 to 360.
> > If the data signal is leading to the clock, the signedness of clock
> > phase is postive, otherwise, the signedness is negative.
> >
> > Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> 
> The implementation here can't be changed without a change to the binding
> documentation:
> 

Okay, the binding document will be changed in the next patch version.

> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Docume
> ntation/devicetree/bindings/mmc/mmc-controller.yaml?h=v5.15-rc7#n345
> 
> > ---
> >  drivers/mmc/core/host.c  | 10 ++++++----  include/linux/mmc/host.h |
> > 2 ++
> >  2 files changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c index
> > d4683b1d263f..c2de7cbc7838 100644
> > --- a/drivers/mmc/core/host.c
> > +++ b/drivers/mmc/core/host.c
> > @@ -214,14 +214,16 @@ static void mmc_retune_timer(struct timer_list
> > *t)  static void mmc_of_parse_timing_phase(struct device *dev, const char
> *prop,
> >  				      struct mmc_clk_phase *phase)  {
> > -	int degrees[2] = {0};
> > +	int degrees[4] = {0};
> >  	int rc;
> >
> > -	rc = device_property_read_u32_array(dev, prop, degrees, 2);
> > +	rc = device_property_read_u32_array(dev, prop, degrees, 4);
> >  	phase->valid = !rc;
> >  	if (phase->valid) {
> > -		phase->in_deg = degrees[0];
> > -		phase->out_deg = degrees[1];
> > +		phase->inv_in_deg = degrees[0] ? true : false;
> > +		phase->in_deg = degrees[1];
> > +		phase->inv_out_deg = degrees[2] ? true : false;
> > +		phase->out_deg = degrees[3];
> 
> This fundamentally breaks any in-tree users. We can't do this.
> 
> In terms of the binding, if negative phase values are something we must do,
> we can just extend the value range to include [-359, -1] right?

Yes, agree it and I tried it before. But, it seems that the device tree doesn't support
negative value with "-" prefixed and there is no device tree related API used to get
the negative value from .dts. Thus, I tried to add an additional flag to present
negative value.

> That avoids changing the type of the value positions in the manner this patch
> does.
> 
> Andrew

Chin-Ting
