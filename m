From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Mon, 21 Oct 2024 22:19:22 +1030
Subject: [PATCH] i2c: aspeed: Consider i2c reset for muti-master case
In-Reply-To: <20241018034919.974025-1-tommy_huang@aspeedtech.com>
References: <20241018034919.974025-1-tommy_huang@aspeedtech.com>
Message-ID: <e06a0db538bf62d4aeb7352ecc81a3a679fb9eec.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Tommy,

On Fri, 2024-10-18 at 11:49 +0800, Tommy Huang wrote:
> In the original code, the device reset would not be triggered
> when the driver is set to multi-master and bus is free.

That's not how I read the existing code. As it stands, if it's multi-
master and busy we do the recovery, however, if it's multi-master and
free, or busy but not multi-master, or free and not multi-master, then
we do the reset.

> It needs to be considered with multi-master condition.

Is there a specific circumstance you've found that's problematic? Can
you provide some more details about that scenario?

> 
> Fixes: <f327c686d3ba> ("i2c: aspeed: Reset the i2c controller when timeout occurs")
> 
> Signed-off-by: Tommy Huang <tommy_huang@aspeedtech.com>
> ---
>  drivers/i2c/busses/i2c-aspeed.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> index cc5a26637fd5..7639ae3ace67 100644
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -716,14 +716,15 @@ static int aspeed_i2c_master_xfer(struct i2c_adapter *adap,
>  	if (time_left == 0) {
>  		/*
>  		 * In a multi-master setup, if a timeout occurs, attempt
> -		 * recovery. But if the bus is idle, we still need to reset the
> -		 * i2c controller to clear the remaining interrupts.
> +		 * recovery device. But if the bus is idle,
> +		 * we still need to reset the i2c controller to clear
> +		 * the remaining interrupts or reset device abnormal condition.
>  		 */
> -		if (bus->multi_master &&
> -		    (readl(bus->base + ASPEED_I2C_CMD_REG) &
> -		     ASPEED_I2CD_BUS_BUSY_STS))
> -			aspeed_i2c_recover_bus(bus);
> -		else
> +		if ((readl(bus->base + ASPEED_I2C_CMD_REG) &
> +			ASPEED_I2CD_BUS_BUSY_STS)){
> +			if (bus->multi_master)
> +				aspeed_i2c_recover_bus(bus);

The change doesn't seem match the commit message. In this case you've
punched a hole - if the bus is busy but _not_ multi-master, we neither
do the reset _nor_ the recovery.

Which is what you intended? The implementation? Or the prose
description?

Now, back to the implementation, punching this hole seems reasonable on
the surface, but I guess we need to keep in mind that time_left has
also expired...

> +		} else
>  			aspeed_i2c_reset(bus);
>  
>  		/*

Andrew
