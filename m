From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 29 Nov 2022 07:06:03 -0800
Subject: [v4 5/5] hwmon: Add Aspeed ast2600 TACH support
In-Reply-To: <D5F454FE-9C4B-4B7E-8817-637D5FCC047A@aspeedtech.com>
References: <20221123061635.32025-1-billy_tsai@aspeedtech.com>
 <20221123061635.32025-6-billy_tsai@aspeedtech.com>
 <bf851fa1-af62-5cdc-8cb4-bcf29b73731a@roeck-us.net>
 <D5F454FE-9C4B-4B7E-8817-637D5FCC047A@aspeedtech.com>
Message-ID: <a0b48e60-59ce-0033-b09f-2f92983753b7@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 11/28/22 23:08, Billy Tsai wrote:
> On 2022/11/23, 11:45 PM, "Guenter Roeck" <groeck7 at gmail.com on behalf of linux@roeck-us.net> wrote:
> 
>      On 11/22/22 22:16, Billy Tsai wrote:
>      > > +The driver provides the following sensor accesses in sysfs:
>      > > +=============== ======= =====================================================
>      > > +fanX_input	ro	provide current fan rotation value in RPM as reported
>      > > +			by the fan to the device.
>      > > +fanX_div	rw	Fan divisor: Supported value are power of 4 (1, 4, 16
>      > > +                        64, ... 4194304)
> 
>      > The code doesn't support 1.
> 
> The code can support 1.
> 
Sorry, leftover from when I misread the code and thought it didn't.
> 
>      > The existence of a status register makes me wonder what is in there.
>      > Does the controller report any errors ? If so, it might be worthwile
>      > adding attribute(s) for it.
> 
>      > > +	if (ret)
>      > > +		return ret;
>      > > +
>      > > +	if (!(val & TACH_ASPEED_FULL_MEASUREMENT))
>      > > +		return 0;
>      > > +	rpm = aspeed_tach_val_to_rpm(priv, fan_tach_ch,
>      > > +				     val & TACH_ASPEED_VALUE_MASK);
>      > > +
>      > > +	return rpm;
> 
> The status register is the TACH_ASPEED_FULL_MEASUREMENT which is used to indicate that
> the controller doesn't detect the change in tach pin for a long time.
> 
>      > > +static void aspeed_create_fan_tach_channel(struct aspeed_tach_data *priv,
>      > > +					   u32 tach_ch)
>      > > +{
>      > > +	priv->tach_present[tach_ch] = true;
>      > > +	priv->tach_channel[tach_ch].limited_inverse = 0;
>      > > +	regmap_write_bits(priv->regmap, TACH_ASPEED_CTRL(tach_ch),
>      > > +			  TACH_ASPEED_INVERS_LIMIT,
>      > > +			  priv->tach_channel[tach_ch].limited_inverse ?
>      > > +				  TACH_ASPEED_INVERS_LIMIT :
>      > > +				  0);
>      > > +
>      > What is the purpose of the above code ? limited_inverse is always 0.
> 
>      > > +	priv->tach_channel[tach_ch].tach_debounce = DEBOUNCE_3_CLK;
>      > > +	regmap_write_bits(priv->regmap, TACH_ASPEED_CTRL(tach_ch),
>      > > +			  TACH_ASPEED_DEBOUNCE_MASK,
>      > > +			  priv->tach_channel[tach_ch].tach_debounce
>      > > +				  << TACH_ASPEED_DEBOUNCE_BIT);
>      > > +
>      > > +	priv->tach_channel[tach_ch].tach_edge = F2F_EDGES;
>      > > +	regmap_write_bits(priv->regmap, TACH_ASPEED_CTRL(tach_ch),
>      > > +			  TACH_ASPEED_IO_EDGE_MASK,
>      > > +			  priv->tach_channel[tach_ch].tach_edge
>      > > +				  << TACH_ASPEED_IO_EDGE_BIT);
>      > > +
> 
>      > limited_inverse, tach_debounce, and tach_edge are constants.
>      > There is no need to keep constants as per-channel variables.
> 
>      > > +	priv->tach_channel[tach_ch].divisor = DEFAULT_TACH_DIV;
>      > > +	regmap_write_bits(priv->regmap, TACH_ASPEED_CTRL(tach_ch),
>      > > +			  TACH_ASPEED_CLK_DIV_T_MASK,
>      > > +			  DIV_TO_REG(priv->tach_channel[tach_ch].divisor)
>      > > +				  << TACH_ASPEED_CLK_DIV_BIT);
>      > > +
>      > > +	priv->tach_channel[tach_ch].threshold = 0;
>      > > +	regmap_write_bits(priv->regmap, TACH_ASPEED_CTRL(tach_ch),
>      > > +			  TACH_ASPEED_THRESHOLD_MASK,
>      > > +			  priv->tach_channel[tach_ch].threshold);
>      > > +
> 
>      > The above applies to threshold as well.
> 
> The above code is used to retain the adjustable feature of the controller.
> I will remove them until I add the dts property to support them.
> 
>      > > +	}
>      > > +
>      > > +	hwmon = devm_hwmon_device_register_with_info(dev, "aspeed_tach", priv,
>      > > +						     &aspeed_tach_chip_info, NULL);
>      > > +	ret = PTR_ERR_OR_ZERO(hwmon);
>      > > +	if (ret)
>      > > +		return dev_err_probe(dev, ret,
>      > > +				     "Failed to register hwmon device\n");
>      > > +	return 0;
> 
>      > Why not return the error ? Either it is an error or it isn't. If it is
>      > not an error, dev_err_probe() is not appropriate. If it is, the error
>      > should be returned. Either case, if this is on purpose, it needs an
>      > explanation.
> 
> I have return the return value of the dev_err_probe. Did I miss someting?
> 
No, me not having enough coffee when reviewing the code. Sorry for the noise.

Thanks,
Guenter

