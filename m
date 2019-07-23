From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 23 Jul 2019 08:52:39 -0600
Subject: [PATCH] dt-bindings: Add pxe1610 as a trivial device
In-Reply-To: <CAL_Jsq+uAjK6+xzkyOhcH96tZuqv7i6Nz5_nhUQkZ2adt2gutA@mail.gmail.com>
References: <20190723002052.2878847-1-vijaykhemka@fb.com>
 <CAL_Jsq+uAjK6+xzkyOhcH96tZuqv7i6Nz5_nhUQkZ2adt2gutA@mail.gmail.com>
Message-ID: <CAL_Jsq+Kw0TFW_v54Y2QHcChqpNDYhFyCSO5Cj-be9yLSCq-Pw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jul 23, 2019 at 8:50 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Mon, Jul 22, 2019 at 6:46 PM Vijay Khemka <vijaykhemka@fb.com> wrote:
> >
> > The pxe1610 is a voltage regulator from Infineon. It also supports
> > other VRs pxe1110 and pxm1310 from Infineon.

What happened to the other compatibles? S/w doesn't need to know the
differences?

> >
> > Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> > ---
> >  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> > index 2e742d399e87..1be648828a31 100644
> > --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> > +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> > @@ -99,6 +99,8 @@ properties:
> >              # Infineon IR38064 Voltage Regulator
> >            - infineon,ir38064
> >              # Infineon SLB9635 (Soft-) I2C TPM (old protocol, max 100khz)
> > +          - infineon,pxe1610
> > +            # Infineon PXE1610, PXE1110 and PXM1310 Voltage Regulators
>
> The comment goes above the entry.
>
> >            - infineon,slb9635tt
> >              # Infineon SLB9645 I2C TPM (new protocol, max 400khz)
> >            - infineon,slb9645tt
> > --
> > 2.17.1
> >
