From: Ninad Palsule <ninad@linux.ibm.com>
Date: Mon, 8 Jan 2024 14:04:42 -0600
Subject: [PATCH v1 7/8] tpm: tis-i2c: Add more compatible strings
In-Reply-To: <20231212-avid-grill-dbead068fac8@spud>
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
 <20231212164004.1683589-8-ninad@linux.ibm.com>
 <20231212-avid-grill-dbead068fac8@spud>
Message-ID: <d5b2ce4b-ada0-46d3-98b1-8648127dec2b@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Conor,

On 12/12/23 11:15, Conor Dooley wrote:
> On Tue, Dec 12, 2023 at 10:40:03AM -0600, Ninad Palsule wrote:
>> From: Joel Stanley <joel@jms.id.au>
>>
>> The NPCT75x TPM is TIS compatible. It has an I2C and SPI interface.
>>
>> https://www.nuvoton.com/products/cloud-computing/security/trusted-platform-module-tpm/
>>
>> Add a compatible string for it, and the generic compatible.
>>
>> OpenBMC-Staging-Count: 3
> Delete this from every patch that it appears from.
Removed.
>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
>> Link: https://lore.kernel.org/r/20220928043957.2636877-4-joel at jms.id.au
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>> ---
>>   drivers/char/tpm/tpm_tis_i2c.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
>> index a897402cc36a..9511c0d50185 100644
>> --- a/drivers/char/tpm/tpm_tis_i2c.c
>> +++ b/drivers/char/tpm/tpm_tis_i2c.c
>> @@ -383,6 +383,8 @@ MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_id);
>>   #ifdef CONFIG_OF
>>   static const struct of_device_id of_tis_i2c_match[] = {
>>   	{ .compatible = "infineon,slb9673", },
>> +	{ .compatible = "nuvoton,npct75x", },
>> +	{ .compatible = "tcg,tpm-tis-i2c", },
> What's the point of the generic compatible if you are adding the device
> specific ones to the driver anyway?
>
> Thanks,
> Conor.

I have removed this commit from this patchset and send it as a separate 
patch.

Regards,

Ninad

