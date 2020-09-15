From: Rob Herring <robh@kernel.org>
Date: Tue, 15 Sep 2020 13:47:40 -0600
Subject: [PATCH v2 01/15] dt-bindings: gpio: convert bindings for NXP
 PCA953x family to dtschema
In-Reply-To: <20200910191305.phjtijx2fhkhqavu@akan>
References: <20200910175733.11046-1-krzk@kernel.org>
 <20200910175733.11046-2-krzk@kernel.org>
 <20200910182814.veviax3n377undkv@akan>
 <CAJKOXPdQJz7aLu4sjds46SiZwxvB-VMBR=stjpUme+8iEo+d-w@mail.gmail.com>
 <20200910191305.phjtijx2fhkhqavu@akan>
Message-ID: <20200915194740.GA2385241@bogus>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Sep 10, 2020 at 02:13:05PM -0500, Nishanth Menon wrote:
> On 20:53-20200910, Krzysztof Kozlowski wrote:
> > On Thu, 10 Sep 2020 at 20:28, Nishanth Menon <nm@ti.com> wrote:
> > >
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
> Probably a nitpick.. but then,.. I have'nt seen us depend on hierarchy
> for uniqueness of naming.. we choose for example "bus" no matter where
> in the hierarchy it falls in, as long it is a bus.. etc.. same argument
> holds good for properties as well.. "gpio-hog;" is kinda redundant if
> you think of it for a compatible that is already gpio ;)..
> 
> I did'nt mean to de-rail the discussion, but was curious what the DT
> maintainers think..

Not really a fan of gpio-hog binding to have another type of hog nor can 
I imagine what that would be.

Rob
