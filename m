From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 23 Aug 2024 08:13:28 +0200
Subject: [PATCH v5 1/2] dt-bindings: arm: aspeed: Add aspeed,video binding
In-Reply-To: <TYZPR06MB6568AB9E260263DBB1ED474DF1882@TYZPR06MB6568.apcprd06.prod.outlook.com>
References: <20240819080859.1304671-1-jammy_huang@aspeedtech.com>
 <20240819080859.1304671-2-jammy_huang@aspeedtech.com>
 <nnjcjt2kuplsy5bbxujuubkn2xdtpifjeiqt5qfvktdmaorzuz@x444p5ezcoch>
 <TYZPR06MB6568AB9E260263DBB1ED474DF1882@TYZPR06MB6568.apcprd06.prod.outlook.com>
Message-ID: <a17f963e-0e6d-4132-817f-2e663268ee2d@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 23/08/2024 03:11, Jammy Huang wrote:

> 
>>
>>> @@ -0,0 +1,81 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/arm/aspeed/aspeed,video.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: ASPEED Video Engine
>>
>> ASPEED or Aspeed?
> I prefer ASPEED.

What is the name of the company? How is it called in all bindings? Is it
an acronym?

> 
>>
>>> +
>>> +maintainers:
>>> +  - Eddie James <eajames@linux.ibm.com>
>>> +  - Jammy Huang <jammy_huang@aspeedtech.com>
>>> +
>>> +descriptio


...

> 
>>
>>> +           compatible = "aspeed,ast2600-video-engine";
>>
>> Fix indentation, this is supposed 4 spaces.
> OK
> ************* Email Confidentiality Notice ********************
> ????:
> ???(????)????????????????? ???????????????????????????, ??????????????????????????????!
> 
> DISCLAIMER:
> This message (and any attachments) may contain legally privileged and/or other confidential information. If you have received it in error, please notify the sender by reply e-mail and immediately delete the e-mail and any attachments without copying or disclosing the contents. Thank you.


Every damn time from Aspeed. People, fix it finally. If you keep sending
confidential data, I will be rejecting/NAKing and deleting your messages
as requested.

<form letter>
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
<form letter>

Best regards,
Krzysztof

