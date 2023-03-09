From: Michael Walle <michael@walle.cc>
Date: Thu, 09 Mar 2023 13:35:35 +0100
Subject: [PATCH] spi: Replace `dummy.nbytes` with `dummy.ncycles`
In-Reply-To: <5183a184-c72d-3acd-70cd-6aa1e31533f5@linaro.org>
References: <20220911174551.653599-1-sergiu.moga@microchip.com>
 <20220925220304.buk3yuqoh6vszfci@mobilestation>
 <18e6e8a8-6412-7e31-21e0-6becd4400ac1@microchip.com>
 <20220926172454.kbpzck7med5bopre@mobilestation>
 <1766f6ef-d9d8-04f7-a6bf-0ea6bc0b3d23@linaro.org>
 <f647e713a65f5d3f0f2e3af95c4d0a89@walle.cc>
 <1849e2c8-54f5-9e56-4ed8-8b0e4a826d04@linaro.org>
 <302ecf0421fe4c99fca3eb0ca2f66127@walle.cc>
 <5183a184-c72d-3acd-70cd-6aa1e31533f5@linaro.org>
Message-ID: <03a9f117316ab81f1b5a18100f771e65@walle.cc>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Am 2023-03-09 13:09, schrieb Tudor Ambarus:
> On 3/9/23 10:56, Michael Walle wrote:
>> Am 2023-03-09 11:42, schrieb Tudor Ambarus:
>>> On 09.03.2023 10:38, Michael Walle wrote:
>>>>> In an ideal world, where both the controller and the device talk 
>>>>> about
>>>>> dummy number of cycles, I would agree with you, buswidth and dtr 
>>>>> should
>>>>> not be relevant for the number of dummy cycles. But it seems that 
>>>>> there
>>>>> are old controllers (e.g. spi-hisi-sfc-v3xx.c, spi-mt65xx.c,
>>>>> spi-mxic.c)
>>>>> that support buswidths > 1 and work only with dummy nbytes, they 
>>>>> are
>>>>> not
>>>>> capable of specifying a smaller granularity (ncycles). Thus the 
>>>>> older
>>>>> controllers would have to convert the dummy ncycles to dummy 
>>>>> nbytes.
>>>>> Since mixed transfer modes are a thing (see jesd251, it talks about
>>>>> 4S-4D-4D), where single transfer mode (S) can be mixed with double
>>>>> transfer mode (D) for a command, the controller would have to guess 
>>>>> the
>>>>> buswidth and dtr of the dummy. Shall they replicate the buswidth 
>>>>> and
>>>>> dtr
>>>>> of the address or of the data? There's no rule for that.
>>>> 
>>>> But in the end that doesn't matter because they are just dummy clock
>>>> cycles and the mode will only affect the data/address/command.
>>>> Therefore,
>>>> the controller is free to choose the mode that suits it best.
>>>> ?> But that begs the question, is ncycles in regard to DTR or SDR?
>>>> That is,
>>>> are you counting just one type of edges or both the falling and 
>>>> rising
>>>> edges. The smallest granularity would be ncycles in regard of DTR. 
>>>> To
>>>> me,
>>>> it's not obvious what the SEMPER Nano Flash [1] uses. I'd say we 
>>>> choose
>>>> the smallest granularty in spi-mem to be future proof and maybe 
>>>> provide
>>>> some spi-mem helper to help setting the cycles for SDR/DTR. As an
>>>> example,
>>>> if you want to wait 4 cycles in SDR you'd have ncycles=8 in spi-mem.
>>>> 
>>> 
>>> No, we can't invent our own measuring units. We have cycles and half
>>> cycles (regardless of the transfer mode used (STR, DTR)).
>> 
>> That is basically what I was saying, just using the correct term.
>> Ok. So we don't need the dtr property, right? I'm still not sure,
> 
> We do.
> 
> As of now you can't specify 20 dummy cycles for READID in 8D-8D-8D mode
> because all the layers treats dummy as bytes, whereas they should treat
> it as cycles. One dummy byte in 8D-8D-8D means 16 dummy cycles. 20 
> dummy
> cycles in 8D-8D-8D means one byte and a quarter? This is a non-sense.

Agreed.

> As the code is now, SPI NAND uses dummy cycles that are multiple of 8.
> SPI NOR requires a variable number of dummy cycles, there's no
> restrictions. In SPI NOR we get from SFDP or datasheets the number of
> dummy cycles, and in the code we convert them to dummy nbytes. Then 
> when
> we get at the controller side, the majority of the controllers undo the
> operation, they take the dummy nbytes and convert them to dummy 
> ncycles.
> Isn't better to use dummy ncycles from the beginning?

Yes, but now we should define what *one* cycle is. And that it is 
defined
regardless of the mode, because the mode only affects the IO lines. But
a clock cycle refers to the clock line. [coming back to here] And as you
said one cycle is one full clock cycle, it is also independent of the 
dtr
setting.

> The controllers that can talk in dummy ncycles don't need the
> dummy.{buswidth, dtr} fields.
> 
> The controllers that can't talk in dummy cycles, but only on a "byte"
> boundary need both buswidth and dtr fields. Assume a flash needs 32
> dummy cycles for an op on 8D-8D-8D mode. If the controller does not 
> have
> the buswidth and dtr info, it can't convert the dummy ncycles to 
> nbytes.
> If he knows only that buswidth is 8, it will convert ncycles to 4 
> bytes.
> If dtr is also specified it converts ncycles to 2 bytes.

No they don't need it. Lets take your semper flash and assume it needs
12 latency cycles. SPI-NOR will set ncycles to 12 *regardless of the 
mode
or dtr setting*. The controller then knows we need 12 clock cycles. It 
has
then to figure out how that can be achieved. E.g. if it can only do the
"old" byte programming and is in quad mode, good for it. It will send 6
dummy bytes, which will result in 12 dummy clock cycles, because 1 byte
takes two clock cycles in quad SDR mode. If its in octal mode, send 12
bytes. If its in dual mode, send 3 bytes. Obiously, it cannot be in
single bit mode, because it cannot send 1.5 bytes..

If it's freely programmable, it will just tell the hardware to insert
12 dummy clock cycles.

>> what the semper nano flash uses. Half cycles? But according to your
> 
> there's no spimem flash code that use half cycles for now.

Ahh, I just saw the semper flash doesn't support DTR at all. Ok then,
makes things even simpler.

>> naming you'd specify full cylces?
> 
> A clock period, yes.

Ok.

-michael
