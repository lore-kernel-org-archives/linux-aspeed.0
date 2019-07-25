From: Adriana Kobylak <anoo@linux.ibm.com>
Date: Thu, 25 Jul 2019 08:41:52 -0500
Subject: [PATCH linux dev-5.2] ARM: dts: aspeed: swift: Fix FSI GPIOs
In-Reply-To: <7f2c08f5-a04d-499c-b59b-3d62d7f025af@www.fastmail.com>
References: <20190719203037.11795-1-mspinler@linux.ibm.com>
 <7f2c08f5-a04d-499c-b59b-3d62d7f025af@www.fastmail.com>
Message-ID: <28d5c3f99df3c11bc04ba5d79626fec8@linux.vnet.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2019-07-23 19:32, Andrew Jeffery wrote:
> On Sat, 20 Jul 2019, at 06:01, Matt Spinler wrote:
>> From: Matt Spinler <spinler@us.ibm.com>
>> 
>> Change the FSI clock and data GPIOs to match what the hardware turned
>> out to use.
>> 
>> Signed-off-by: Matt Spinler <spinler@us.ibm.com>
> 
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: Adriana Kobylak <anoo@us.ibm.com>

Schematics have been updated.

> 
> And yeah, please make sure to include relevant lists in the future as 
> Olof
> mentioned.
> 
> Andrew
> 
>> ---
>>  arch/arm/boot/dts/aspeed-bmc-opp-swift.dts | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
>> b/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
>> index caac895c60b4..f14f745b34ca 100644
>> --- a/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
>> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
>> @@ -207,8 +207,8 @@
>>  		#size-cells = <0>;
>>  		no-gpio-delays;
>> 
>> -		clock-gpios = <&gpio ASPEED_GPIO(AA, 0) GPIO_ACTIVE_HIGH>;
>> -		data-gpios = <&gpio ASPEED_GPIO(E, 0) GPIO_ACTIVE_HIGH>;
>> +		clock-gpios = <&gpio ASPEED_GPIO(P, 1) GPIO_ACTIVE_HIGH>;
>> +		data-gpios = <&gpio ASPEED_GPIO(P, 2) GPIO_ACTIVE_HIGH>;
>>  		mux-gpios = <&gpio ASPEED_GPIO(P, 4) GPIO_ACTIVE_HIGH>;
>>  		enable-gpios = <&gpio ASPEED_GPIO(P, 0) GPIO_ACTIVE_HIGH>;
>>  		trans-gpios = <&gpio ASPEED_GPIO(P, 3) GPIO_ACTIVE_HIGH>;
>> --
>> 2.22.0
>> 
>> 
