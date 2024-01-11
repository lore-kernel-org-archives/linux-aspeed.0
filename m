From: Ninad Palsule <ninad@linux.ibm.com>
Date: Thu, 11 Jan 2024 10:23:29 -0600
Subject: [PATCH v1 1/1] soc/aspeed: Add host side BMC device driver
In-Reply-To: <5c918888-6933-7661-45f0-32ae4521aa2c@linux.vnet.ibm.com>
References: <20230821183525.3427144-1-ninad@linux.ibm.com>
 <20230821183525.3427144-2-ninad@linux.ibm.com>
 <5159abb8-1b4c-4576-b370-4dd9db142beb@lunn.ch>
 <6cea8ee7-f845-6ef3-631f-3f252ff5e949@linux.vnet.ibm.com>
 <5c918888-6933-7661-45f0-32ae4521aa2c@linux.vnet.ibm.com>
Message-ID: <c5a4cde9-cc30-48f7-8da0-7c0e71d7d2aa@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Andrew,

On 8/23/23 12:32, Ninad Palsule wrote:
> Hello Andrew,
>
> On 8/22/23 11:14 AM, Ninad Palsule wrote:
>> Hello Andrew,
>>
>> Thanks for the review.
>>
>> On 8/21/23 2:29 PM, Andrew Lunn wrote:
>>>> Testing:
>>>> ?? - This is tested on IBM rainier system with BMC. It requires BMC 
>>>> side
>>>> ???? BMC device driver which is available in the ASPEED's 5.15 SDK
>>>> ???? kernel.
>>> How relevant is that? To the host side, it just appears to be an
>>> 16550A. Is the SDK emulating an 16550A? If you where to use a
>>> different kernel, is it still guaranteed to be an 16550A? I also
>>> notice there is a mainline
>>> drivers/tty/serial/8250/8250_aspeed_vuart.c. Could that be used on the
>>> BMC? That would be a better testing target than the vendor kernel.
>>
>> This is just to indicate how I tested my code.
>>
>> Yes, aspeed chip (in this case ast2600) is compatible with 16550 UART.
>>
>> I am guessing it should work with different kernel too as 16550 
>> standard is used.
>>
>> The 8250_aspeed_vuart.c is a BMC side driver for accessing VUART over 
>> LPC bus and
>>
>> this is a host side driver to access VUART over PCIe bus.
>>
>>>> +config ASPEED_HOST_BMC_DEV
>>>> +??? bool "ASPEED SoC Host BMC device driver"
>>>> +??? default ARCH_ASPEED
>>>> +??? select SOC_BUS
>>>> +??? default ARCH_ASPEED
>>> same default twice?
>> Removed.
>>
>>>> +late_initcall(aspeed_host_bmc_device_init);
>>>> +module_exit(aspeed_host_bmc_device_exit);
>>> It looks like you can use module_pci_driver() ?
>> yes, It should work unless the late initcall is important. I will 
>> test it and see.
>
> I will not be able to use module_pci_driver() as it doesn't support 
> late initcall which is required otherwise
>
> 8250 registration fails. So I am not making this change.

Please let me know if you are fine with this.

Thanks for the review.

Regards,

Ninad

