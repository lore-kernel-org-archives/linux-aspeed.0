From: Heyi Guo <guoheyi@linux.alibaba.com>
Date: Tue, 11 Jan 2022 15:52:25 +0800
Subject: [PATCH] drivers/i2c-aspeed: avoid invalid memory reference after
 timeout
In-Reply-To: <20220109132613.122912-1-guoheyi@linux.alibaba.com>
References: <20220109132613.122912-1-guoheyi@linux.alibaba.com>
Message-ID: <ad5e5438-4a3f-2447-4af3-7caa91e7252a@linux.alibaba.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi all,

Any comments?

Thanks,

Heyi

? 2022/1/9 ??9:26, Heyi Guo ??:
> The memory will be freed by the caller if transfer timeout occurs,
> then it would trigger kernel panic if the peer device responds with
> something after timeout and triggers the interrupt handler of aspeed
> i2c driver.
>
> Set the msgs pointer to NULL to avoid invalid memory reference after
> timeout to fix this potential kernel panic.
>
> Signed-off-by: Heyi Guo <guoheyi@linux.alibaba.com>
>
> -------
>
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: linux-i2c at vger.kernel.org
> Cc: openbmc at lists.ozlabs.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-aspeed at lists.ozlabs.org
> ---
>   drivers/i2c/busses/i2c-aspeed.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> index 67e8b97c0c950..3ab0396168680 100644
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -708,6 +708,11 @@ static int aspeed_i2c_master_xfer(struct i2c_adapter *adap,
>   		spin_lock_irqsave(&bus->lock, flags);
>   		if (bus->master_state == ASPEED_I2C_MASTER_PENDING)
>   			bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
> +		/*
> +		 * All the buffers may be freed after returning to caller, so
> +		 * set msgs to NULL to avoid memory reference after freeing.
> +		 */
> +		bus->msgs = NULL;
>   		spin_unlock_irqrestore(&bus->lock, flags);
>   
>   		return -ETIMEDOUT;
