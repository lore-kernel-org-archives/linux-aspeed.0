From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Wed, 4 Oct 2023 17:44:12 +0000
Subject: [PATCH v1] iio: adc: aspeed: Support deglitch feature.
In-Reply-To: <4bee3205-212b-4032-a105-9b8f1fb1fa22@app.fastmail.com>
References: <20230925081845.4147424-1-billy_tsai@aspeedtech.com>
 <a310aba3-0f04-4549-a776-36ff8cef736e@app.fastmail.com>
 <SG2PR06MB336555C2C52E24FCCDE72C748BC5A@SG2PR06MB3365.apcprd06.prod.outlook.com>
 <4bee3205-212b-4032-a105-9b8f1fb1fa22@app.fastmail.com>
Message-ID: <SG2PR06MB3365F684ED71DB0CB90246318BCBA@SG2PR06MB3365.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


>>> > Create event sysfs for applying the deglitch condition. When
>>> > in_voltageY_thresh_rising_en/in_voltageY_thresh_falling_en is set to true,
>>> > the driver will use the in_voltageY_thresh_rising_value and
>>> > in_voltageY_thresh_falling_value as threshold values. If the ADC value
>>> > falls outside this threshold, the driver will wait for the ADC sampling
>>> > period and perform an additional read once to achieve the deglitching
>>> > purpose.
>>> >
>>> > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
>>> > ---
>>> >  drivers/iio/adc/aspeed_adc.c | 193 ++++++++++++++++++++++++++++++++++-
>>> >  1 file changed, 189 insertions(+), 4 deletions(-)
>>> >
>>> > diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
>>> > index 998e8bcc06e1..9e746c81d916 100644
>>> > --- a/drivers/iio/adc/aspeed_adc.c
>>> > +++ b/drivers/iio/adc/aspeed_adc.c
>>> > @@ -95,6 +95,7 @@ struct aspeed_adc_model_data {
>>> >       bool wait_init_sequence;
>>> >       bool need_prescaler;
>>> >       bool bat_sense_sup;
>>> > +     bool require_extra_eoc;
>>
>>> What is "eoc"? Can we use a better name or add an explanatory comment?
>>
>> Hi Andrew,
>> This is the signal name for our ADC controller, it means "End Of
>> Conversion".
>> The appearance of this signal period indicates that the ADC value is
>> valid and being updated to the register.

> Okay, searching for "conversion" in the datasheet didn't turn up anything like this. It seems I wasn't off-track with asking. If you go forward with the patch in some manner, can you add a comment to the code documenting the meaning of 'eoc'?

Okay, I will add the comment for the meaning of eoc.

>
>> >       /* Register ADC clock prescaler with source specified by device tree.
>> > */
>> >       spin_lock_init(&data->clk_lock);
>> >       snprintf(clk_parent_name, ARRAY_SIZE(clk_parent_name), "%s",
>> > @@ -632,7 +806,14 @@ static int aspeed_adc_probe(struct platform_device
>> > *pdev)
>> >       adc_engine_control_reg_val |= ASPEED_ADC_CTRL_CHANNEL;
>> >       writel(adc_engine_control_reg_val,
>> >              data->base + ASPEED_REG_ENGINE_CONTROL);
>> > -
>> > +     adc_engine_control_reg_val =
>> > +             FIELD_GET(ASPEED_ADC_CTRL_CHANNEL,
>> > +                       readl(data->base + ASPEED_REG_ENGINE_CONTROL));
>> > +     data->required_eoc_num = hweight_long(adc_engine_control_reg_val);
>> > +     if (data->model_data->require_extra_eoc &&
>> > +         (adc_engine_control_reg_val &
>> > +          BIT(data->model_data->num_channels - 1)))
>> > +             data->required_eoc_num += 12;
>
>> Why 12? Why add a value to the number of engines enabled? Have I misunderstood?
>
> This behavior is specified by the hardware. In our ADC, it requires 12
> dummy sampling
> periods to switch the sampling channel from CH7 to CH0. Hence, this
> condition checks
> the enable status of channel 7 to determine the necessary delay period
> for obtaining the
> updated ADC values for each channel.

> Okay, I feel using a magic value '12' with what you wrote above as an explanation is asking a bit much of the reader. Again, if you go forward with this patch in some fashion, can you document the meaning of 12 in a comment (and possibly use a macro to name it)?

Okay, I will include comments and use meaningful macro to name it.

Thanks
