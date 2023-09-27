From: Tommy Huang <tommy_huang@aspeedtech.com>
Date: Wed, 27 Sep 2023 03:24:53 +0000
Subject: [External] Re: [PATCH] i2c: aspeed: Fix i2c bus hang in slave
 read
In-Reply-To: <CACPK8XeO404ok+B+k4U_bdFE3yYebzT-UNcTqcHStJfEnDh6jg@mail.gmail.com>
References: <20230810072155.3726352-1-zhangjian.3032@bytedance.com>
 <CACPK8XfWKLS_4nBC+NCSw=21iQeaHzBXOROmz9T+S0qZHCBKeg@mail.gmail.com>
 <CA+J-oUtxiQBOT+VM3fbOUM8HL5TX-C4HqtbbT__b4_KsGAJy1w@mail.gmail.com>
 <CACPK8XeO404ok+B+k4U_bdFE3yYebzT-UNcTqcHStJfEnDh6jg@mail.gmail.com>
Message-ID: <KL1PR0601MB5614B0CCA2C96ADEB3AC8AC9E1C2A@KL1PR0601MB5614.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Joel / Jian,

	Sorry ~ I didn't observe the last mail from Jian.
	
	My last patch was used to avoid the situation like below link.
	https://lists.ozlabs.org/pipermail/openbmc/2023-August/033756.html

	Because I have applied controller reset in my patch.
	Therefore, I think you just need to reset the slave state by "bus->slave_state = ASPEED_I2C_SLAVE_INACTIVE" in your case.

	BR,

	by Tommy

> -----Original Message-----
> From: Joel Stanley <joel@jms.id.au>
> Sent: Wednesday, September 27, 2023 10:43 AM
> To: Jian Zhang <zhangjian.3032@bytedance.com>
> Cc: Tommy Huang <tommy_huang@aspeedtech.com>;
> brendan.higgins at linux.dev; benh at kernel.crashing.org; andrew at aj.id.au;
> zhangjian3032 at gmail.com; yulei.sh at bytedance.com;
> xiexinnan at bytedance.com; open list:ARM/ASPEED I2C DRIVER
> <linux-i2c@vger.kernel.org>; moderated list:ARM/ASPEED I2C DRIVER
> <openbmc@lists.ozlabs.org>; moderated list:ARM/ASPEED MACHINE SUPPORT
> <linux-arm-kernel@lists.infradead.org>; moderated list:ARM/ASPEED
> MACHINE SUPPORT <linux-aspeed@lists.ozlabs.org>; open list
> <linux-kernel@vger.kernel.org>
> Subject: Re: [External] Re: [PATCH] i2c: aspeed: Fix i2c bus hang in slave read
> 
> On Fri, 22 Sept 2023 at 14:39, Jian Zhang <zhangjian.3032@bytedance.com>
> wrote:
> > >
> > > Tommy has submitted a similar fix:
> > >
> > >
> > > https://lore.kernel.org/linux-i2c/20230906004910.4157305-1-tommy_hua
> > > ng at aspeedtech.com/
> > >
> > > His change is very heavy handed; it reinitialises the bus including
> > > re-parsing the device tree (!).
> > >
> > > Should we have merged this fix instead? If not, are you able to
> > > confirm that his change fixes your issue?
> >
> > I feel it's for solving the same issue, but I think this patch is
> > missing the action `bus->slave_state = ASPEED_I2C_SLAVE_INACTIVE;`,
> > which means it can't resolve my problem. @Tommy, can you help confirm
> this?
> 
> You're right, it doesn't change the slave_state at all.
> 
> Unfortunately, despite no acks from the maintainers, this patch has now been
> merged and backported to stable. We should complete the fix, or revert it
> asap.
