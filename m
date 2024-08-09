From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Fri, 9 Aug 2024 06:12:02 +0000
Subject: [PATCH 2/4] dt-bindings: reset Add AST2700 reset bindings
In-Reply-To: <4f1c275d-63bd-4649-9517-17ac4f20e3bf@kernel.org>
References: <20240808075937.2756733-1-ryan_chen@aspeedtech.com>
 <20240808075937.2756733-3-ryan_chen@aspeedtech.com>
 <0f227033-4818-4ff5-9140-851c6d802fb2@wanadoo.fr>
 <OS8PR06MB7541E0944EAD547DED2AE561F2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <4f1c275d-63bd-4649-9517-17ac4f20e3bf@kernel.org>
Message-ID: <OS8PR06MB75413780807BD24C2E281303F2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Subject: Re: [PATCH 2/4] dt-bindings: reset Add AST2700 reset bindings
>
> On 09/08/2024 07:42, Ryan Chen wrote:
> >>> +#define SCU0_RESET_PORTA_EHCI              (38)
> >>> +#define SCU0_RESET_PORTA_VHUB0             (38)
> >>
> >> Is having 38 twice expected?
> >> If not, why not use an enum, BTW?
> >>
> > Yes, it is expected. Due to 38 is shared reset for 2 usb controller.
> > One for EHCI, another is for vhub0. So I do define the same value.
> > That I can do more clear in dtsi description.
> > The following will be expected dtsi file descript.
>
> No, that's confusing. Don't do this. You are hiding information that one reset is
> shared. Terrible idea.

OK I can remove this.
Use #define SCU0_RESET_PORTA_USB              (38)
>
> Best regards,
> Krzysztof

************* Email Confidentiality Notice ********************
????:
???(????)????????????????? ???????????????????????????, ??????????????????????????????!

DISCLAIMER:
This message (and any attachments) may contain legally privileged and/or other confidential information. If you have received it in error, please notify the sender by reply e-mail and immediately delete the e-mail and any attachments without copying or disclosing the contents. Thank you.
