From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 25 Jan 2021 11:17:24 +1030
Subject: [PATCH 1/1] clk: aspeed: modify some default clks are critical
In-Reply-To: <HK0PR06MB338049BAE1D1DAE7567F620DF2A00@HK0PR06MB3380.apcprd06.prod.outlook.com>
References: <20200928070108.14040-1-ryan_chen@aspeedtech.com>
 <20200928070108.14040-2-ryan_chen@aspeedtech.com>
 <160264382296.310579.9835482254268204873@swboyd.mtv.corp.google.com>
 <CACPK8Xe-_hTey7hTJjG2-EcDsTN0qOw3bWBcrZZohEK3QOJuvg@mail.gmail.com>
 <160269577311.884498.8429245140509326318@swboyd.mtv.corp.google.com>
 <adadc9ef-32ab-0a79-327c-c499c1c04093@sholland.org>
 <HK0PR06MB338049BAE1D1DAE7567F620DF2A00@HK0PR06MB3380.apcprd06.prod.outlook.com>
Message-ID: <57a20436-5d12-4f7c-b413-0cd1908acf02@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 22 Jan 2021, at 18:45, Ryan Chen wrote:
> Hello,
> 	How about this patch progress?
> 	It does impact a lot of machine that when BMC boot at u-boot. 
> 	SUART is work for Host. But after boot into kernel, due to the clk disabled. 
> 	The SUART is not work for Host anymore. 

Maybe it's worth taking Ryan's patch for now, and when the protected-clocks 
binding gets merged we can rip out the CLK_IS_CRITICAL flags and convert the 
Aspeed devicetrees to use protected-clocks instead?

The only issue I see with that plan is it becomes ambiguous as to which clock 
each platform considers crititical/in-need-of-protection.

Andrew

> 
> Regards,
> Ryan
> > -----Original Message-----
> > From: Samuel Holland <samuel@sholland.org>
> > Sent: Thursday, October 29, 2020 10:25 AM
> > To: Stephen Boyd <sboyd@kernel.org>; Joel Stanley <joel@jms.id.au>
> > Cc: Andrew Jeffery <andrew@aj.id.au>; Michael Turquette
> > <mturquette@baylibre.com>; Ryan Chen <ryan_chen@aspeedtech.com>;
> > BMC-SW <BMC-SW@aspeedtech.com>; Linux ARM
> > <linux-arm-kernel@lists.infradead.org>; linux-aspeed
> > <linux-aspeed@lists.ozlabs.org>; linux-clk at vger.kernel.org; Linux Kernel
> > Mailing List <linux-kernel@vger.kernel.org>
> > Subject: Re: Re: [PATCH 1/1] clk: aspeed: modify some default clks are critical
> > 
> > Stephen,
> > 
> > On 10/14/20 12:16 PM, Stephen Boyd wrote:
> > > Quoting Joel Stanley (2020-10-13 22:28:00)
> > >> On Wed, 14 Oct 2020 at 02:50, Stephen Boyd <sboyd@kernel.org> wrote:
> > >>>
> > >>> Quoting Ryan Chen (2020-09-28 00:01:08)
> > >>>> In ASPEED SoC LCLK is LPC clock for all SuperIO device, UART1/UART2
> > >>>> are default for Host SuperIO UART device, eSPI clk for Host eSPI
> > >>>> bus access eSPI slave channel, those clks can't be disable should
> > >>>> keep default, otherwise will affect Host side access SuperIO and SPI slave
> > device.
> > >>>>
> > >>>> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> > >>>> ---
> > >>>
> > >>> Is there resolution on this thread?
> > >>
> > >> Not yet.
> > >>
> > >> We have a system where the BMC (management controller) controls some
> > >> clocks, but the peripherals that it's clocking are outside the BMC's
> > >> control. In this case, the host processor us using some UARTs and
> > >> what not independent of any code running on the BMC.
> > >>
> > >> Ryan wants to have them marked as critical so the BMC never powers them
> > down.
> > >>
> > >> However, there are systems that don't use this part of the soc, so
> > >> for those implementations they are not critical and Linux on the BMC
> > >> can turn them off.
> > >>
> > >> Do you have any thoughts? Has anyone solved a similar problem already?
> > >>
> > >
> > > Is this critical clocks in DT? Where we want to have different DT for
> > > different device configurations to indicate that some clks should be
> > > marked critical so they're never turned off and other times they
> > > aren't so they're turned off?
> > >
> > > It also sounds sort of like the protected-clocks binding. Where you
> > > don't want to touch certain clks depending on the usage configuration
> > > of the SoC. There is a patch to make that generic that I haven't
> > > applied because it looks wrong at first glance[1]. Maybe not
> > > registering those clks to the framework on the configuration that Ryan has is
> > good enough?
> > 
> > Could you please be more specific than the patch "looks wrong"? I'm more
> > than happy to update the patch to address your concerns, but I cannot do that
> > unless I know what your concerns are.
> > 
> > Regards,
> > Samuel
> > 
> > > [1]
> > > https://lore.kernel.org/r/20200903040015.5627-2-samuel at sholland.org
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
