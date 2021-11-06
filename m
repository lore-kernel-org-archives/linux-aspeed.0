From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Date: Sat, 6 Nov 2021 10:01:23 +0000
Subject: [PATCH 02/10] sdhci: aspeed: Add SDR50 support
In-Reply-To: <125453f3-55d5-4b2a-afe8-6e76b268ce01@www.fastmail.com>
References: <20210922103116.30652-1-chin-ting_kuo@aspeedtech.com>
 <20210922103116.30652-3-chin-ting_kuo@aspeedtech.com>
 <125453f3-55d5-4b2a-afe8-6e76b268ce01@www.fastmail.com>
Message-ID: <HK0PR06MB27868D14ED8DF7550246674CB28F9@HK0PR06MB2786.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Andrew,

Thanks for the review.

> -----Original Message-----
> From: Andrew Jeffery <andrew@aj.id.au>
> Sent: Tuesday, October 26, 2021 8:31 AM
> Subject: Re: [PATCH 02/10] sdhci: aspeed: Add SDR50 support
> 
> Hi Chin-Ting,
> 
> Sorry for the delay in looking at your series.
> 
> On Wed, 22 Sep 2021, at 20:01, Chin-Ting Kuo wrote:
> > From the analog waveform analysis result, SD/SDIO controller of
> > AST2600 cannot always work well with 200MHz. The upper bound stable
> > frequency for SD/SDIO controller is 100MHz. Thus, SDR50 supported bit,
> > instead of SDR104, in capability 2 register should be set in advance.
> >
> > Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> > ---
> >  drivers/mmc/host/sdhci-of-aspeed.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-of-aspeed.c
> > b/drivers/mmc/host/sdhci-of-aspeed.c
> > index 6e4e132903a6..c6eaeb02e3f9 100644
> > --- a/drivers/mmc/host/sdhci-of-aspeed.c
> > +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> > @@ -35,6 +35,8 @@
> >  #define ASPEED_SDC_CAP1_1_8V           (0 * 32 + 26)
> >  /* SDIO{14,24} */
> >  #define ASPEED_SDC_CAP2_SDR104         (1 * 32 + 1)
> > +/* SDIO{14,24} */
> 
> I don't think we need to duplicate this comment.

Okay, it will be modified in the next patch version.

> 
> > +#define ASPEED_SDC_CAP2_SDR50          (1 * 32 + 0)
> 
> Can we keep the defines in increasing bit order (i.e. put
> ASPEED_SDC_CAP2_SDR50 above ASPEED_SDC_CAP2_SDR104)?
> 

Okay.

> >
> >  struct aspeed_sdc {
> >  	struct clk *clk;
> > @@ -410,11 +412,17 @@ static int aspeed_sdhci_probe(struct
> > platform_device *pdev)
> >  	sdhci_get_of_property(pdev);
> >
> >  	if (of_property_read_bool(np, "mmc-hs200-1_8v") ||
> > +		of_property_read_bool(np, "sd-uhs-sdr50") ||
> 
> Minor formatting issue, but can you make sure all the conditions are aligned
> vertically from the left?
> 

It will also be updated in the next patch version.

> >  	    of_property_read_bool(np, "sd-uhs-sdr104")) {
> >  		aspeed_sdc_set_slot_capability(host, dev->parent,
> ASPEED_SDC_CAP1_1_8V,
> >  					       true, slot);
> >  	}
> >
> > +	if (of_property_read_bool(np, "sd-uhs-sdr50")) {
> > +		aspeed_sdc_set_slot_capability(host, dev->parent,
> ASPEED_SDC_CAP2_SDR50,
> > +					       true, slot);
> > +	}
> > +
> >  	if (of_property_read_bool(np, "sd-uhs-sdr104")) {
> >  		aspeed_sdc_set_slot_capability(host, dev->parent,
> ASPEED_SDC_CAP2_SDR104,
> >  					       true, slot);
> > --
> > 2.17.1

Chin-Ting
