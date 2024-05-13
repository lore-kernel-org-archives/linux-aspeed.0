From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 May 2024 11:59:44 -0000
Subject: [PATCH v2 07/20] pinctrl: renesas: Use scope based of_node_put() cleanups
In-Reply-To: <20240504-pinctrl-cleanup-v2-7-26c5f2dc1181@nxp.com>
References: <20240504-pinctrl-cleanup-v2-0-26c5f2dc1181@nxp.com> <20240504-pinctrl-cleanup-v2-7-26c5f2dc1181@nxp.com>
Message-ID: <CAMuHMdUD=1rpns_mLF2rMM-x5EnOK7TExaJxoJVkbXjVz1H8uQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Peng,

On Sat, May 4, 2024 at 3:14?PM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> Use scope based of_node_put() cleanup to simplify code.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/pinctrl/renesas/pinctrl-rzn1.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzn1.c

You missed one trivial conversion, presumably because no error handling
and thus no of_node_put() is involved?

@@ -737,13 +737,12 @@ static int rzn1_pinctrl_parse_groups(struct
device_node *np,

 static int rzn1_pinctrl_count_function_groups(struct device_node *np)
 {
-       struct device_node *child;
        int count = 0;

        if (of_property_count_u32_elems(np, RZN1_PINS_PROP) > 0)
                count++;

-       for_each_child_of_node(np, child) {
+       for_each_child_of_node_scoped(np, child) {
                if (of_property_count_u32_elems(child, RZN1_PINS_PROP) > 0)
                        count++;
        }

If you prefer not to include this, I will send a small patch myself later.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
