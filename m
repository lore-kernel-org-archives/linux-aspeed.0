From: Stephen Boyd <sboyd@kernel.org>
Date: Wed, 14 Oct 2020 10:16:13 -0700
Subject: [PATCH 1/1] clk: aspeed: modify some default clks are critical
In-Reply-To: <CACPK8Xe-_hTey7hTJjG2-EcDsTN0qOw3bWBcrZZohEK3QOJuvg@mail.gmail.com>
References: <20200928070108.14040-1-ryan_chen@aspeedtech.com>
 <20200928070108.14040-2-ryan_chen@aspeedtech.com>
 <160264382296.310579.9835482254268204873@swboyd.mtv.corp.google.com>
 <CACPK8Xe-_hTey7hTJjG2-EcDsTN0qOw3bWBcrZZohEK3QOJuvg@mail.gmail.com>
Message-ID: <160269577311.884498.8429245140509326318@swboyd.mtv.corp.google.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Quoting Joel Stanley (2020-10-13 22:28:00)
> On Wed, 14 Oct 2020 at 02:50, Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Ryan Chen (2020-09-28 00:01:08)
> > > In ASPEED SoC LCLK is LPC clock for all SuperIO device, UART1/UART2 are
> > > default for Host SuperIO UART device, eSPI clk for Host eSPI bus access
> > > eSPI slave channel, those clks can't be disable should keep default,
> > > otherwise will affect Host side access SuperIO and SPI slave device.
> > >
> > > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> > > ---
> >
> > Is there resolution on this thread?
> 
> Not yet.
> 
> We have a system where the BMC (management controller) controls some
> clocks, but the peripherals that it's clocking are outside the BMC's
> control. In this case, the host processor us using some UARTs and what
> not independent of any code running on the BMC.
> 
> Ryan wants to have them marked as critical so the BMC never powers them down.
> 
> However, there are systems that don't use this part of the soc, so for
> those implementations they are not critical and Linux on the BMC can
> turn them off.
> 
> Do you have any thoughts? Has anyone solved a similar problem already?
> 

Is this critical clocks in DT? Where we want to have different DT for
different device configurations to indicate that some clks should be
marked critical so they're never turned off and other times they aren't
so they're turned off?

It also sounds sort of like the protected-clocks binding. Where you
don't want to touch certain clks depending on the usage configuration of
the SoC. There is a patch to make that generic that I haven't applied
because it looks wrong at first glance[1]. Maybe not registering those
clks to the framework on the configuration that Ryan has is good enough?

[1] https://lore.kernel.org/r/20200903040015.5627-2-samuel at sholland.org
