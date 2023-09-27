From: Joel Stanley <joel@jms.id.au>
Date: Wed, 27 Sep 2023 02:42:46 +0000
Subject: [External] Re: [PATCH] i2c: aspeed: Fix i2c bus hang in slave read
In-Reply-To: <CA+J-oUtxiQBOT+VM3fbOUM8HL5TX-C4HqtbbT__b4_KsGAJy1w@mail.gmail.com>
References: <20230810072155.3726352-1-zhangjian.3032@bytedance.com>
 <CACPK8XfWKLS_4nBC+NCSw=21iQeaHzBXOROmz9T+S0qZHCBKeg@mail.gmail.com> <CA+J-oUtxiQBOT+VM3fbOUM8HL5TX-C4HqtbbT__b4_KsGAJy1w@mail.gmail.com>
Message-ID: <CACPK8XeO404ok+B+k4U_bdFE3yYebzT-UNcTqcHStJfEnDh6jg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 22 Sept 2023 at 14:39, Jian Zhang <zhangjian.3032@bytedance.com> wrote:
> >
> > Tommy has submitted a similar fix:
> >
> >  https://lore.kernel.org/linux-i2c/20230906004910.4157305-1-tommy_huang at aspeedtech.com/
> >
> > His change is very heavy handed; it reinitialises the bus including
> > re-parsing the device tree (!).
> >
> > Should we have merged this fix instead? If not, are you able to
> > confirm that his change fixes your issue?
>
> I feel it's for solving the same issue, but I think this patch is
> missing the action
> `bus->slave_state = ASPEED_I2C_SLAVE_INACTIVE;`,
>  which means it can't resolve my problem. @Tommy, can you help confirm this?

You're right, it doesn't change the slave_state at all.

Unfortunately, despite no acks from the maintainers, this patch has
now been merged and backported to stable. We should complete the fix,
or revert it asap.
