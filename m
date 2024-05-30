From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Thu, 30 May 2024 09:47:44 +0200
Subject: [PATCH] i2c: aspeed: Update the stop sw state when the bus
 recovry occurs
In-Reply-To: <20240530070656.3841066-1-tommy_huang@aspeedtech.com>
References: <20240530070656.3841066-1-tommy_huang@aspeedtech.com>
Message-ID: <2774cb4c-4eea-4bf5-8b2b-438adf18448d@molgen.mpg.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear Tommy,


Thank you for your patch.

Am 30.05.24 um 09:06 schrieb Tommy Huang:
> When the i2c bus recovey occurs, driver will send i2c stop command

recove*r*y

> in the scl low condition. In this case the sw state will still keep
> original situation. Under multi-master usage, i2c bus recovery will

What is the user visible problem?

> be called when i2c transfer timeout occurs. Update the stop command
> calling with aspeed_i2c_do_stop function to update master_state.

How can this be tested?

> Fixes: f327c686d3ba ("i2c: aspeed: added driver for Aspeed I2C")
> 

The blank line can be removed.

> Signed-off-by: Tommy Huang <tommy_huang@aspeedtech.com>
> ---
>   drivers/i2c/busses/i2c-aspeed.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> index ce8c4846b7fa..32f8b0c1c174 100644
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -169,6 +169,7 @@ struct aspeed_i2c_bus {
>   };
>   
>   static int aspeed_i2c_reset(struct aspeed_i2c_bus *bus);
> +static void aspeed_i2c_do_stop(struct aspeed_i2c_bus *bus);
>   
>   static int aspeed_i2c_recover_bus(struct aspeed_i2c_bus *bus)
>   {
> @@ -187,7 +188,7 @@ static int aspeed_i2c_recover_bus(struct aspeed_i2c_bus *bus)
>   			command);
>   
>   		reinit_completion(&bus->cmd_complete);
> -		writel(ASPEED_I2CD_M_STOP_CMD, bus->base + ASPEED_I2C_CMD_REG);
> +		aspeed_i2c_do_stop(bus);
>   		spin_unlock_irqrestore(&bus->lock, flags);
>   
>   		time_left = wait_for_completion_timeout(


Kind regards,

Paul
