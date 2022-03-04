From: Cédric Le Goater <clg@kaod.org>
Date: Fri, 4 Mar 2022 19:00:25 +0100
Subject: [SPAM] [PATCH 1/1] mtd: spi-nor: aspeed: set the decoding size to
 at least 2MB for AST2600
In-Reply-To: <67004879-96ab-33b5-f389-bbe0005d78ef@kaod.org>
References: <20220304170757.16924-1-potin.lai@quantatw.com>
 <67004879-96ab-33b5-f389-bbe0005d78ef@kaod.org>
Message-ID: <6ed257f7-ae87-e2fe-26ed-9db300f5ebcc@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 3/4/22 18:29, C?dric Le Goater wrote:
> Hello Potin,
> 
> On 3/4/22 18:07, Potin Lai wrote:
>> In AST2600, the unit of SPI CEx decoding range register is 1MB, and end
>> address offset is set to the acctual offset - 1MB. If the flash only has
>> 1MB, the end address will has same value as start address, which will
>> causing unexpected errors.
> 
> Yes. That's probably true.
> 
>> This patch set the decoding size to at least 2MB to avoid decoding errors.
>>
>> Tested:
>> root at bletchley:~# dmesg | grep "aspeed-smc 1e631000.spi: CE0 window"
> 
> Could you send all the "aspeed-smc" logs please ? I would like to
> reproduce on QEMU. You can use these machine options :
> 
>  ? fmc-model=<string>???? - Change the FMC Flash model
>  ? spi-model=<string>???? - Change the SPI Flash model
> 
> to change the default flash device models and see how the driver reacts.
> Add -trace aspeed_smc_flash_set_segment to see how the QEMU model is
> configured.
> 
>> [?? 59.328134] aspeed-smc 1e631000.spi: CE0 window resized to 2MB (AST2600 Decoding)
>> [?? 59.343001] aspeed-smc 1e631000.spi: CE0 window [ 0x50000000 - 0x50200000 ] 2MB
>> root at bletchley:~# devmem 0x1e631030
>> 0x00100000
> 
> I thought devmem was banned :)
> 
> We could expose the main FMC/SPI registers under sysfs or debugfs.
> The segment registers and the timing registers would be nice to
> have. I can revive some experimental patch I did a few years ago.
> 
> If you have some time, could you please try the new driver based
> on spi-mem ?
> 
> v3 is pushed here :
> 
>  ? https://github.com/legoater/linux/commits/openbmc-5.15
> 
> The patch looks correct but we also want to fix the new driver and
> I have reworked the window setting part. It should be less fragile.
> aspeed_spi_chip_adjust_window() still needs to handle HW quirks
> though.

Using a mx25l1606e on SPI1, here is what we get :

$ qemu-system-arm -M ast2600-evb,spi-model=mx25l1606e ....

[    1.069297] spi-aspeed-smc 1e630000.spi: registered master spi1
[    1.069863] spi-aspeed-smc 1e630000.spi: CE0 default window [ 0x30000000 - 0x37ffffff ] 128MB
[    1.070161] spi-aspeed-smc 1e630000.spi: CE0 setup done
[    1.070359] spi spi1.0: setup mode 0, 8 bits/w, 100000000 Hz max --> 0
[    1.071245] spi-aspeed-smc 1e630000.spi: CE0 read OP 0x9f mode:1.0.0.1 naddr:0x0 ndummies:0x0 len:0x6
[    1.071747] spi-nor spi1.0: mx25l1606e (2048 Kbytes)
aspeed_smc_flash_set_segment CS0 segreg=0x100000 [ 0x30000000 - 0x30200000 ]
[    1.072253] spi-aspeed-smc 1e630000.spi: CE0 new window [ 0x30000000 - 0x301fffff ] 2MB
aspeed_smc_flash_set_segment CS1 segreg=0x7f00020 [ 0x30200000 - 0x38000000 ]
[    1.072833] spi-aspeed-smc 1e630000.spi: CE1 new window [ 0x30200000 - 0x37ffffff ] 126MB
[    1.073162] spi-aspeed-smc 1e630000.spi: calculate timing compensation - AHB freq: 200 MHz
[    1.079692] spi-aspeed-smc 1e630000.spi: Trying HCLK/5 [000b0d41] ...
[    1.143327] spi-aspeed-smc 1e630000.spi:   * [00000000] 0 HCLK delay, DI delay none : PASS
[    1.143642] spi-aspeed-smc 1e630000.spi: Trying HCLK/4 [000b0641] ...
[    1.207062] spi-aspeed-smc 1e630000.spi:   * [00000000] 0 HCLK delay, DI delay none : PASS
[    1.207404] spi-aspeed-smc 1e630000.spi: Trying HCLK/3 [000b0e41] ...
[    1.273171] spi-aspeed-smc 1e630000.spi:   * [00000000] 0 HCLK delay, DI delay none : PASS
[    1.273512] spi-aspeed-smc 1e630000.spi: Trying HCLK/2 [000b0741] ...
[    1.341648] spi-aspeed-smc 1e630000.spi:   * [00000000] 0 HCLK delay, DI delay none : PASS
[    1.341942] spi-aspeed-smc 1e630000.spi: Found good read timings at HCLK/2
[    1.342190] spi-aspeed-smc 1e630000.spi: CE0 read buswidth:1 [0x000b0741]
[    1.363662] spi-aspeed-smc 1e630000.spi: registered child spi1.0

The new spi-mem driver behaves better (on QEMU).

Thanks,

C.
