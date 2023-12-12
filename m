From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 12 Dec 2023 10:20:47 -0800
Subject: [PATCH v1 2/8] dt-bindings: tpm: Add schema for TIS I2C devices
In-Reply-To: <20231212-amusement-elevation-28e42bcccc35@spud>
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
 <20231212164004.1683589-3-ninad@linux.ibm.com>
 <20231212-amusement-elevation-28e42bcccc35@spud>
Message-ID: <874d4416-86e5-48cc-9c84-97357e4caefe@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Dec 12, 2023 at 05:14:26PM +0000, Conor Dooley wrote:
> Hey,
> 
> On Tue, Dec 12, 2023 at 10:39:58AM -0600, Ninad Palsule wrote:
> > From: Johannes Holland <johannes.holland@infineon.com>
> > 
> > Add a dt schema to support device tree bindings
> 
> "Add bindings for..."
> 
> > for the generic I2C
> > physical layer. Refer to the TCG PC Client Platform TPM Profile (PTP)
> > Specification for TPM 2.0 v1.04 Revision 14.
> > 
> > This includes descriptions for the Nuvoton and Infineon devices.
> > 
> 
> > OpenBMC-Staging-Count: 3
> 
> I have no idea what this is, but it needs to be removed from the patch.
> 
> > Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> > ---
> >  .../bindings/security/tpm/tpm-tis-i2c.yaml    | 50 +++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
> > new file mode 100644
> > index 000000000000..de1e34065748
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
> > @@ -0,0 +1,50 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/security/tpm/tpm-tis-i2c.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: I2C PTP based TPM Devices
> > +
> > +maintainers:
> > +  - Johannes Holland <johannes.holland@infineon.com>
> > +
> > +description:
> > +  Device Tree Bindings for I2C based Trusted Platform Module (TPM).
> 
> s/Device Tree Bindings for //. Doesn't dt_binding_check now complain if
> you have this in a title or description?
> 
> > +properties:
> > +  $nodename:
> > +    pattern: "^tpm(@[0-9a-f]+)?$"
> > +
> > +  compatible:
> > +    oneOf:
> > +      - description: Infineon's Trusted Platform Module (TPM) (SLB9673).
> > +        items:
> > +          - const: infineon,slb9673
> > +          - const: tcg,tpm-tis-i2c
> > +      - description: Nuvoton's Trusted Platform Module (TPM) (NPCT75x).
> > +        items:
> > +          - const: nuvoton,npct75x
> > +          - const: tcg,tpm-tis-i2c
> 
> > +      - const: tcg,tpm-tis-i2c
> 
> IMO this should be removed and this fallback should only be used in
> combination with device specific compatibles, like you have here for the
> infineon and nuvoton devices.

As mentioned in my response to the other patch, "only" isn't sufficient
since the tacoma devicetree file only references the generic entry.
It would also make support for chips from other vendors unnecessarily
complex.

Question should in my opinion be if the non-fallback entries are really
needed.

Thanks,
Guenter
