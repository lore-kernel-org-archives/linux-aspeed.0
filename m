From: Eddie James <eajames@linux.ibm.com>
Date: Mon, 27 Mar 2023 14:01:53 -0500
Subject: [PATCH v2 2/4] doc: Add Atmel AT30TSE serial eeprom
In-Reply-To: <20230327151802.GA3485600-robh@kernel.org>
References: <20230321151642.461618-1-eajames@linux.ibm.com>
 <20230321151642.461618-3-eajames@linux.ibm.com>
 <6d4cf513-0787-6b39-8d38-30484be7ddff@linaro.org>
 <baf7ad36-0410-3063-7960-8dd7040fb8fd@linux.ibm.com>
 <5993d93e-f57b-51aa-85a3-f58ca0cf846d@linux.ibm.com>
 <20230327151802.GA3485600-robh@kernel.org>
Message-ID: <f99a2e40-abd0-699e-d764-0351bd0b2ff5@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 3/27/23 10:18, Rob Herring wrote:
> On Tue, Mar 21, 2023 at 10:55:43AM -0500, Eddie James wrote:
>> On 3/21/23 10:46, Eddie James wrote:
>>> On 3/21/23 10:19, Krzysztof Kozlowski wrote:
>>>> On 21/03/2023 16:16, Eddie James wrote:
>>>>> The AT30TSE is compatible with the JEDEC EE1004 standard. Document it
>>>>> as a trivial I2C device.
>>>>>
>>>>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>>>> Use subject prefixes matching the subsystem (which you can get for
>>>> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
>>>> your patch is touching).
>>>
>>> Oops, sorry, will fix.
>>>
>>>
>>>>> ---
>>>>>  ? Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>>>>>  ? 1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git
>>>>> a/Documentation/devicetree/bindings/trivial-devices.yaml
>>>>> b/Documentation/devicetree/bindings/trivial-devices.yaml
>>>>> index 6f482a254a1d..43e26c73a95f 100644
>>>>> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
>>>>> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
>>>>> @@ -47,6 +47,8 @@ properties:
>>>>>  ??????????? - ams,iaq-core
>>>>>  ????????????? # i2c serial eeprom (24cxx)
>>>>>  ??????????? - at,24c08
>>>>> +??????????? # i2c serial eeprom (EE1004 standard)
>>>> AT30TSE?
>>>>
>>>>> +????????? - atmel,at30tse
>>>> Microchip does not find anything on AT30TSE. Are you sure this is the
>>>> model name?
>>>
>>> Yes: https://www.microchip.com/content/dam/mchp/documents/OTH/ProductDocuments/DataSheets/Atmel-8868-DTS-AT30TSE004A-Datasheet.pdf
>>>
>>>
>>> Maybe it's actually an 8868? Or should I include the 004A as well?
>>
>> I found some other AT30TSE (AT30TSE752A for example) devices that do not
>> appear compatible with the EE1004 standard, so I will include the full model
>> number.
> If this standard is sufficiently complete, then you might want a EE1004
> fallback compatible. Complete would mean power supply(ies) and any extra
> i/o are defined and the exact device model is discoverable.


I don't think this standard would meet those requirements unfortunately. 
Thanks for the suggestion!

Eddie


>
> Rob
