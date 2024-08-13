From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 13 Aug 2024 11:48:30 +0200
Subject: =?UTF-8?B?UmU6IOWbnuimhjogW1BBVENIIHYxIDIvMl0gaXJxY2hpcC9hc3BlZWQt?=
 =?UTF-8?Q?intc=3A_Add_support_for_10_INTC_interrupts_on_AST27XX_platforms?=
In-Reply-To: <PSAPR06MB4949680EBF66DCD47F2B4CF889862@PSAPR06MB4949.apcprd06.prod.outlook.com>
References: <20240813074338.969883-1-kevin_chen@aspeedtech.com>
 <20240813074338.969883-3-kevin_chen@aspeedtech.com>
 <315f9095-8928-44a9-bab7-a924a070eded@kernel.org>
 <PSAPR06MB4949680EBF66DCD47F2B4CF889862@PSAPR06MB4949.apcprd06.prod.outlook.com>
Message-ID: <13e6625f-9f62-4973-b8f2-e825bd7665ee@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 13/08/2024 11:44, Kevin Chen wrote:
> Hi Krzk,
> 
> In ASPEED, ast2400/2500/2600 use arm architecture with KCONFIG_ARCH_ASPEED which slect MACH_ASPEED_G4/G5/G6 in arch/arm/mach-aspeed/Kconfig.
> In the fureture, there would be ast2800/2900/... using arm64. We need to clarify the IC generation between 7th/8th/9th/....
> 
> Maybe change ARCH_ASPEED/MACH_ASPEEDG7 to ARCH_ASPEED first.
> Or, do you have better Kconfig usage?

Fix your quotes and do not top-post.

Please respond inline, instead of top-posting, because it makes your
emails hard to follow.
https://elixir.bootlin.com/linux/v6.8-rc7/source/Documentation/process/submitting-patches.rst#L340

> 
> 
>> +config ARCH_ASPEED
>> +     bool "Aspeed SoC family"
>> +     select MACH_ASPEED_G7
>> +     help
>> +       Say yes if you intend to run on an Aspeed ast2700 or similar
>> +       seventh generation Aspeed BMCs.
>> +
>> +config MACH_ASPEED_G7
>> +     bool "Aspeed SoC AST2700"
> 
> There are no MACHines for arm64. Look at this code. Do you see MACH
> anywhere else? No. Then why Aspeed must be different?

What is this?

> 
> --
> Best Regards,
> Kevin. Chen
> 
> ________________________________
> ???: Krzysztof Kozlowski <krzk@kernel.org>
> ????: 2024?8?13? ?? 04:50
> ???: Kevin Chen <kevin_chen@aspeedtech.com>; tglx at linutronix.de <tglx@linutronix.de>; robh at kernel.org <robh@kernel.org>; krzk+dt at kernel.org <krzk+dt@kernel.org>; conor+dt at kernel.org <conor+dt@kernel.org>; joel at jms.id.au <joel@jms.id.au>; andrew at codeconstruct.com.au <andrew@codeconstruct.com.au>; linux-kernel at vger.kernel.org <linux-kernel@vger.kernel.org>; devicetree at vger.kernel.org <devicetree@vger.kernel.org>; linux-arm-kernel at lists.infradead.org <linux-arm-kernel@lists.infradead.org>; linux-aspeed at lists.ozlabs.org <linux-aspeed@lists.ozlabs.org>
> ??: Re: [PATCH v1 2/2] irqchip/aspeed-intc: Add support for 10 INTC interrupts on AST27XX platforms
> 

...

>> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
>> index 15635812b2d6..d2fe686ae018 100644
>> --- a/drivers/irqchip/Makefile
>> +++ b/drivers/irqchip/Makefile
>> @@ -84,6 +84,7 @@ obj-$(CONFIG_MVEBU_SEI)                     += irq-mvebu-sei.o
>>  obj-$(CONFIG_LS_EXTIRQ)                      += irq-ls-extirq.o
>>  obj-$(CONFIG_LS_SCFG_MSI)            += irq-ls-scfg-msi.o
>>  obj-$(CONFIG_ARCH_ASPEED)            += irq-aspeed-vic.o irq-aspeed-i2c-ic.o irq-aspeed-scu-ic.o
>> +obj-$(CONFIG_MACH_ASPEED_G7)         += irq-aspeed-intc.o
> 
> There is no such thing as CONFIG_MACH_ASPEED_G7. And there will never be.
> 
> You already received feedback on this, so why do you keep pushing your
> solution? You did not respond to any feedback given, just send the same
> and the same till we agree?
> 
> NAK.

And this?

> 
>>  obj-$(CONFIG_STM32MP_EXTI)           += irq-stm32mp-exti.o
>>  obj-$(CONFIG_STM32_EXTI)              += irq-stm32-exti.o
>>  obj-$(CONFIG_QCOM_IRQ_COMBINER)              += qcom-irq-combiner.o
>> diff --git a/drivers/irqchip/irq-aspeed-intc.c b/drivers/irqchip/irq-aspeed-intc.c
>> new file mode 100644
>> index 000000000000..71407475fb27
> 

...

> 
> ************* Email Confidentiality Notice ********************
> ????:
> ???(????)????????????????? ???????????????????????????, ??????????????????????????????!
> 
> DISCLAIMER:
> This message (and any attachments) may contain legally privileged and/or other confidential information. If you have received it in error, please notify the sender by reply e-mail and immediately delete the e-mail and any attachments without copying or disclosing the contents. Thank you.

Maybe I am the intended recipient of your message, maybe not. I don't
want to have any legal questions regarding upstream, public
collaboration, thus probably I should just remove your messages.

Please talk with your IT that such disclaimers in open-source are not
desired (and maybe even harmful).
If you do not understand why, please also see:
https://www.youtube.com/live/fMeH7wqOwXA?si=GY7igfbda6vnjXlJ&t=835

If you need to go around company SMTP server, then consider using b4
web-relay: https://b4.docs.kernel.org/en/latest/contributor/send.html

Please be informed that by responding to this email you agree that all
communications from you and/or your company is made public. In other
words, all messages originating from you and/or your company will be
made public.

You already received exactly this feedback. Around three times. If you
keep ignoring feedback, I will keep NAKing your patches.

Best regards,
Krzysztof

