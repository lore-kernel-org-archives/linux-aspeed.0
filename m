From: Conor Dooley <conor@kernel.org>
Date: Wed, 10 Jan 2024 16:23:25 +0000
Subject: [PATCH v1 7/8] tpm: tis-i2c: Add more compatible strings
In-Reply-To: <385b06e9-1daa-408a-a0ed-7b09d7d539df@linux.ibm.com>
References: <73381bb0-7fa7-4a9e-88df-ab0063058e26@roeck-us.net>
 <20231212-mouth-choice-40a83caa34ec@spud>
 <2946fbb1-2a47-4d21-83dc-8e45bf6ba5a9@roeck-us.net>
 <60c8bbdb-4e08-44f0-88d4-ab164d4843b5@linux.ibm.com>
 <20240109-pep-coerce-2a86ae88753d@spud>
 <01974929-dfbf-4989-ba39-369e521827d0@linux.ibm.com>
 <3d194e84-bf1a-48e4-a376-e5c327c6508d@linaro.org>
 <2dd37d2b-28da-4e73-9047-61ec5d64bdb5@linux.ibm.com>
 <edbefdfd-eb59-4d86-ad07-feb066a21082@linaro.org>
 <385b06e9-1daa-408a-a0ed-7b09d7d539df@linux.ibm.com>
Message-ID: <20240110-straggler-around-a53bc0a669fb@spud>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jan 10, 2024 at 09:54:19AM -0600, Ninad Palsule wrote:
> Hello Krzysztof,
> 
> 
> On 1/10/24 09:37, Krzysztof Kozlowski wrote:
> > On 10/01/2024 15:31, Ninad Palsule wrote:
> > > Hello Krzysztof,
> > > 
> > > 
> > > 
> > > > > > > I have send it as a separate commit. https://lore.kernel.org/linux-kernel/20231214144954.3833998-1-ninad at linux.ibm.com/
> > > > > > Why did you do that? It now just adds undocumented compatibles to the
> > > > > > driver. Please, as Rob requested, work with Lukas on his series to make
> > > > > > sure that these devices are documented.
> > > > > I think krzysztof kozlowski suggested to send these patches separately:
> > > > > https://lore.kernel.org/linux-kernel/1c5ace65-2fd8-4503-b22f-e0f564d1c83f at linaro.org/
> > > > > 
> > > > > Did I misunderstood it? Do you guys want me to include that commit again?
> > > > My comment was in DTS thread under specific DTS patch. How did you
> > > > figure out it applies to driver and bindings? This does not make sense.
> > > Sorry for the misunderstanding. Where do you want me to add driver
> > > patch? Before all DTS patches or after all DTS patches?
> > Does not matter, why do you insist on combining them with DTS? Drivers
> > and bindings are going together. DTS better separate, although depending
> > on the case can be together.
> > 
> I have combined DTS and Driver because DTS was using compatibility string
> which is not upstream yet hence I thought it is logical to send it under
> same patchset.
> 
> Conor and Rob, Do you have preference?

I'm not sure what you want from me that Krzysztof hasn't already
provided. dt-bindings and drivers usually go together, and the dts
patches are often in the same series. If you send dts separately, note
under the --- line the patches adding the binding so that the platform
maintainer knows that the compatible has not yet been documented.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240110/113a8355/attachment.sig>
