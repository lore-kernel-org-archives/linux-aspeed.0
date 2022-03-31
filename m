From: Cédric Le Goater <clg@kaod.org>
Date: Thu, 31 Mar 2022 17:56:38 +0200
Subject: [PATCH v3 0/7] Fix AST2600 quad mode SPI pinmux settings
In-Reply-To: <ea2ecef9-f47f-2a4e-8dda-ffd0c3691389@quicinc.com>
References: <20220329173932.2588289-1-quic_jaehyoo@quicinc.com>
 <CACPK8Xed5Kh_Y2B3NY41bjgoALvz1gC4zbNfmUaHn_8EbHio4g@mail.gmail.com>
 <ea2ecef9-f47f-2a4e-8dda-ffd0c3691389@quicinc.com>
Message-ID: <c4bcb633-02d2-1cd5-3485-787ebd4b1e0a@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Jae,

On 3/31/22 17:44, Jae Hyun Yoo wrote:
> On 3/30/2022 10:50 PM, Joel Stanley wrote:
>> On Tue, 29 Mar 2022 at 17:40, Jae Hyun Yoo <quic_jaehyoo@quicinc.com> wrote:
>>>
>>> I?m sending this patch series to fix current issues in AST2600 pinmux
>>> settings while enabling quad mode SPI support.
>>>
>>> FWSPI18 pins are basically 1.8v logic pins that are different from the
>>> dedicated FWSPI pins that provide 3.3v logic level, so FWSPI18 pins can?t
>>> be grouped with FWSPIDQ2 and FWSPIDQ3, so this series fix the issue.
>>>
>>> Also, fixes QSPI1 and QSPI2 function settings in AST2600 pinctrl dtsi to
>>> make it able to enable quad mode on SPI1 and SPI2 interfaces.
>>>
>>> With this series, quad mode pinmux can be set like below.
>>>
>>> FW SPI:
>>> &fmc {
>>> ???????? pinctrl-names = "default";
>>> ???????? pinctrl-0 = <&pinctrl_fwqspi_default>;
>>> }
>>>
>>> SPI1:
>>> &spi1 {
>>> ???????? pinctrl-names = "default";
>>> ???????? pinctrl-0 = <&pinctrl_qspi1_default>;
>>> }
>>>
>>> SPI2:
>>> &spi2 {
>>> ???????? pinctrl-names = "default";
>>> ???????? pinctrl-0 = <&pinctrl_qspi2_default>;
>>> }
>>
>> Thanks. I hope to see a board from you that uses this soon :)
>>
>> I'll send the patches as fixes once -rc1 is out.
> 
> Thanks Joel!
> 
> Yes, I would be able to send my BMC board dts soon.
> Thanks in advance for your review on that too.

Out of curiosity, which driver are you using ? the one from SDK ?

I proposed a new one for upstream supporting all AST2400, AST2500, AST2600
controllers. I would be glad to have some feedback if you have time.

Thanks,

C.
