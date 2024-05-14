From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 14 May 2024 06:36:25 -0000
Subject: [PATCH v2 07/20] pinctrl: renesas: Use scope based of_node_put() cleanups
In-Reply-To: <CACRpkdaUecnwvHFdtGkuM80SObvXpXZkWGYoUMgnNHcvObYF0g@mail.gmail.com>
References: <20240504-pinctrl-cleanup-v2-0-26c5f2dc1181@nxp.com>
 <20240504-pinctrl-cleanup-v2-7-26c5f2dc1181@nxp.com> <CAMuHMdUD=1rpns_mLF2rMM-x5EnOK7TExaJxoJVkbXjVz1H8uQ@mail.gmail.com>
 <CACRpkdaUecnwvHFdtGkuM80SObvXpXZkWGYoUMgnNHcvObYF0g@mail.gmail.com>
Message-ID: <CAMuHMdWCD+k8=iX8+tcK76DU_m9quR8BV+K68K73SygJzCz5VA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Linus,

On Mon, May 13, 2024 at 10:51?PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, May 13, 2024 at 1:59?PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Sat, May 4, 2024 at 3:14?PM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > Use scope based of_node_put() cleanup to simplify code.
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> >
> > Thanks for your patch!
> >
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Does this go into the Renesas patch stack?
>
> I think the patch stands fine without the rest of the series.

Sure, I can do that.
From your positive response to v1, I thought that perhaps you just
wanted to take the full series yourself?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
