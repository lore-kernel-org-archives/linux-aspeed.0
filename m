From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 12 Dec 2023 11:50:00 -0800
Subject: [PATCH v1 7/8] tpm: tis-i2c: Add more compatible strings
In-Reply-To: <20231212-mouth-choice-40a83caa34ec@spud>
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
 <20231212164004.1683589-8-ninad@linux.ibm.com>
 <20231212-avid-grill-dbead068fac8@spud>
 <73381bb0-7fa7-4a9e-88df-ab0063058e26@roeck-us.net>
 <20231212-mouth-choice-40a83caa34ec@spud>
Message-ID: <2946fbb1-2a47-4d21-83dc-8e45bf6ba5a9@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 12/12/23 10:51, Conor Dooley wrote:
> On Tue, Dec 12, 2023 at 10:00:39AM -0800, Guenter Roeck wrote:
>> On Tue, Dec 12, 2023 at 05:15:51PM +0000, Conor Dooley wrote:
>>> On Tue, Dec 12, 2023 at 10:40:03AM -0600, Ninad Palsule wrote:
>>>> From: Joel Stanley <joel@jms.id.au>
>>>>
>>>> The NPCT75x TPM is TIS compatible. It has an I2C and SPI interface.
>>>>
>>>> https://www.nuvoton.com/products/cloud-computing/security/trusted-platform-module-tpm/
>>>>
>>>> Add a compatible string for it, and the generic compatible.
>>>>
>>>> OpenBMC-Staging-Count: 3
>>>
>>> Delete this from every patch that it appears from.
>>>
>>>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>>>> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
>>>> Link: https://lore.kernel.org/r/20220928043957.2636877-4-joel at jms.id.au
>>>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>>>> ---
>>>>   drivers/char/tpm/tpm_tis_i2c.c | 2 ++
>>>>   1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
>>>> index a897402cc36a..9511c0d50185 100644
>>>> --- a/drivers/char/tpm/tpm_tis_i2c.c
>>>> +++ b/drivers/char/tpm/tpm_tis_i2c.c
>>>> @@ -383,6 +383,8 @@ MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_id);
>>>>   #ifdef CONFIG_OF
>>>>   static const struct of_device_id of_tis_i2c_match[] = {
>>>>   	{ .compatible = "infineon,slb9673", },
>>>> +	{ .compatible = "nuvoton,npct75x", },
>>>> +	{ .compatible = "tcg,tpm-tis-i2c", },
>>>
>>> What's the point of the generic compatible if you are adding the device
>>> specific ones to the driver anyway?
>>>
>>
>> $ git grep infineon,slb9673
>> Documentation/devicetree/bindings/trivial-devices.yaml:          - infineon,slb9673
> 
> Hmm, this would then need to be moved into the new schema, out of
> trivial devices.
> 
>> drivers/char/tpm/tpm_tis_i2c.c: { .compatible = "infineon,slb9673", },
>> $ git grep nuvoton,npct75x
>> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:            compatible = "nuvoton,npct75x", "tcg,tpm-tis-i2c";
>> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts:            compatible = "nuvoton,npct75x", "tcg,tpm-tis-i2c";
>> $ git grep tcg,tpm-tis-i2c
>> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:            compatible = "nuvoton,npct75x", "tcg,tpm-tis-i2c";
>> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts:            compatible = "nuvoton,npct75x", "tcg,tpm-tis-i2c";
>> arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts:             compatible = "tcg,tpm-tis-i2c";
> 
> pog, undocumented compatibles.
> 

Yes, I know, quite annoying. Though, to be fair, a generic "tcg,tpm-tis-i2c"
would make a lot of sense.

Note that Rob had rejected the original addition (into trivial devices)
with the argument that it is not a trivial device
(https://lore.kernel.org/lkml/20220605225610.GA3682221-robh at kernel.org/).

>> It looks like at least the generic entry is needed, given that it is quite
>> likely that there is hardware out there using it. Other than that, this
>> makes me wonder: Is there some official guideline describing if and when
>> to use (only) generic devicetree compatible entries and when specific ones
>> may / should / have to be used ? I suspect the answer to your question might
>> simply be "because we did not know better", and it might be helpful to be
>> able to say "please see XXX for details".
> 
> To me using generic compatibles is okay when there is another mechanism
> to identify the device. This patch would make more sense if the addition
> of nuvoton,npct75x was omitted and the dt-binding had
> 
> properties:
>    compatible:
>      items:
>        - enum:
>            - infineon,slb9673
>            - nuvoton,npct75x
>        - const: tcg,tpm-tis-i2c
> 
> And whenever new i2c tpms showed up the device specific compatible was
> added to the bindings and the driver had only* the generic compatible
> static const struct of_device_id of_tis_i2c_match[] = {
> 	{ .compatible = "infineon,slb9673", },
> 	{ .compatible = "tcg,tpm-tis-i2c", },
> };
> 
> * well, and the existing one since that cannot be removed.

That would be perfectly fine with me. All I personally care about is to get
"tcg,tpm-tis-i2c" added to the kernel source so I can start testing the
code in qemu.

Thanks,
Guenter

