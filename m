From: Eddie James <eajames@linux.ibm.com>
Date: Tue, 21 Mar 2023 10:46:42 -0500
Subject: [PATCH v2 2/4] doc: Add Atmel AT30TSE serial eeprom
In-Reply-To: <6d4cf513-0787-6b39-8d38-30484be7ddff@linaro.org>
References: <20230321151642.461618-1-eajames@linux.ibm.com>
 <20230321151642.461618-3-eajames@linux.ibm.com>
 <6d4cf513-0787-6b39-8d38-30484be7ddff@linaro.org>
Message-ID: <baf7ad36-0410-3063-7960-8dd7040fb8fd@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 3/21/23 10:19, Krzysztof Kozlowski wrote:
> On 21/03/2023 16:16, Eddie James wrote:
>> The AT30TSE is compatible with the JEDEC EE1004 standard. Document it
>> as a trivial I2C device.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Use subject prefixes matching the subsystem (which you can get for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching).


Oops, sorry, will fix.


>
>> ---
>>   Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
>> index 6f482a254a1d..43e26c73a95f 100644
>> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
>> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
>> @@ -47,6 +47,8 @@ properties:
>>             - ams,iaq-core
>>               # i2c serial eeprom (24cxx)
>>             - at,24c08
>> +            # i2c serial eeprom (EE1004 standard)
> AT30TSE?
>
>> +          - atmel,at30tse
> Microchip does not find anything on AT30TSE. Are you sure this is the
> model name?


Yes: 
https://www.microchip.com/content/dam/mchp/documents/OTH/ProductDocuments/DataSheets/Atmel-8868-DTS-AT30TSE004A-Datasheet.pdf


Maybe it's actually an 8868? Or should I include the 004A as well?

Thanks,

Eddie


>
>
> Best regards,
> Krzysztof
>
