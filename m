From: Joel Stanley <joel@jms.id.au>
Date: Wed, 17 Nov 2021 06:06:10 +0000
Subject: [PATCH v3 0/4] Add Aspeed AST2600 soc display support
In-Reply-To: <20211117054518.3555-1-tommy_huang@aspeedtech.com>
References: <20211117054518.3555-1-tommy_huang@aspeedtech.com>
Message-ID: <CACPK8XdUHZBAwcwT96Su+Fa_nenYSa75vCNpskh864Cvx04y8Q@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 17 Nov 2021 at 05:45, tommy-huang <tommy_huang@aspeedtech.com> wrote:
>
> v3:
>   Refine the patch for clear separate purpose.
>   Skip to send devicetree patch

Thanks Tommy. A few things:

 - Set up your authorship in git:

 git config --global user.name "Tommy Haung"

- The "Add AST2600 chip support" patch is the same as the one I sent,
you can put mine back in your series now

- We should add a device tree bindings document

Can you confirm you tested these changes on both the ast2500 and the
ast2600? How did you test?

Cheers,

Joel


>
> v2:
>   Remove some unnecessary patch.
>   Refine for reviwer request.
>
> v1:
>   First add patch.
>
> Joel Stanley (2):
>   ARM: dts: aspeed: Add GFX node to AST2600
>   ARM: dts: aspeed: ast2600-evb: Enable GFX device
>
> tommy-huang (2):
>   drm/aspeed: Update INTR_STS handling
>   drm/aspeed: Add AST2600 chip support
>
>  arch/arm/boot/dts/aspeed-ast2600-evb.dts | 18 ++++++++++++++++++
>  arch/arm/boot/dts/aspeed-g6.dtsi         | 11 +++++++++++
>  drivers/gpu/drm/aspeed/aspeed_gfx.h      |  1 +
>  drivers/gpu/drm/aspeed/aspeed_gfx_drv.c  | 15 ++++++++++++++-
>  4 files changed, 44 insertions(+), 1 deletion(-)
>
> --
> 2.17.1
>
