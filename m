From: Joel Stanley <joel@jms.id.au>
Date: Mon, 3 Dec 2018 09:28:58 +1030
Subject: [PATCH v3 2/2] ARM: dts: aspeed: Add Facebook Backpack-CMM BMC
In-Reply-To: <20181109005046.210657-1-taoren@fb.com>
References: <20181109005046.210657-1-taoren@fb.com>
Message-ID: <CACPK8XfVHDwso=kMXjk_6Q0eEJTQxUC5B=onqLfw6QzAYZU7vQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 9 Nov 2018 at 11:20, Tao Ren <taoren@fb.com> wrote:
>
> Add initial version of device tree file for Facebook Backpack CMM
> (Chasis Management Module) ast2500 BMC.
>
> Signed-off-by: Tao Ren <taoren@fb.com>
> ---
>  Changes in v3:
>    - including pin configurations in UARTs 1-4 device nodes explicitly.
>    - including external pinctrl controller nodes gfx and lhc explicitly.
>    - deleting misleading i2c-related statements from commit messages, and
>      adding comments for i2c buses in the board device tree file.
>  Changes in v2:
>    - including "aspeed-bmc-facebook-cmm.dtb" in Makefile.
>

Thanks. I've merged v3 for inclusion in 4.21.

Cheers,

Joel
