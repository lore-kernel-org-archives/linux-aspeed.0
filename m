From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
Date: Thu, 3 Oct 2019 02:35:02 +0000
Subject: [PATCH 0/2] peci: aspeed: Add AST2600 compatible
In-Reply-To: <03d21443-aa9a-a126-dc77-a21f14f708c9@linux.intel.com>
References: <20191002061200.29888-1-chiawei_wang@aspeedtech.com>
 <70044749-785b-6ff3-7a28-fb049dcfec54@linux.intel.com>
 <CACPK8XfBxC+4PHHCkMoXr+twjfWaovcJ5c=hfCmHRJ6LpGNeFg@mail.gmail.com>
 <03d21443-aa9a-a126-dc77-a21f14f708c9@linux.intel.com>
Message-ID: <4af9eb8fa6fd41fc87708fc8afdcc83e@TWMBX02.aspeed.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Jae Hyun,

Thanks for the feedback.
For now should I use GitHub pull-request to submit the patches of PECI-related change to OpenBMC dev-5.3 tree only?

Regards,
Chiawei

************* Email Confidentiality Notice ********************
DISCLAIMER:
This message (and any attachments) may contain legally privileged and/or other confidential information. If you have received it in error, please notify the sender by reply e-mail and immediately delete the e-mail and any attachments without copying or disclosing the contents. Thank you.


-----Original Message-----
From: Jae Hyun Yoo [mailto:jae.hyun.yoo at linux.intel.com] 
Sent: Thursday, October 3, 2019 7:43 AM
To: Joel Stanley <joel@jms.id.au>
Cc: ChiaWei Wang <chiawei_wang@aspeedtech.com>; Jason M Biils <jason.m.bills@linux.intel.com>; Rob Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; Andrew Jeffery <andrew@aj.id.au>; linux-aspeed <linux-aspeed@lists.ozlabs.org>; OpenBMC Maillist <openbmc@lists.ozlabs.org>; devicetree <devicetree@vger.kernel.org>; Linux ARM <linux-arm-kernel@lists.infradead.org>; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; Ryan Chen <ryan_chen@aspeedtech.com>
Subject: Re: [PATCH 0/2] peci: aspeed: Add AST2600 compatible

On 10/2/2019 3:05 PM, Joel Stanley wrote:
> On Wed, 2 Oct 2019 at 18:11, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>>
>> Hi Chia-Wei,
>>
>> On 10/1/2019 11:11 PM, Chia-Wei, Wang wrote:
>>> Update the Aspeed PECI driver with the AST2600 compatible string.
>>> A new comptabile string is needed for the extended HW feature of 
>>> AST2600.
>>>
>>> Chia-Wei, Wang (2):
>>>     peci: aspeed: Add AST2600 compatible string
>>>     dt-bindings: peci: aspeed: Add AST2600 compatible
>>>
>>>    Documentation/devicetree/bindings/peci/peci-aspeed.txt | 1 +
>>>    drivers/peci/peci-aspeed.c                             | 1 +
>>>    2 files changed, 2 insertions(+)
>>>
>>
>> PECI subsystem isn't in linux upstream yet so you should submit it 
>> into OpenBMC dev-5.3 tree only.
> 
> OpenBMC has been carrying the out of tree patches for some time now. I 
> haven't seen a new version posted for a while. Do you have a timeline 
> for when you plan to submit it upstream?

Thanks for your effort for carrying the out of tree patches in OpenBMC.
I don't have a exact timeline but I'm gonna upstream it as soon as it gets ready.

Thanks,

Jae
