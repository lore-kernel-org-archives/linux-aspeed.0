From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Wed, 28 Aug 2024 06:05:01 +0000
Subject: [PATCH v5 1/2] dt-bindings: arm: aspeed: Add aspeed,video binding
In-Reply-To: <a17f963e-0e6d-4132-817f-2e663268ee2d@kernel.org>
References: <20240819080859.1304671-1-jammy_huang@aspeedtech.com>
 <20240819080859.1304671-2-jammy_huang@aspeedtech.com>
 <nnjcjt2kuplsy5bbxujuubkn2xdtpifjeiqt5qfvktdmaorzuz@x444p5ezcoch>
 <TYZPR06MB6568AB9E260263DBB1ED474DF1882@TYZPR06MB6568.apcprd06.prod.outlook.com>
 <a17f963e-0e6d-4132-817f-2e663268ee2d@kernel.org>
Message-ID: <TYZPR06MB6568A38AD08F72EC637EFA7BF1952@TYZPR06MB6568.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

Sorry for the troublesome e-mail notice. We have informed IT to remove it.

On 2024/8/23 ?? 02:13, Krzysztof Kozlowski wrote:
> On 23/08/2024 03:11, Jammy Huang wrote:
> 
> >
> >>
> >>> @@ -0,0 +1,81 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/arm/aspeed/aspeed,video.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: ASPEED Video Engine
> >>
> >> ASPEED or Aspeed?
> > I prefer ASPEED.
> 
> What is the name of the company? How is it called in all bindings? Is it an
> acronym?
It's ASPEED Technology Inc. You can find brief introduction here, https://www.aspeedtech.com/about_vision/.
I did check it in bindings, but both ASPEED and Aspeed can be found.
If you have suggestion, please let me know.
> 
> >
> >>
> >>> +
> >>> +maintainers:
> >>> +  - Eddie James <eajames@linux.ibm.com>
> >>> +  - Jammy Huang <jammy_huang@aspeedtech.com>
> >>> +
> >>> +descriptio
> 
> 
> ...
Typo. Will be fixed.

> 
> >
> >>
> >>> +           compatible = "aspeed,ast2600-video-engine";
> >>
> >> Fix indentation, this is supposed 4 spaces.
> > OK
> 
> Every damn time from Aspeed. People, fix it finally. If you keep sending
> confidential data, I will be rejecting/NAKing and deleting your messages as
> requested.
> 
> <form letter>
> Maybe I am the intended recipient of your message, maybe not. I don't want to
> have any legal questions regarding upstream, public collaboration, thus
> probably I should just remove your messages.
> 
> Please talk with your IT that such disclaimers in open-source are not desired
> (and maybe even harmful).
> If you do not understand why, please also see:
> https://www.youtube.com/live/fMeH7wqOwXA?si=GY7igfbda6vnjXlJ&t=835
> 
> If you need to go around company SMTP server, then consider using b4
> web-relay: https://b4.docs.kernel.org/en/latest/contributor/send.html
> 
> Please be informed that by responding to this email you agree that all
> communications from you and/or your company is made public. In other words,
> all messages originating from you and/or your company will be made public.
> <form letter>
> 
> Best regards,
> Krzysztof

