From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Fri, 1 Sep 2023 05:10:19 +0000
Subject: [PATCH v8 3/3] hwmon: (aspeed-g6-pwm-tacho): Support for ASPEED
 g6 PWM/Fan tach
In-Reply-To: <99ffd1fb-14ae-1c83-bc32-2d0aead4d696@gmail.com>
References: <20230830123202.3408318-1-billy_tsai@aspeedtech.com>
 <20230830123202.3408318-4-billy_tsai@aspeedtech.com>
 <99ffd1fb-14ae-1c83-bc32-2d0aead4d696@gmail.com>
Message-ID: <SG2PR06MB336524E341C2B621D09C7BA98BE4A@SG2PR06MB3365.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 8/30/23 20:32, Billy Tsai wrote:
>> +static int aspeed_tach_hwmon_write(struct device *dev,
>> +                                enum hwmon_sensor_types type, u32 attr,
>> +                                int channel, long val)
>> +{
>> +     struct aspeed_pwm_tach_data *priv = dev_get_drvdata(dev);
>> +     u32 reg_val;
>> +
>> +     switch (attr) {
>> +     case hwmon_fan_div:
>> +             if (!is_power_of_2(val) || (ilog2(val) % 2) ||
>> +                 DIV_TO_REG(val) > 0xb)
>> +                     return -EINVAL;
>> +             priv->tach_divisor = val;
>> +             reg_val = readl(priv->base + TACH_ASPEED_CTRL(channel));
>> +             reg_val &= ~TACH_ASPEED_CLK_DIV_T_MASK;
>> +             reg_val |= FIELD_GET(TACH_ASPEED_CLK_DIV_T_MASK,
>> +                                  DIV_TO_REG(priv->tach_divisor));

> Hi Billy,
> I notice the fanX_div is always shows 1 after I set 1024.
> I think FIELD_GET() needs to replaced with FIELD_PREP().

>> +             writel(reg_val, priv->base + TACH_ASPEED_CTRL(channel));
>> +             break;
>> +     default:
>> +             return -EOPNOTSUPP;
>> +     }
>> +
>> +     return 0;
>> +}


>> +static void aspeed_present_fan_tach(struct aspeed_pwm_tach_data *priv, u32 tach_ch)
>> +{
>> +     u32 val;
>> +
>> +     priv->tach_present[tach_ch] = true;
>> +     priv->tach_divisor = DEFAULT_TACH_DIV;
>> +
>> +     val = readl(priv->base + TACH_ASPEED_CTRL(tach_ch));
>> +     val &= ~(TACH_ASPEED_INVERS_LIMIT | TACH_ASPEED_DEBOUNCE_MASK |
>> +              TACH_ASPEED_IO_EDGE_MASK | TACH_ASPEED_CLK_DIV_T_MASK |
>> +              TACH_ASPEED_THRESHOLD_MASK);
>> +     val |= (DEBOUNCE_3_CLK << TACH_ASPEED_DEBOUNCE_BIT) | F2F_EDGES |
>> +            FIELD_GET(TACH_ASPEED_CLK_DIV_T_MASK,
>> +                      DIV_TO_REG(priv->tach_divisor));

> And here as well.

>> +     writel(val, priv->base + TACH_ASPEED_CTRL(tach_ch));
>> +
>> +     aspeed_tach_ch_enable(priv, tach_ch, true);
>> +}
>> +
>>

Hi Potin,

I will fix it in next verison of the patch.

Thanks for reviewing.
