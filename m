From: Jonathan Cameron <jic23@kernel.org>
Date: Sun, 18 Oct 2020 11:22:49 +0100
Subject: [PATCH 1/3] iio: adc: aspeed: Orgnaize and add the define of adc
In-Reply-To: <20201013103245.16723-2-billy_tsai@aspeedtech.com>
References: <20201013103245.16723-1-billy_tsai@aspeedtech.com>
 <20201013103245.16723-2-billy_tsai@aspeedtech.com>
Message-ID: <20201018112249.44dd3bde@archlinux>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 13 Oct 2020 18:32:43 +0800
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> This patch organizes the define of adc to multiple partitions
> and adds the new bit field define for ast2600 driver.

Should be 2 patch patches.  If you need to do a reorg,
do it first, then add new bits in a second patch.  That way
we are reviewing one non functional change, and one that actually
does something.

As a general rule, I'd also prefer to just see the additional defines
added as and when they are used (in the patch that first uses them).

> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  drivers/iio/adc/aspeed_adc.c | 42 ++++++++++++++++++++++++++++++++----
>  1 file changed, 38 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
> index 1e5375235cfe..ae400c4d6d40 100644
> --- a/drivers/iio/adc/aspeed_adc.c
> +++ b/drivers/iio/adc/aspeed_adc.c
> @@ -21,23 +21,57 @@
>  #include <linux/iio/driver.h>
>  #include <linux/iopoll.h>
>  
> +/**********************************************************
> + * ADC feature define
> + *********************************************************/

I'm generally of the view that block comments like this
normally imply the defines are not sufficiently self
identifying.   It should be possible to know what sort of thing
they are at the point of use without having to go find a comment
in the header.
So if you think these are needed, perhaps reconsider the naming
of of the defines?  Personally I just don't seem them as necessary.
Like all comments, they tend to 'rot' over time so if they
aren't adding information, better not to have them!

>  #define ASPEED_RESOLUTION_BITS		10
>  #define ASPEED_CLOCKS_PER_SAMPLE	12
>  
> +/**********************************************************
> + * ADC HW register offset define
> + *********************************************************/
>  #define ASPEED_REG_ENGINE_CONTROL	0x00
>  #define ASPEED_REG_INTERRUPT_CONTROL	0x04
>  #define ASPEED_REG_VGA_DETECT_CONTROL	0x08
>  #define ASPEED_REG_CLOCK_CONTROL	0x0C
> +#define ASPEED_REG_COMPENSATION_TRIM	0xC4
>  #define ASPEED_REG_MAX			0xC0
>  
> +/**********************************************************
> + * ADC register Bit field
> + *********************************************************/
> +/*ENGINE_CONTROL */
Inconsistent spacing after /* 
> +/* [0] */
> +#define ASPEED_ENGINE_ENABLE		BIT(0)
> +/* [3:1] */

If the docs are needed, then better to use FIELD_PREP and GENMASK as that is
going to be self documenting at the actual point of the defines.

>  #define ASPEED_OPERATION_MODE_POWER_DOWN	(0x0 << 1)
>  #define ASPEED_OPERATION_MODE_STANDBY		(0x1 << 1)
>  #define ASPEED_OPERATION_MODE_NORMAL		(0x7 << 1)
> -
> -#define ASPEED_ENGINE_ENABLE		BIT(0)
> -
> +/* [4] */
> +#define ASPEED_CTRL_COMPENSATION	BIT(4)
> +/* [5] */
> +#define ASPEED_AUTOPENSATING		BIT(5)
> +/* [7:6] */
> +#define ASPEED_REF_VOLTAGE_2500mV	(0 << 6)
> +#define ASPEED_REF_VOLTAGE_1200mV	(1 << 6)
> +#define ASPEED_REF_VOLTAGE_EXT_HIGH	(2 << 6)
> +#define ASPEED_REF_VOLTAGE_EXT_LOW	(3 << 6)
> +#define ASPEED_BATTERY_SENSING_VOL_DIVIDE_2_3	(0 << 6)
> +#define ASPEED_BATTERY_SENSING_VOL_DIVIDE_1_3	(1 << 6)
> +/* [8] */
>  #define ASPEED_ADC_CTRL_INIT_RDY	BIT(8)
> -
> +/* [12] */
> +#define ASPEED_ADC_CH7_VOLTAGE_NORMAL	(0 << 12)
> +#define ASPEED_ADC_CH7_VOLTAGE_BATTERY	(1 << 12)
> +/* [13] */
> +#define ASPEED_ADC_EN_BATTERY_SENSING	BIT(13)
> +/* [31:16] */
> +#define ASPEED_ADC_CTRL_CH_EN(n)	(1 << (16 + n))
> +#define ASPEED_ADC_CTRL_CH_EN_ALL	GENMASK(31, 16)
> +
> +/**********************************************************
> + * Software setting
> + *********************************************************/
>  #define ASPEED_ADC_INIT_POLLING_TIME	500
>  #define ASPEED_ADC_INIT_TIMEOUT		500000
>  

