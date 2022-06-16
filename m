From: Randy Dunlap <rdunlap@infradead.org>
Date: Thu, 16 Jun 2022 08:02:22 -0700
Subject: [PATCH v8 1/3] ipmi: ssif_bmc: Add SSIF BMC driver
In-Reply-To: <74f94464-a095-f539-746a-853b8f1d52ca@os.amperecomputing.com>
References: <20220615090259.1121405-1-quan@os.amperecomputing.com>
 <20220615090259.1121405-2-quan@os.amperecomputing.com>
 <8b7841a9-9313-b1d5-8a80-a65cfa8e7b4d@infradead.org>
 <74f94464-a095-f539-746a-853b8f1d52ca@os.amperecomputing.com>
Message-ID: <fb8e7e35-7f26-15bc-9fbb-2949fc80a18b@infradead.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 6/16/22 00:25, Quan Nguyen wrote:
> On 15/06/2022 23:06, Randy Dunlap wrote:
>>
>>
>> On 6/15/22 02:02, Quan Nguyen wrote:
>>> diff --git a/drivers/char/ipmi/Kconfig b/drivers/char/ipmi/Kconfig
>>> index b061e6b513ed..18a89093d64e 100644
>>> --- a/drivers/char/ipmi/Kconfig
>>> +++ b/drivers/char/ipmi/Kconfig
>>> @@ -169,6 +169,17 @@ config ASPEED_BT_IPMI_BMC
>>> ??????? found on Aspeed SOCs (AST2400 and AST2500). The driver
>>> ??????? implements the BMC side of the BT interface.
>>> ? +config SSIF_IPMI_BMC
>>> +??? tristate "SSIF IPMI BMC driver"
>>> +??? select I2C
>>
>> No. That should be:
>> ????depends on I2C
>>
>> We don't select an entire subsystem just to satisfy one driver.
>>
>>> +??? select I2C_SLAVE
>>> +??? help
>>> +????? This enables the IPMI SMBus system interface (SSIF) at the
>>> +????? management (BMC) side.
>>> +
>>> +????? The driver implements the BMC side of the SMBus system
>>> +????? interface (SSIF).
>>> +
>>
>> Thanks.
> 
> Thanks Randy,
> it should be change to "depends on I2C && I2C_SLAVE"

Either way is OK for I2C_SLAVE AFAIK.

thanks.

-- 
~Randy
