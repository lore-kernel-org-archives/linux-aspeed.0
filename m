From: Joel Stanley <joel@jms.id.au>
Date: Wed, 14 Oct 2020 22:31:04 +0000
Subject: [PATCH 1/1] net: ftgmac100: Fix Aspeed ast2600 TX hang issue
In-Reply-To: <PS1PR0601MB1849DAC59EDA6A9DB62B4EE09C050@PS1PR0601MB1849.apcprd06.prod.outlook.com>
References: <20201014060632.16085-1-dylan_hung@aspeedtech.com>
 <20201014060632.16085-2-dylan_hung@aspeedtech.com>
 <CACPK8Xe_O44BUaPCEm2j3ZN+d4q6JbjEttLsiCLbWF6GnaqSPg@mail.gmail.com>
 <PS1PR0601MB1849DAC59EDA6A9DB62B4EE09C050@PS1PR0601MB1849.apcprd06.prod.outlook.com>
Message-ID: <CACPK8Xd_DH+VeaPmXK2b5FXbrOpg_NmT_R4ENzY-=uNo=6HcyQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 14 Oct 2020 at 13:32, Dylan Hung <dylan_hung@aspeedtech.com> wrote:
> > > The new HW arbitration feature on Aspeed ast2600 will cause MAC TX to
> > > hang when handling scatter-gather DMA.  Disable the problematic
> > > feature by setting MAC register 0x58 bit28 and bit27.
> >
> > Hi Dylan,
> >
> > What are the symptoms of this issue? We are seeing this on our systems:
> >
> > [29376.090637] WARNING: CPU: 0 PID: 9 at net/sched/sch_generic.c:442
> > dev_watchdog+0x2f0/0x2f4
> > [29376.099898] NETDEV WATCHDOG: eth0 (ftgmac100): transmit queue 0
> > timed out
> >
>
> May I know your soc version? This issue happens on ast2600 version A1.  The registers to fix this issue are meaningless/reserved on A0 chip, so it is okay to set them on either A0 or A1.

We are running the A1. All of our A0 parts have been replaced with A1.

> I was encountering this issue when I was running the iperf TX test.  The symptom is the TX descriptors are consumed, but no complete packet is sent out.

What parameters are you using for iperf? I did a lot of testing with
iperf3 (and stress-ng running at the same time) and couldn't reproduce
the error.

We could only reproduce it when performing other functions, such as
debugging/booting the host processor.

> > > +/*
> > > + * test mode control register
> > > + */
> > > +#define FTGMAC100_TM_RQ_TX_VALID_DIS (1 << 28) #define
> > > +FTGMAC100_TM_RQ_RR_IDLE_PREV (1 << 27)
> > > +#define FTGMAC100_TM_DEFAULT
> > \
> > > +       (FTGMAC100_TM_RQ_TX_VALID_DIS |
> > FTGMAC100_TM_RQ_RR_IDLE_PREV)
> >
> > Will aspeed issue an updated datasheet with this register documented?

Did you see this question?

Cheers,

Joel
