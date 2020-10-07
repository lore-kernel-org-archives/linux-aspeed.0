From: Joel Stanley <joel@jms.id.au>
Date: Wed, 7 Oct 2020 11:34:01 +0000
Subject: [PATCH 1/1] clk: aspeed: modify some default clks are critical
In-Reply-To: <HK0PR06MB338059A24B66C14675298D0BF2320@HK0PR06MB3380.apcprd06.prod.outlook.com>
References: <20200928070108.14040-1-ryan_chen@aspeedtech.com>
 <20200928070108.14040-2-ryan_chen@aspeedtech.com>
 <CACPK8XcjmxBGUfDxE2WB3zBgG8OCoRMogfG=Fk5f+wNZu0pjMg@mail.gmail.com>
 <HK0PR06MB338059A24B66C14675298D0BF2320@HK0PR06MB3380.apcprd06.prod.outlook.com>
Message-ID: <CACPK8XdBmkhZ8mcSFmDAFV8k7Qj7ajBL8TVKfK8c+5aneUMHZw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 29 Sep 2020 at 08:40, Ryan Chen <ryan_chen@aspeedtech.com> wrote:
>
> > From: Joel Stanley <joel@jms.id.au>
> > Sent: Tuesday, September 29, 2020 4:04 PM
> > To: Ryan Chen <ryan_chen@aspeedtech.com>; Jae Hyun Yoo
> > <jae.hyun.yoo@linux.intel.com>; Andrew Jeffery <andrew@aj.id.au>
> > Cc: Michael Turquette <mturquette@baylibre.com>; Stephen Boyd
> > <sboyd@kernel.org>; linux-clk at vger.kernel.org; Linux ARM
> > <linux-arm-kernel@lists.infradead.org>; linux-aspeed
> > <linux-aspeed@lists.ozlabs.org>; Linux Kernel Mailing List
> > <linux-kernel@vger.kernel.org>; BMC-SW <BMC-SW@aspeedtech.com>
> > Subject: Re: [PATCH 1/1] clk: aspeed: modify some default clks are critical
> >
> > On Mon, 28 Sep 2020 at 07:01, Ryan Chen <ryan_chen@aspeedtech.com>
> > wrote:
> > >
> > > In ASPEED SoC LCLK is LPC clock for all SuperIO device, UART1/UART2
> > > are default for Host SuperIO UART device, eSPI clk for Host eSPI bus
> > > access eSPI slave channel, those clks can't be disable should keep
> > > default, otherwise will affect Host side access SuperIO and SPI slave device.
> > >
> > > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> > > ---
> > >  drivers/clk/clk-aspeed.c  | 8 ++++----  drivers/clk/clk-ast2600.c | 8
> > > ++++----
> > >  2 files changed, 8 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c index
> > > 411ff5fb2c07..d348c4fd3f9f 100644
> > > --- a/drivers/clk/clk-aspeed.c
> > > +++ b/drivers/clk/clk-aspeed.c
> > > @@ -54,15 +54,15 @@ static const struct aspeed_gate_data aspeed_gates[]
> > = {
> > >         [ASPEED_CLK_GATE_DCLK] =        {  5, -1, "dclk-gate",
> > NULL,   CLK_IS_CRITICAL }, /* DAC */
> > >         [ASPEED_CLK_GATE_REFCLK] =      {  6, -1, "refclk-gate",
> > "clkin", CLK_IS_CRITICAL },
> > >         [ASPEED_CLK_GATE_USBPORT2CLK] = {  7,  3, "usb-port2-gate",
> > NULL,   0 }, /* USB2.0 Host port 2 */
> > > -       [ASPEED_CLK_GATE_LCLK] =        {  8,  5, "lclk-gate",
> > NULL,   0 }, /* LPC */
> > > +       [ASPEED_CLK_GATE_LCLK] =        {  8,  5, "lclk-gate",
> > NULL,   CLK_IS_CRITICAL }, /* LPC */
> > >         [ASPEED_CLK_GATE_USBUHCICLK] =  {  9, 15, "usb-uhci-gate",
> > NULL,   0 }, /* USB1.1 (requires port 2 enabled) */
> > >         [ASPEED_CLK_GATE_D1CLK] =       { 10, 13, "d1clk-gate",
> > NULL,   0 }, /* GFX CRT */
> > >         [ASPEED_CLK_GATE_YCLK] =        { 13,  4, "yclk-gate",
> > NULL,   0 }, /* HAC */
> > >         [ASPEED_CLK_GATE_USBPORT1CLK] = { 14, 14, "usb-port1-gate",
> > NULL,   0 }, /* USB2 hub/USB2 host port 1/USB1.1 dev */
> > > -       [ASPEED_CLK_GATE_UART1CLK] =    { 15, -1, "uart1clk-gate",
> > "uart", 0 }, /* UART1 */
> > > -       [ASPEED_CLK_GATE_UART2CLK] =    { 16, -1, "uart2clk-gate",
> > "uart", 0 }, /* UART2 */
> > > +       [ASPEED_CLK_GATE_UART1CLK] =    { 15, -1, "uart1clk-gate",
> > "uart", CLK_IS_CRITICAL }, /* UART1 */
> > > +       [ASPEED_CLK_GATE_UART2CLK] =    { 16, -1, "uart2clk-gate",
> > "uart", CLK_IS_CRITICAL }, /* UART2 */
> > >         [ASPEED_CLK_GATE_UART5CLK] =    { 17, -1, "uart5clk-gate",
> > "uart", 0 }, /* UART5 */
> > > -       [ASPEED_CLK_GATE_ESPICLK] =     { 19, -1, "espiclk-gate",
> > NULL,   0 }, /* eSPI */
> > > +       [ASPEED_CLK_GATE_ESPICLK] =     { 19, -1, "espiclk-gate",
> > NULL,   CLK_IS_CRITICAL }, /* eSPI */
> >
> > This is fine for systems that have eSPI. For systems that do not use eSPI, the
> > clocks are not "required".
> >
> > I was sent a similar patch by Jae some time ago:
> >
> >
> > https://lore.kernel.org/openbmc/697a184b-ef99-a46e-bf98-4d339b3aafd8 at lin
> > ux.intel.com/
> >
> > Better is to associate drivers with these clocks, and those drivers will ensure
> > they are left enabled.
> >
> > Alternatively, we will need to come up with a device tree binding to describe
> > the hardware requirement that these clocks are left on.
> >
> ASPEED BMC SoC have SuperIO device that default enable, even without BMC fw boot.
> Host can use SUART1/SUART2/GPIO....
> That the reason even Linux kernel boot should not change the SoC default clk, that is the impact.

Ok, that makes sense. Linux will not enable these clocks if a driver
is loaded for them though, so we should load a driver for them.

ESPI: We do not have an upstream driver for eSPI, but once you submit
one this will solve the eSPI issue.

LPC: The existing LPC driver will enable the clock, so by loading that
this clock will be left enabled.

UART1/UART2: This is harder, as the SUART mode means the BMC does not
load a driver for these devices. We could add a property to the device
tree to describe the clocks that must be left on?

Cheers,

Joel
