From: Jian Zhang <zhangjian.3032@bytedance.com>
Date: Thu, 28 Sep 2023 11:04:23 -0400
Subject: [External] Re: [PATCH v2] i2c: aspeed: Fix i2c bus hang in slave read
In-Reply-To: <20230928145128.tjflbgvena4apivs@zenone.zhora.eu>
References: <20230927154244.3774670-1-zhangjian.3032@bytedance.com> <20230928145128.tjflbgvena4apivs@zenone.zhora.eu>
Message-ID: <CA+J-oUsgZuFmKor_thfehf2T8Y9T4NHcDp713YHyZC=fQvvZgA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> From: "Andi Shyti"<andi.shyti@kernel.org>
> Date:? Thu, Sep 28, 2023, 22:51
> Subject:? [External] Re: [PATCH v2] i2c: aspeed: Fix i2c bus hang in slave read
> To: "Jian Zhang"<zhangjian.3032@bytedance.com>
> Cc: <brendan.higgins@linux.dev>, <benh@kernel.crashing.org>, <joel@jms.id.au>, <andrew@aj.id.au>, <zhangjian3032@gmail.com>, <yulei.sh@bytedance.com>, <xiexinnan@bytedance.com>, "Tommy Huang"<tommy_huang@aspeedtech.com>, "Wolfram Sang"<wsa@kernel.org>, "open list:ARM/ASPEED I2C DRIVER"<linux-i2c@vger.kernel.org>, "moderated list:ARM/ASPEED I2C DRIVER"<openbmc@lists.ozlabs.org>, "moderated list:ARM/ASPEED MACHINE SUPPORT"<linux-arm-kernel@lists.infradead.org>, "moderated list:ARM/ASPEED MACHINE SUPPORT"<linux-aspeed@lists.ozlabs.org>, "open list"<linux-kernel@vger.kernel.org>
> Hi Jian,
>
> On Wed, Sep 27, 2023 at 11:42:43PM +0800, Jian Zhang wrote:
> > When the `CONFIG_I2C_SLAVE` option is enabled and the device operates
> > as a slave, a situation arises where the master sends a START signal
> > without the accompanying STOP signal. This action results in a
> > persistent I2C bus timeout. The core issue stems from the fact that
> > the i2c controller remains in a slave read state without a timeout
> > mechanism. As a consequence, the bus perpetually experiences timeouts.
> >
> > In this case, the i2c bus will be reset, but the slave_state reset is
> > missing.
> >
> > Fixes: fee465150b45 ("i2c: aspeed: Reset the i2c controller when timeout occurs")
> > Signed-off-by: Jian Zhang <zhangjian.3032@bytedance.com>
>
> Why I'm failing to find your v1 patch? And where is the
> changelog?
Sorry, something was missing,
v2:
* remove the i2c slave reset and only move the `bus->slave_state =
ASPEED_I2C_SLAVE_INACTIVE` to the aspeed_i2c_init

[0]: https://lore.kernel.org/linux-arm-kernel/20230810072155.3726352-1-zhangjian.3032 at bytedance.com/T/
Jian
>
> Andi
