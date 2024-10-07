From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Mon, 7 Oct 2024 16:02:00 +0530
Subject: [PATCH v3 1/2] dt-bindings: arm: aspeed: add IBM SBP1 board
In-Reply-To: <xuczpa6nrxjwo7hjn62ehblnzc5twupghbg4uuwp5vfczw3gmg@x23yhbxjccpy>
References: <20241002084023.467383-1-naresh.solanki@9elements.com> <xuczpa6nrxjwo7hjn62ehblnzc5twupghbg4uuwp5vfczw3gmg@x23yhbxjccpy>
Message-ID: <CABqG17gbXGRBDHzt8-rt6_n+37oMhjmJGxCLEqqM48GjMrKNrw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Krzysztof

On Thu, 3 Oct 2024 at 13:47, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Wed, Oct 02, 2024 at 02:10:17PM +0530, Naresh Solanki wrote:
> > Document the new compatibles used on IBM SBP1.
> >
> > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> > ---
> >  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> > index 95113df178cc..8c04d6eaec08 100644
> > --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> > +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> > @@ -89,6 +89,7 @@ properties:
> >                - ibm,everest-bmc
> >                - ibm,rainier-bmc
> >                - ibm,system1-bmc
> > +              - ibm,sbp1-bmc
>
> Keep alphabetical order.
Sure. Will update in next patchset. Will also include Ack-by for the patch.

Thanks.
Naresh
>
> Best regards,
> Krzysztof
>
