From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Wed, 2 Oct 2019 16:42:53 -0700
Subject: [PATCH 0/2] peci: aspeed: Add AST2600 compatible
In-Reply-To: <CACPK8XfBxC+4PHHCkMoXr+twjfWaovcJ5c=hfCmHRJ6LpGNeFg@mail.gmail.com>
References: <20191002061200.29888-1-chiawei_wang@aspeedtech.com>
 <70044749-785b-6ff3-7a28-fb049dcfec54@linux.intel.com>
 <CACPK8XfBxC+4PHHCkMoXr+twjfWaovcJ5c=hfCmHRJ6LpGNeFg@mail.gmail.com>
Message-ID: <03d21443-aa9a-a126-dc77-a21f14f708c9@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

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
>> PECI subsystem isn't in linux upstream yet so you should submit it into
>> OpenBMC dev-5.3 tree only.
> 
> OpenBMC has been carrying the out of tree patches for some time now. I
> haven't seen a new version posted for a while. Do you have a timeline
> for when you plan to submit it upstream?

Thanks for your effort for carrying the out of tree patches in OpenBMC.
I don't have a exact timeline but I'm gonna upstream it as soon as it
gets ready.

Thanks,

Jae
