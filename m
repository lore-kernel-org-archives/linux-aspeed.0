From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 30 Jul 2024 08:04:40 +0200
Subject: [PATCH v11 25/27] ARM: dts: aspeed: yosemite4: add RTQ6056
 support
In-Reply-To: <ZqgRq4h0HWClxSEW@heinlein.vulture-banana.ts.net>
References: <20240723092310.3565410-1-Delphine_CC_Chiu@wiwynn.com>
 <20240723092310.3565410-26-Delphine_CC_Chiu@wiwynn.com>
 <ZqgRq4h0HWClxSEW@heinlein.vulture-banana.ts.net>
Message-ID: <8e416a44-f637-4a3a-ad9a-6a84b3770b2e@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 30/07/2024 00:03, Patrick Williams wrote:
> On Tue, Jul 23, 2024 at 05:23:06PM +0800, Delphine CC Chiu wrote:
>> Add RTQ6056 (spider board 3rd source) support in yosemite4 DTS.
>>
>> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
>> ---
>>  .../boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts  | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
>> index f73719b3c2f1..03a1e41312e3 100644
>> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
>> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
>> @@ -1240,35 +1240,35 @@ adc at 37 {
>>  	};
>>  
>>  	power-sensor at 40 {
>> -		compatible = "ti,ina233";
>> +		compatible = "ti,ina233", "richtek,rtq6056";
> 
> Is this legal to have two chips both listed as compatible?  I thought
> this approach has been rejected before.
> 

Testing would tell... This was clearly not tested and is just ridiculous.

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).


Best regards,
Krzysztof

