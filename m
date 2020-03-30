From: Andrew Geissler <geissonator@gmail.com>
Date: Mon, 30 Mar 2020 13:16:16 -0500
Subject: [PATCH 2/2] ARM: dts: aspeed: zaius: Add gpio line names
In-Reply-To: <294a52cd-2f60-41e5-a58f-a74151a83b08@www.fastmail.com>
References: <20200306170218.79698-1-geissonator@yahoo.com>
 <20200306170218.79698-2-geissonator@yahoo.com>
 <294a52cd-2f60-41e5-a58f-a74151a83b08@www.fastmail.com>
Message-ID: <9360D2B2-8242-4BA1-BF06-8916E87EDE67@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



> On Mar 26, 2020, at 6:20 PM, Andrew Jeffery <andrew@aj.id.au> wrote:
> 
> 
> 
> On Sat, 7 Mar 2020, at 03:32, Andrew Geissler wrote:
>> Name the GPIOs to help userspace work with them. The names describe the
>> functionality the lines provide, not the net or ball name. This makes it
>> easier to share userspace code across different systems and makes the
>> use of the lines more obvious.
>> 
>> Signed-off-by: Andrew Geissler <geissonator@yahoo.com>
> 
> So we're creating a bit of an ad-hoc ABI here between the DT and userspace.
> 
> Where are we documenting it?

Yeah, so far it?s basically design by precedent. If you want your OpenBMC
function to work then follow the standards we're setting in other dts?s.

Is there a good place to document this? I could create a OpenBMC design
doc but that would not address non-OpenBMC areas.

> 
> Generally I think the idea is good though, so:
> 
> Acked-by: Andrew Jeffery <andrew@aj.id.au>

Thanks

> 
>> ---
>> arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts | 37 +++++++++++++++++++---
>> 1 file changed, 33 insertions(+), 4 deletions(-)
>> 
>> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts 
>> b/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
>> index bc60ec291681..4bcc82046362 100644
>> --- a/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
>> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
>> @@ -478,32 +478,61 @@
>> 	pinctrl-names = "default";
>> 	pinctrl-0 = <&pinctrl_gpioh_unbiased>;
>> 
>> +	gpio-line-names =
>> +	/*A0-A7*/	"","cfam-reset","","","","","","",
>> +	/*B0-B7*/	"","","","","","","","",
>> +	/*C0-C7*/	"","","","","","","","",
>> +	/*D0-D7*/	"fsi-enable","","","","","led-sys-boot-status","led-attention",
>> +				"led-fault",
>> +	/*E0-E7*/	"","","","","","","","presence-pcie-e2b",
>> +	/*F0-F7*/	"","","","","","","","checkstop",
>> +	/*G0-G7*/	"fsi-clock","fsi-data","","","","","","",
>> +	/*H0-H7*/	"onewire0","onewire1","onewire2","onewire3","","","","",
>> +	/*I0-I7*/	"","","","power-button","","","","",
>> +	/*J0-J7*/	"","","","","","","","",
>> +	/*K0-K7*/	"","","","","","","","",
>> +	/*L0-L7*/	"","","","","","","","",
>> +	/*M0-M7*/	"","","","","","","","",
>> +	/*N0-N7*/	"","","","","","","","",
>> +	/*O0-O7*/	"","","","","iso_u164_en","","fsi-trans","",
>> +	/*P0-P7*/	"ncsi_mux_en_n","bmc_i2c2_sw_rst_n","","bmc_i2c5_sw_rst_n","",
>> +				"","fsi-mux","",
>> +	/*Q0-Q7*/	"","","","","","","","",
>> +	/*R0-R7*/	"","","","","","","","",
>> +	/*S0-S7*/	"","","","","","","","",
>> +	/*T0-T7*/	"","","","","","","","",
>> +	/*U0-U7*/	"","","","","","","","",
>> +	/*V0-V7*/	"","","","","","","","",
>> +	/*W0-W7*/	"","","","","","","","",
>> +	/*X0-X7*/	"","","","","","","","",
>> +	/*Y0-Y7*/	"","","","","","","","",
>> +	/*Z0-Z7*/	"","","","","","","","",
>> +	/*AA0-AA7*/	"","","led-hdd-fault","","","","","",
>> +	/*AB0-AB7*/	"","","","","","","","",
>> +	/*AC0-AC7*/	"","","","","","","","";
>> +
>> 	line_iso_u146_en {
>> 		gpio-hog;
>> 		gpios = <ASPEED_GPIO(O, 4) GPIO_ACTIVE_HIGH>;
>> 		output-high;
>> -		line-name = "iso_u164_en";
>> 	};
>> 
>> 	ncsi_mux_en_n {
>> 		gpio-hog;
>> 		gpios = <ASPEED_GPIO(P, 0) GPIO_ACTIVE_HIGH>;
>> 		output-low;
>> -		line-name = "ncsi_mux_en_n";
>> 	};
>> 
>> 	line_bmc_i2c2_sw_rst_n {
>> 		gpio-hog;
>> 		gpios = <ASPEED_GPIO(P, 1) GPIO_ACTIVE_HIGH>;
>> 		output-high;
>> -		line-name = "bmc_i2c2_sw_rst_n";
>> 	};
>> 
>> 	line_bmc_i2c5_sw_rst_n {
>> 		gpio-hog;
>> 		gpios = <ASPEED_GPIO(P, 3) GPIO_ACTIVE_HIGH>;
>> 		output-high;
>> -		line-name = "bmc_i2c5_sw_rst_n";
>> 	};
>> };
>> 
>> -- 
>> 2.21.0 (Apple Git-122)
>> 
>> 

