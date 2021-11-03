From: Joel Stanley <joel@jms.id.au>
Date: Wed, 3 Nov 2021 22:45:38 +0000
Subject: [PATCH -next v2 5/6] dt-bindings: ipmi: aspeed,kcs-bmc: add
 'clocks' as a required property
In-Reply-To: <796e0c02-5bca-e8a9-a17f-898aafec237f@linux.intel.com>
References: <20211102203717.96794-1-jae.hyun.yoo@intel.com>
 <20211102203717.96794-6-jae.hyun.yoo@intel.com>
 <1635902437.654631.3880388.nullmailer@robh.at.kernel.org>
 <8db279c9-4c76-91a5-3617-a17effb2d103@linux.intel.com>
 <CAL_Jsq+SwCqFycKz4+agRsB3qr4Rbfra55Q6tNbMH2bNtoX+hA@mail.gmail.com>
 <796e0c02-5bca-e8a9-a17f-898aafec237f@linux.intel.com>
Message-ID: <CACPK8Xcwkz1QLOvN0MiSkX+jj2NZY10--1qo7M8UMyEmQQtYmA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 3 Nov 2021 at 17:27, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>
> On 11/3/2021 9:29 AM, Rob Herring wrote:

> > It's possible that 'clocks' was always required or that it never
> > worked without clocks, then this change is okay. Looking at this
> > patch, I have no way to know that. The commit message has to explain
> > that. A commit message needs to answer WHY are you making the change.
> > You don't really need WHAT the change is as anyone can read the diff.
>
> Then what would be better? Would it be good enough if I add more detail
> commit message including a note that dtb recompiling is required? Or,
> should I change this series to treat the 'clocks' as an optional
> property? Can you please share your thought?

Make it essential. It was only by accident that things have worked
without this change.

While keeping backwards compatibility with dtbs is a goal we strive
for, in practice we use the dtb from the corresponding kernel source
tree, so as long as the patch to the driver is applied in the same
place as the patch to the device tree no systems will break.
