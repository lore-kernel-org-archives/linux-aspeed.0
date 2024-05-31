From: Peng Fan <peng.fan@nxp.com>
Date: Fri, 31 May 2024 03:07:54 -0000
Subject: [PATCH v2 00/20] pinctrl: Use scope based of_node_put() cleanups
In-Reply-To: <CAMuHMdVprgpjDP6PDn7appofJv8Tv30nRA4+7n4sR8n6n4qy+g@mail.gmail.com>
References: <20240504-pinctrl-cleanup-v2-0-26c5f2dc1181@nxp.com>
 <CAMuHMdVprgpjDP6PDn7appofJv8Tv30nRA4+7n4sR8n6n4qy+g@mail.gmail.com>
Message-ID: <DU0PR04MB9417FF2632A278BF6605AE1F88FC2@DU0PR04MB9417.eurprd04.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Geert

> Subject: Re: [PATCH v2 00/20] pinctrl: Use scope based of_node_put()
> cleanups
> 
> Hi Peng,
> 
> On Sat, May 4, 2024 at 3:12?PM Peng Fan (OSS) <peng.fan@oss.nxp.com>
> wrote:
> > Use scope based of_node_put() to simplify code. It reduces the chance
> > of forgetting of_node_put(), and also simplifies error handling path.
> > I not able to test the changes on all the hardwares, so driver owners,
> > please help review when you have time.
> >
> > This patchset was inspired from Dan's comments on pinctrl-scmi-imx.c,
> > thanks.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> 
> Andy's question about code generation on a related patch made me wonder,
> too.
> 
> On arm32, a conversion to for_each_child_of_node_scoped() seems to cost ca.
> 48 bytes of additional code, regardless of whether there were explicit
> cleanups before or not.
> 
> I checked "pinctrl: renesas: Use scope based of_node_put() cleanups", and all
> but the conversions in *_dt_node_to_map() cost 48 bytes each.
> 

I am not sure this is an issue or else. What would you suggest me to do?
If you think extra 48bytes consumption is not good here, feel free to drop the
patch.

Thanks,
Peng.

> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-
> m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

