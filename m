From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 18 Oct 2024 15:05:46 +1030
Subject: [PATCH] ARM: dts: aspeed: Add device tree for Ampere's Mt.
 Jefferson BMC
In-Reply-To: <b16b82d7-60e1-428d-bc7a-8a236ebb98ca@amperemail.onmicrosoft.com>
References: <20241014105031.1963079-1-chanh@os.amperecomputing.com>
	 <172891445289.1127319.4114892374425336022.robh@kernel.org>
	 <b5919d904c9f06a618a54d49bc895c3081a511e4.camel@codeconstruct.com.au>
	 <e8e31fb4-4a9f-4ea9-be4d-9ba29d824cc5@amperemail.onmicrosoft.com>
	 <7555c528c90e6151f54d0e17c278527f95fac184.camel@codeconstruct.com.au>
	 <c42be4ea-9902-4fac-8b1e-afc38fe04bad@amperemail.onmicrosoft.com>
	 <f833ef3b873d0e71581dd138f046b19fa3fdeaf2.camel@codeconstruct.com.au>
	 <b16b82d7-60e1-428d-bc7a-8a236ebb98ca@amperemail.onmicrosoft.com>
Message-ID: <0361287ca986cb6101fae2b269b2fe14eea84158.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2024-10-17 at 17:02 +0700, Chanh Nguyen wrote:
> 
> On 17/10/2024 07:08, Andrew Jeffery wrote:
> > [EXTERNAL EMAIL NOTICE: This email originated from an external sender. Please be mindful of safe email handling and proprietary information protection practices.]
> > 
> > 
> > Hi Chanh,
> > 
> > On Wed, 2024-10-16 at 17:26 +0700, Chanh Nguyen wrote:
> > > 
> > > On 16/10/2024 12:07, Andrew Jeffery wrote:
> > > > You can also find discussions where other maintainers (Guenter, hwmon
> > > > maintainer; Krzysztof, devicetree maintainer) have asked that "pmbus"
> > > > not be used as a compatible:
> > > > 
> > > > https://lore.kernel.org/all/f76798ea-6edd-4888-8057-c09aaed88f25 at roeck-us.net/
> > > > 
> > > 
> > > Hi Andrew,
> > > I checked the discussion at
> > > https://lore.kernel.org/all/f76798ea-6edd-4888-8057-c09aaed88f25 at roeck-us.net/
> > > . It seems the maintainers don't want to use the "pmbus" compatible for
> > > specific devices. The maintaners require an explicitly compatible from
> > > device list in drivers/hwmon/pmbus/pmbus.c .
> > > 
> > 
> > There are two problems:
> > 
> > 1. Describing your _hardware_ (not drivers) in the devicetree
> > 2. Binding a driver to your device
> > 
> > You ultimately care about both 1 and 2 as you want Linux to do
> > something useful with the device, but for the purpose of this patch
> > adding the devicetree, 1 is what matters and 2 is not really a part of
> > the considerations.
> > 
> > What needs to be the case is that the devicetree describes the device
> > via an appropriate compatible string for the device (manufacturer and
> > part number). Prior to that, the compatible string for the device needs
> > to be documented in a devicetree binding. This may be the trivial-
> > devices binding if there are no extra properties that need to be
> > described, or you may need to write your own binding document for the
> > device if it's more complex and one doesn't yet exist.
> > 
> > So whatever is in pmbus.c needs to be fixed later on if your device is
> > not yet supported by it, but that's a separate problem (2) to the
> > problem you have here (1).
> > 
> > Who is the manufacturer and what is the part number?
> > 
> > 
> > Andrew
> 
> Thank Andrew for your explanation! I'm so happy to receive comments from 
> you.
> 
> I'll remove the PSU node with "pmbus" compatible in the patch v2. We'll 
> discuss more to have a suitable PSU node later.
> 
> I'm preparing the patch v2. Summary, I need to update as the below list.
> 1. Add Mt. Jefferson board compatible binding as Krzysztof pointed.
> 2. Remove the PSU node with "pmbus" compatible.

Sounds good. Thanks.

> 
> If you have any other comments on patch v1 please don't hesitate to 
> point out; I'll update that in patch v2.

I had one query on v1.

Andrew

