From: Dylan Hung <dylan_hung@aspeedtech.com>
Date: Wed, 14 Oct 2020 07:58:44 +0000
Subject: [PATCH 1/1] net: ftgmac100: Fix Aspeed ast2600 TX hang issue
In-Reply-To: <CACPK8Xe_O44BUaPCEm2j3ZN+d4q6JbjEttLsiCLbWF6GnaqSPg@mail.gmail.com>
References: <20201014060632.16085-1-dylan_hung@aspeedtech.com>
 <20201014060632.16085-2-dylan_hung@aspeedtech.com>
 <CACPK8Xe_O44BUaPCEm2j3ZN+d4q6JbjEttLsiCLbWF6GnaqSPg@mail.gmail.com>
Message-ID: <PS1PR0601MB1849DAC59EDA6A9DB62B4EE09C050@PS1PR0601MB1849.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Joel,

> -----Original Message-----
> From: Joel Stanley [mailto:joel at jms.id.au]
> Sent: Wednesday, October 14, 2020 2:41 PM
> To: Dylan Hung <dylan_hung@aspeedtech.com>
> Cc: David S . Miller <davem@davemloft.net>; Jakub Kicinski
> <kuba@kernel.org>; netdev at vger.kernel.org; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>; Po-Yu Chuang <ratbert@faraday-tech.com>;
> linux-aspeed <linux-aspeed@lists.ozlabs.org>; OpenBMC Maillist
> <openbmc@lists.ozlabs.org>; BMC-SW <BMC-SW@aspeedtech.com>
> Subject: Re: [PATCH 1/1] net: ftgmac100: Fix Aspeed ast2600 TX hang issue
> 
> On Wed, 14 Oct 2020 at 06:07, Dylan Hung <dylan_hung@aspeedtech.com>
> wrote:
> >
> > The new HW arbitration feature on Aspeed ast2600 will cause MAC TX to
> > hang when handling scatter-gather DMA.  Disable the problematic
> > feature by setting MAC register 0x58 bit28 and bit27.
> 
> Hi Dylan,
> 
> What are the symptoms of this issue? We are seeing this on our systems:
> 
> [29376.090637] WARNING: CPU: 0 PID: 9 at net/sched/sch_generic.c:442
> dev_watchdog+0x2f0/0x2f4
> [29376.099898] NETDEV WATCHDOG: eth0 (ftgmac100): transmit queue 0
> timed out
> 

May I know your soc version? This issue happens on ast2600 version A1.  The registers to fix this issue are meaningless/reserved on A0 chip, so it is okay to set them on either A0 or A1.
I was encountering this issue when I was running the iperf TX test.  The symptom is the TX descriptors are consumed, but no complete packet is sent out.

> > Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
> 
> This fixes support for the ast2600, so we can put:
> 
> Fixes: 39bfab8844a0 ("net: ftgmac100: Add support for DT phy-handle
> property")
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> 
> > ---
> >  drivers/net/ethernet/faraday/ftgmac100.c | 5 +++++
> > drivers/net/ethernet/faraday/ftgmac100.h | 8 ++++++++
> >  2 files changed, 13 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/faraday/ftgmac100.c
> > b/drivers/net/ethernet/faraday/ftgmac100.c
> > index 87236206366f..00024dd41147 100644
> > --- a/drivers/net/ethernet/faraday/ftgmac100.c
> > +++ b/drivers/net/ethernet/faraday/ftgmac100.c
> > @@ -1817,6 +1817,11 @@ static int ftgmac100_probe(struct
> platform_device *pdev)
> >                 priv->rxdes0_edorr_mask = BIT(30);
> >                 priv->txdes0_edotr_mask = BIT(30);
> >                 priv->is_aspeed = true;
> > +               /* Disable ast2600 problematic HW arbitration */
> > +               if (of_device_is_compatible(np, "aspeed,ast2600-mac"))
> {
> > +                       iowrite32(FTGMAC100_TM_DEFAULT,
> > +                                 priv->base +
> FTGMAC100_OFFSET_TM);
> > +               }
> >         } else {
> >                 priv->rxdes0_edorr_mask = BIT(15);
> >                 priv->txdes0_edotr_mask = BIT(15); diff --git
> > a/drivers/net/ethernet/faraday/ftgmac100.h
> > b/drivers/net/ethernet/faraday/ftgmac100.h
> > index e5876a3fda91..63b3e02fab16 100644
> > --- a/drivers/net/ethernet/faraday/ftgmac100.h
> > +++ b/drivers/net/ethernet/faraday/ftgmac100.h
> > @@ -169,6 +169,14 @@
> >  #define FTGMAC100_MACCR_FAST_MODE      (1 << 19)
> >  #define FTGMAC100_MACCR_SW_RST         (1 << 31)
> >
> > +/*
> > + * test mode control register
> > + */
> > +#define FTGMAC100_TM_RQ_TX_VALID_DIS (1 << 28) #define
> > +FTGMAC100_TM_RQ_RR_IDLE_PREV (1 << 27)
> > +#define FTGMAC100_TM_DEFAULT
> \
> > +       (FTGMAC100_TM_RQ_TX_VALID_DIS |
> FTGMAC100_TM_RQ_RR_IDLE_PREV)
> 
> Will aspeed issue an updated datasheet with this register documented?
> 
> 
> > +
> >  /*
> >   * PHY control register
> >   */
> > --
> > 2.17.1
> >
