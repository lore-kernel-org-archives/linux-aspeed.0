From: Conor Dooley <conor@kernel.org>
Date: Thu, 14 Dec 2023 16:35:40 -0000
Subject: [PATCH v1 2/8] dt-bindings: tpm: Add schema for TIS I2C devices
In-Reply-To: <d8b5df1c-c732-4cf3-ae28-cc2017d3b0b6@linux.ibm.com>
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
 <20231212164004.1683589-3-ninad@linux.ibm.com>
 <20231212-amusement-elevation-28e42bcccc35@spud>
 <d8b5df1c-c732-4cf3-ae28-cc2017d3b0b6@linux.ibm.com>
Message-ID: <20231214-stopper-bounce-ca9002869293@spud>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Dec 14, 2023 at 09:34:39AM -0600, Ninad Palsule wrote:
> Hello Conor,
> 
> On 12/12/23 11:14, Conor Dooley wrote:
> > Hey,
> > 
> > On Tue, Dec 12, 2023 at 10:39:58AM -0600, Ninad Palsule wrote:
> > > From: Johannes Holland <johannes.holland@infineon.com>
> > > 
> > > Add a dt schema to support device tree bindings
> > "Add bindings for..."
> Fixed.
> > 
> > > for the generic I2C
> > > physical layer. Refer to the TCG PC Client Platform TPM Profile (PTP)
> > > Specification for TPM 2.0 v1.04 Revision 14.
> > > 
> > > This includes descriptions for the Nuvoton and Infineon devices.
> > > 
> > > OpenBMC-Staging-Count: 3
> > I have no idea what this is, but it needs to be removed from the patch.
> Removed.
> > 
> > > Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
> > > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > > Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> > > ---
> > >   .../bindings/security/tpm/tpm-tis-i2c.yaml    | 50 +++++++++++++++++++
> > >   1 file changed, 50 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
> > > new file mode 100644
> > > index 000000000000..de1e34065748
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
> > > @@ -0,0 +1,50 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/security/tpm/tpm-tis-i2c.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: I2C PTP based TPM Devices
> > > +
> > > +maintainers:
> > > +  - Johannes Holland <johannes.holland@infineon.com>
> > > +
> > > +description:
> > > +  Device Tree Bindings for I2C based Trusted Platform Module (TPM).
> > s/Device Tree Bindings for //. Doesn't dt_binding_check now complain if
> > you have this in a title or description?
> Fixed.
> > 
> > > +properties:
> > > +  $nodename:
> > > +    pattern: "^tpm(@[0-9a-f]+)?$"
> > > +
> > > +  compatible:
> > > +    oneOf:
> > > +      - description: Infineon's Trusted Platform Module (TPM) (SLB9673).
> > > +        items:
> > > +          - const: infineon,slb9673
> > > +          - const: tcg,tpm-tis-i2c
> > > +      - description: Nuvoton's Trusted Platform Module (TPM) (NPCT75x).
> > > +        items:
> > > +          - const: nuvoton,npct75x
> > > +          - const: tcg,tpm-tis-i2c

Also, another thought - the bus is not usually encoded in the compatible
string, so it would be good to remove that.

> > > +      - const: tcg,tpm-tis-i2c
> > IMO this should be removed and this fallback should only be used in
> > combination with device specific compatibles, like you have here for the
> > infineon and nuvoton devices.
> 
> As Guenter mentioned I need to keep it as tacoma board is just using this
> string.

No, that does not mean that you have to keep this in the binding. I know
Rob had some comments that might invalidate this binding entirely, but
if that does not happen then I think think that the tacoma devicetree
needs to have a device-specific compatible added for the tpm that it has.
You could of course retain the generic fallback compatible however.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20231214/913ca573/attachment-0001.sig>
