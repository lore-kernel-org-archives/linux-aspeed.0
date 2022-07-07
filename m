From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 7 Jul 2022 15:33:48 +0200
Subject: [PATCH v3] The Yosemite V3.5 is a facebook multi-node server
 platform that host four OCP server. The BMC in the Yosemite V3.5 platform
 based on AST2600 SoC.
In-Reply-To: <20220707132054.GA10610@logan-ThinkPad-T14-Gen-1>
References: <20220707132054.GA10610@logan-ThinkPad-T14-Gen-1>
Message-ID: <CAK8P3a0P2u+LdXcU7As=dfNbg_J2eWfhgB9TT1-xVyH0v6OM5Q@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jul 7, 2022 at 3:20 PM Logananth Sundararaj
<logananth13.hcl@gmail.com> wrote:
>
> This patch adds linux device tree entry related to
> Yosemite V3.5 specific devices connected to BMC SoC.
>
> Signed-off-by: Logananth Sundararaj <logananth_s@hcl.com>


Something went wrong with the patch description, it looks like you dropped
the subject and sent the first paragraph as the subject instead.

> +/ {
> +       model = "Facebook fby35";
> +       compatible = "facebook,fby35", "aspeed,ast2600";
> +
> +       aliases {
> +               serial4 = &uart5;
> +       };

Why not start at serial0 here?

> +       chosen {
> +               stdout-path = &uart5;
> +               bootargs = "console=ttyS4,57600n8 root=/dev/ram rw vmalloc=384M";
> +       };

The bootargs should really come from the boot loader.

Why do you need the vmalloc=384M? That seems excessive.

> +
> +       memory at 80000000 {
> +               device_type = "memory";
> +               reg = <0x80000000 0x80000000>;
> +       };

The memory location and size is usually also set by the boot loader

        Arnd
