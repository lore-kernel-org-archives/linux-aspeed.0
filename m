From: Joel Stanley <joel@jms.id.au>
Date: Thu, 12 Jul 2018 17:53:17 +1000
Subject: [PATCH v3 3/5] fsi: master-ast-cf: Add new FSI master using
 Aspeed ColdFire
In-Reply-To: <20180712034847.12878-4-benh@kernel.crashing.org>
References: <20180712034847.12878-1-benh@kernel.crashing.org>
 <20180712034847.12878-4-benh@kernel.crashing.org>
Message-ID: <CACPK8XdZKbh2NLQaiZOx66FAo+3csS_D9-BXjJKeppKm8aEM6w@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 12 July 2018 at 13:48, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> The Aspeed AST2x00 can contain a ColdFire v1 coprocessor which
> is currently unused on OpenPower systems.
>
> This adds an alternative to the fsi-master-gpio driver that
> uses that coprocessor instead of bit banging from the ARM
> core itself. The end result is about 4 times faster.
>
> The firmware for the coprocessor and its source code can be
> found at https://github.com/ozbenh/cf-fsi and is system specific.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  drivers/fsi/Kconfig                      |    9 +
>  drivers/fsi/Makefile                     |    1 +
>  drivers/fsi/cf-fsi-fw.h                  |  157 +++
>  drivers/fsi/fsi-master-ast-cf.c          | 1438 ++++++++++++++++++++++
>  include/trace/events/fsi_master_ast_cf.h |  150 +++
>  5 files changed, 1755 insertions(+)
>  create mode 100644 drivers/fsi/cf-fsi-fw.h
>  create mode 100644 drivers/fsi/fsi-master-ast-cf.c
>  create mode 100644 include/trace/events/fsi_master_ast_cf.h
>
> diff --git a/drivers/fsi/Kconfig b/drivers/fsi/Kconfig
> index 322cec393cf2..e0220d1e1357 100644
> --- a/drivers/fsi/Kconfig
> +++ b/drivers/fsi/Kconfig
> @@ -27,6 +27,15 @@ config FSI_MASTER_HUB
>         allow chaining of FSI links to an arbitrary depth.  This allows for
>         a high target device fanout.
>
> +config FSI_MASTER_AST_CF
> +       tristate "FSI master based on Aspeed ColdFire coprocessor"
> +       depends on GPIOLIB
> +       depends on GPIO_ASPEED
> +       ---help---
> +       This option enables a FSI master using the AST2400 and AST2500 GPIO
> +       lines driven by the internal ColdFire coprocessor. This requires
> +       the corresponding machine specific ColdFire firmware to be available.

The "machine specific" part isn't true anymore, is it?

I gave this a spin on a palmetto and it appeared to work fine for me.

Tested-by: Joel Stanley <joel@jms.id.au>
