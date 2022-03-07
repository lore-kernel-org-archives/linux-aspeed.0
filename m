From: Cédric Le Goater <clg@kaod.org>
Date: Mon, 7 Mar 2022 19:28:48 +0100
Subject: [SPAM] [PATCH 1/1] mtd: spi-nor: aspeed: set the decoding size to
 at least 2MB for AST2600
In-Reply-To: <4d072c43-a766-9ce4-a629-a3ed095663a4@kaod.org>
References: <20220304170757.16924-1-potin.lai@quantatw.com>
 <67004879-96ab-33b5-f389-bbe0005d78ef@kaod.org>
 <6ed257f7-ae87-e2fe-26ed-9db300f5ebcc@kaod.org>
 <efeac1dc-0762-b6d3-e03b-dffc2c76d756@quantatw.com>
 <4d072c43-a766-9ce4-a629-a3ed095663a4@kaod.org>
Message-ID: <e10877f9-57f7-7019-b9ca-0812a60cdea9@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 3/7/22 08:57, C?dric Le Goater wrote:
> 
>> I tested with spi-mem v3 patch, it looks same issue appeared. (spi-model=mx25l800)
>>
>>
>> [??? 0.541050] spi-nor spi1.0: mx25l8005 (1024 Kbytes)
>> aspeed_smc_flash_set_segment CS0 segreg=0x0 [ 0x30000000 - 0x30000000 ]
>> aspeed_smc_flash_set_segment CS1 segreg=0x7f00010 [ 0x30100000 - 0x38000000 ]
>> [??? 0.541976] spi-aspeed-smc 1e630000.spi: Calibration area too uniform, using low speed
>> [??? 0.542267] spi-aspeed-smc 1e630000.spi: CE0 read buswidth:1 [0x000b0041]
>>
>> I think the model mx25l1606e you tested is 2MB flash.
> 
> Indeed. Thanks for the test of v3. We should send a followup patch
> for this 2MB restriction on the minimum size of the flash when the
> patchset is merged or I will if a v4 is asked for.

Here is an updated version for the spi-mem driver :

   https://github.com/legoater/linux/commit/418126725d11863b7b51b70ff507d1da6db192c3
Thanks,

C.
