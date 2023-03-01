From: Joel Stanley <joel@jms.id.au>
Date: Wed, 1 Mar 2023 01:04:15 +0000
Subject: [PATCH 0/4] i3c: Add support for ast2600 i3c controller
In-Reply-To: <cover.1676532146.git.jk@codeconstruct.com.au>
References: <cover.1676532146.git.jk@codeconstruct.com.au>
Message-ID: <CACPK8Xd0k8EKR1v4NVmgb6yp3Zh5hUyVyoxsyk0NTx9MF80oYQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 16 Feb 2023 at 07:42, Jeremy Kerr <jk@codeconstruct.com.au> wrote:
>
> The AST2600 SoC hardware includes a set of i3c controllers, based on the
> designware i3c core, plus some global registers for SoC integration.
>
> This series adds support for these i3c controllers, through the existing
> dw i3c master controller driver, by adding a set of platform-specific
> hooks to handle the global register configuration. This also gives us a
> way to add any future hardware-specific behaviours.
>
> We also need a DT binding to describe the ast2600-specific hardware.
> Since this involves new (mandatory) properties, I have added this as a
> separate binding rather than add a new compat string to the dw binding.
>
> The dt-binding example depends on a prior submission to the dt binding
> headers:
>
>   https://lore.kernel.org/linux-devicetree/cover.1676294433.git.jk at codeconstruct.com.au/
>
> Full support for the global regmap will land with this queued mfd change:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/commit/?id=cf2271843de835839e91c5c036492a87085af756
>
> Of course, any queries/comments/etc are most welcome.

Reviewed-by: Joel Stanley <joel@jms.id.au>

>
> Cheers,
>
>
> Jeremy
>
> Jeremy Kerr (4):
>   dt-bindings: i3c: Add AST2600 i3c controller
>   i3c: dw: Add platform operations
>   i3c: dw: Add AST2600 platform ops
>   i3c: dw: Add compatible string for ASPEED AST2600 BMC platform
>
>  .../bindings/i3c/aspeed,ast2600-i3c.yaml      |  73 ++++++++
>  drivers/i3c/master/dw-i3c-master.c            | 165 +++++++++++++++++-
>  2 files changed, 232 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/i3c/aspeed,ast2600-i3c.yaml
>
> --
> 2.39.1
>
