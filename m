From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Wed, 8 Mar 2023 09:04:55 +0000
Subject: [PATCH] spi: Replace `dummy.nbytes` with `dummy.ncycles`
In-Reply-To: <20220926172454.kbpzck7med5bopre@mobilestation>
References: <20220911174551.653599-1-sergiu.moga@microchip.com>
 <20220925220304.buk3yuqoh6vszfci@mobilestation>
 <18e6e8a8-6412-7e31-21e0-6becd4400ac1@microchip.com>
 <20220926172454.kbpzck7med5bopre@mobilestation>
Message-ID: <1766f6ef-d9d8-04f7-a6bf-0ea6bc0b3d23@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi, Sarge,

On 9/26/22 18:24, Serge Semin wrote:
>>>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>>>> index f2c64006f8d7..cc8ca824f912 100644
>>>> --- a/drivers/mtd/spi-nor/core.c
>>>> +++ b/drivers/mtd/spi-nor/core.c
>>>> @@ -88,7 +88,7 @@ void spi_nor_spimem_setup_op(const struct spi_nor *nor,
>>>>        if (op->addr.nbytes)
>>>>                op->addr.buswidth = spi_nor_get_protocol_addr_nbits(proto);
>>>>
>>>
>>>
>>>> -     if (op->dummy.nbytes)
>>>> +     if (op->dummy.ncycles)
>>>>                op->dummy.buswidth = spi_nor_get_protocol_addr_nbits(proto);
>>>>
>>>>        if (op->data.nbytes)
>>>> @@ -106,9 +106,6 @@ void spi_nor_spimem_setup_op(const struct spi_nor *nor,
>>>>                op->dummy.dtr = true;
>>>>                op->data.dtr = true;
>>>>
>>>> -             /* 2 bytes per clock cycle in DTR mode. */
>>>> -             op->dummy.nbytes *= 2;
>>>> -
>>>>                ext = spi_nor_get_cmd_ext(nor, op);
>>>>                op->cmd.opcode = (op->cmd.opcode << 8) | ext;
>>>>                op->cmd.nbytes = 2;
>>>> @@ -207,10 +204,7 @@ static ssize_t spi_nor_spimem_read_data(struct spi_nor *nor, loff_t from,
>>>>
>>>>        spi_nor_spimem_setup_op(nor, &op, nor->read_proto);
>>>>
>>>> -     /* convert the dummy cycles to the number of bytes */
>>>> -     op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
>>>> -     if (spi_nor_protocol_is_dtr(nor->read_proto))
>>>> -             op.dummy.nbytes *= 2;
>>>> +     op.dummy.ncycles = nor->read_dummy;
>>> So according to this modification and what is done in the rest of the
>>> patch, the dummy part of the SPI-mem operations now contains the number
>>> of cycles only. Am I right to think that it means a number of dummy
>>> clock oscillations? (Judging from what I've seen in the HW-manuals of
>>> the SPI NOR memory devices most likely I am...)
>>
>>
>> Yes, you are correct.
>>

I confirm.

>>
>>> If so the "ncycles" field
>>> is now free from the "data" semantic. Then what is the meaning of the
>>> "buswidth and "dtr" fields in the spi_mem_op.dummy field?
>>>
>>
>> It is still meaningful as it is used for the conversion by some drivers 
>> to nbytes and I do not see how it goes out of the specification in any 
>> way. So, at least for now, I do not see any reason to remove these fields.
> I do see the way these fields are used in the SPI-mem drivers. I was
> wondering what do these bits mean in the framework of the SPI-mem
> core? AFAICS from the specification the dummy cycles are irrelevant to
> the data bus state. It says "the master tri-states the bus during
> 'dummy' cycles." If so I don't see a reason to have the DTR and
> buswidth fields in the spi_mem_op structure anymore. The number of
> cycles could be calculated right on the initialization stage based on
> the SPI NOR/NAND requirements.
> 
> @Mark, @Tudor, @Pratyush, what do you think?
> 

In an ideal world, where both the controller and the device talk about
dummy number of cycles, I would agree with you, buswidth and dtr should
not be relevant for the number of dummy cycles. But it seems that there
are old controllers (e.g. spi-hisi-sfc-v3xx.c, spi-mt65xx.c, spi-mxic.c)
that support buswidths > 1 and work only with dummy nbytes, they are not
capable of specifying a smaller granularity (ncycles). Thus the older
controllers would have to convert the dummy ncycles to dummy nbytes.
Since mixed transfer modes are a thing (see jesd251, it talks about
4S-4D-4D), where single transfer mode (S) can be mixed with double
transfer mode (D) for a command, the controller would have to guess the
buswidth and dtr of the dummy. Shall they replicate the buswidth and dtr
of the address or of the data? There's no rule for that. So we're forced
to keep the dummy.{dtr, buswidth} fields by the old controllers that
don't understand dummy ncycles.

I'm going to send a v2 of this patch, I'll add you in To. Thanks for
taking the time to review this patch!

Cheers,
ta
