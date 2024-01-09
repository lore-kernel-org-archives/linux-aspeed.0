From: Conor Dooley <conor@kernel.org>
Date: Tue, 9 Jan 2024 17:14:29 +0000
Subject: [PATCH v1 7/8] tpm: tis-i2c: Add more compatible strings
In-Reply-To: <60c8bbdb-4e08-44f0-88d4-ab164d4843b5@linux.ibm.com>
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
 <20231212164004.1683589-8-ninad@linux.ibm.com>
 <20231212-avid-grill-dbead068fac8@spud>
 <73381bb0-7fa7-4a9e-88df-ab0063058e26@roeck-us.net>
 <20231212-mouth-choice-40a83caa34ec@spud>
 <2946fbb1-2a47-4d21-83dc-8e45bf6ba5a9@roeck-us.net>
 <60c8bbdb-4e08-44f0-88d4-ab164d4843b5@linux.ibm.com>
Message-ID: <20240109-pep-coerce-2a86ae88753d@spud>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jan 08, 2024 at 02:05:53PM -0600, Ninad Palsule wrote:
> Hello Guenter,
> 
> On 12/12/23 13:50, Guenter Roeck wrote:
> > On 12/12/23 10:51, Conor Dooley wrote:
> > > On Tue, Dec 12, 2023 at 10:00:39AM -0800, Guenter Roeck wrote:
> > > > On Tue, Dec 12, 2023 at 05:15:51PM +0000, Conor Dooley wrote:
> > > > > On Tue, Dec 12, 2023 at 10:40:03AM -0600, Ninad Palsule wrote:
> > > > > > From: Joel Stanley <joel@jms.id.au>
> > > > > > 
> > > > > > The NPCT75x TPM is TIS compatible. It has an I2C and SPI interface.
> > > > > > 
> > > > > > https://www.nuvoton.com/products/cloud-computing/security/trusted-platform-module-tpm/
> > > > > > 
> > > > > > 
> > > > > > Add a compatible string for it, and the generic compatible.
> > > > > > 
> > > > > > OpenBMC-Staging-Count: 3
> > > > > 
> > > > > Delete this from every patch that it appears from.
> 
> 
> I have send it as a separate commit. https://lore.kernel.org/linux-kernel/20231214144954.3833998-1-ninad at linux.ibm.com/

Why did you do that? It now just adds undocumented compatibles to the
driver. Please, as Rob requested, work with Lukas on his series to make
sure that these devices are documented.

Thanks,
Conor.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240109/a7caf3ea/attachment.sig>
