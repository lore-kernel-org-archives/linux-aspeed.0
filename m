From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Thu, 4 Nov 2021 09:16:57 -0700
Subject: [PATCH -next v2 5/6] dt-bindings: ipmi: aspeed,kcs-bmc: add
 'clocks' as a required property
In-Reply-To: <CACPK8Xcwkz1QLOvN0MiSkX+jj2NZY10--1qo7M8UMyEmQQtYmA@mail.gmail.com>
References: <20211102203717.96794-1-jae.hyun.yoo@intel.com>
 <20211102203717.96794-6-jae.hyun.yoo@intel.com>
 <1635902437.654631.3880388.nullmailer@robh.at.kernel.org>
 <8db279c9-4c76-91a5-3617-a17effb2d103@linux.intel.com>
 <CAL_Jsq+SwCqFycKz4+agRsB3qr4Rbfra55Q6tNbMH2bNtoX+hA@mail.gmail.com>
 <796e0c02-5bca-e8a9-a17f-898aafec237f@linux.intel.com>
 <CACPK8Xcwkz1QLOvN0MiSkX+jj2NZY10--1qo7M8UMyEmQQtYmA@mail.gmail.com>
Message-ID: <27c6e902-7cb3-97c6-f4db-b31a81869115@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 11/3/2021 3:45 PM, Joel Stanley wrote:
> On Wed, 3 Nov 2021 at 17:27, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>>
>> On 11/3/2021 9:29 AM, Rob Herring wrote:
> 
>>> It's possible that 'clocks' was always required or that it never
>>> worked without clocks, then this change is okay. Looking at this
>>> patch, I have no way to know that. The commit message has to explain
>>> that. A commit message needs to answer WHY are you making the change.
>>> You don't really need WHAT the change is as anyone can read the diff.
>>
>> Then what would be better? Would it be good enough if I add more detail
>> commit message including a note that dtb recompiling is required? Or,
>> should I change this series to treat the 'clocks' as an optional
>> property? Can you please share your thought?
> 
> Make it essential. It was only by accident that things have worked
> without this change.
> 
> While keeping backwards compatibility with dtbs is a goal we strive
> for, in practice we use the dtb from the corresponding kernel source
> tree, so as long as the patch to the driver is applied in the same
> place as the patch to the device tree no systems will break.

Okay. I'll keep 'clocks' property as a required property and will make
the commit message of this patch more descriptive. Thanks a lot for your
feedback.

Cheers,
Jae

