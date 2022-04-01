From: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Date: Fri, 1 Apr 2022 07:10:26 -0700
Subject: [PATCH v3 0/7] Fix AST2600 quad mode SPI pinmux settings
In-Reply-To: <42694139-61d0-fb0d-d4c3-a81cc31488d2@quicinc.com>
References: <20220329173932.2588289-1-quic_jaehyoo@quicinc.com>
 <CACPK8Xed5Kh_Y2B3NY41bjgoALvz1gC4zbNfmUaHn_8EbHio4g@mail.gmail.com>
 <ea2ecef9-f47f-2a4e-8dda-ffd0c3691389@quicinc.com>
 <c4bcb633-02d2-1cd5-3485-787ebd4b1e0a@kaod.org>
 <42694139-61d0-fb0d-d4c3-a81cc31488d2@quicinc.com>
Message-ID: <e362f6dd-785f-87b3-3090-554be0fb860c@quicinc.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi C?dric,

On 3/31/2022 9:06 AM, Jae Hyun Yoo wrote:
> Hello C?dric,
> 
> On 3/31/2022 8:56 AM, C?dric Le Goater wrote:
>> Hello Jae,
>>
>> On 3/31/22 17:44, Jae Hyun Yoo wrote:
>>> On 3/30/2022 10:50 PM, Joel Stanley wrote:
>>>> On Tue, 29 Mar 2022 at 17:40, Jae Hyun Yoo 
>>>> <quic_jaehyoo@quicinc.com> wrote:
>>>>>
>>>>> I?m sending this patch series to fix current issues in AST2600 pinmux
>>>>> settings while enabling quad mode SPI support.
>>>>>
>>>>> FWSPI18 pins are basically 1.8v logic pins that are different from the
>>>>> dedicated FWSPI pins that provide 3.3v logic level, so FWSPI18 pins 
>>>>> can?t
>>>>> be grouped with FWSPIDQ2 and FWSPIDQ3, so this series fix the issue.
>>>>>
>>>>> Also, fixes QSPI1 and QSPI2 function settings in AST2600 pinctrl 
>>>>> dtsi to
>>>>> make it able to enable quad mode on SPI1 and SPI2 interfaces.
>>>>>
>>>>> With this series, quad mode pinmux can be set like below.
>>>>>
>>>>> FW SPI:
>>>>> &fmc {
>>>>> ???????? pinctrl-names = "default";
>>>>> ???????? pinctrl-0 = <&pinctrl_fwqspi_default>;
>>>>> }
>>>>>
>>>>> SPI1:
>>>>> &spi1 {
>>>>> ???????? pinctrl-names = "default";
>>>>> ???????? pinctrl-0 = <&pinctrl_qspi1_default>;
>>>>> }
>>>>>
>>>>> SPI2:
>>>>> &spi2 {
>>>>> ???????? pinctrl-names = "default";
>>>>> ???????? pinctrl-0 = <&pinctrl_qspi2_default>;
>>>>> }
>>>>
>>>> Thanks. I hope to see a board from you that uses this soon :)
>>>>
>>>> I'll send the patches as fixes once -rc1 is out.
>>>
>>> Thanks Joel!
>>>
>>> Yes, I would be able to send my BMC board dts soon.
>>> Thanks in advance for your review on that too.
>>
>> Out of curiosity, which driver are you using ? the one from SDK ?
>>
>> I proposed a new one for upstream supporting all AST2400, AST2500, 
>> AST2600
>> controllers. I would be glad to have some feedback if you have time.
> 
> Yes, I saw your patch set of the new driver.
> 
> I'm currently using this fix with legacy aspeed-smc driver after
> adding some fixes. I'll give it a try with your new driver as well and
> will give you some feedback if I find any.

I tested this patch series using the new spi-aspeed-smc driver you
proposed.

https://lore.kernel.org/linux-arm-kernel/20220325100849.2019209-1-clg at kaod.org/

I modified my BMC's device tree like below to enable quad mode.

	&fmc {
		status = "okay";
		pinctrl-names = "default";
		pinctrl-0 = <&pinctrl_fwqspi_default>;

		flash at 0 {
			status = "okay";
			m25p,fast-read;
			label = "bmc";
			spi-rx-bus-width = <4>;
			spi-max-frequency = <133000000>;
	#include "openbmc-flash-layout-64.dtsi"
		};

		flash at 1 {
			status = "okay";
			m25p,fast-read;
			label = "alt-bmc";
			spi-rx-bus-width = <4>;
			spi-max-frequency = <133000000>;
	#include "openbmc-flash-layout-64-alt.dtsi"
		};
	};

And I got these kernel boot logs.

[    0.720745] spi-nor spi0.0: w25q512nwfm (65536 Kbytes)
[    0.837368] spi-aspeed-smc 1e620000.spi: CE0 read buswidth:4 [0x406c0741]
[    0.846352] 5 fixed-partitions partitions found on MTD device bmc
[    0.853220] Creating 5 MTD partitions on "bmc":
[    0.858295] 0x000000000000-0x0000000e0000 : "u-boot"
[    0.865014] 0x0000000e0000-0x000000100000 : "u-boot-env"
[    0.872229] 0x000000100000-0x000000a00000 : "kernel"
[    0.878963] 0x000000a00000-0x000002a00000 : "rofs"
[    0.885406] 0x000002a00000-0x000004000000 : "rwfs"
[    0.892880] spi-nor spi0.1: w25q512nwfm (65536 Kbytes)
[    1.009460] spi-aspeed-smc 1e620000.spi: CE1 read buswidth:4 [0x406c0741]
[    1.018334] 5 fixed-partitions partitions found on MTD device alt-bmc
[    1.025537] Creating 5 MTD partitions on "alt-bmc":
[    1.031027] 0x000000000000-0x0000000e0000 : "u-boot-alt"
[    1.038165] 0x0000000e0000-0x000000100000 : "u-boot-env-alt"
[    1.045623] 0x000000100000-0x000000a00000 : "kernel-alt"
[    1.052807] 0x000000a00000-0x000002a00000 : "rofs-alt"
[    1.059800] 0x000002a00000-0x000004000000 : "rwfs-alt"

As you can see in the log, FMC10[31:28] and FMC14[31:28] are properly
set to 0100b which means 'quad bit read/write, data cycle only'.
I verified that your new driver supports quad mode properly and it has
worked well so far without making any issue.

Thanks for your making the new driver.
I left my comment in your patch proposal thread.

Cheers,

Jae



