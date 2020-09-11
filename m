From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 11 Sep 2020 08:41:52 +0200
Subject: [PATCH v2 01/15] dt-bindings: gpio: convert bindings for NXP
 PCA953x family to dtschema
In-Reply-To: <CAJKOXPdQJz7aLu4sjds46SiZwxvB-VMBR=stjpUme+8iEo+d-w@mail.gmail.com>
References: <20200910175733.11046-1-krzk@kernel.org>
 <20200910175733.11046-2-krzk@kernel.org>
 <20200910182814.veviax3n377undkv@akan>
 <CAJKOXPdQJz7aLu4sjds46SiZwxvB-VMBR=stjpUme+8iEo+d-w@mail.gmail.com>
Message-ID: <CAMuHMdVG6+BsTUxb4wcAwj1WK982S0k2RCxmb3x9gsOS2TphNw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

On Thu, Sep 10, 2020 at 8:54 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Thu, 10 Sep 2020 at 20:28, Nishanth Menon <nm@ti.com> wrote:
> > On 19:57-20200910, Krzysztof Kozlowski wrote:
> > [...]
> > > +  wakeup-source:
> > > +    $ref: /schemas/types.yaml#/definitions/flag
> > > +
> > > +patternProperties:
> > > +  "^(hog-[0-9]+|.+-hog(-[0-9]+)?)$":
> >
> > I wonder if "hog" is too generic and might clash with "something-hog" in
> > the future?
>
> This pattern is already used in
> Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml. It will
> match only children and so far it did not find any other nodes in ARM
> and ARM64 dts. I don't expect clashes. Also the question is then - if
> one adds a child of GPIO expander named "foobar-hog" and it is not a
> GPIO hog, then what is it?

Perhaps you didn't find any other nodes as children of pca953x
controllers?
There are other hog nodes in other types of GPIO controllers. Typically
they're named after the purpose, e.g. "wifi-disable", "i2c3_mux_oe_n",
"pcie_sata_switch", "lcd0_mux".

IMHO it's a hog if it contains a "gpio-hog" property, regardless of node
naming.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
