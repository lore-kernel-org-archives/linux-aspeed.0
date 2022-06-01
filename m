From: Heyi Guo <guoheyi@linux.alibaba.com>
Date: Wed, 1 Jun 2022 09:59:58 +0800
Subject: [PATCH] drivers/i2c-aspeed: avoid invalid memory reference after
 timeout
In-Reply-To: <CAGm54UFUxNpwKjQyQnqtbys_nfgx2KcEEJt3-0nJWYjyjM9pvw@mail.gmail.com>
References: <20220109132613.122912-1-guoheyi@linux.alibaba.com>
 <ad5e5438-4a3f-2447-4af3-7caa91e7252a@linux.alibaba.com>
 <CACPK8XcYp9iAD3fjBQCax41C-1UpA+1AQW3epyEooYzNLt7R5g@mail.gmail.com>
 <e62fba0b-ebb9-934a-d7cf-6da33ecc4335@linux.alibaba.com>
 <CACPK8Xc+v132vM-ytdAUFhywFXGpPF+uPSBWi68ROf_PLD4VQQ@mail.gmail.com>
 <0f5cd773-2d0a-b782-b967-ecbcec3de7b1@linux.alibaba.com>
 <CAGm54UFUxNpwKjQyQnqtbys_nfgx2KcEEJt3-0nJWYjyjM9pvw@mail.gmail.com>
Message-ID: <374237cb-1cda-df12-eb9f-7422cab51fc4@linux.alibaba.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Thanks for your feedback :)

? 2022/5/31 ??5:35, Lei Yu ??:
> I hit a similar problem that has a slightly different backtrace on a
> malfunctioning device.
> https://pastebin.com/TiWdkdrG
>
> With this patch, the kernel panic is gone and it gets below logs instead:
>
>   aspeed-i2c-bus 1e78a180.i2c-bus: bus in unknown state. irq_status: 0x1
>   aspeed-i2c-bus 1e78a180.i2c-bus: irq handled != irq. expected
> 0x00000001, but was 0x00000000
>   aspeed-i2c-bus 1e78a180.i2c-bus: bus in unknown state. irq_status: 0x10
>   aspeed-i2c-bus 1e78a180.i2c-bus: irq handled != irq. expected
> 0x00000010, but was 0x00000000
>
> So I think this patch is good in that it prevents the kernel panic.
>
> On Wed, Jan 19, 2022 at 11:00 AM Heyi Guo <guoheyi@linux.alibaba.com> wrote:
>>
>> ? 2022/1/17 ??2:38, Joel Stanley ??:
>>> On Fri, 14 Jan 2022 at 14:01, Heyi Guo <guoheyi@linux.alibaba.com> wrote:
>>>> Hi Joel,
>>>>
>>>>
>>>> ? 2022/1/11 ??6:51, Joel Stanley ??:
>>>>> On Tue, 11 Jan 2022 at 07:52, Heyi Guo <guoheyi@linux.alibaba.com> wrote:
>>>>>> Hi all,
>>>>>>
>>>>>> Any comments?
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>> Heyi
>>>>>>
>>>>>> ? 2022/1/9 ??9:26, Heyi Guo ??:
>>>>>>> The memory will be freed by the caller if transfer timeout occurs,
>>>>>>> then it would trigger kernel panic if the peer device responds with
>>>>>>> something after timeout and triggers the interrupt handler of aspeed
>>>>>>> i2c driver.
>>>>>>>
>>>>>>> Set the msgs pointer to NULL to avoid invalid memory reference after
>>>>>>> timeout to fix this potential kernel panic.
>>>>> Thanks for the patch. How did you discover this issue? Do you have a
>>>>> test I can run to reproduce the crash?
>>>> We are using one i2c channel to communicate with another MCU by
>>>> implementing user space SSIF protocol, and the MCU may not respond in
>>>> time if it is busy. If it responds after timeout occurs, it will trigger
>>>> below kernel panic:
>>>>
>>> Thanks for the details. It looks like you've done some testing of
>>> this, which is good.
>>>
>>>> After applying this patch, we'll get below warning instead:
>>>>
>>>> "bus in unknown state. irq_status: 0x%x\n"
>>> Given we get to here in the irq handler, we've done these two tests:
>>>
>>>    - aspeed_i2c_is_irq_error()
>>>    - the state is not INACTIVE or PENDING
>>>
>>> but there's no buffer ready for us to use. So what has triggered the
>>> IRQ in this case? Do you have a record of the irq status bits?
>>>
>>> I am wondering if the driver should know that the transaction has
>>> timed out, instead of detecting this unknown state.
>> Yes, some drivers will try to abort the transaction before returning to
>> the caller, if timeout happens.
>>
>> The irq status bits are not always the same; searching from the history
>> logs, I found some messages like below:
>>
>> [  495.289499] aspeed-i2c-bus 1e78a680.i2c-bus: bus in unknown state.
>> irq_status: 0x2
>> [  495.298003] aspeed-i2c-bus 1e78a680.i2c-bus: bus in unknown state.
>> irq_status: 0x10
>>
>> [   65.176761] aspeed-i2c-bus 1e78a680.i2c-bus: bus in unknown state.
>> irq_status: 0x15
>>
>> Thanks,
>>
>> Heyi
>>
>>>
>>>>> Can you provide a Fixes tag?
>>>> I think the bug was introduced by the first commit of this file :(
>>>>
>>>> f327c686d3ba44eda79a2d9e02a6a242e0b75787
>>>>
>>>>
>>>>> Do other i2c master drivers do this? I took a quick look at the meson
>>>>> driver and it doesn't appear to clear it's pointer to msgs.
>>>> It is hard to say. It seems other drivers have some recover scheme like
>>>> aborting the transfer, or loop each messages in process context and
>>>> don't do much in IRQ handler, which may disable interrupts or not retain
>>>> the buffer pointer before returning timeout.
>>> I think your change is okay to go in as it fixes the crash, but first
>>> I want to work out if there's some missing handling of a timeout
>>> condition that we should add as well.
>>>
>>>
>>>> Thanks,
>>>>
>>>> Heyi
>>>>
>>>>
>>>>>>> Signed-off-by: Heyi Guo <guoheyi@linux.alibaba.com>
>>>>>>>
>>>>>>> -------
>>>>>>>
>>>>>>> Cc: Brendan Higgins <brendanhiggins@google.com>
>>>>>>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>>>>>> Cc: Joel Stanley <joel@jms.id.au>
>>>>>>> Cc: Andrew Jeffery <andrew@aj.id.au>
>>>>>>> Cc: Philipp Zabel <p.zabel@pengutronix.de>
>>>>>>> Cc: linux-i2c at vger.kernel.org
>>>>>>> Cc: openbmc at lists.ozlabs.org
>>>>>>> Cc: linux-arm-kernel at lists.infradead.org
>>>>>>> Cc: linux-aspeed at lists.ozlabs.org
>>>>>>> ---
>>>>>>>      drivers/i2c/busses/i2c-aspeed.c | 5 +++++
>>>>>>>      1 file changed, 5 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
>>>>>>> index 67e8b97c0c950..3ab0396168680 100644
>>>>>>> --- a/drivers/i2c/busses/i2c-aspeed.c
>>>>>>> +++ b/drivers/i2c/busses/i2c-aspeed.c
>>>>>>> @@ -708,6 +708,11 @@ static int aspeed_i2c_master_xfer(struct i2c_adapter *adap,
>>>>>>>                  spin_lock_irqsave(&bus->lock, flags);
>>>>>>>                  if (bus->master_state == ASPEED_I2C_MASTER_PENDING)
>>>>>>>                          bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
>>>>>>> +             /*
>>>>>>> +              * All the buffers may be freed after returning to caller, so
>>>>>>> +              * set msgs to NULL to avoid memory reference after freeing.
>>>>>>> +              */
>>>>>>> +             bus->msgs = NULL;
>>>>>>>                  spin_unlock_irqrestore(&bus->lock, flags);
>>>>>>>
>>>>>>>                  return -ETIMEDOUT;
>
>
