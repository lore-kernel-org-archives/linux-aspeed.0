From: Lei YU <mine260309@gmail.com>
Date: Mon, 31 Jul 2023 14:10:14 +0800
Subject: [PATCH] i2c: aspeed: Avoid accessing freed buffers during i2c transfers.
In-Reply-To: <CACPK8Xf6YssamEmHB5XDf8JYk+_=hnG8Yzqn4kCikseqg6rqOA@mail.gmail.com>
References: <20230728122416.17782-1-lianglixuehao@126.com> <CACPK8Xf6YssamEmHB5XDf8JYk+_=hnG8Yzqn4kCikseqg6rqOA@mail.gmail.com>
Message-ID: <CAARXrtmZbu3aabYJkEc25rHymRHDX4=zNdecHAs3LnQ259RkPg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

There is a same fix in
https://lore.kernel.org/openbmc/374237cb-1cda-df12-eb9f-7422cab51fc4 at linux.alibaba.com/

On Mon, Jul 31, 2023 at 12:21?PM Joel Stanley <joel@jms.id.au> wrote:

> On Fri, 28 Jul 2023 at 12:40, Lixue Liang <lianglixuehao@126.com> wrote:
> >
> > From: Lixue Liang <lianglixue@greatwall.com.cn>
> >
> > After waiting for the transmission timeout, the I2C controller will
> > continue to transmit data when the bus is idle. Clearing bus->msg will
> > avoid kernel panic when accessing the freed msg->buf in
> > aspeed_i2c_master_irq.
> >
> > Signed-off-by: Lixue Liang <lianglixue@greatwall.com.cn>
> > ---
> >  drivers/i2c/busses/i2c-aspeed.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/i2c/busses/i2c-aspeed.c
> b/drivers/i2c/busses/i2c-aspeed.c
> > index 2e5acfeb76c8..c83057497e26 100644
> > --- a/drivers/i2c/busses/i2c-aspeed.c
> > +++ b/drivers/i2c/busses/i2c-aspeed.c
> > @@ -713,6 +713,8 @@ static int aspeed_i2c_master_xfer(struct i2c_adapter
> *adap,
> >                 spin_lock_irqsave(&bus->lock, flags);
> >                 if (bus->master_state == ASPEED_I2C_MASTER_PENDING)
> >                         bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
> > +
> > +               bus->msgs = NULL;
>
> Eddie, is this the same issue you were debugging?
>
> >                 spin_unlock_irqrestore(&bus->lock, flags);
> >
> >                 return -ETIMEDOUT;
> > --
> > 2.27.0
> >
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230731/56eebb09/attachment.htm>
