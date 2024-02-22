From: Florian Fainelli <florian.fainelli@broadcom.com>
Date: Thu, 22 Feb 2024 11:54:46 -0800
Subject: [PATCH v1 10/14] serial: 8250_of: Switch to use
 uart_read_port_properties()
In-Reply-To: <e5fd9d8b-84eb-4ef9-82ab-ff4ecc41c0d5@broadcom.com>
References: <20240221183442.4124354-1-andriy.shevchenko@linux.intel.com>
 <20240221183442.4124354-11-andriy.shevchenko@linux.intel.com>
 <0a828f2c50de712940fb9a881702ac1678a35b7c.camel@codeconstruct.com.au>
 <ZddKzHplwOX7naLv@smile.fi.intel.com> <Zdd5m2xIPlGI0_Qv@smile.fi.intel.com>
 <Zdd6lnXwvpPPUhRR@smile.fi.intel.com>
 <e5fd9d8b-84eb-4ef9-82ab-ff4ecc41c0d5@broadcom.com>
Message-ID: <ad91eec0-39da-4b9c-8da7-f1e98bb4565b@broadcom.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2/22/24 09:39, Florian Fainelli wrote:
> On 2/22/24 08:47, Andy Shevchenko wrote:
>> On Thu, Feb 22, 2024 at 06:43:08PM +0200, Andy Shevchenko wrote:
>>> On Thu, Feb 22, 2024 at 03:23:24PM +0200, Andy Shevchenko wrote:
>>>> On Thu, Feb 22, 2024 at 11:07:05AM +1030, Andrew Jeffery wrote:
>>>>> On Wed, 2024-02-21 at 20:31 +0200, Andy Shevchenko wrote:
>>>>>> Since we have now a common helper to read port properties
>>>>>> use it instead of sparse home grown solution.
>>>>>
>>>>> I did some brief testing of the series for the Aspeed machines under
>>>>> qemu, building them on top of v6.8-rc5:
>>>>>
>>>>> export ARCH=arm
>>>>> export CROSS_COMPILE=arm-linux-gnueabihf-
>>>>> make aspeed_g5_defconfig
>>>>> make -j$(nproc)
>>>>> qemu-system-arm -M rainier-bmc -nographic -no-reboot -kernel 
>>>>> arch/arm/boot/zImage -dtb 
>>>>> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dtb -initrd ...
>>>>>
>>>>> I got an oops during boot, which bisected to this change:
>>>>
>>>> Thank you for prompt testing! I will look at it.
>>>
>>> I found the issue, will be fixed in next version.
>>
>> Whoever is going to test this series, the
>>
>> -??????? port->iotype = use_defaults ? UPIO_MEM : port->iotype;
>> +??????? port->iotype = UPIO_MEM;
>>
>> should be applied to uart_read_port_properties() implementation.
>>
> 
> Thanks, on 8250_bcm7271.c with the above hunk applied, I did not spot 
> any differences between the values returned by stty or a cat 
> /sys/class/tty/ttyS0/* before or after, the console remained fully 
> functional. I will see if I can run an additional test where I removed 
> the DT's "clocks" property and confirm that the fall back to 
> "clock-frequency" works.
> 
> Thanks Andy!

Also appears to work properly on a Raspberry Pi 4 with the console using 
the bcm2835-aux driver, will provide Tested-by tags on the next 
submission, thanks!
-- 
Florian

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 4221 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240222/f8cc7634/attachment.p7s>
