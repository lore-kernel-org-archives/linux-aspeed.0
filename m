From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 15 Sep 2020 10:13:58 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_1/3]_dt:_bindings:_mmc:_Add_phase_control_propertie?=
 =?UTF-8?Q?s_for_the_Aspeed_SDHCI?=
In-Reply-To: <CAPDyKFq+QYzJNT94eFt2EsQBVqQciUoqnMDdrr3DbbkpnHRpCw@mail.gmail.com>
References: <20200910105440.3087723-1-andrew@aj.id.au>
 <20200910105440.3087723-2-andrew@aj.id.au>
 <CAPDyKFq+QYzJNT94eFt2EsQBVqQciUoqnMDdrr3DbbkpnHRpCw@mail.gmail.com>
Message-ID: <e4bab65c-8a81-4a4b-be3f-3a07d5c7f95f@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Mon, 14 Sep 2020, at 19:11, Ulf Hansson wrote:
> On Thu, 10 Sep 2020 at 12:54, Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> > Add properties to control the phase delay for input and output data
> > sampling.
> >
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> >  Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > index 987b287f3bff..75effd411554 100644
> > --- a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > @@ -61,6 +61,14 @@ patternProperties:
> >        sdhci,auto-cmd12:
> >          type: boolean
> >          description: Specifies that controller should use auto CMD12
> > +      "aspeed,input-phase":
> > +        $ref: '/schemas/types.yaml#/definitions/uint32'
> > +        description:
> > +          The input clock phase delay value.
> > +      "aspeed,output-phase":
> > +        $ref: '/schemas/types.yaml#/definitions/uint32'
> > +        description:
> > +          The output clock phase delay value.
> 
> We already have a common mmc clk-phase* binding, see
> mmc-controller.yaml. As matter of fact, there is one binding per speed
> mode.
> 
> Could that work for this case as well?

Ah, great, I think so. Sorry for overlooking that. I just need to extract from 
Aspeed what units the damn register fields are using :/

Andrew
