From: Andi Shyti <andi.shyti@kernel.org>
Date: Thu, 6 Jun 2024 02:26:55 +0100
Subject: [PATCH] i2c: aspeed: Update the stop sw state when the bus
 recovry occurs
In-Reply-To: <20240530070656.3841066-1-tommy_huang@aspeedtech.com>
References: <20240530070656.3841066-1-tommy_huang@aspeedtech.com>
Message-ID: <kts7ib2rxq4g26ayumcyaohs37zl43qo66gok3vae3reyabobe@nbbborkf2eow>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Tommy,

On Thu, May 30, 2024 at 03:06:56PM +0800, Tommy Huang wrote:
> When the i2c bus recovey occurs, driver will send i2c stop command
> in the scl low condition. In this case the sw state will still keep
> original situation. Under multi-master usage, i2c bus recovery will
> be called when i2c transfer timeout occurs. Update the stop command
> calling with aspeed_i2c_do_stop function to update master_state.
> 
> Fixes: f327c686d3ba ("i2c: aspeed: added driver for Aspeed I2C")
> 
> Signed-off-by: Tommy Huang <tommy_huang@aspeedtech.com>

Can you please add:

Cc: <stable@vger.kernel.org> # v4.13+

> ---
>  drivers/i2c/busses/i2c-aspeed.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> index ce8c4846b7fa..32f8b0c1c174 100644
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -169,6 +169,7 @@ struct aspeed_i2c_bus {
>  };
>  
>  static int aspeed_i2c_reset(struct aspeed_i2c_bus *bus);
> +static void aspeed_i2c_do_stop(struct aspeed_i2c_bus *bus);

Can you please move aspeed_i2c_do_stop() on top? Doesn't make
much sense to add the prototype here as there is no dependencies.

It's different the case of aspeed_i2c_reset() because it needs
aspeed_i2c_init().

>  static int aspeed_i2c_recover_bus(struct aspeed_i2c_bus *bus)
>  {
> @@ -187,7 +188,7 @@ static int aspeed_i2c_recover_bus(struct aspeed_i2c_bus *bus)
>  			command);
>  
>  		reinit_completion(&bus->cmd_complete);
> -		writel(ASPEED_I2CD_M_STOP_CMD, bus->base + ASPEED_I2C_CMD_REG);
> +		aspeed_i2c_do_stop(bus);

The patch is good, though!

Thanks,
Andi
