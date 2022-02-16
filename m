From: Cédric Le Goater <clg@kaod.org>
Date: Wed, 16 Feb 2022 09:12:48 +0100
Subject: [PATCH 10/10] spi: aspeed: Activate new spi-mem driver
In-Reply-To: <CACPK8XdvczyZ1QHtFm7JJAC7AY+QmWSx0MarUwLjUyOtC9DnSQ@mail.gmail.com>
References: <20220214094231.3753686-1-clg@kaod.org>
 <20220214094231.3753686-11-clg@kaod.org>
 <CACPK8XdvczyZ1QHtFm7JJAC7AY+QmWSx0MarUwLjUyOtC9DnSQ@mail.gmail.com>
Message-ID: <d517d453-ddd5-8c9e-7b1f-56f5f83d2f1e@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2/16/22 08:02, Joel Stanley wrote:
> On Mon, 14 Feb 2022 at 09:43, C?dric Le Goater <clg@kaod.org> wrote:
>>
>> The previous driver using the MTD SPI NOR interface is kept in case we
>> find some issues but we should remove it quickly once the new driver
>> using the spi-mem interface has been sufficiently exposed.
>>
>> Signed-off-by: C?dric Le Goater <clg@kaod.org>
> 
> I suggest we drop the defconfig changes from both this patch and the
> first. This way we'll always have the new driver being built, with
> less churn.
> 
> If you strongly prefer the way you've done it then that's fine too.

I am fine with that, but, with only patch 1, the defconfig files would
be referencing an non-existing CONFIG. Is that ok ?

Thanks,

C.



> 
>> ---
>>   arch/arm/configs/aspeed_g4_defconfig | 2 +-
>>   arch/arm/configs/aspeed_g5_defconfig | 2 +-
>>   arch/arm/configs/multi_v5_defconfig  | 2 +-
>>   arch/arm/configs/multi_v7_defconfig  | 2 +-
>>   4 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/configs/aspeed_g4_defconfig b/arch/arm/configs/aspeed_g4_defconfig
>> index 964536444cd7..b4a1b2ed1a17 100644
>> --- a/arch/arm/configs/aspeed_g4_defconfig
>> +++ b/arch/arm/configs/aspeed_g4_defconfig
>> @@ -64,7 +64,7 @@ CONFIG_MTD_BLOCK=y
>>   CONFIG_MTD_PARTITIONED_MASTER=y
>>   CONFIG_MTD_SPI_NOR=y
>>   # CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
>> -CONFIG_SPI_ASPEED_SMC_MTD_SPI_NOR=y
>> +CONFIG_SPI_ASPEED_SMC=y
>>   CONFIG_MTD_UBI=y
>>   CONFIG_MTD_UBI_FASTMAP=y
>>   CONFIG_MTD_UBI_BLOCK=y
>> diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
>> index e809236ca88b..ccc4240ee4b5 100644
>> --- a/arch/arm/configs/aspeed_g5_defconfig
>> +++ b/arch/arm/configs/aspeed_g5_defconfig
>> @@ -103,7 +103,7 @@ CONFIG_MTD_BLOCK=y
>>   CONFIG_MTD_PARTITIONED_MASTER=y
>>   CONFIG_MTD_SPI_NOR=y
>>   # CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
>> -CONFIG_SPI_ASPEED_SMC_MTD_SPI_NOR=y
>> +CONFIG_SPI_ASPEED_SMC=y
>>   CONFIG_MTD_UBI=y
>>   CONFIG_MTD_UBI_FASTMAP=y
>>   CONFIG_MTD_UBI_BLOCK=y
>> diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
>> index 49083ef05fb0..80a3ae02d759 100644
>> --- a/arch/arm/configs/multi_v5_defconfig
>> +++ b/arch/arm/configs/multi_v5_defconfig
>> @@ -103,7 +103,7 @@ CONFIG_MTD_RAW_NAND=y
>>   CONFIG_MTD_NAND_ATMEL=y
>>   CONFIG_MTD_NAND_ORION=y
>>   CONFIG_MTD_SPI_NOR=y
>> -CONFIG_SPI_ASPEED_SMC_MTD_SPI_NOR=y
>> +CONFIG_SPI_ASPEED_SMC=y
>>   CONFIG_MTD_UBI=y
>>   CONFIG_BLK_DEV_LOOP=y
>>   CONFIG_ATMEL_SSC=m
>> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
>> index fc1b69256b64..33572998dbbe 100644
>> --- a/arch/arm/configs/multi_v7_defconfig
>> +++ b/arch/arm/configs/multi_v7_defconfig
>> @@ -217,7 +217,7 @@ CONFIG_MTD_NAND_DAVINCI=y
>>   CONFIG_MTD_NAND_STM32_FMC2=y
>>   CONFIG_MTD_NAND_PL35X=y
>>   CONFIG_MTD_SPI_NOR=y
>> -CONFIG_SPI_ASPEED_SMC_MTD_SPI_NOR=m
>> +CONFIG_SPI_ASPEED_SMC=m
>>   CONFIG_MTD_UBI=y
>>   CONFIG_BLK_DEV_LOOP=y
>>   CONFIG_BLK_DEV_RAM=y
>> --
>> 2.34.1
>>

