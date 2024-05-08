From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Wed, 08 May 2024 10:30:28 +0930
Subject: [PATCH v8 0/2] Change email sender
In-Reply-To: <20240507092109.6018-1-KellyHung@asus.com>
References: <20240507092109.6018-1-KellyHung@asus.com>
Message-ID: <db966c501288c73ac50a86aa2e5884e6cfc28715.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Kelly,

On Tue, 2024-05-07 at 17:21 +0800, Kelly Hung wrote:
> Requesting assistance from ASUS IT, I obtained a new smtp account.
> So send the patch again using new smtp account.

Ah, thanks, however Joel's already sent a PR to the ARM SoC maintainers
with your patches. Sorry that we didn't communicate that too well.
Here's the PR:

https://lore.kernel.org/lkml/CACPK8Xd2Qc9MQUJ-8GuRjmyU50oMHpmmHPHLqAh9W_1Gyqi2ug at mail.gmail.com/

> 
> Kelly Hung (2):
>   dt-bindings: arm: aspeed: add ASUS X4TF board
>   ARM: dts: aspeed: x4tf: Add dts for asus x4tf project
> 
>  .../bindings/arm/aspeed/aspeed.yaml           |   1 +
>  arch/arm/boot/dts/aspeed/Makefile             |   1 +
>  .../boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts  | 581 ++++++++++++++++++
>  3 files changed, 583 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts
> 
> --
> 2.25.1
> 
> ===================================================================================================================================
> This email and any attachments to it contain confidential information and are intended solely for the use of the individual to whom it is addressed. If you are not the intended recipient or receive it accidentally, please immediately notify the sender by e-mail and delete the message and any attachments from your computer system, and destroy all hard copies. Please be advised that any unauthorized disclosure, copying, distribution or any action taken or omitted in reliance on this, is illegal and prohibited. Any views or opinions expressed are solely those of the author and do not represent those of ASUSTeK.
> 
> For pricing information, ASUS is only entitled to set a recommendation resale price. All customers are free to set their own price as they wish.
> ===================================================================================================================================

Unfortunately these footers aren't helpful. The kernel's mailing list
etiquette documentation has more info:

https://subspace.kernel.org/etiquette.html#do-not-include-confidentiality-disclaimers

Andrew
