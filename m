From: Kevin Chen <kevin_chen@aspeedtech.com>
Date: Thu, 15 Aug 2024 03:19:24 +0000
Subject: =?big5?B?pl7C0DogW1BBVENIIHYyIDAvMl0gQWRkIHN1cHBvcnQgZm9yIEFTVDI3MDAgSU5U?=
 =?big5?Q?C?=
In-Reply-To: <1bf9edfe-5b32-4382-83d4-5be91e6c036e@kernel.org>
References: <20240814114106.2809876-1-kevin_chen@aspeedtech.com>
 <20240814114106.2809876-2-kevin_chen@aspeedtech.com>
 <1bf9edfe-5b32-4382-83d4-5be91e6c036e@kernel.org>
Message-ID: <PSAPR06MB494959EA1822E0DE5AEF36CD89802@PSAPR06MB4949.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Krzk,

>> Support for the Aspeed Interrupt Controller found on Aspeed 7th Geration Silicon
>> SoCs.
>>
>> ASPEED interrupt controller(INTC) maps the internal interrupt sources of
>> the AST27XX devices to an parent interrupt controller.
>>
>> Changes since v2:
>> Combine the aspeed_intc_ic_of_init and aspeed_intc_ic_of_init_v2.
>> Switch raw_spin_lock_irqsave to scoped_guard and guard.
>> Fix the error of make dt_binding_check.
>> Refine the aspeed,ast2700-intc.yaml.
>
>It seems that entire Aspeed has troubles working with people in the
>community. You do not address feedback, you ignore it and asks us to
>re-review the same crap.
Sorry.

>Before we proceed further:
>1. Answer, inline, without confidentiality notice (after asking you this
>5 times, I think you should fix it finally) that you:
> - agree (ack/ok/agree)
> - disagree with explanation why
Agree, I will reply all previous feedbacks. Sorry to bother you for previous new patches wihout feedback.

>2. Then double check that your new version implements everything above.
Agree

>3. Then send new version (max once per 24h) with changelog and
>versioning (just use `b4`).
I will try to use b4, but I need to check the usage with our ASPEED MIS.
I studied the b4 as the following:
# first patches
b4 prep -n ast27xx-intc
b4 send -o /tmp/tosend
b4 prep --auto-to-cc
b4 prep --edit-cover
b4 send -o /tmp/tosend
./scripts/checkpatch.pl /tmp/tosend/xxx.patch
b4 send --reflect
b4 send --web-auth-new
b4 send --web-auth-verify xxx
b4 send
# new patches
b4 prep --edit-cover
b4 send v2


>If you keep ignoring step 1 and 2, you will annoy reviewers up to the
>point of automatic NAK or being ignored.
I will follow the rules. Thanks for your kind reminder.

--
Best Regards,
Kevin. Chen
________________________________
???: Krzysztof Kozlowski <krzk@kernel.org>
????: 2024?8?14? ?? 11:14
???: Kevin Chen <kevin_chen@aspeedtech.com>; tglx at linutronix.de <tglx@linutronix.de>; robh at kernel.org <robh@kernel.org>; krzk+dt at kernel.org <krzk+dt@kernel.org>; conor+dt at kernel.org <conor+dt@kernel.org>; joel at jms.id.au <joel@jms.id.au>; andrew at codeconstruct.com.au <andrew@codeconstruct.com.au>; linux-kernel at vger.kernel.org <linux-kernel@vger.kernel.org>; devicetree at vger.kernel.org <devicetree@vger.kernel.org>; linux-arm-kernel at lists.infradead.org <linux-arm-kernel@lists.infradead.org>; linux-aspeed at lists.ozlabs.org <linux-aspeed@lists.ozlabs.org>
??: Re: [PATCH v2 0/2] Add support for AST2700 INTC

On 14/08/2024 13:41, Kevin Chen wrote:
> Support for the Aspeed Interrupt Controller found on Aspeed 7th Geration Silicon
> SoCs.
>
> ASPEED interrupt controller(INTC) maps the internal interrupt sources of
> the AST27XX devices to an parent interrupt controller.
>
> Changes since v2:
> Combine the aspeed_intc_ic_of_init and aspeed_intc_ic_of_init_v2.
> Switch raw_spin_lock_irqsave to scoped_guard and guard.
> Fix the error of make dt_binding_check.
> Refine the aspeed,ast2700-intc.yaml.

It seems that entire Aspeed has troubles working with people in the
community. You do not address feedback, you ignore it and asks us to
re-review the same crap.

Before we proceed further:
1. Answer, inline, without confidentiality notice (after asking you this
5 times, I think you should fix it finally) that you:
 - agree (ack/ok/agree)
 - disagree with explanation why

2. Then double check that your new version implements everything above.

3. Then send new version (max once per 24h) with changelog and
versioning (just use `b4`).

If you keep ignoring step 1 and 2, you will annoy reviewers up to the
point of automatic NAK or being ignored.

Best regards,
Krzysztof

************* Email Confidentiality Notice ********************
????:
???(????)????????????????? ???????????????????????????, ??????????????????????????????!

DISCLAIMER:
This message (and any attachments) may contain legally privileged and/or other confidential information. If you have received it in error, please notify the sender by reply e-mail and immediately delete the e-mail and any attachments without copying or disclosing the contents. Thank you.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240815/c7edeaa0/attachment-0001.htm>
