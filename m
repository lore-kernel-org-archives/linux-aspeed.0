From: Brendan Higgins <brendanhiggins@google.com>
Date: Thu, 10 Sep 2020 02:00:53 -0700
Subject: [PATCH v3 3/5] i2c: aspeed: Mask IRQ status to relevant bits
In-Reply-To: <20200909203059.23427-4-eajames@linux.ibm.com>
References: <20200909203059.23427-1-eajames@linux.ibm.com>
 <20200909203059.23427-4-eajames@linux.ibm.com>
Message-ID: <CAFd5g46ghV7ArmM8LnMkGa-Nip_fT934+3cPOkVxS-b5odZXYw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Sep 9, 2020 at 1:31 PM Eddie James <eajames@linux.ibm.com> wrote:
>
> Mask the IRQ status to only the bits that the driver checks. This
> prevents excessive driver warnings when operating in slave mode
> when additional bits are set that the driver doesn't handle.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Tao Ren <rentao.bupt@gmail.com>

Sorry, looks like I didn't get my comment in in time.

Looks good in principle. One minor comment below:

> ---
>  drivers/i2c/busses/i2c-aspeed.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> index 31268074c422..724bf30600d6 100644
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -69,6 +69,7 @@
>   * These share bit definitions, so use the same values for the enable &
>   * status bits.
>   */
> +#define ASPEED_I2CD_INTR_RECV_MASK                     0xf000ffff

Could we define ASPEED_I2CD_INTR_RECV_MASK to be ASPEED_I2CD_INTR_ALL ?

>  #define ASPEED_I2CD_INTR_SDA_DL_TIMEOUT                        BIT(14)
>  #define ASPEED_I2CD_INTR_BUS_RECOVER_DONE              BIT(13)
>  #define ASPEED_I2CD_INTR_SLAVE_MATCH                   BIT(7)
> @@ -604,6 +605,7 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
>         writel(irq_received & ~ASPEED_I2CD_INTR_RX_DONE,
>                bus->base + ASPEED_I2C_INTR_STS_REG);
>         readl(bus->base + ASPEED_I2C_INTR_STS_REG);
> +       irq_received &= ASPEED_I2CD_INTR_RECV_MASK;
>         irq_remaining = irq_received;
>
>  #if IS_ENABLED(CONFIG_I2C_SLAVE)
> --
> 2.26.2
>
