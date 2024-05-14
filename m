From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 14 May 2024 08:07:22 -0000
Subject: [PATCH v2 07/20] pinctrl: renesas: Use scope based of_node_put() cleanups
In-Reply-To: <CACRpkdYS8=cHT=7tGbzWZ73jbLhjqdpssbaHH-qREe=bcHYe2A@mail.gmail.com>
References: <20240504-pinctrl-cleanup-v2-0-26c5f2dc1181@nxp.com>
 <20240504-pinctrl-cleanup-v2-7-26c5f2dc1181@nxp.com> <CAMuHMdUD=1rpns_mLF2rMM-x5EnOK7TExaJxoJVkbXjVz1H8uQ@mail.gmail.com>
 <CACRpkdaUecnwvHFdtGkuM80SObvXpXZkWGYoUMgnNHcvObYF0g@mail.gmail.com>
 <CAMuHMdWCD+k8=iX8+tcK76DU_m9quR8BV+K68K73SygJzCz5VA@mail.gmail.com> <CACRpkdYS8=cHT=7tGbzWZ73jbLhjqdpssbaHH-qREe=bcHYe2A@mail.gmail.com>
Message-ID: <CAMuHMdUucOu-c7tbeBBCMaoouFcUnJi0aRU--pc2Gk9QWNrANg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, May 14, 2024 at 9:33?AM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, May 14, 2024 at 8:36?AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > Does this go into the Renesas patch stack?
> > > I think the patch stands fine without the rest of the series.
> >
> > Sure, I can do that.
>
> Please apply it!

OK, will queue in renesas-pinctrl for v6.11.

> > From your positive response to v1, I thought that perhaps you just
> > wanted to take the full series yourself?
>
> Sorry, I always prefer submaintainers to pick their stuff, they
> know what they are doing and they can test the entire patch
> stack properly.

OK, will (try to ;-) remember...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
