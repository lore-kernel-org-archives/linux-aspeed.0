From: Rob Herring <robh@kernel.org>
Date: Fri, 26 Apr 2024 13:43:19 -0500
Subject: [PATCH v3 08/14] dt-bindings: fsi: ast2600-fsi-master: Switch to
 yaml format
In-Reply-To: <24e7644e-f9ff-4a4b-8883-33b2f69b36cf@linux.ibm.com>
References: <20240425213701.655540-1-eajames@linux.ibm.com>
 <20240425213701.655540-9-eajames@linux.ibm.com>
 <5822e000-01d3-442c-bb52-04fab87cb3da@kernel.org>
 <24e7644e-f9ff-4a4b-8883-33b2f69b36cf@linux.ibm.com>
Message-ID: <20240426184319.GA2558853-robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Apr 26, 2024 at 10:13:52AM -0500, Eddie James wrote:
> 
> On 4/26/24 01:25, Krzysztof Kozlowski wrote:
> > On 25/04/2024 23:36, Eddie James wrote:
> > > Switch to yaml for the AST2600 FSI master documentation.
> > > 
> > > Signed-off-by: Eddie James <eajames@linux.ibm.com>
> > > ---
> > >   .../fsi/aspeed,ast2600-fsi-master.yaml        | 72 +++++++++++++++++++
> > >   .../bindings/fsi/fsi-master-aspeed.txt        | 36 ----------
> > >   2 files changed, 72 insertions(+), 36 deletions(-)
> > >   create mode 100644 Documentation/devicetree/bindings/fsi/aspeed,ast2600-fsi-master.yaml
> > >   delete mode 100644 Documentation/devicetree/bindings/fsi/fsi-master-aspeed.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/fsi/aspeed,ast2600-fsi-master.yaml b/Documentation/devicetree/bindings/fsi/aspeed,ast2600-fsi-master.yaml
> > > new file mode 100644
> > > index 000000000000..f053e3e1d259
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/fsi/aspeed,ast2600-fsi-master.yaml
> > > @@ -0,0 +1,72 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-master.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Aspeed FSI master
> > > +
> > > +maintainers:
> > > +  - Eddie James <eajames@linux.ibm.com>
> > > +
> > > +description:
> > > +  The AST2600 and later contain two identical FSI masters. They share a
> > > +  clock and have a separate interrupt line and output pins.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - "aspeed,ast2600-fsi-master"
> > > +      - "aspeed,ast2700-fsi-master"
> > This wasn't tested. No quotes. Do you see any other example like this?
> 
> 
> Strangely this passes make dt_binding_check for me... And Rob's bot didn't
> seem to catch it either. Just an oversight, I'll fix it.

Disabled due to yamllint bug. The fix is now released, so that reminds 
me to go enable it.

Rob
