From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Date: Thu, 31 Mar 2022 08:34:42 +0000
Subject: [PATCH v4 08/11] spi: aspeed: Calibrate read timings
In-Reply-To: <d12860e6-cc56-6073-0bf2-bfae02cbbd88@kaod.org>
References: <20220325100849.2019209-1-clg@kaod.org>
 <20220325100849.2019209-9-clg@kaod.org>
 <HK0PR06MB2786548534B370AE0C691C32B21F9@HK0PR06MB2786.apcprd06.prod.outlook.com>
 <0ec477b5-e404-536f-ff60-39f43208c3cc@kaod.org>
 <HK0PR06MB27866B5CC29F46436A4F6230B2E19@HK0PR06MB2786.apcprd06.prod.outlook.com>
 <d12860e6-cc56-6073-0bf2-bfae02cbbd88@kaod.org>
Message-ID: <HK0PR06MB2786142465433B7BAFB0FEE4B2E19@HK0PR06MB2786.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi C?dric,

> -----Original Message-----
> From: C?dric Le Goater <clg@kaod.org>
> Sent: Thursday, March 31, 2022 3:16 PM
> To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>; linux-spi at vger.kernel.org;
> linux-mtd at lists.infradead.org
> Subject: Re: [PATCH v4 08/11] spi: aspeed: Calibrate read timings
> 
> Hello Chin-Ting,
> 
> >>> - Maybe, if the calibration process is not executed, the frequency
> >>> setting
> >> calculated from max_frequency in the device tree can be filled in
> >> FMC10 instead of using dumb slow one, 12.5MHz, always.
> >>
> >> Indeed.
> >>
> >>>    For example, except for uniform content case, the calibration
> >>> process will
> >> be ignored when SPI clock frequency in the device tree is smaller than
> 40MHz.
> >>> - The function, aspeed_2600_spi_clk_basic_setting, in [2] can be
> >>> added to
> >> support lower SPI clock frequency, e.g., 4MHz.
> >>>    For AST2600, SPI clock frequency can be calculated by
> >> HCLK/(FMC10[27:24] + FMC10[11:8]).
> >>
> >> Could you please send patches on top of this series ? Here are the
> branches :
> >>
> >
> > Of course. How do I provide you the patch? By private mail or send a PR?
> 
> We should discuss first by email on the openbmc@ and linux-aspeed@ lists.
> Please send as follow ups on top of v4.
> 

Okay.

> Using the openbmc tree should be easier :
> 
>       https://github.com/legoater/linux/commits/openbmc-5.15
> 
> > Besides, I may add a new callback function for this part due to
> > difference between AST2500 and AST2600.
> 
> ok.
> 
> Given all the reviews and tests that were done on AST2400, AST2500, AST2600
> platforms, I will be careful not to break the existing proposal.
> 
> Thanks,
> 
> C.
