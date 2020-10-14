From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Wed, 14 Oct 2020 05:39:08 +0000
Subject: [PATCH 1/1] clk: aspeed: modify some default clks are critical
In-Reply-To: <CACPK8Xe-_hTey7hTJjG2-EcDsTN0qOw3bWBcrZZohEK3QOJuvg@mail.gmail.com>
References: <20200928070108.14040-1-ryan_chen@aspeedtech.com>
 <20200928070108.14040-2-ryan_chen@aspeedtech.com>
 <160264382296.310579.9835482254268204873@swboyd.mtv.corp.google.com>
 <CACPK8Xe-_hTey7hTJjG2-EcDsTN0qOw3bWBcrZZohEK3QOJuvg@mail.gmail.com>
Message-ID: <HK0PR06MB33800F099D8191D0EC65A2E7F2050@HK0PR06MB3380.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Joel Stanley <joel@jms.id.au>
> Sent: Wednesday, October 14, 2020 1:28 PM
> To: Stephen Boyd <sboyd@kernel.org>
> Cc: Andrew Jeffery <andrew@aj.id.au>; Michael Turquette
> <mturquette@baylibre.com>; Ryan Chen <ryan_chen@aspeedtech.com>;
> BMC-SW <BMC-SW@aspeedtech.com>; Linux ARM
> <linux-arm-kernel@lists.infradead.org>; linux-aspeed
> <linux-aspeed@lists.ozlabs.org>; linux-clk at vger.kernel.org; Linux Kernel
> Mailing List <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH 1/1] clk: aspeed: modify some default clks are critical
> 
> On Wed, 14 Oct 2020 at 02:50, Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Ryan Chen (2020-09-28 00:01:08)
> > > In ASPEED SoC LCLK is LPC clock for all SuperIO device, UART1/UART2
> > > are default for Host SuperIO UART device, eSPI clk for Host eSPI bus
> > > access eSPI slave channel, those clks can't be disable should keep
> > > default, otherwise will affect Host side access SuperIO and SPI slave device.
> > >
> > > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> > > ---
> >
> > Is there resolution on this thread?
> 
> Not yet.
> 
> We have a system where the BMC (management controller) controls some
> clocks, but the peripherals that it's clocking are outside the BMC's control. In
> this case, the host processor us using some UARTs and what not independent of
> any code running on the BMC.
> 
> Ryan wants to have them marked as critical so the BMC never powers them
> down.
> 
> However, there are systems that don't use this part of the soc, so for those
> implementations they are not critical and Linux on the BMC can turn them off.
> 
Take an example, conflict thought about ASPEED_CLK_GATE_BCLK is CLK_IS_CRITICAL in clk-ast2600.c
In my opinion, the driver should keep the SoC default clk setting. It is original chip feature.  

> Do you have any thoughts? Has anyone solved a similar problem already?
> 
