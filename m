From: Cédric Le Goater <clg@kaod.org>
Date: Thu, 5 Sep 2019 08:45:06 +0200
Subject: [PATCH] ARM: dts: aspeed-g4: Add all flash chips
In-Reply-To: <d9805fa2-db79-457b-a166-7c84e1608128@www.fastmail.com>
References: <20190905000221.31445-1-joel@jms.id.au>
 <d9805fa2-db79-457b-a166-7c84e1608128@www.fastmail.com>
Message-ID: <6348d0f1-6e2e-cae6-7f76-996825de0527@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 05/09/2019 02:33, Andrew Jeffery wrote:
> 
> 
> On Thu, 5 Sep 2019, at 09:32, Joel Stanley wrote:
>> The FMC supports five chip selects, so describe the five possible flash
>> chips.
>>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> ---
>>  arch/arm/boot/dts/aspeed-g4.dtsi | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
>> index e465cda40fe7..dffb595d30e4 100644
>> --- a/arch/arm/boot/dts/aspeed-g4.dtsi
>> +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
>> @@ -67,6 +67,26 @@
>>  				compatible = "jedec,spi-nor";
>>  				status = "disabled";
>>  			};
>> +			flash at 1 {
>> +				reg = < 1 >;
>> +				compatible = "jedec,spi-nor";
>> +				status = "disabled";
>> +			};
>> +			flash at 2 {
>> +				reg = < 2 >;
>> +				compatible = "jedec,spi-nor";
>> +				status = "disabled";
>> +			};
>> +			flash at 3 {
>> +				reg = < 3 >;
>> +				compatible = "jedec,spi-nor";
>> +				status = "disabled";
>> +			};
>> +			flash at 4 {
>> +				reg = < 4 >;
>> +				compatible = "jedec,spi-nor";
>> +				status = "disabled";
>> +			};
> 
> The FMC supports parallel NOR and NAND interfaces too, but so far no-one has
> cared for these options, so if they ever do we'll fix it then.

New Aspeed SoCs only have SPI support. So I don't think the other interfaces
were ever used.

C. 
 
> 
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> 

