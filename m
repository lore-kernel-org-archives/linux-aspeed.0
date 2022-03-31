From: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Date: Thu, 31 Mar 2022 08:44:09 -0700
Subject: [PATCH v3 0/7] Fix AST2600 quad mode SPI pinmux settings
In-Reply-To: <CACPK8Xed5Kh_Y2B3NY41bjgoALvz1gC4zbNfmUaHn_8EbHio4g@mail.gmail.com>
References: <20220329173932.2588289-1-quic_jaehyoo@quicinc.com>
 <CACPK8Xed5Kh_Y2B3NY41bjgoALvz1gC4zbNfmUaHn_8EbHio4g@mail.gmail.com>
Message-ID: <ea2ecef9-f47f-2a4e-8dda-ffd0c3691389@quicinc.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 3/30/2022 10:50 PM, Joel Stanley wrote:
> On Tue, 29 Mar 2022 at 17:40, Jae Hyun Yoo <quic_jaehyoo@quicinc.com> wrote:
>>
>> I?m sending this patch series to fix current issues in AST2600 pinmux
>> settings while enabling quad mode SPI support.
>>
>> FWSPI18 pins are basically 1.8v logic pins that are different from the
>> dedicated FWSPI pins that provide 3.3v logic level, so FWSPI18 pins can?t
>> be grouped with FWSPIDQ2 and FWSPIDQ3, so this series fix the issue.
>>
>> Also, fixes QSPI1 and QSPI2 function settings in AST2600 pinctrl dtsi to
>> make it able to enable quad mode on SPI1 and SPI2 interfaces.
>>
>> With this series, quad mode pinmux can be set like below.
>>
>> FW SPI:
>> &fmc {
>>          pinctrl-names = "default";
>>          pinctrl-0 = <&pinctrl_fwqspi_default>;
>> }
>>
>> SPI1:
>> &spi1 {
>>          pinctrl-names = "default";
>>          pinctrl-0 = <&pinctrl_qspi1_default>;
>> }
>>
>> SPI2:
>> &spi2 {
>>          pinctrl-names = "default";
>>          pinctrl-0 = <&pinctrl_qspi2_default>;
>> }
> 
> Thanks. I hope to see a board from you that uses this soon :)
> 
> I'll send the patches as fixes once -rc1 is out.

Thanks Joel!

Yes, I would be able to send my BMC board dts soon.
Thanks in advance for your review on that too.

Best,
Jae

>>
>> Please review.
>>
>> Thanks,
>> Jae
>>
>> Changes in v3:
>>   * Added bindings patches. (Andrew)
>>
>> Changes in v2:
>>   * Rebased it on the latest.
>>
>> Jae Hyun Yoo (5):
>>    ARM: dts: aspeed-g6: remove FWQSPID group in pinctrl dtsi
>>    pinctrl: pinctrl-aspeed-g6: remove FWQSPID group in pinctrl
>>    dt-bindings: pinctrl: aspeed-g6: remove FWQSPID group
>>    dt-bindings: pinctrl: aspeed-g6: add FWQSPI function/group
>>    ARM: dts: aspeed-g6: fix SPI1/SPI2 quad pin group
>>
>> Johnny Huang (2):
>>    pinctrl: pinctrl-aspeed-g6: add FWQSPI function-group
>>    ARM: dts: aspeed-g6: add FWQSPI group in pinctrl dtsi
>>
>>   .../pinctrl/aspeed,ast2600-pinctrl.yaml         |  4 ++--
>>   arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi        | 10 +++++-----
>>   drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c      | 17 ++++++++---------
>>   3 files changed, 15 insertions(+), 16 deletions(-)
>>
>> --
>> 2.25.1
>>
