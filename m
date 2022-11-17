From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Thu, 17 Nov 2022 10:23:38 +0700
Subject: [PATCH] ARM: dts: aspeed: mtjade,mtmitchell: Add BMC SSIF nodes
In-Reply-To: <CACPK8XcCKK_o0hBA82k0CEcpbHXbHcUii3bgoGvHaGvtw2Q_Ww@mail.gmail.com>
References: <20221024081115.3320584-1-quan@os.amperecomputing.com>
 <781ea7c7-b33e-f054-71eb-d760f7a01301@os.amperecomputing.com>
 <CACPK8XcCKK_o0hBA82k0CEcpbHXbHcUii3bgoGvHaGvtw2Q_Ww@mail.gmail.com>
Message-ID: <8562147f-b68a-e49d-c914-c8d9d00901d6@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 17/11/2022 10:01, Joel Stanley wrote:
> On Wed, 16 Nov 2022 at 07:06, Quan Nguyen <quan@os.amperecomputing.com> wrote:
>>
>>
>> Just a gentle ping about this patch.
>>
>> Thanks and best regards,
>> - Quan
>>
>> On 24/10/2022 15:11, Quan Nguyen wrote:
>>> Add BMC SSIF node to support IPMI in-band communication.
>>>
>>> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> 
> Applied, thanks.
> 

Thanks Joel.
- Quan

> 
>>> ---
>>>    arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts     | 4 ++++
>>>    arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts | 4 ++++
>>>    2 files changed, 8 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
>>> index d127cbcc7998..353359822d7b 100644
>>> --- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
>>> +++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
>>> @@ -342,6 +342,10 @@ &mac1 {
>>>
>>>    &i2c0 {
>>>        status = "okay";
>>> +     ssif-bmc at 10 {
>>> +             compatible = "ssif-bmc";
>>> +             reg = <0x10>;
>>> +     };
>>>    };
>>>
>>>    &i2c1 {
>>> diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
>>> index 606cd4be245a..4b91600eaf62 100644
>>> --- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
>>> +++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
>>> @@ -445,6 +445,10 @@ &i2c9 {
>>>
>>>    &i2c11 {
>>>        status = "okay";
>>> +     ssif-bmc at 10 {
>>> +             compatible = "ssif-bmc";
>>> +             reg = <0x10>;
>>> +     };
>>>    };
>>>
>>>    &i2c14 {
