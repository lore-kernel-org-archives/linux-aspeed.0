From: Jonathan Cameron <jic23@kernel.org>
Date: Sun, 26 Sep 2021 12:27:34 +0100
Subject: [v7 00/11] Add support for ast2600 ADC
In-Reply-To: <20210922081520.30580-1-billy_tsai@aspeedtech.com>
References: <20210922081520.30580-1-billy_tsai@aspeedtech.com>
Message-ID: <20210926122734.2fccf55a@jic23-huawei>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 22 Sep 2021 16:15:09 +0800
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> This patch serials make aspeed_adc.c can support ast2600 and backward
> compatible.

Hi Billy,

Series applied to the togreg branch of iio.git and pushed out as testing for
0-day to poke at it.

Note the fix for platform_set_drvdata() is in the fixes branch so there will
be a bit of mess around context for patch 1 but that should all resolve in
a trivial fashion.

Thanks,

Jonathan

> 
> Change since v6:
> aspeed_adc.c:
>  - Fix the parameter error for aspeed_adc_unregister_fixed_divider.
> 
> Change since v5:
> aspeed_adc.c:
>   - Use devm_clk_hw_register_divider()
>   - Enabling and setting the ADC to normal mode is a necessary flow, so
>   take it out of the condition.
> 
> Change since v4:
> dt-bindings:
>   - Add clocks maxItems.
>   - Rename the property to meet the property-units.yaml.
>   - Add the description for the difference between adc0 and adc1.
> aspeed_adc.c:
>   - Use new property name to get internal reference voltage: units from mv
>   to uv.
>   - Fix -Wnonnull warning caused by snprintf parameters.
>   - Add suffix mv to the vref parameters.
>   - Use ARRAY_SIZE instead of 32.
>   - Add a reset action for ADC power down and Use devm_iio_device_register.
>   - Fix typo error.
>   - Separate the offset interface of ch7 when battery sensing enable
> 
> Change since v3:
> dt-bindings:
>   - Fix properties:aspeed,int_vref_mv type error.
> 
> Change since v2:
> dt-bindings:
>   - Create a new dt-bindings for ast2600 adc
> aspeed_adc.c:
>   - Splits the patch for more details
>   - Remove version enum and use the flags in model data to distinguish
>   hardware feature
>   - Support trimming data get and set.
>   - Use devm_add_action_or_reset to simplify probe error handling.
> 
> Changes since v1:
> dt-bindings:
>   - Fix the aspeed,adc.yaml check error.
>   - Add battery-sensing property.
> aspeed_adc.c:
>   - Change the init flow:
>     Clock and reference voltage setting should be completed before adc
>     engine enable.
>   - Change the default sampling rate to meet most user case.
>   - Add patch #8 to suppoert battery sensing mode.
> 
> Billy Tsai (11):
>   iio: adc: aspeed: Keep model data to driver data.
>   iio: adc: aspeed: Restructure the model data
>   iio: adc: aspeed: Add vref config function
>   iio: adc: aspeed: Use model_data to set clk scaler.
>   iio: adc: aspeed: Use devm_add_action_or_reset.
>   iio: adc: aspeed: Support ast2600 adc.
>   iio: adc: aspeed: Fix the calculate error of clock.
>   iio: adc: aspeed: Add func to set sampling rate.
>   iio: adc: aspeed: Add compensation phase.
>   iio: adc: aspeed: Support battery sensing.
>   iio: adc: aspeed: Get and set trimming data.
> 
>  drivers/iio/adc/aspeed_adc.c | 554 +++++++++++++++++++++++++++++------
>  1 file changed, 459 insertions(+), 95 deletions(-)
> 

