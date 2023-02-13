From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Date: Mon, 13 Feb 2023 10:54:36 +0200 (EET)
Subject: [PATCH 3/4] serial: 8250: Add Aspeed UART driver
In-Reply-To: <KL1PR0601MB378160E42842A0A55947BF7191DD9@KL1PR0601MB3781.apcprd06.prod.outlook.com>
References: <20230210072643.2772-1-chiawei_wang@aspeedtech.com> <20230210072643.2772-4-chiawei_wang@aspeedtech.com> <2d389fc9-0d5-42a1-b6d7-695c70dcf0fe@linux.intel.com> <KL1PR0601MB378160E42842A0A55947BF7191DD9@KL1PR0601MB3781.apcprd06.prod.outlook.com>
Message-ID: <bc8a6d9c-48ec-e394-78d8-c53bc267af1c@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 13 Feb 2023, ChiaWei Wang wrote:

> > From: Ilpo J?rvinen <ilpo.jarvinen@linux.intel.com>
> > Sent: Friday, February 10, 2023 9:52 PM
> > 
> > On Fri, 10 Feb 2023, Chia-Wei Wang wrote:
> > 
> > > Add the driver for Aspeed UART/VUART devices, which are 16550A
> > > compatible. It is an wrapper to cover the generic 16550A operation
> > > while exetending DMA feature for the devices.
> > >
> > > Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> > > ---
> > >  drivers/tty/serial/8250/8250_aspeed.c | 502
> > ++++++++++++++++++++++++++
> > >  drivers/tty/serial/8250/Kconfig       |   8 +
> > >  drivers/tty/serial/8250/Makefile      |   1 +
> > 
> > Hi,
> > 
> > Before I look any further into this, could you please explain why this is made to
> > be entirely separate from what we have in
> >   drivers/tty/serial/8250/8250_aspeed_vuart.c
> > ?
> > 
> > I quickly went through some functions and they've significant parts in common
> > with no variations at all in many functions and you're defines are 1:1 too
> > (except for the DMA buf sizes). It would seem much better to add the missing
> > functionality into 8250_aspeed_vuart.c rather than creating something from
> > scratch with large overlap with existing code.
> > 
> > If you intend to keep it as a separate one, you should have a rather good
> > justification for it.
> 
> Yes, the main difference is the UART DMA support.
> However, due to the UDMA design is not quite fit to the DMAEngine, the implementation is kind of hacking.
> We thought leaving the original VUART driver unimpacted would be better.
> The UDMA covers both UART and VUART DMA support, and so do the new 8250_aspeed.c.

To me it seems rather weak reasoning.

If you want to go to this path, then you need to anyway share the common 
code between those two drivers rather than duplicating it. It's likely 
more work for you than just putting it all into the existing driver and
having just a mostly separated setup() for 2600 case.

The DMA functions should probably also depend on SERIAL_8250_DMA anyway 
and the driver should fallback to non-DMA if SERIAL_8250_DMA is not set 
which is yet another reason to use the existing code.

-- 
 i.
