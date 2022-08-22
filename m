From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 22 Aug 2022 13:13:25 +0200
Subject: [PATCH 1/2] dt-bindings: pinctrl: aspeed: Add missing properties
 to examples
In-Reply-To: <20220810161635.73936-2-robh@kernel.org>
References: <20220810161635.73936-1-robh@kernel.org> <20220810161635.73936-2-robh@kernel.org>
Message-ID: <CACRpkdagwr91UuwC80thn5t7KpcBek1gitTHPHvUy1ntP7FQrg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Aug 10, 2022 at 6:16 PM Rob Herring <robh@kernel.org> wrote:

> The aspeed pinctrl parent node (SCU) in the examples is missing various
> properties. Add the properties in preparation for the SCU schema.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

I see Lee applied 2/2 to the MFD tree so I applied this to the pinctrl
tree.

Yours,
Linus Walleij
