From: Potin Lai (賴柏廷) <Potin.Lai@quantatw.com>
Date: Tue, 8 Mar 2022 01:14:45 +0000
Subject: [SPAM] [PATCH 1/1] mtd: spi-nor: aspeed: set the decoding size to
 at least 2MB for AST2600
In-Reply-To: <e10877f9-57f7-7019-b9ca-0812a60cdea9@kaod.org>
References: <20220304170757.16924-1-potin.lai@quantatw.com>
 <67004879-96ab-33b5-f389-bbe0005d78ef@kaod.org>
 <6ed257f7-ae87-e2fe-26ed-9db300f5ebcc@kaod.org>
 <efeac1dc-0762-b6d3-e03b-dffc2c76d756@quantatw.com>
 <4d072c43-a766-9ce4-a629-a3ed095663a4@kaod.org>
 <e10877f9-57f7-7019-b9ca-0812a60cdea9@kaod.org>
Message-ID: <597dcccf-f01a-92b5-9b62-72580660a1c5@quantatw.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

C?dric Le Goater ? 2022/3/8 ?? 02:28 ??:
> On 3/7/22 08:57, C?dric Le Goater wrote:
>>
>>> I tested with spi-mem v3 patch, it looks same issue appeared. (spi-model=mx25l800)
>>>
>>>
>>> [??? 0.541050] spi-nor spi1.0: mx25l8005 (1024 Kbytes)
>>> aspeed_smc_flash_set_segment CS0 segreg=0x0 [ 0x30000000 - 0x30000000 ]
>>> aspeed_smc_flash_set_segment CS1 segreg=0x7f00010 [ 0x30100000 - 0x38000000 ]
>>> [??? 0.541976] spi-aspeed-smc 1e630000.spi: Calibration area too uniform, using low speed
>>> [??? 0.542267] spi-aspeed-smc 1e630000.spi: CE0 read buswidth:1 [0x000b0041]
>>>
>>> I think the model mx25l1606e you tested is 2MB flash.
>>
>> Indeed. Thanks for the test of v3. We should send a followup patch
>> for this 2MB restriction on the minimum size of the flash when the
>> patchset is merged or I will if a v4 is asked for.
>
> Here is an updated version for the spi-mem driver :
>
> ? https://apc01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Flegoater%2Flinux%2Fcommit%2F418126725d11863b7b51b70ff507d1da6db192c3&amp;data=04%7C01%7CPotin.Lai%40quantatw.com%7Cde46d26422ae4f2dbd1708da0068575f%7C179b032707fc4973ac738de7313561b2%7C1%7C0%7C637822745417263929%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=D594iU1%2BDbDcvC%2BPP1yUWSLhGxlCGfGC4qWXh0QJoH4%3D&amp;reserved=0
> Thanks,
>
> C.


Thanks for taking this patch into spi-mem driver, the tested log as below.

[??? 1.945705] spi-nor spi1.0: mx25l8005 (1024 Kbytes)
[??? 1.945926] spi-aspeed-smc 1e630000.spi: CE0 window resized to 2MB (AST2600 Decoding)
aspeed_smc_flash_set_segment CS0 segreg=0x100000 [ 0x30000000 - 0x30200000 ]
aspeed_smc_flash_set_segment CS1 segreg=0x7f00020 [ 0x30200000 - 0x38000000 ]
[??? 1.953083] spi-aspeed-smc 1e630000.spi: Calibration area too uniform, using low speed
[??? 1.953409] spi-aspeed-smc 1e630000.spi: CE0 read buswidth:1 [0x000b0041]


By the way, there is a small error when compiling kernel, it needs forward declare for both ast2600_spi_data & ast2600_fmc_data.

Also, I saw you add ast2600_fmc_data for resize checking as well, should I add it in aspeed-smc.c and resend the patch?

Thanks,
Potin


