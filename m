From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 08 Nov 2021 10:12:38 +1030
Subject: [PATCH 05/10] mmc: aspeed: Adjust delay taps calculation method
In-Reply-To: <HK0PR06MB2786C1ED2463764EAAEA7166B28F9@HK0PR06MB2786.apcprd06.prod.outlook.com>
References: <20210922103116.30652-1-chin-ting_kuo@aspeedtech.com>
 <20210922103116.30652-6-chin-ting_kuo@aspeedtech.com>
 <95669b37-d512-4439-86cb-418ab085118f@www.fastmail.com>
 <HK0PR06MB2786C1ED2463764EAAEA7166B28F9@HK0PR06MB2786.apcprd06.prod.outlook.com>
Message-ID: <30748da1-0fdb-40c1-bf28-8682d3a89c73@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Chin-Ting,

I've had another think about this, see my comments below.

On Sat, 6 Nov 2021, at 20:35, Chin-Ting Kuo wrote:
> Hi Andrew,
>> >  struct aspeed_sdhci_pdata {
>> > @@ -158,43 +160,60 @@ aspeed_sdc_set_phase_taps(struct aspeed_sdc
>> > *sdc,  }
>> >
>> >  #define PICOSECONDS_PER_SECOND		1000000000000ULL
>> > -#define ASPEED_SDHCI_NR_TAPS		15
>> > -/* Measured value with *handwave* environmentals and static loading */
>> > -#define ASPEED_SDHCI_MAX_TAP_DELAY_PS	1253
>> > +#define ASPEED_SDHCI_MAX_TAPS		15
>> 
>> Why are we renaming this? It looks to cause a bit of noise in the diff.
>> 
>
> Okay, it can be changed back to the original one in the next patch version.

Well, maybe it makes sense, but I think we have to take into account 
how we describe the taps in the discussion below.

>> > -	if (phase_deg >= 180) {
>> > -		inverted = ASPEED_SDHCI_TAP_PARAM_INVERT_CLK;
>> > -		phase_deg -= 180;
>> > -		dev_dbg(dev,
>> > -			"Inverting clock to reduce phase correction from %d to %d
>> degrees\n",
>> > -			phase_deg + 180, phase_deg);
>> > -	} else {
>> > -		inverted = 0;
>> > +	prop_delay_ps = sdc->max_tap_delay_ps / nr_taps;
>> > +	clk_period_ps = div_u64(PICOSECONDS_PER_SECOND, (u64)rate_hz);
>> > +
>> > +	/*
>> > +	 * For ast2600, if clock phase degree is negative, clock signal is
>> > +	 * output from falling edge first by default. Namely, clock signal
>> > +	 * is leading to data signal by 90 degrees at least.
>> > +	 */
>> 
>> Have I missed something about a asymmetric clock timings? Otherwise the
>> falling edge is 180 degrees away from the rising edge? I'm still not clear on
>> why 90 degrees is used here.
>> 
>
> Oh, you are right. It should be 180 degrees.
>
>> > +	if (invert) {
>> > +		if (phase_deg >= 90)
>> > +			phase_deg -= 90;
>> > +		else
>> > +			phase_deg = 0;
>> 
>> Why are we throwing away information?
>> 
>
> With the above correction, it should be modified as below.
> If the "invert" is needed, we expect that its value should be greater than 180
> degrees. We clear "phase_deg" if its value is unexpected. Maybe, a warning
> should be shown and -EINVAL can be returned.
>
> if (invert) {
> 	if (phase_deg >= 180)
> 		phase_deg -= 180;
> 	else
> 		phase_deg = 0;

Though we want this to return the EINVAL right?

\>> > +		/*
>> > +		 * There are 15 taps recorded in AST2600 datasheet.
>> > +		 * But, actually, the time period of the first tap
>> > +		 * is two times of others. Thus, 16 tap is used to
>> > +		 * emulate this situation.
>> > +		 */
>> > +		.nr_taps = 16,
>> 
>> I think this is a very indirect way to communicate the problem. The only time
>> we look at nr_taps is in a test that explicitly compensates for the non-uniform
>> delay. I think we should just have a boolean struct member called
>> 'non_uniform_delay' rather than 'nr_taps', as the number of taps isn't what's
>> changing. But also see the discussion below about a potential
>> aspeed,tap-delays property.
>> 
>
> A new property may be the better choice.

I think I'm changing my mind on this sorry.

I'm think that aiming for fewer custom devicetree properties is better.

Using SoC-specific and device-specific compatibles (i.e. to 
differentiate between the eMMC and SD controllers in the 2600) we can 
just encode this data straight in the driver using the OF match data.

Rob and/or Joel: Thoughts?

>
>> Something further to consider is whether we
>> separate the compatibles or add e.g. an aspeed,tap-delays property that
>> specifies the specific delay of each logic element. This might take the place of
>> e.g. the max-tap-delay property?
>> 
>
> Yes, an additional property may be better.

Again, flip-flopping on this a bit, the aspeed,ast2600-emmc compatible 
is probably fine, and we add the tap delays in the OF match data for 
the compatible. This means we get rid of any aspeed-specific devictree 
properties with respect to the delays.

Andrew
