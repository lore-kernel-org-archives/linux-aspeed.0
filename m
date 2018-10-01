From: Eddie James <eajames@linux.vnet.ibm.com>
Date: Mon, 1 Oct 2018 10:20:57 -0500
Subject: [PATCH v3 1/2] dt-bindings: media: Add Aspeed Video Engine
 binding documentation
In-Reply-To: <CACPK8Xd0MhrFQqiM=u-Rv5u7RJRo5R-pAejH4dmeTrYSWE0AZA@mail.gmail.com>
References: <1537903629-14003-1-git-send-email-eajames@linux.ibm.com>
 <1537903629-14003-2-git-send-email-eajames@linux.ibm.com>
 <CACPK8Xd0MhrFQqiM=u-Rv5u7RJRo5R-pAejH4dmeTrYSWE0AZA@mail.gmail.com>
Message-ID: <3e53dda4-81c4-1009-add2-45a3a7998e4e@linux.vnet.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 10/01/2018 08:08 AM, Joel Stanley wrote:
> On Tue, 25 Sep 2018 at 21:27, Eddie James <eajames@linux.ibm.com> wrote:
>> Document the bindings.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>>   .../devicetree/bindings/media/aspeed-video.txt     | 26 ++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/media/aspeed-video.txt
>>
>> diff --git a/Documentation/devicetree/bindings/media/aspeed-video.txt b/Documentation/devicetree/bindings/media/aspeed-video.txt
>> new file mode 100644
>> index 0000000..f1af528
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/media/aspeed-video.txt
>> @@ -0,0 +1,26 @@
>> +* Device tree bindings for Aspeed Video Engine
>> +
>> +The Video Engine (VE) embedded in the Aspeed AST2400 and AST2500 SOCs can
>> +capture and compress video data from digital or analog sources.
>> +
>> +Required properties:
>> + - compatible:         "aspeed,ast2400-video-engine" or
>> +                       "aspeed,ast2500-video-engine"
>> + - reg:                        contains the offset and length of the VE memory region
>> + - clocks:             clock specifiers for the syscon clocks associated with
>> +                       the VE (ordering must match the clock-names property)
>> + - clock-names:                "vclk" and "eclk"
>> + - resets:             reset specifier for the syscon reset associaated with
> associated

Good catch, thanks.

>
>> +                       the VE
>> + - interrupts:         the interrupt associated with the VE on this platform
>> +
>> +Example:
>> +
>> +video-engine at 1e700000 {
>> +    compatible = "aspeed,ast2500-video-engine";
>> +    reg = <0x1e700000 0x20000>;
>> +    clocks = <&syscon ASPEED_CLK_GATE_VCLK>, <&syscon ASPEED_CLK_GATE_ECLK>;
>> +    clock-names = "vclk", "eclk";
> Did you end up sending the clock patches out?

Yes,

https://lore.kernel.org/patchwork/patch/978979/
https://lore.kernel.org/patchwork/patch/978976/

Do I need to send them as a separate series?

Thanks,
Eddie

>
> Cheers,
>
> Joel
>
>> +    resets = <&syscon ASPEED_RESET_VIDEO>;
>> +    interrupts = <7>;
>> +};
>> --
>> 1.8.3.1
>>

