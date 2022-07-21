From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Thu, 21 Jul 2022 09:46:10 +0700
Subject: [PATCH v2 2/2] ARM: dts: aspeed: Add device tree for Ampere's Mt.
 Mitchell BMC
In-Reply-To: <ab78f85c-dd0a-9176-103f-8e4abe01b8f9@linaro.org>
References: <20220720085230.3801945-1-quan@os.amperecomputing.com>
 <20220720085230.3801945-3-quan@os.amperecomputing.com>
 <ab78f85c-dd0a-9176-103f-8e4abe01b8f9@linaro.org>
Message-ID: <878f9889-0255-96d8-77c8-19b0542932f4@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 20/07/2022 17:36, Krzysztof Kozlowski wrote:
> On 20/07/2022 10:52, Quan Nguyen wrote:
>> The Mt. Mitchell BMC is an ASPEED AST2600-based BMC for the Mt. Mitchell
>> hardware reference platform with AmpereOne(TM) processor.
>>
>> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
>> Signed-off-by: Phong Vo <phong@os.amperecomputing.com>
>> Signed-off-by: Thang Q. Nguyen <thang@os.amperecomputing.com>
>> ---
>> v2 :
>>    + Remove bootargs                                       [Krzysztof]
>>    + Fix gpio-keys nodes name to conform with device tree binding
>>    documents                                               [Krzysztof]
>>    + Fix some nodes to use generic name                    [Krzysztof]
>>    + Remove unnecessary blank line                         [Krzysztof]
>>    + Fix typo "LTC" to "LLC" in license info and corrected license
>>    info to GPL-2.0-only
>>
>>   arch/arm/boot/dts/Makefile                    |   1 +
>>   .../boot/dts/aspeed-bmc-ampere-mtmitchell.dts | 577 ++++++++++++++++++
>>   2 files changed, 578 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
>>
> 
> (...)
> 
>> +
>> +&i2c3 {
>> +	status = "okay";
>> +};
>> +
>> +&i2c4 {
>> +	status = "okay";
>> +
>> +	adc_i2c: adc-i2c at 16 {
> 
> Node name: just "adc"
> 

Thanks, will fix.

>> +		compatible = "lltc,ltc2497";
>> +		reg = <0x16>;
>> +		vref-supply = <&voltage_mon_reg>;
>> +		#io-channel-cells = <1>;
>> +		status = "okay";
> 
> Isn't this new node? Why do you need status here?
> 
Thanks for the comment. The drivers/iio/adc/ltc2497.c does not check for 
the status indeed. Will remove it.

>> +	 };
>> +
>> +	eeprom at 50 {
>> +		compatible = "atmel,24c64";
>> +		reg = <0x50>;
>> +		pagesize = <32>;
>> +	};
>> +
> 
> (...)
> 
>> +
>> +&gpio1 {
>> +	gpio-line-names =
>> +	/*18A0-18A7*/	"","","","","","","","",
>> +	/*18B0-18B7*/	"","","","","emmc-rst-n","","s0-soc-pgood","",
>> +	/*18C0-18C7*/	"uart1-mode0","uart1-mode1","uart2-mode0","uart2-mode1",
>> +			"uart3-mode0","uart3-mode1","uart4-mode0","uart4-mode1",
>> +	/*18D0-18D7*/	"","","","","","","","",
>> +	/*18E0-18E3*/	"","","","";
>> +};
>> +
> 
> You have a trailing line error.
> 
> 
Thanks, will fix
- Quan
