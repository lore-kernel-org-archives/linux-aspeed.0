From: Cédric Le Goater <clg@kaod.org>
Date: Wed, 16 Aug 2017 08:53:30 +0200
Subject: [PATCH] i2c: aspeed: Retain delay/setup/hold values when
 configuring bus frequency
In-Reply-To: <CACPK8XeNDxo14KRsAqo3a0Rs26h-1vRsLyqSX+bt2jfZHq=5yA@mail.gmail.com>
References: <20170815072102.23067-1-andrew@aj.id.au>
 <CACPK8XeNDxo14KRsAqo3a0Rs26h-1vRsLyqSX+bt2jfZHq=5yA@mail.gmail.com>
Message-ID: <247768a3-074f-70ad-6132-39d1443ce210@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 08/16/2017 08:49 AM, Joel Stanley wrote:
> On Tue, Aug 15, 2017 at 4:51 PM, Andrew Jeffery <andrew@aj.id.au> wrote:
>> In addition to the base, low and high clock configuration, the AC timing
>> register #1 on the AST2400 houses fields controlling:
>>
>> 1. tBUF: Minimum delay between Stop and Start conditions
>> 2. tHDSTA: Hold time for the Start condition
>> 3. tACST: Setup time for Start and Stop conditions, and hold time for the
>>    Repeated Start condition
>>
>> These values are defined in hardware on the AST2500 and therefore don't
>> need to be set.
>>
>> aspeed_i2c_init_clk() was performing a direct write of the generated
>> clock values rather than a read/mask/modify/update sequence to retain
>> tBUF, tHDSTA and tACST, and therefore cleared the tBUF, tHDSTA and tACST
>> fields on the AST2400. This resulted in a delay/setup/hold time of 1
>> base clock, which in some configurations is not enough for some devices
>> (e.g. the MAX31785 fan controller, with an APB of 48MHz and a desired
>> bus speed of 100kHz).
>>
>> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>> ---
>>  drivers/i2c/busses/i2c-aspeed.c | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
>> index ee76e6dddc4b..284f8670dbeb 100644
>> --- a/drivers/i2c/busses/i2c-aspeed.c
>> +++ b/drivers/i2c/busses/i2c-aspeed.c
>> @@ -53,6 +53,9 @@
>>  #define ASPEED_I2CD_MASTER_EN                          BIT(0)
>>
>>  /* 0x04 : I2CD Clock and AC Timing Control Register #1 */
>> +#define ASPEED_I2CD_TIME_TBUF_MASK                     GENMASK(31, 28)
>> +#define ASPEED_I2CD_TIME_THDSTA_MASK                   GENMASK(27, 24)
>> +#define ASPEED_I2CD_TIME_TACST_MASK                    GENMASK(23, 20)
>>  #define ASPEED_I2CD_TIME_SCL_HIGH_SHIFT                        16
>>  #define ASPEED_I2CD_TIME_SCL_HIGH_MASK                 GENMASK(19, 16)
>>  #define ASPEED_I2CD_TIME_SCL_LOW_SHIFT                 12
>> @@ -744,7 +747,11 @@ static int aspeed_i2c_init_clk(struct aspeed_i2c_bus *bus)
>>         u32 divisor, clk_reg_val;
>>
>>         divisor = DIV_ROUND_UP(bus->parent_clk_frequency, bus->bus_frequency);
>> -       clk_reg_val = bus->get_clk_reg_val(divisor);
>> +       clk_reg_val = readl(bus->base + ASPEED_I2C_AC_TIMING_REG1);
>> +       clk_reg_val &= (ASPEED_I2CD_TIME_TBUF_MASK |
>> +                       ASPEED_I2CD_TIME_THDSTA_MASK |
>> +                       ASPEED_I2CD_TIME_TACST_MASK);
> 
> Instead of keeping the u-boot values (which appear to be hard-coded),
> should we instead put the known working values in the register?

Yes. I was wondering where the initial setting was from on the AST400.

C.
