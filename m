From: Potin Lai <potin.lai.pt@gmail.com>
Date: Fri, 21 Jun 2024 16:53:40 +0800
Subject: [PATCH v3 1/2] dt-bindings: pinctrl: aspeed,ast2600-pinctrl: add
 NCSI group
In-Reply-To: <cb55efedaef63e4580c11415aa2e29606edcaf9f.camel@codeconstruct.com.au>
References: <20240620084337.3525690-1-potin.lai.pt@gmail.com>
 <20240620084337.3525690-2-potin.lai.pt@gmail.com> <cb55efedaef63e4580c11415aa2e29606edcaf9f.camel@codeconstruct.com.au>
Message-ID: <CAGfYmwWp2dayGvySdYvU+nmtxZ-x3PPW_j69ZoBD4mxzPMQAzg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jun 21, 2024 at 8:46?AM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> Hi Potin,
>
> On Thu, 2024-06-20 at 16:43 +0800, Potin Lai wrote:
> > In the NCSI pin table, the reference clock output pin (RMIIXRCLKO) is not
> > needed on the management controller side.
> >
> > Add NCSI group to distinguish the pin group between RMII and NCSI.
> >
> > - RMII pins:
> >   - RMIIXRCLKI
> >   - RMIIXRXD0
> >   - RMIIXRXD1
> >   - RMIIXCRSDV
> >   - RMIIXRXER
> >   - RMIIXRCLKO
> >   - RMIIXTXEN
> >   - RMIIXTXD0
> >   - RMIIXTXD1
> >
> > - NCSI pins:
> >   - RMIIXRCLKI
> >   - RMIIXRXD0
> >   - RMIIXRXD1
> >   - RMIIXCRSDV
> >   - RMIIXRXER
> >   - RMIIXTXEN
> >   - RMIIXTXD0
> >   - RMIIXTXD1
>
> I think listing all the pins for both groups obscures the fact that
> there aren't more changes than removing RMIIXRCLKO.
>
> Can we instead drop these lists and replace
>
> > Add NCSI group to distinguish the pin group between RMII and NCSI.
>
> With:
>
> > Add "NCSI" pin groups that are equivalent to the RMII pin groups,
> > but without the RMIIXRCLKO pin
>
> ?
>
Got it, will update it in the next version.

> >
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
> > ---
> >  .../devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml     | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
> > index 00b6974a5ed3d..3f02dc94a7ce2 100644
> > --- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
> > +++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
> > @@ -337,6 +337,8 @@ additionalProperties:
> >          - MDIO2
> >          - MDIO3
> >          - MDIO4
> > +        - NCSI3
> > +        - NCSI4
>
> Can we also do this for RMII{1,2}RCLKO (and in the driver patch as
> well)?
>
The power of RMII{1,2} is 1.8v, which does not meet NCSI requirements.

> >          - NCTS1
> >          - NCTS2
> >          - NCTS3
>
> Overall, what I was hoping for with the comment on the earlier patch
> was that you would add the discussion in the commit message to the
> "description" entry in the binding YAML. Can you please do so? That way
> the information is always present for people reading the binding
> without them having to look at the binding's change history.
>
Got it, I will add note into aspeed,ast2600-pinctrl.yaml.

> Thanks,
>
> Andrew
