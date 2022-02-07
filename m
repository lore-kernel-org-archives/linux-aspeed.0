From: Cédric Le Goater <clg@kaod.org>
Date: Mon, 7 Feb 2022 18:13:01 +0100
Subject: [PATCH] mtd: aspeed-smc: improve probe resilience
In-Reply-To: <20220124203708.lm23sgsub234wlhq@ti.com>
References: <20211229143334.297305-1-patrick@stwcx.xyz>
 <20211229173411.l2bipmi4x3arqjoo@ti.com> <Yc3Qav+ULNdF5zRT@heinlein>
 <20211231102623.izaqlzjvracbbgmp@ti.com> <20220103171721.46c8e697@xps13>
 <YdSP6tKyQ2ZRUC+2@heinlein> <20220105063244.lno3xur64uepa7i5@ti.com>
 <d4ba6413-57ce-14c1-ed48-d00db2f74bd3@kaod.org>
 <20220124153644.m3iwlvq5ld5cpbyz@ti.com>
 <b222361a-288a-55b2-fc02-04c0b93b4220@kaod.org>
 <20220124203708.lm23sgsub234wlhq@ti.com>
Message-ID: <53d53523-7174-89fd-8661-550346d53141@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

On 1/24/22 21:37, Pratyush Yadav wrote:
> On 24/01/22 07:34PM, C?dric Le Goater wrote:
>>>> spimem needs an extension I think. Sorry I have not been able to
>>>> push that forward. Lack of time and other tasks to address on the
>>>> host side of the machine. This is really a software problem, we
>>>> have the HW procedures ready. If a spimem expert could get involved
>>>> to make a few proposals, I would be happy to help and do some testing.
>>>> QEMU models are good enough for the software part. We can do the
>>>> training validation on real HW when ready.
>>>
>>> What information about the flash do you need for this training?
>>
>> Last time I looked, we lacked some post_init handler to setup a slave:
>> configure the registers defining the AHB windows for each flash
>> slave and perform the read timing calibration. calibration should
>> only be done once.
>>
>> See how the aspeed_spi_flash_init() routine doing the calibration
>> is hooked up under aspeed_spi_claim_bus() in the u-boot driver :
> 
> My patch series should provide a hook for doing the calibration _after_
> the flash is initialized.

You can also use the .dirmap_create handler. The flash device has
been scanned when called and the size is available in the spi-mem
dirmap descriptor.

I reworked the current Aspeed driver with this approach and it
seems sufficient for read calibration.

Thanks,

C.


> 
>>
>>    https://github.com/openbmc/u-boot/blob/v2019.04-aspeed-openbmc/drivers/spi/aspeed_spi.c
>>
>> Not good enough for upstream, Linux would be the same :/
>>
>>> I proposed a patch series [0] some time ago trying to implement training
>>> for TI SoCs. It did not get merged but I do intend to respin it and get
>>> it through. Would this API work for your tuning as well?
>>
>> I will take a look.
>>> Also, I am curious how your training works. What data do you read for
>>> training delays? Where is it stored?
>>
>> The driver reads the first 16K at slow speed (that's why we need a
>> basic minimal setup of the slave) and checks if the buffer is valid
>> enough for the calibration :
>>
>>    https://github.com/openbmc/linux/blob/dev-5.15/drivers/mtd/spi-nor/controllers/aspeed-smc.c#L998
>>
>> it then performs reads by changing the frequency and delays and
>> compares results with the initial default buffer.
> 
> This seems similar to the tuning I implemented, except mine uses a
> pre-defined pattern at a pre-defined location.
> 
>>
>> if not, then the driver stays in a safe mode (slow).
> 
> Same for my patches.
> 
>>
>>> In our case we need to flash a
>>> known pattern at some location (which is passed in via DT). Do you need
>>> to run it for every read transaction or just once after the flash is
>>> initialized?
>>
>> Just once because it is a heavy process. See the debug outputs below.
>> Once we have good read timings and frequency, there is no need to do
>> it each time.
> 
> It looks very similar to the tuning I implemented in my patch series.
> You should be able to use those APIs for your tuning as well. But it
> should not block the SPI MEM port. The current upstream driver does not
> seem to implement this tuning anyway.
> 
>>
>>> [0] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=233504&state=%2A&archive=both
>> Thanks,
>>
>> C.
> 

