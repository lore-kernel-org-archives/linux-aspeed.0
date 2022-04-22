From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Fri, 22 Apr 2022 11:17:08 +0700
Subject: [PATCH v7 3/3] i2c: aspeed: Assert NAK when slave is busy
In-Reply-To: <20220422040803.2524940-4-quan@os.amperecomputing.com>
References: <20220422040803.2524940-1-quan@os.amperecomputing.com>
 <20220422040803.2524940-4-quan@os.amperecomputing.com>
Message-ID: <6fcbe1e0-b011-7537-b61b-50bfe15f0ce5@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Added Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
as I'm not aware of the email change
- Quan


On 22/04/2022 11:08, Quan Nguyen wrote:
> When processing I2C_SLAVE_WRITE_REQUESTED event, if slave returns
> -EBUSY, i2c controller should issue RxCmdLast command to assert NAK
> on the bus.
> 
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> ---
> v7:
>    + None
> 
> v6:
>    + New introduced in v6                      [Quan]
> 
>   drivers/i2c/busses/i2c-aspeed.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> index 771e53d3d197..ebc2b92656c8 100644
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -244,6 +244,7 @@ static u32 aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
>   	u32 command, irq_handled = 0;
>   	struct i2c_client *slave = bus->slave;
>   	u8 value;
> +	int ret;
>   
>   	if (!slave)
>   		return 0;
> @@ -311,7 +312,9 @@ static u32 aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
>   		break;
>   	case ASPEED_I2C_SLAVE_WRITE_REQUESTED:
>   		bus->slave_state = ASPEED_I2C_SLAVE_WRITE_RECEIVED;
> -		i2c_slave_event(slave, I2C_SLAVE_WRITE_REQUESTED, &value);
> +		ret = i2c_slave_event(slave, I2C_SLAVE_WRITE_REQUESTED, &value);
> +		if (ret == -EBUSY)
> +			writel(ASPEED_I2CD_M_S_RX_CMD_LAST, bus->base + ASPEED_I2C_CMD_REG);
>   		break;
>   	case ASPEED_I2C_SLAVE_WRITE_RECEIVED:
>   		i2c_slave_event(slave, I2C_SLAVE_WRITE_RECEIVED, &value);

