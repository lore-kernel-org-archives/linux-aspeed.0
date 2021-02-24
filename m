From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Tue, 23 Feb 2021 16:34:24 -0800
Subject: [PATCH v3 3/4] i2c: aspeed: add buffer mode transfer support
In-Reply-To: <CAFd5g47MBQ67S3XzaH9rDPSieihNJ_WPhUgw=Pkg1Vk1PK3AvQ@mail.gmail.com>
References: <20210216182735.11639-1-jae.hyun.yoo@linux.intel.com>
 <20210216182735.11639-4-jae.hyun.yoo@linux.intel.com>
 <CAFd5g47MBQ67S3XzaH9rDPSieihNJ_WPhUgw=Pkg1Vk1PK3AvQ@mail.gmail.com>
Message-ID: <fb60042c-e1c9-bf79-7769-a97c626b4f4b@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Brendan,

On 2/23/2021 3:03 PM, Brendan Higgins wrote:
> On Tue, Feb 16, 2021 at 10:15 AM Jae Hyun Yoo
> <jae.hyun.yoo@linux.intel.com> wrote:
>>
>> This driver uses byte mode that makes lots of interrupt calls
>> which isn't good for performance and it makes the driver very
>> timing sensitive. To improve performance of the driver, this commit
>> adds buffer mode transfer support which uses I2C SRAM buffer
>> instead of using a single byte buffer.
>>
>> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>> Tested-by: Tao Ren <taoren@fb.com>
> 
> Overall looks pretty good! There were just a couple bits of code which
> were not immediately obvious to me that I would like to see improved:
> 
>> ---
>> Changes since v2:
>> - Refined SoC family dependent xfer mode configuration functions.
>>
>> Changes since v1:
>> - Updated commit message.
>> - Refined using abstract functions.
>>
>>   drivers/i2c/busses/i2c-aspeed.c | 464 ++++++++++++++++++++++++++++----
>>   1 file changed, 412 insertions(+), 52 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
>> index 724bf30600d6..343e621ff133 100644
>> --- a/drivers/i2c/busses/i2c-aspeed.c
>> +++ b/drivers/i2c/busses/i2c-aspeed.c
> [...]
>> +static inline u32
>> +aspeed_i2c_prepare_tx_buf(struct aspeed_i2c_bus *bus, struct i2c_msg *msg)
>> +{
>> +       u8 slave_addr = i2c_8bit_addr_from_msg(msg);
>> +       u32 command = 0;
>> +       int len;
>> +
>> +       if (msg->len + 1 > bus->buf_size)
>> +               len = bus->buf_size;
>> +       else
>> +               len = msg->len + 1;
>> +
>> +       if (bus->buf_base) {
>> +               u8 wbuf[4];
>> +               int i;
>> +
>> +               command |= ASPEED_I2CD_TX_BUFF_ENABLE;
>> +
>> +               /*
>> +                * Yeah, it looks bad but byte writing on remapped I2C SRAM
>> +                * causes corruption so use this way to make dword writings.
>> +                */
> 
> Not surprised. It looks like you reuse this code in a couple of
> places, at the very least I think you should break this out into a
> helper function. Otherwise, please make a similar comment in the other
> locations.

There is one more place which has a similar code but loop count, tx
buffer and message buffer indexing are slightly different so better
leave them, IMO. Instead, I'll add this comment even for the other one.

> Also, why doesn't writesl()
> (https://elixir.bootlin.com/linux/v5.11/source/include/asm-generic/io.h#L413)
> work here?

This is caused by Aspeed I2C SRAM specific behavior so it can't be
covered by writesl().

Will submit v4 soon. Thanks for your review!

Best,
Jae

>> +               wbuf[0] = slave_addr;
>> +               for (i = 1; i < len; i++) {
>> +                       wbuf[i % 4] = msg->buf[i - 1];
>> +                       if (i % 4 == 3)
>> +                               writel(*(u32 *)wbuf, bus->buf_base + i - 3);
>> +               }
>> +               if (--i % 4 != 3)
>> +                       writel(*(u32 *)wbuf, bus->buf_base + i - (i % 4));
>> +
>> +               writel(FIELD_PREP(ASPEED_I2CD_BUF_TX_COUNT_MASK, len - 1) |
>> +                      FIELD_PREP(ASPEED_I2CD_BUF_OFFSET_MASK, bus->buf_offset),
>> +                      bus->base + ASPEED_I2C_BUF_CTRL_REG);
>> +       }
>> +
>> +       bus->buf_index = len - 1;
>> +
>> +       return command;
>> +}
>> +
> [...]
> 
