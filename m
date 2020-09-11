From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 11 Sep 2020 08:54:40 +0200
Subject: [PATCH v2 01/15] dt-bindings: gpio: convert bindings for NXP
 PCA953x family to dtschema
In-Reply-To: <CAMuHMdVG6+BsTUxb4wcAwj1WK982S0k2RCxmb3x9gsOS2TphNw@mail.gmail.com>
References: <20200910175733.11046-1-krzk@kernel.org>
 <20200910175733.11046-2-krzk@kernel.org>
 <20200910182814.veviax3n377undkv@akan>
 <CAJKOXPdQJz7aLu4sjds46SiZwxvB-VMBR=stjpUme+8iEo+d-w@mail.gmail.com>
 <CAMuHMdVG6+BsTUxb4wcAwj1WK982S0k2RCxmb3x9gsOS2TphNw@mail.gmail.com>
Message-ID: <CAJKOXPcSUY6aqvix7R0YkzQL9Mze9O8jrWLLxKoRyjHTRhrYLA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2020 at 08:42, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Krzysztof,
>
> On Thu, Sep 10, 2020 at 8:54 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > On Thu, 10 Sep 2020 at 20:28, Nishanth Menon <nm@ti.com> wrote:
> > > On 19:57-20200910, Krzysztof Kozlowski wrote:
> > > [...]
> > > > +  wakeup-source:
> > > > +    $ref: /schemas/types.yaml#/definitions/flag
> > > > +
> > > > +patternProperties:
> > > > +  "^(hog-[0-9]+|.+-hog(-[0-9]+)?)$":
> > >
> > > I wonder if "hog" is too generic and might clash with "something-hog" in
> > > the future?
> >
> > This pattern is already used in
> > Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml. It will
> > match only children and so far it did not find any other nodes in ARM
> > and ARM64 dts. I don't expect clashes. Also the question is then - if
> > one adds a child of GPIO expander named "foobar-hog" and it is not a
> > GPIO hog, then what is it?
>
> Perhaps you didn't find any other nodes as children of pca953x
> controllers?

There shouldn't be.. unless one makes some i2c-gpio controller under
such GPIO expander. But now it wouldn't be instantiated as expander is
not a bus.

> There are other hog nodes in other types of GPIO controllers. Typically
> they're named after the purpose, e.g. "wifi-disable", "i2c3_mux_oe_n",
> "pcie_sata_switch", "lcd0_mux".
>
> IMHO it's a hog if it contains a "gpio-hog" property, regardless of node
> naming.

Yes. The question is then whether to expect the "hog" in name. Just
like we expect for all other device nodes to represent the class.

Best regards,
Krzysztof
