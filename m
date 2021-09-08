From: Paul Fertser <fercerpav@gmail.com>
Date: Wed, 8 Sep 2021 13:52:45 +0300
Subject: [PATCH v2 0/3] arm: aspeed: Add UART routing support
In-Reply-To: <HK0PR06MB3779180F75DB8BD872F8A78391D49@HK0PR06MB3779.apcprd06.prod.outlook.com>
References: <20210902021817.17506-1-chiawei_wang@aspeedtech.com>
 <20210908094248.GZ23326@home.paul.comp>
 <HK0PR06MB3779180F75DB8BD872F8A78391D49@HK0PR06MB3779.apcprd06.prod.outlook.com>
Message-ID: <20210908105245.GB23326@home.paul.comp>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Sep 08, 2021 at 10:18:35AM +0000, ChiaWei Wang wrote:
> > Does UART1 need some explicit disabling for VUART IRQs to work? It looks like
> > setting LPC address and IRQ number in VUART is enough to override the
> > register part but probably not for the interrupt?
> 
> You may need to confirm that the Host does not enable the SIO SUART1
> device. This will conflict with VUART as both SUART and VAURT are
> competing for the port address 0x3f8 and SIRQ 4.

Do you really mean the Host here, that is, software that controls LPC
master when ASpeed is used as an LPC slave? Linux driver is not doing
anything special with the UART1, it's just trying to use it as if it
was a hardware 16550A physical IC on I/O bus.

Or do you mean the BMC software shouldn't be enabling SUART1 by making
sure its clock is disabled in SCU0C? Is there anything else needed?
I've tried reading the ast2500 datasheet many times but this detail
seem to be missing. Is there some appnote on the topic probably?

In this case do we have some way to make it an obvious error to enable
both SUART1 and VUART in DTS? If they're conflicting surely there
should be a way to express that?

Thank you for looking into this!

-- 
Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
mailto:fercerpav at gmail.com
